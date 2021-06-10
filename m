Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E43A3798
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFJXF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:05:59 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:34586 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFJXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:05:58 -0400
Received: by mail-qk1-f181.google.com with SMTP id k11so27523593qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=qeFcj3RvFIgn+Y/tzqbFYekNNwhIfYGgU+jLdlJf6yw=;
        b=S2vuX7oNdf+mrc2CccHRI8RD2z52UkXdVZCD3Z4nXs1ZCTOGjOCB00hpBp6Le71dDN
         nEP3uCRUpx8e82Ph5jWK0V6ONwe0HUyXaLOO5KCWsFXIr6Rp7IYB2R97cJkmT9B/1MsW
         m228PdcwPPzD4PXXyTkyr2A4nEIYBIrRgSCygv96STR3dn22sZ1WU9gETjb6lL2w0kdb
         E3PlCgGTZ2IrMT/bj/mrNQ8OH9kJzOyUXA3RkleGCwx8jCSNFs1eWLDj5zCwDqVI7NmT
         a4kts9fj++lUiud4KgPiMAUmkfbjMsDciun/TWKze+DzJy/xXx9gVqa26XtmmfQo87rO
         UA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=qeFcj3RvFIgn+Y/tzqbFYekNNwhIfYGgU+jLdlJf6yw=;
        b=sv3bitD9Z0QS/EFKEhxdhH2/5u+3Fb58bUvmgoE1kaTMEUbKXQgPE6J+h0UTg05uWF
         9Na0zKdUcKuoUkUStYMANiSnLvqpz+fQ99r8g/9JGikCs0VC5xMRbluJqvVXzHxLvUsl
         9K3soXKrVlaD2g6ej5v7MeaNAWjESmZW3nMjW3E4iP8E+/POOI+6DG/yqw/U6u4yaSrE
         7pojnbDuR5lXzj5vFlt9Fb92e341saQ4YWL6Q8PfE385k7H3F/h1ST08Rhg8lNEn5A2j
         x5XBc+suhtqd4+cJ1HgQyW6629zIaitog5VfU/PMtmr1tbEFmbxBvB92FJBeZJw4fk/L
         Cfqg==
X-Gm-Message-State: AOAM532eD2cv2WeGf1EHzMhBEgDZOX+FrPBvrxNfWf4NGz4fhkC5oxIm
        hzMex2Vqm/LbLpVs8jkfzxa24Q==
X-Google-Smtp-Source: ABdhPJw0UZNntSZ2RdzdfiSlt9jzmTDqgxw9uetF/bojrQqYtAUHHFHI2tYNdUiBCL1HjkCwrM5gMw==
X-Received: by 2002:a37:9381:: with SMTP id v123mr1087360qkd.64.1623366169388;
        Thu, 10 Jun 2021 16:02:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o22sm3063286qtq.89.2021.06.10.16.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:02:49 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:02:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] mm: page_vma_mapped_walk(): crossing page table
 boundary
In-Reply-To: <20210610093203.x42jpifagiavmrlp@box.shutemov.name>
Message-ID: <4679ec74-80a-ed13-e58e-654911fbab28@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com> <799b3f9c-2a9e-dfef-5d89-26e9f76fd97@google.com> <20210610093203.x42jpifagiavmrlp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, Kirill A. Shutemov wrote:
> On Wed, Jun 09, 2021 at 11:44:10PM -0700, Hugh Dickins wrote:
> > page_vma_mapped_walk() cleanup: adjust the test for crossing page table
> > boundary - I believe pvmw->address is always page-aligned, but nothing
> > else here assumed that;
> 
> Maybe we should just get it aligned instead? (PMD_SIZE - PAGE_SIZE) is not
> most obvious mask calculation.

Would you prefer it with another line of comment after the
/* Did we cross page table boundary? */

Maybe,
/* Is address always page-aligned? No need to assume that. */

I just don't see the point in forcing alignment when the test is good
(and don't know for sure whether address is always aligned there or not).

I prefer to leave it as is, just letting the commit message document it.

> 
> > and remember to reset pvmw->pte to NULL after
> > unmapping the page table, though I never saw any bug from that.
> 
> Okay, it's fair enough.

Thanks,
Hugh
