Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A13BE61E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhGGKG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:06:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A5C061574;
        Wed,  7 Jul 2021 03:04:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625652251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4d+X+0oh7pLRmIT4Tm+7PRFWAQYzplz4q7LBd0lrGI=;
        b=sL98hjZqm+h0kRcLs1YYzAgxBwL8RHynHt5cJpwBWwaKK1YyqOJleoTKS6QdlYQKJyvoDo
        OVMeBZv2CFLQdCnRaXOoPa9+Idpx5wH5T9RWrsPg9QSyKsJgiVriudjCOrpwaTULTHUVvK
        BrtqDXVHikDeh7oc27vBXsf4hSS9pLEJmQ7vutzfn8UXKsupH0VrrE3rVvUEzUdF1M+F24
        jlQ2QNX28gYx+EzLeokz9C9P5pkGzQtP+b4kiq8BZvYPjEvSBxnpxe2rFoHJCOOrTgHJJd
        /AeGfCO34SyxRe2SXtvgNUrzle0UjQ6t5SBGMnPKJPAvsDv4gAxwgI38zVplrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625652251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4d+X+0oh7pLRmIT4Tm+7PRFWAQYzplz4q7LBd0lrGI=;
        b=yCcETyJtZUh7eHrpcXLzRjuIs+A5rrhW8VNZjstKw/MkjiDicrP9QvRmIISczVjY+OOEnm
        QjkQxuds7kQTUbDQ==
To:     "zhaoyan.liao" <zhaoyan.liao@linux.alibaba.com>, mingo@redhat.com,
        hpa@zytor.com, dwmw@amazon.co.uk
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com,
        "zhaoyan.liao" <zhaoyan.liao@linux.alibaba.com>
Subject: Re: [PATCH] use 64bit timer for hpet
In-Reply-To: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com>
Date:   Wed, 07 Jul 2021 12:04:11 +0200
Message-ID: <875yxmqw2s.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liao,

On Fri, Jul 02 2021 at 16:13, zhaoyan liao wrote:
> The kernel judges whether the tsc clock is accurate in the
> clocksource_watchdog background thread function. The hpet clock source
> is 32-bit, but tsc is 64-bit. Therefore, when the system is busy and the
> clocksource_watchdog cannot be scheduled in time, the hpet clock may
> overflow and cause the system to misjudge tsc as unreliable.

Seriously? The wrap-around time for 32bit HPET @24MHz is ~3 minutes.

> In this case, we recommend that the kernel adopts the 64-bit hpet clock
> by default to keep the width of the two clock sources the same to reduce
> misjudgment. Some CPU models may not support 64-bit hpet, but according
> to the description of the CPU's register manual, it does not affect our
> reading action.

So much for the theory.

> -#define HPET_MASK			CLOCKSOURCE_MASK(32)
> +#define HPET_MASK			CLOCKSOURCE_MASK(64)

How is that valid for a 32bit HPET? This breaks the clocksource.
 
> +inline unsigned long hpet_readq(unsigned int a)
> +{
> +	return readq(hpet_virt_address + a);

Breaks 32bit build immediately.

Aside of that the reason why the kernel does not support 64bit HPET is
that there are HPETs which advertise 64bit support, but the
implementation is buggy.

IOW, while this works for your hardware this breaks quite some parts of
the universe. Not really a good approach.

Thanks,

        tglx
