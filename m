Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549D3A2886
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJJlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:41:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFEFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:39:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p17so2205744lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uiBF8oGdGwg4soSH3l9mTBsEsWc8HaqWV9DzR3YGpGE=;
        b=Uxq2AgxBMmVFJjkYUeehwF1e1oIYB05TC6fFhIenvZ8EaafPU5ksxFnuE2teh9iMyL
         CI1+J+L4lKXTTNwQ4+C3zHQIOVWL9VFVSgGh0rN7JROnnJbOD2LEPysXh0piMVGW6mts
         otFnCV5cyQTzFSfydCmyBYCGRGDTGt8lNJ5AZ+8dEx9dufIKLuuWWSdcQeUdzN9a3ziB
         SXM3kulVt8jmJLbNUpN/9ugVhgXiKSKlpyYms4La868O0zXfqtpz2OzP2+kQvlVRY0Bc
         TSn0fU99lM40JndXxheYmrnJI3Yfht9IyEKUu/Vcj1cuBNH42Sl2kzsnP+41keJFlhDc
         ECvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uiBF8oGdGwg4soSH3l9mTBsEsWc8HaqWV9DzR3YGpGE=;
        b=b5p2hdj/ADXSLh3vWinn3cSoUUepShSySNokVl5Keb2n7a0QjjUb+zSujTSzAU7ZdJ
         3ixYDp/kFZbDGaor65hvInxrSTAfo1Lf6yl6QAoBeZgWiFN3XvnQkaMDsrEtrFQUqiRc
         BFrOHgvPoTQqVsn7IgZwr7nV+NsT1WFiD0uGfVxPixdAHOxaNpUXBR9AJrS4dNgajO+5
         F1AkO2viyqXODfLiVQ6n+bb28wB2ZM63DEiqv45g+2v5YJNnqosEJp35BcjE4uQRKI7v
         FTJ+ckmr+5JEqsgqQvX8QKXdUz83KRMUFNbsDKmAm1dTAvAg2oTrkxSjNXHBEvBjMG55
         uQhg==
X-Gm-Message-State: AOAM530MGaLd/zrmycJW7XXZGglOsgz1kh27jUrUNuR/SLTY41bDMvKZ
        iHL6S8mSvcluwc1KZMyPyUqVrQ==
X-Google-Smtp-Source: ABdhPJxPok1/WSVp33Il7/mnSedLMmjVjtz1JZIAhMzTdi04s7h2yOcwuvJTAtfTN2vnKCI8jxkOfQ==
X-Received: by 2002:a19:c1cd:: with SMTP id r196mr1277086lff.643.1623317994262;
        Thu, 10 Jun 2021 02:39:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p26sm278471ljn.33.2021.06.10.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:39:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AADBA1027EE; Thu, 10 Jun 2021 12:40:09 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:40:09 +0300
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
Subject: Re: [PATCH 09/11] mm: page_vma_mapped_walk(): get vma_address_end()
 earlier
Message-ID: <20210610094009.p5agcrbt26jelkwx@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <4542b34d-862f-7cb4-bb22-e0df6ce830a2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4542b34d-862f-7cb4-bb22-e0df6ce830a2@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:50:23PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: get THP's vma_address_end() at the start,
> rather than later at next_pte.  It's a little unnecessary overhead on the
> first call, but makes for a simpler loop in the following commit.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
