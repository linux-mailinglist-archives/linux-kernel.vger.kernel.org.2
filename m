Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67B3796F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEJSYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhEJSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:24:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55211C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:23:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h7so9574522plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzeEt2iLZsv/e10Yd+9MeGfoznQwyzGkrL9B5lma3LM=;
        b=PTHzuMmdV5rppvtqXsnyDqNTwha1kpVo0YQxNMxa82x8VXCB1LLyT2SALRi+SijsWw
         WC9b4IEGZJ0UY8rWLq5au1RduDqesgiz0ibZlHrO4y+0eI1u7Dfc6q0cHXE2/MPQVJJ2
         SsA9k8B1a8KB+K/q0lzGDuS7KiFJW30CG1EbyHdYAGtplirZ/pTxYOCvQdc0zlYfWKb/
         SvEsx9ZM3/d+QagYl50vecHVoZ1WtgyIxzqFh4xyzXLISw16wwDhDli5tkF9dlCqmbIw
         kgGgf/tRrW/f6G0YilyXYsRyi2JH+PY86iB22FjcHORB3Z6dP07f0Djhv44TCDFbLmD+
         Jgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzeEt2iLZsv/e10Yd+9MeGfoznQwyzGkrL9B5lma3LM=;
        b=Ex30OTAGRoNKYL/Da/RZPowi50urOf+7je9myW0v8dz3/nt04X1eGq1OWTdoQAg9eS
         CAf2fh7F1+C98f0cfPh7r4YDwwDRj0bGHbC7Dba1NW9DjDrsafWwhtXR5lW6b3HA7W4q
         NgE3BlyirJmZ3xPEk9ECSYTlfXoXaXIDermg5GfYEtbl0Gy5IfAxgU5VcoMGys0zGpLJ
         +kgcqNLkwvxUdOXVVvRLKYo7lVRhVQuyEKMZveMjNqLgZkWu27SDv+MZj85wiGcY988L
         bHD6jeAISudbjWY3mDo/86FjwTlOx4/PAhwFOrJp+BhYBqWfiY062E7Dr4V/ZlHnE6fB
         Pl4Q==
X-Gm-Message-State: AOAM532wpxvnks1+lENgzecv9QaU3zp1ntYfgEH3Yr60CG044MTJUlXT
        gM6cfgzoW9vQ9sJYoCtofezz4+gGsTR/lyxA6bTABnVWsn9dEA==
X-Google-Smtp-Source: ABdhPJyR8+mhzGMixl3aCj04W8g4i7YEgDxP/gV0CVKW2sLb2jbWOq2iKq4quxLHLUBRX03hwHPSRAMkwrBDFKFA8ec=
X-Received: by 2002:a17:90a:17a2:: with SMTP id q31mr539529pja.32.1620671018477;
 Mon, 10 May 2021 11:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210430123822.13825-1-brijesh.singh@amd.com> <20210430123822.13825-17-brijesh.singh@amd.com>
In-Reply-To: <20210430123822.13825-17-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 10 May 2021 12:23:27 -0600
Message-ID: <CAMkAt6q=G96mG905u1GisbkVR42saPsgzQkXTtPVM=ar0Pdasg@mail.gmail.com>
Subject: Re: [PATCH Part2 RFC v2 16/37] crypto: ccp: Handle the legacy TMR
 allocation when SNP is enabled
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, jroedel@suse.de,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>, peterz@infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static int snp_set_rmptable_state(unsigned long paddr, int npages,
> +                                 struct rmpupdate *val, bool locked, bool need_reclaim)
> +{
> +       unsigned long pfn = __sme_clr(paddr) >> PAGE_SHIFT;
> +       unsigned long pfn_end = pfn + npages;
> +       int rc;
> +
> +       while (pfn < pfn_end) {
> +               if (need_reclaim)
> +                       if (snp_reclaim_page(pfn_to_page(pfn), locked))
> +                               return -EFAULT;
> +
> +               rc = rmpupdate(pfn_to_page(pfn), val);
> +               if (rc)
> +                       return rc;

This functional can return an error but have partially converted some
of the npages requested by the caller. Should this function return the
number of affected pages or something to allow the caller to know if
some pages need to be reverted? Or should the function attempt to do
that itself?

> +
> +               pfn++;
> +       }
> +
> +       return 0;
> +}

> +
> +static void __snp_free_firmware_pages(struct page *page, int order)
> +{
> +       struct rmpupdate val = {};
> +       unsigned long paddr;
> +
> +       if (!page)
> +               return;
> +
> +       paddr = __pa((unsigned long)page_address(page));
> +
> +       if (snp_set_rmptable_state(paddr, 1 << order, &val, false, true))
> +               return;

We now have leaked the given pages right? Should some warning be
logged or should we track these leaked pages and maybe try and free
them with a kworker?

> +
> +       __free_pages(page, order);
> +}
> +
