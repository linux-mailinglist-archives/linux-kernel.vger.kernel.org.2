Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193D34823F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhCXT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbhCXT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:56:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C614C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:56:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y5so18203290pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=51a7/l/nsk+WHKm80laHXs7j8o4M0B9C9qfqcVGcX5I=;
        b=K45Yk7dH6S2icYYhK/lbtxo1NUm3pzoclNBBTt6R9JS6Geeitbntvhy2QWM5hDafQp
         oBeQY0p64KD51tB8xn8T0u9mEdoJxZyQNCGuJAXTXVSXodIQ53U7JyHCwY0PNjd9ekjf
         V7ZaifKye0sGEmsAbwcR1Z2xRPLiA3xAJPJkz29+M8gm24QcKaJckFa5eqPERsbXCLEq
         zEDeqnTF8BOWmBhghERl0uEqQvo7DNdd5YM+VWRTZxYUYzlsWNm5tvuFVnGvbpeJZhuF
         nQSwIi5r65jsAdqHc9SfxlzIfCKCLySGNVNWikd8jkbXoG0Y2iiEtuhybgRZe8GXPiZX
         9+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=51a7/l/nsk+WHKm80laHXs7j8o4M0B9C9qfqcVGcX5I=;
        b=HidvOA6nTiGSmBy5ItjULrLIi7PAx6vb+yVIVc08r5nvcXGbbHFIF3iKrhqETw4dwa
         JSbuuHmXmuLORTGmm74VKbRZ7XjqleS8fUbacNP2WHm/NUGsMPPmHcNCYie7ddTJO0Jf
         XvN9x7NrhXxsFNGEQXSMNpnHaNXnFH/7rZoOK+0+dHjumVYbHILyxlGx8gTAP7X7CRbN
         X+1SX9aiARuKi2tUUMR6ZgaB46JfDrVJAU3Gif/zWapaRHWb3v75xaqobkaWQk5+HyCv
         0xhKlxKx3fcJ0wY45Raysyf5BQ9Kxzdq4k9walYablIO7v++gcwQeR1YhR2vdMNYdkJQ
         WuPg==
X-Gm-Message-State: AOAM532Zfg6zcZAWXatKU82S0GKxh/mjPXpA7x+xF50n28/y6ryqa8/3
        iyHRORlJvGpyXwjtDCSKPAg=
X-Google-Smtp-Source: ABdhPJzxyw/mCcqsc2kDs99hAfYJ0miSrcjoq1apwSItiSsphfv8di9b3a872QCkbs4pwNrYBEHbpA==
X-Received: by 2002:a17:902:780c:b029:e7:11a4:8106 with SMTP id p12-20020a170902780cb02900e711a48106mr3065479pll.57.1616615759699;
        Wed, 24 Mar 2021 12:55:59 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id e83sm3404548pfh.80.2021.03.24.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:55:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 12:55:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org,
        digetx@gmail.com
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
Message-ID: <YFuZTNQRIZXQGley@google.com>
References: <20210324192044.1505747-1-minchan@kernel.org>
 <01e09f8b-93f9-cd59-1f12-7ab4c86743e6@nvidia.com>
 <bf558f31-8044-954d-70a7-550cea6c08f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf558f31-8044-954d-70a7-550cea6c08f1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:53:26PM +0100, David Hildenbrand wrote:
> On 24.03.21 20:45, John Hubbard wrote:
> > On 3/24/21 12:20 PM, Minchan Kim wrote:
> > > struct cma_stat's lifespan for cma_sysfs is different with
> > > struct cma because kobject for sysfs requires dynamic object
> > > while CMA is static object[1]. When CMA is initialized,
> > > it couldn't use slab to allocate cma_stat since slab was not
> > > initialized yet. Thus, it allocates the dynamic object
> > > in subsys_initcall.
> > > 
> > > However, the cma allocation can happens before subsys_initcall
> > > then, it goes crash.
> > > 
> > > Dmitry reported[2]:
> > > 
> > > ..
> > > [    1.226190] [<c027762f>] (cma_sysfs_alloc_pages_count) from [<c027706f>] (cma_alloc+0x153/0x274)
> > > [    1.226720] [<c027706f>] (cma_alloc) from [<c01112ab>] (__alloc_from_contiguous+0x37/0x8c)
> > > [    1.227272] [<c01112ab>] (__alloc_from_contiguous) from [<c1104af9>] (atomic_pool_init+0x7b/0x126)
> > > [    1.233596] [<c1104af9>] (atomic_pool_init) from [<c0101d69>] (do_one_initcall+0x45/0x1e4)
> > > [    1.234188] [<c0101d69>] (do_one_initcall) from [<c1101141>] (kernel_init_freeable+0x157/0x1a6)
> > > [    1.234741] [<c1101141>] (kernel_init_freeable) from [<c0a27fd1>] (kernel_init+0xd/0xe0)
> > > [    1.235289] [<c0a27fd1>] (kernel_init) from [<c0100155>] (ret_from_fork+0x11/0x1c)
> > > 
> > > This patch moves those statistic fields of cma_stat into struct cma
> > > and introduces cma_kobject wrapper to follow kobject's rule.
> > > 
> > > At the same time, it fixes other routines based on suggestions[3][4].
> > > 
> > > [1] https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> > > [2] https://lore.kernel.org/linux-mm/fead70a2-4330-79ff-e79a-d8511eab1256@gmail.com/
> > > [3] https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
> > > [4] https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/
> > > 
> > > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > > Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> > > Suggested-by: John Hubbard <jhubbard@nvidia.com>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > > I belive it's worth to have separate patch rather than replacing
> > > original patch. It will also help to merge without conflict
> > > since we already filed other patch based on it.
> > > Strictly speaking, separating fix part and readbility part
> > > in this patch would be better but it's gray to separate them
> > > since most code in this patch was done while we were fixing
> > > the bug. Since we don't release it yet, I hope it will work.
> > > Otherwise, I can send a replacement patch inclucing all of
> > > changes happend until now with gathering SoB.
> > 
> > If we still have a choice, we should not merge a patch that has a known
> > serious problem, such as a crash. That's only done if the broken problematic
> > patch has already been committed to a tree that doesn't allow rebasing,
> > such as of course the main linux.git.
> > 
> > Here, I *think* it's just in linux-next and mmotm, so we still are allowed
> > to fix the original patch.
> 
> Yes, that's what we should do in case it's not upstream yet. Clean resend +
> re-apply.

Okay, let me replace the original one including all other patches.
