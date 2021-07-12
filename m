Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF83C55A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhGLILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbhGLHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:31:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332DEC005F24;
        Mon, 12 Jul 2021 00:25:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626074738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icbIB7QTKPXqI/o8Y0H/OIL5w65Qd9ZrzW3+ozldd6k=;
        b=KIY5hoSrZleZkQd3Hr1NDdrVjxzCLM/ECRW+fWSNVeFZ6HqiY81KzsQV6Y2/NAwhLIMfO4
        pFw+tsKXA4mQLwuu1N3BHyRE/fgIHsmizXnInfHdl11nLJay6Lxn8mmoPTYmwTC3RQyyz4
        bfdEcJ7aRhCw6TIo99cnjO656sfcCBi3TSBURBmEKr1IZcfzKuYB3fEsP7OklV//9GbhMI
        UmPth8dCaBnPpW2rO3RaK3ZXcx0I2ArXu+Hi4RcCJzJwvX9EaKc6F9r9ess7ZLOkzi0IUA
        qAkOt8SeYYVF3CKtsYSjzLpS+GBn0/aCny4A1zBOxpUG0y9CgwfWVMq3fhHNPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626074738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icbIB7QTKPXqI/o8Y0H/OIL5w65Qd9ZrzW3+ozldd6k=;
        b=6SAQG5Jk/rtsvH7besLKDUpbdQKd3pcgfIe1n8Dl3FCahXf4nMtBqM5NuHtS2n4GIMFhIh
        +cYaVHiOn8aJtBDA==
To:     Linux <zhaoyan.liao@linux.alibaba.com>
Cc:     mingo@redhat.com, hpa@zytor.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        songmuchun@bytedance.com, likunkun@bytedance.com,
        guancheng.rjk@alibaba-inc.com, duanxiongchun@bytedance.com,
        wenan.mao@linux.alibaba.com
Subject: Re: [PATCH] use 64bit timer for hpet
In-Reply-To: <2CC6F5DA-B186-4A06-92B4-B763386F0D0A@linux.alibaba.com>
References: <1625213625-25745-1-git-send-email-zhaoyan.liao@linux.alibaba.com> <875yxmqw2s.ffs@nanos.tec.linutronix.de> <8A96C0F7-FBE4-4B23-8565-E814401BF927@linux.alibaba.com> <87o8bdoy11.ffs@nanos.tec.linutronix.de> <2CC6F5DA-B186-4A06-92B4-B763386F0D0A@linux.alibaba.com>
Date:   Mon, 12 Jul 2021 09:25:38 +0200
Message-ID: <875yxgngct.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liao,

On Mon, Jul 12 2021 at 12:52, Linux wrote:
>> Sorry, keeping the softirq from running for 3 minutes is simply out of
>> spec. If the sysadmin decides to do so, then he can keep the pieces.
>
> It is because the kernel thread is busy that the clocksource_watchdog 
> thread is not scheduled, not softirq.

Which thread?

The clocksource watchdog runs from a timer_list timer callback in
softirq context. Even if the softirq is switched to the softirq thread
then still my argument of starving that for 3 minutes still stands.

This is _not_ a kernel problem. Overcommitment is a admin problem.

Thanks,

        tglx
