Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8303CC012
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGQA1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGQA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:27:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:24:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k20so11578043pgg.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kapKSccYf+3d8IEDbRUj0u/6LBJIHmDYeekKIvB07CM=;
        b=QuPsbhLsvtd9XpYR91VosjMB3PPm7XoKqQ6bSM7zU6K4f+gIZy2K1PS2oodCR/B18p
         Yz6wCLfZGeHBy1z9kRR9G4wgFRm7d61JzEsZHA+6wgD25K6Ly2FKbrd01HXNCL4U6hcb
         7bIR+OqDG2FMe7TiHbP0UfPrSbNY6zOaXWZa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kapKSccYf+3d8IEDbRUj0u/6LBJIHmDYeekKIvB07CM=;
        b=F5CAHG7aOnqSZIzJXqSpdoe6B7XZZA2Ii7rCB1wgxjpwca03bYKDKAM3LcBosoXkS/
         5YacFNla+WmHwNd1aptpVqKopF5kY7IHOa4vqYfC2JRbVHp4SyOVf4TNWndJGE/TJuOW
         13QJhUwKY0msnlbrntOQ6Uf57AcXAa/yJON/UqAv9hZWP0FG8qxy9Cmw/sRTvxCf/Zy2
         MdkQaJZhQPZELOtpYquxAVnwmInB5g/8OdBgUExV5yil1GAM3T/jl0IrvytvBZlQ8Zr8
         k64aqmCrwvCs+YRybQkLmEm9obfbF6iF+vwO1Qsx95J3vWWnOlA92iZoMnptrqQxp5Ec
         BPkQ==
X-Gm-Message-State: AOAM532cuz31ih6dghiXI46Pefw3x0izOXYQ+x/hlzcQsTHR3lKdWbfK
        r56F3ysV8aUPJ9IaSQdqVIIYaw==
X-Google-Smtp-Source: ABdhPJzaA08Bg4H8f+oxijbl0pXZESDDUpg8+o2qUI2cA0P+MmccR8kd9Gy5hbpsXo1yaCaxLOIyHQ==
X-Received: by 2002:a63:d014:: with SMTP id z20mr12457261pgf.203.1626481490358;
        Fri, 16 Jul 2021 17:24:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:9be5:9410:eeb8:524e])
        by smtp.gmail.com with ESMTPSA id o25sm12819698pgd.21.2021.07.16.17.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 17:24:49 -0700 (PDT)
Date:   Sat, 17 Jul 2021 09:24:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/kvm: do not touch watchdogs in pvclock
Message-ID: <YPIjS2ZTksEkeiqK@google.com>
References: <20210716053405.1243239-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716053405.1243239-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/16 14:34), Sergey Senozhatsky wrote:
> 
> <IRQ>
> apic_timer_interrupt()
>  smp_apic_timer_interrupt()
>   hrtimer_interrupt()
>    _raw_spin_lock_irqsave()
>     lock_acquire()
>      __lock_acquire()
>       sched_clock_cpu()
>        sched_clock()
>         kvm_sched_clock_read()
>          kvm_clock_read()
>           pvclock_clocksource_read()
>            pvclock_touch_watchdogs()
> 
> Since this is VM and VCPU resume path, jiffies still maybe
> be outdated here, which is often the case on my device.
> pvclock_clocksource_read() clears PVCLOCK_GUEST_STOPPED,
> touches watchdogs, but it uses stale jiffies: 4294740764
> (for example).

Hmm, on the other hand, there is probably nothing that guarantees
that the first watchdog hard IRQ we execute on a resuming VCPU is
going to see updated jiffies, it still can use stale jiffies.
