Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A383B21A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:17:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A07C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:14:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f30so6267356lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=66ykk3fa/e/O9LbG3+nVJlND/S/m5SrN0SqToevufSg=;
        b=d8PmOamlHA7u9848LkKQAILvUUoxD7Gos/8ajMJLFpSzt7ly7OnfyoFsb4dc4at6Ox
         EpPgW3K2ZuzqFe0YsdPZvDsd/KKLj08Fm2XjxluVkIJIXN3SwnB7+yTS+uBqSscorfHJ
         FzgtCtCBujOGlXT9KqvsvcjeRVl1995f7y+Ggm+HRhee3WPIRVWw3rhK0YYfEQra2KDN
         AInT3NU4ooFdTqnbyP2eInpQhvmWLSoitCMBkIjSA4dqmgt137SsdBsFHZHqHFdakfXr
         6HSHLWNaKtszAt7tbsodQ4wtAWlhj5Dw/m13z1QgWysd49Y3EBHIhmFJqm05hmY/b+Cp
         1/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=66ykk3fa/e/O9LbG3+nVJlND/S/m5SrN0SqToevufSg=;
        b=gdxf+xBK4pZTK3pjwFzBTKM2K1KQ1PpAq0b016y+C5h2wwsD96Ws4qmpxucFWouobM
         vFQkMJ20+Dj1T9iGvb1ehfXu2J9zyCsb1++InZMreXTBg4Cd4R4lDVHDVdr8CpNS8ZA0
         boTmcsUwi2ueUIsKaA/JF6T2IZ4xGUdJ7zgCHKlYXlpVL64GIFieEVSTqC3hWyGWyKge
         0UnjSASUFj544idLietz529TYz9nxQ9im4DzKT+VmsQaI/OYLe0pAJiYip5Szy/l5t3R
         UnIare8Rcg87Z1wj8AUIwP6EBB75zlOB+cCMMB+pw9BUitNmDLJEHpbKHOVLh07SdGQ8
         iSlg==
X-Gm-Message-State: AOAM532i1xZYSfjZ925ozNGHenzzvhSPXYMyp77UwmYspYA/9dnJfk3B
        lQ4UpW+zQKOf31if0QCt3io=
X-Google-Smtp-Source: ABdhPJxrjFHJ05de0MAtITfPF5qIsytOdde5OwIuKIU4zXlnlEIC3nymVz+Fqit8bbYyK6BXur9Fhw==
X-Received: by 2002:ac2:4d81:: with SMTP id g1mr983671lfe.319.1624479284265;
        Wed, 23 Jun 2021 13:14:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id bp27sm94906lfb.107.2021.06.23.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:14:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 23 Jun 2021 22:14:42 +0200
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <20210623201442.GA2111@pc638.lan>
References: <20210622225030.478384-1-aquini@redhat.com>
 <20210623112704.GA1911@pc638.lan>
 <YNNwqdM/U+ZErA6j@optiplex-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNNwqdM/U+ZErA6j@optiplex-fbsd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:34:33PM -0400, Rafael Aquini wrote:
> On Wed, Jun 23, 2021 at 01:27:04PM +0200, Uladzislau Rezki wrote:
> > > On non-preemptible kernel builds the watchdog can complain
> > > about soft lockups when vfree() is called against large
> > > vmalloc areas:
> > > 
> > > [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> > > [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> > > [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> > > [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> > > [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> > > [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> > > [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> > > [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> > > [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> > > [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> > > [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> > > [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> > > [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> > > [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> > > [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> > > [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  238.903397] PKRU: 55555554
> > > [  238.906417] Call Trace:
> > > [  238.909149]  __vunmap+0x17c/0x220
> > > [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> > > [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> > > [  238.923746]  do_syscall_64+0x39/0x80
> > > [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > Like in other range zapping routines that iterate over
> > > a large list, lets just add cond_resched() within __vunmap()'s
> > > page-releasing loop in order to avoid the watchdog splats.
> > > 
> > > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > > ---
> > >  mm/vmalloc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index a13ac524f6ff..cd4b23d65748 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2564,6 +2564,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
> > >  
> > >  			BUG_ON(!page);
> > >  			__free_pages(page, page_order);
> > > +			cond_resched();
> > >  		}
> > >  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> > >  
> > > -- 
> > > 2.26.3
> > > 
> > I have a question about a test case you run to trigger such soft lockup.
> > 
> > Is that test_vmalloc.sh test-suite or something local? Do you use a huge
> > vmalloc mappings so high-order pages are used?
> >
> 
> Vlad,
> 
> It's a variant of the simple testcase presented with Kernel Bug 210023:
> https://bugzilla.kernel.org/show_bug.cgi?id=210023#c7
> 
OK, now i see how you get ~23 seconds soft lockup :)

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks!

--
Vlad Rezki
