Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A673A4132
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhFKLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFKLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:25:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:23:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a19so5994444ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=USSio9uT559EwLMdaKvg28/LlsSRVZgA7+FGi03yDYA=;
        b=FwrhWsc7b4Vs/42jyQUSXkZj44OmfEXJ0TkZPCE79YRCLIRKnz4T85V8s2L7HlQWlO
         +rHS5FqVNh9EPY3SYHx0TK1Nz2jttXdjNum4wilnF4F3V5EPoonyS54VZyP98w78NmMU
         T0leseF3I+u27ECRRkzKRqXSMI4q4wSPJ/vzYSiVlMT4vECDJPj6FdBlHdkki/rvQTFC
         7Gz3GfIieChVHhCTTtmBPK85e95wFK6upIgKfhS1IZ/UsYSPumObml0q/KUflkfMXB4O
         WV6QpPa94kYVtu5z4AGjW/vUfcCOQ2YwBe+KrbPODsWwCiYJG58ya7oRjH+dDZTYDHEP
         GYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USSio9uT559EwLMdaKvg28/LlsSRVZgA7+FGi03yDYA=;
        b=e4LjbGdPSYcHVh7m+7MUmujczRIsI2BS5iqCCbupd3HTPM0en0NAeLiKdmqVUuhbTI
         AbBBMm/wh90pw4vxt33dNDx1sainXRWXbyhlaGzPNPJ9UTmurKVCfahDh3k1RPMQsBlZ
         S4EIL5NQBrrALk8Pe5cACiOBkgLAXZbfhmbCBNfjnVp1ebsX7lZQ0CcqvDgIt7IxpTnh
         cnoTO4KNLxeAClbzywUkqTUHxVhMcUGvtFNXpErQPXYpODyRbHR0hIpBNbnQLF6Jsy1S
         dXrcNOGqWEKToNQDv88//JAO0UpB11kk2Nzd5X/0TTZAqLQIjZ1fUD1lZwmjhkHHe8O+
         vOXQ==
X-Gm-Message-State: AOAM530fyQT3limzmGPcyIILP2Er/loFasVxdlnwUP210cL9P1PN+vx6
        r/YLpPogGuAmjpH3xqdx/ONQoA==
X-Google-Smtp-Source: ABdhPJyoxHNcYAUTt5FeVPuTkixfS7mu+aT5G0rgsl0eogqYnA6hBZmeBd6m15Dpw3ay3S1QP7N7jw==
X-Received: by 2002:a05:651c:1697:: with SMTP id bd23mr2632917ljb.148.1623410600127;
        Fri, 11 Jun 2021 04:23:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q126sm678515ljq.111.2021.06.11.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:23:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0317D1027DC; Fri, 11 Jun 2021 14:23:35 +0300 (+03)
Date:   Fri, 11 Jun 2021 14:23:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210611112335.37sno6wwbsef6zen@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <799b3f9c-2a9e-dfef-5d89-26e9f76fd97@google.com>
 <20210610093203.x42jpifagiavmrlp@box.shutemov.name>
 <4679ec74-80a-ed13-e58e-654911fbab28@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4679ec74-80a-ed13-e58e-654911fbab28@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 04:02:47PM -0700, Hugh Dickins wrote:
> On Thu, 10 Jun 2021, Kirill A. Shutemov wrote:
> > On Wed, Jun 09, 2021 at 11:44:10PM -0700, Hugh Dickins wrote:
> > > page_vma_mapped_walk() cleanup: adjust the test for crossing page table
> > > boundary - I believe pvmw->address is always page-aligned, but nothing
> > > else here assumed that;
> > 
> > Maybe we should just get it aligned instead? (PMD_SIZE - PAGE_SIZE) is not
> > most obvious mask calculation.
> 
> Would you prefer it with another line of comment after the
> /* Did we cross page table boundary? */
> 
> Maybe,
> /* Is address always page-aligned? No need to assume that. */
> 
> I just don't see the point in forcing alignment when the test is good
> (and don't know for sure whether address is always aligned there or not).
> 
> I prefer to leave it as is, just letting the commit message document it.

Okay.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
