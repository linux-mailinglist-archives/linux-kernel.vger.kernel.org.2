Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01123C1FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGIHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhGIHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 03:00:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007BC0613DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 23:57:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f13so21140335lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNwCztH9soNCj1/VUtznwJJ6LKaeAxleMqtHhooZqvM=;
        b=lDYXpuL5XrtcRyW0xunY6csyLpkPzY3oEFgZstyQTVwzB06dxVDIPhMkbRiRQKy9Se
         +2FARTttJsQgpRScH6yuAttPM0141pVlPxWzTPkCook3DwgW/QwY1WNwVNj0WbdCeXs9
         RdblqBjP2bYDQfcGskrvimzghUvdcn/V2mMGKtGVsIJDQJ/k28xCLy8SzlF/fty1//dQ
         4pIxTU9VmW6/ujH9z8Pk3A8p4j9hU9zIEvHu1k13iKr/l1F9Doszy/HjnnloeWfi6asl
         RwwLMca5NLWIBXlfadAdosQxU/kIQdQN9tTQrzxldZ16nBnlJ2xrMk6aX0ms6AR75uCv
         +gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNwCztH9soNCj1/VUtznwJJ6LKaeAxleMqtHhooZqvM=;
        b=CM+489xRnDBAebS4Yluv+Y6eEQMdReV1QyCLrIkaYzcNB/83EFcEoxsaiNHuikPJYW
         p0sHMI7gY73MsmnHA1CwXxoVe+zy4dZ8VRS/3oVZAQ6dRFI3QNeCebSk/jrwLtVJTA8j
         NafU/imk2PAxg/I5Pb9RSFw8S5Jb5bEAxUZSCx623cR7vMI7Z2lqboz/v1PRNMxc5Msf
         lg2+cY8zQrie65XHD/maLKq7o5FljjAnFTqe3QNQvzWSc8KolsITSfmqeOTsoEvb7iQA
         adavf9xv//r5PuSv6//lNis5b6R06gOpmLTMXic7BmvzJsnadVbGCxfN6ekrxHX9YnvM
         V9XA==
X-Gm-Message-State: AOAM531612v45gU9dwPXQUXv7Xt2ZXOn3FRWulqwa1CQuPl+AMV1hcAv
        425GiZScFOAlH+eICFP9o8w=
X-Google-Smtp-Source: ABdhPJwYuGhWjn4GdtAm64j4cfXAtqQWVLK85UyCuM8gj8GZ+ozyIhbAf8kl2y7VI9xizWG1f42LyQ==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr27855430lfb.297.1625813873985;
        Thu, 08 Jul 2021 23:57:53 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id w17sm386110lfd.126.2021.07.08.23.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 23:57:53 -0700 (PDT)
Date:   Fri, 9 Jul 2021 09:57:45 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xu Qiang <xuqiang36@huawei.com>
Subject: Re: BUG in alloc_workqueue (linux-next)
Message-ID: <20210709095745.33a500c9@gmail.com>
In-Reply-To: <CAJhGHyBrm0iowGdX8=NDr=tBG8qM8rke2ouxWVhJRTP+pxXGJw@mail.gmail.com>
References: <20210708162417.777bff77@gmail.com>
        <CAJhGHyBrm0iowGdX8=NDr=tBG8qM8rke2ouxWVhJRTP+pxXGJw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 11:59:01 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> Hello, Pavel
> Thanks for the report.
> 
> Huawei (CC-ed) is also dealing with the problem:
> https://lore.kernel.org/lkml/20210708093136.2195752-1-yangyingliang@huawei.com/t/#u
> 
> 
> Could you have a try on the fix, please?
> 
> Thanks
> Lai
> 


Hi, Lai!

I am going to apply this patch to my local tree and let syzbot test the
fix for a day. Will reply to this email with results tomorrow :)




With regards,
Pavel Skripkin

> On Thu, Jul 8, 2021 at 9:24 PM Pavel Skripkin <paskripkin@gmail.com>
> wrote:
> 
> >
> > I've spent some time trying to came up with a fix, but I gave
> > up :( But! I have an idea about what's happening, maybe it will help
> > somehow...
> >
> >
> > So, all 3 reports have same stack trace: alloc_workqueue() in
> > loop_configure(). I skimmed through syzbot's log and found, that
> > syzbot injected failure into alloc_unbound_pwq() in all 3 cases:
> >
> > FAULT_INJECTION: forcing a failure.
> > name failslab, interval 1, probability 0, space 0, times 0
> > CPU: 1 PID: 17986 Comm: syz-executor.0 Tainted: G        W
> > 5.13.0-next-20210706 #9 Hardware name: QEMU Standard PC (i440FX +
> > PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org
> > 04/01/2014 Call Trace: dump_stack_lvl (lib/dump_stack.c:106
> > (discriminator 4)) should_fail.cold (lib/fault-inject.c:52
> > lib/fault-inject.c:146) should_failslab (mm/slab_common.c:1327)
> >    kmem_cache_alloc_node (mm/slab.h:487 mm/slub.c:2902
> > mm/slub.c:3017) ? alloc_unbound_pwq (kernel/workqueue.c:3813)
> >    alloc_unbound_pwq (kernel/workqueue.c:3813)
> >    apply_wqattrs_prepare (kernel/workqueue.c:3963)
> >    apply_workqueue_attrs_locked (kernel/workqueue.c:4041)
> >    alloc_workqueue (kernel/workqueue.c:4078 kernel/workqueue.c:4201
> > kernel/workqueue.c:4309)
> >
> >
> > So, if alloc_unbound_pwq() fails, apply_wqattrs_prepare() will jump
> > to this code:
> >
> > out_free:
> >         free_workqueue_attrs(tmp_attrs);
> >         free_workqueue_attrs(new_attrs);
> >         apply_wqattrs_cleanup(ctx);     <----|
> >         return NULL;                         |
> >                                              |
> > put_pwq_unlocked() -> put_pwq() ->
> > schedule_work(&pwq->unbound_release_work);
> >
> >
> > and apply_wqattrs_cleanup() will schedule
> > pwq_unbound_release_workfn() [2], but alloc_workqueue() will free
> > workqueue_struct in case of alloc_unbound_pwq() error [1]. In that
> > case we will get UAF in pwq_unbound_release_workfn() like in 3rd
> > report.
> >
> >
> > Does written above make some sence? :)
> >
> >
> >
> > With regards,
> > Pavel Skripkin
