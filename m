Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCC315D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhBJCfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhBJCQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:16:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:16:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o7so239809pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BeDrXvxhQbdckvcpLsPaAD5HRfrqUrYQwMz31lS7sPA=;
        b=p6wg8fSQZr+H1f/MAarzTysWT12G/aqlZF6cUODPJ0KKvcR6L/o4ThHDOJ0G6Iip08
         bhO5ePg0Y9bdoPDH6rFqF7Di0XZnp+83z9suBManNfAd2h2F0vZAFLFk7GFzZtBd/PMx
         HgO6Y+yFRx0OP2jklzlds16Kb2dcNjYPH6YSv/FohJqQaFtKEw92qVY/q3c8YjZEfcyo
         8NoGW2YVwYQlMmjpaoTLKWCUS8JRqvPD17ZhXWzAVdRv0IUH5K5axwVHs/6pW41Dx4eC
         hgdg5GtlH2L2ZFtZy5xW0ZlbIGaLEqZM+7bbVh9PNgWwDN5f70oY0bNb7TWZmfBQSRP4
         SrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BeDrXvxhQbdckvcpLsPaAD5HRfrqUrYQwMz31lS7sPA=;
        b=LE0ONbu1kzvGznhVkUQEUCVwN06dQ7K6uQ/4tnD2n6vAQSR/sEza9s/WEN9t+luV3I
         Kk55R/Fs1k6Fwx1qNAx+JWwzNNMi93jYlwnqMAap9Zzi7133/ntxk+7Rpf4nzkS+eCDv
         OX2LwieFcjQGBcnKv0ag6iFI1aftCr5J1xjzEqlT6E9N/d+8MyZCqGa21w9UmAiwKPLZ
         /dhl5nzfyWGmHgV9P3CPmmc4NtaGk9aSjgDP5Z00w2M++j0IdoGLE+yYwYV7GzzlZhph
         Etkxtkc08PG3IRWdfbMXCEwOOVz1n0IKLIHvxNNFYkA9pkGGJr856cnuHUDsVoJFyKOe
         fTeg==
X-Gm-Message-State: AOAM5306vyHxdV6cyorYLr7GrC6D5n5xLD3Vm2o/ByxQNqW/jiRfg7JB
        MBjgfmOAY/CEuTxxn4/Y0aU=
X-Google-Smtp-Source: ABdhPJwzOhYWeWhhNIJPNa7r/PYroUWXCP46DUamo4guTqRPR0ZFUZyH2FISOOICIUFHbmH1S2HWwg==
X-Received: by 2002:aa7:8184:0:b029:1e5:1e7a:bcc0 with SMTP id g4-20020aa781840000b02901e51e7abcc0mr885695pfi.73.1612923366701;
        Tue, 09 Feb 2021 18:16:06 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id g6sm223106pfi.15.2021.02.09.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:16:05 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:16:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCNB492X/HcFT5xl@jagdpanzerIV.localdomain>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
 <YCJTrrirMlH7M5i7@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCJTrrirMlH7M5i7@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/09 10:19), Petr Mladek wrote:
> On Sat 2021-02-06 13:41:24, Muchun Song wrote:

[..]

> What about the following commit message? It uses imperative language
> and explains that the patch just prevents the deadlock. It removes
> some details. The diagram is better than many words.
> 
> <commit message>
> printk_safe_flush_on_panic() caused the following deadlock on our server:
> 
> CPU0:                                         CPU1:
> panic                                         rcu_dump_cpu_stacks
>   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
>     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
>                                                     __printk_safe_flush
>                                                       raw_spin_lock_irqsave(&read_lock)
>     // send NMI to other processors
>     apic_send_IPI_allbutself(NMI_VECTOR)
>                                                         // NMI interrupt, dead loop
>                                                         crash_nmi_callback
>   printk_safe_flush_on_panic
>     printk_safe_flush
>       __printk_safe_flush
>         // deadlock
>         raw_spin_lock_irqsave(&read_lock)

[..]

I would also add to the commit message that it avoids the deadlock
_in this particular case_ at expense of losing contents of printk_safe
buffers. This looks important enough to be mentioned.

	-ss
