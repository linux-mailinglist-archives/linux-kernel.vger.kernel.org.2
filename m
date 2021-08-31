Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4E3FCFC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhHaXDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhHaXDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:03:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BACC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:02:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso3222316pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6fVAWuXyMT/0QgdpRVgsjl6TJ333S1dL0H95dr0w7D4=;
        b=cN/pRkWepY9szJhCGFEPduR7G2SfRnHtedWRZGHZgo7ynsiU42WzlO23dLKzbB5Cxm
         UfhXiclsdLL1nN6w2+HaQ5elSEGTMTMDi3zRaDVHaE51R0tY4B8WvTHgpz65Rey73xXt
         X1C0nLlMydp9kyQbDpJSA4faH41L5bAJf5msA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6fVAWuXyMT/0QgdpRVgsjl6TJ333S1dL0H95dr0w7D4=;
        b=FxTYK/29YuMZAx8syWFx4XjtVtGXWiP5q+WAbXrSGS8uqHddE77Uof7KXbhZtGQ5pv
         wUWIevMTwKY2ETDc4No4v5Hyj0ltqNvuxkVb9AWftc/SWPgzPa95h+gs8EynrYzGNzDU
         Mw2RiGVoxDfx/lor7h6+imBIDvPHJ1NYSnSPMuXwdSSUuUei6I9RWd2Bq99dxIFBGQJk
         eDD+gASpM19Dc+TgNX6AxGHVfuaH5AgEokeA8YR/39z/YVEjdU8kyVDbV3fJ7hcUrQ3u
         9QUZ+wnKSonsxcbIeJwgWiJlg1/yMvGQBM8czvgD/InkQv/imLTFDC5Gb+Wk0k2zItA6
         KNqw==
X-Gm-Message-State: AOAM531+WEmJTQX8uFjMHs3qZ8telJZMA2c0feSDr2VUeiZ6wexTYdNX
        2Ft1m94NEI/ZenHF654rnF1/yA==
X-Google-Smtp-Source: ABdhPJzE6cWm5HiRuXg08jWq8VHUKGkg1rU7QEpW+TjtjSxhB6ZOgXMAWsvktwi9zY3Ybfadh7SHng==
X-Received: by 2002:a17:902:c401:b0:138:e450:1ec4 with SMTP id k1-20020a170902c40100b00138e4501ec4mr6798556plk.56.1630450934463;
        Tue, 31 Aug 2021 16:02:14 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id f18sm8511663pfc.161.2021.08.31.16.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 16:02:13 -0700 (PDT)
Date:   Wed, 1 Sep 2021 08:02:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     =?utf-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: use kvmalloc instead of kmalloc for devkmsg_user
Message-ID: <YS608AfYqPgQ3F7R@google.com>
References: <CGME20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
 <20210830071701epcms1p70f72ae10940bc407a3c33746d20da771@epcms1p7>
 <YS4jqsSlD7UySNRA@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS4jqsSlD7UySNRA@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/31 14:42), Petr Mladek wrote:
> On Mon 2021-08-30 16:17:01, 이용택 wrote:
> > Size of struct devkmsg_user increased to 16784 by commit 896fbe20b4e2
> > ("printk: use the lockless ringbuffer") so order3(32kb) is needed for
> > kmalloc. Under stress conditions the kernel may temporary fail to
> > allocate 32k with kmalloc. Use kvmalloc instead of kmalloc to aviod
> > this issue.
> > 
> > qseecomd invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=3, oom_score_adj=-1000
> > Call trace:
> >  dump_backtrace+0x0/0x34c
> >  dump_stack_lvl+0xd4/0x16c
> >  dump_header+0x5c/0x338
> >  out_of_memory+0x374/0x4cc
> >  __alloc_pages_slowpath+0xbc8/0x1130
> >  __alloc_pages_nodemask+0x170/0x1b0
> >  kmalloc_order+0x5c/0x24c
> >  devkmsg_open+0x1f4/0x558
> >  memory_open+0x94/0xf0
> >  chrdev_open+0x288/0x3dc
> >  do_dentry_open+0x2b4/0x618
> >  path_openat+0xce4/0xfa8
> >  do_filp_open+0xb0/0x164
> >  do_sys_openat2+0xa8/0x264
> >  __arm64_sys_openat+0x70/0xa0
> >  el0_svc_common+0xc4/0x270
> >  el0_svc+0x34/0x9c
> >  el0_sync_handler+0x88/0xf0
> >  el0_sync+0x1bc/0x200
> > 
> >  DMA32: 4521*4kB (UMEC) 1377*8kB (UMECH) 73*16kB (UM) 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 30268kB
> >  Normal: 2490*4kB (UMEH) 277*8kB (UMH) 27*16kB (UH) 1*32kB (H) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12640kB
> > 
> > Signed-off-by: Yong-Taek Lee <ytk.lee@samsung.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
