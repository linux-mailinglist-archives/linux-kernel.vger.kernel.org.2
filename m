Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9F34D37C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC2PNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC2PNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:13:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:13:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617030811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAwcHh6VjZxvqu3eesE1syVGkWZBlzSGzupXo8CqfAQ=;
        b=IHRwqqJ/d8imEGKqIbKlA/qGFQR4bQ7Mhspabxdc3MX3R7eN5G7MQ4m5yMDEPE07Lv+phx
        zHEhhYkohJ8y/1HxidHAV34j6T1NDKgbBGWl861sk+fSQTqFBgAyx+mn+iamm2DCjBxNr8
        FSS5Pe4mAqzC65UdyPCNXbajLcCGJ7RH28rT2g8VbNzOtgT/36qjtM0xobnnIkx1daTNY6
        ct98FPnxEMo/We+aNUTa0BhSI17YnG4onDaQqN6q3BTiEy5TWC9ZhccI9GrfEQEEV2vbiJ
        RAdsnOm6LcHaaNMaxzoJHU7fUWyXNWeo2tkJ24JgIIySm8sS4q3ecgzXOE6HTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617030811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lAwcHh6VjZxvqu3eesE1syVGkWZBlzSGzupXo8CqfAQ=;
        b=U8WYssHxW3bwbN8MrVn1MezAusXrDPWH1/e3X2mo5XDOhiiwBibO2wcYpGLnSm7tmW4Q/W
        +BAOUaJ5F1W6NoAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <87sg4e6lo5.fsf@jogness.linutronix.de>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-3-john.ogness@linutronix.de> <YFnHKlCvIA2nI41c@alley> <87pmzmi2xm.fsf@jogness.linutronix.de> <YGGmNu5ilDnSKH3g@alley> <87sg4e6lo5.fsf@jogness.linutronix.de>
Date:   Mon, 29 Mar 2021 17:13:30 +0200
Message-ID: <87o8f26lid.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-29, John Ogness <john.ogness@linutronix.de> wrote:
>> Will you call console write() callback with irq enabled from the
>> kthread?
>
> No. That defeats the fundamental purpose of this entire rework
> excercise. ;-)

Sorry, I misread your question. The answer is "yes". We want to avoid a
local_irq_save() when calling into console->write().

John Ogness
