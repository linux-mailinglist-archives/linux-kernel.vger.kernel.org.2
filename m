Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EAD3D95DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhG1THV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhG1THU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:07:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D716C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:07:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627499235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKk5/Wd/N06x6jroDzZaBff6x8l6hFH/jGW8Eg3T2ro=;
        b=EkEt/IixvRlr+a+Y3KOf2igggkpmXi1HWTK1doa0wYr0CYziPb5SMpZW5c+44tD/YcLv3U
        FyuGdX8ZqlwNxLRy2M6z3u192TSglCfuoHJA3oAD9Om0hpBkjOua7amwyKklrDTF3USsjg
        Yli5H2udZvWT0iEn9HSIhozN+Opg67BZvYizb1FWBrCaPxdYZyHL4fjKoX1nS9b0X4UTfp
        GGEEwkRyTqTHjY1U0C0u/Uj9lIJk7IoEZCTNOUJ0QucWHz4o8zU/JM6Sfh3OR1VG/wZ+y1
        KHi9FxWL+rLFbQA23WDzmLqKgBFcJCvUCoSpoSwt7jRDb641CjtEsbE45yzOtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627499235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKk5/Wd/N06x6jroDzZaBff6x8l6hFH/jGW8Eg3T2ro=;
        b=S9rFrKiETQmNfWmidlHpa253RPKGUb/z5brPEAZjCKGKqk65BPkiEMDgQ3CeNohLMfX6AH
        +EgjColZwGJ99eBw==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
In-Reply-To: <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
 <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com>
Date:   Wed, 28 Jul 2021 21:07:14 +0200
Message-ID: <875ywujlzx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28 2021 at 12:21, Paolo Bonzini wrote:
> On 28/07/21 10:06, Thomas Gleixner wrote:
>> On Wed, Jul 14 2021 at 12:35, Paolo Bonzini wrote:
>> Yes, that cures it, but if you think about what this wants to prevent,
>> then having the recursion counter per CPU is at least suboptimal.
>> 
>> Something like the untested below perhaps?
>
> Yes, that works (it should just be #ifdef CONFIG_EVENTFD).

Yup and it lacks an include.

> On !PREEMPT_RT the percpu variable consumes memory while your patch uses 
> none (there are plenty of spare bits in current), but it is otherwise 
> basically the same.  On PREEMPT_RT the local_lock is certainly more 
> expensive.

Let me send a proper patch for that.

Thanks,

        tglx
