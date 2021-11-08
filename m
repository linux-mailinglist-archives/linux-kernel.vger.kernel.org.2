Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50E447DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbhKHKT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbhKHKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:16:23 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110B8C06122C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:13:12 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v23so3177640iom.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 02:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpdYRzw4trrYI88+DWsvxttEJMmFVga5Tyzq5em5J1A=;
        b=eWu+JT8YpnTTUiqWpfPfoxoeIGendRmTcxIhriInBSQP3X9ACgnpv86HzSKltRCIjD
         pDXWLxWytgr/PGgxCNtCGUur5hphd5N9XeTM5ehhjX6up5gMQo6RHT1wU/esLcbTsl8l
         fmiEa9Gvq18+04U8EfXVr6Ffzwj1lrmMZNQVe9bbwVQ4hBrkK4vOH6mYpghnu0PBEG8g
         11xbDZsiOP6MrZf0/tvfjUnDpZDRN4MvnmJHEF8G0OcaxLQWd7DKPQpuCz5Tj6s0gFk4
         f4DftAz+5uFY3irpHsf0wfc4rjq+9e9dLBCBWzRTnNArVXgzxWMI6IYHew706ExUyutH
         QImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpdYRzw4trrYI88+DWsvxttEJMmFVga5Tyzq5em5J1A=;
        b=TYaZSSLMkV3oPYfdz7cEyambr7wTGdd2NoI25eKyuva5E4Ywmnvfzdf7FuMxfNFEfs
         mlqK7UA8DOUcA0d8uH+1OGnWikSOVHojCA+KU72GYaXiCDpg0nJeWU3iLLweMbAOIjfB
         Yc6XIL3H9p6E9Tp7VuoXH9UYq7lp6uvwioOTEEFJrEO0v46UUQZlQpNnnc14Qg6bceQo
         zeq9fE0PWw8U+C3doNP6aaG7cYBtnDZJS6DQ4z3ayD63wsPdwmZ+gbiT7eGWCWwArQf/
         Zhv+pboE0/Cku1cu4sKx9wdq5mqn5ngjpyMgzl0PNexhlqB/q/sPGXDZV9ZVIYc2N+tz
         dZUw==
X-Gm-Message-State: AOAM530ZGXFNB53TTjzENox6P27TK1Q7foohRc8nQ/3udTbpO65pTytU
        Xk4vDt63DTwe1HWa6gZmdOhNOXDiP92RqOsJfw8=
X-Google-Smtp-Source: ABdhPJyFVgby7x2NnFPff82L3rzJ42B5/PnMoS3+61Wft3C/VIVZkOaXoHBixMOC7MTrPIz1Cp9d1gsVpNydgdGh3bg=
X-Received: by 2002:a6b:5b17:: with SMTP id v23mr12356152ioh.54.1636366391399;
 Mon, 08 Nov 2021 02:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com> <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org> <YYVhHCJcm2DM2G9u@casper.infradead.org>
 <20211105165859.GA3538886@iweiny-DESK2.sc.intel.com> <YYVofyW3txoT9RLM@casper.infradead.org>
 <20211105183803.GB3538886@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20211105183803.GB3538886@iweiny-DESK2.sc.intel.com>
From:   Prathu Baronia <prathubaronia2011@gmail.com>
Date:   Mon, 8 Nov 2021 15:42:59 +0530
Message-ID: <CAJp9fseokAd71bRWjEC=WAt1_czPCb+2OmdwCs5-eZrHuuS_CQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,
Sorry for the late reply, I was on vacation. I can see that you
already fixed up the patch(added the zero_user_segments part) and the
patch[1] is now merged in the mainline. Thanks for fixing it up. Also
for the memset_page() thing, IIUC would the below diff suffice?

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 25aff0f2ed0b..dfe21e6a696b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -332,6 +332,7 @@ static inline void memset_page(struct page *page,
size_t offset, int val,

     VM_BUG_ON(offset + len > PAGE_SIZE);
     memset(addr + offset, val, len);
+    flush_dcache_page(page);
     kunmap_local(addr);
 }


- Prathu

[1]: https://github.com/torvalds/linux/commit/d2c20e51e3966bc668ef1ef21fbe90704286c8d0#diff-a5b54499adfa477c1341f1d74cb5331481f00ff9afb4c8d600be19e2d8fa7e30

On Sat, Nov 6, 2021 at 12:08 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Nov 05, 2021 at 05:23:11PM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 05, 2021 at 09:58:59AM -0700, Ira Weiny wrote:
> > > On Fri, Nov 05, 2021 at 04:51:40PM +0000, Matthew Wilcox wrote:
> > > > On Fri, Nov 05, 2021 at 01:50:37PM +0000, Matthew Wilcox wrote:
> > > > > On Thu, Feb 11, 2021 at 03:56:25PM -0800, Andrew Morton wrote:
> > > > > > On Wed, 10 Feb 2021 16:33:07 -0800 Ira Weiny <ira.weiny@intel.com> wrote:
> > > > > >
> > > > > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > > > >
> > > > > > > This already has my signed off by so I'm not going to 'review'.  With Prathu's
> > > > > > > testing information I hope this can land.
> > > > > > >
> > > > > > > Andrew did you see this patch?
> > > > > >
> > > > > > I did now ;)
> > > > > >
> > > > > > Tossed onto the post-rc1 pile, thanks,
> > > > >
> > > > > This patch seems to have slipped through the gaps for a couple of cycles
> > > > > now?  I found a missed spot in it for CONFIG_HIGHMEM:
> > > >
> > > > Ugh, sorry, wrong version of the patch.
> > >
> > > Check!  Yea this works for me...
> > >
> > > I think this should to through as a separate patch because Prathu's has been
> > > soaking for some time.  No need to complicate it with this.
> >
> > This isn't "complicating Prathu's patch".  This is "fixing up the bit
> > that Prathu missed with his patch".  zero_user_segments() should not
> > have different rules on HIGHMEM and non-HIGHMEM kernels.
>
> What do you mean by 'different rules'?
>
> Oh I see...  Ok yea.
>
> Well this should not be a big deal...
>
> Ira
