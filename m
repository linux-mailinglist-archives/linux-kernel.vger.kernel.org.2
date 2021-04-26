Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6AB36B4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhDZO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:27:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34468 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:27:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619447228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/+k3N8n6/WIVCQu+lly6Hn9RW/dNcFcUW7Skdd63yY=;
        b=3oFSsIXbq7VNt/K6ZtQ5HZEiJUl9D+BNR34FO4CbOzC8p2hpIeNQ4CxoUygWuLruM2+MBd
        kAu85LRaj/bmHD6O0PObm973VNWEgwfIZM/fz9BqTBftgXHsqCJx8nQ2QTJT0EauDEXTbD
        +Y0gcOz6UytzkmJWZOHCdwwFmbpWipOAb8U34N7RjSnmtKQAOBXA85C3cNlrEJRJhjXgnb
        eJnbrNV/qJcJsWhZYs1JgdEsCu/vePkP5Xd2njipxxaviQpq0+Ty0fXgHVh5oVBMlXTog8
        1WOdJgi4glg7ZdBNtRJhW2KuW2t4dD1zcI28Brr/jwfKfQnZwiV2Hv408JIytQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619447228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/+k3N8n6/WIVCQu+lly6Hn9RW/dNcFcUW7Skdd63yY=;
        b=bta4INy9h/vbbhRmuKW/y9z6XYWf6g1F1/3c6MCvGGxQmML75ocG2dIa867/Fr3+YtAmZi
        PQrLtrUlLPf46MDA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()
In-Reply-To: <YIa0qWdxM7vIsf/4@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com> <87eef5qbrx.ffs@nanos.tec.linutronix.de> <87v989topu.ffs@nanos.tec.linutronix.de> <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net> <87sg3dtedf.ffs@nanos.tec.linutronix.de> <YIa0qWdxM7vIsf/4@hirez.programming.kicks-ass.net>
Date:   Mon, 26 Apr 2021 16:27:08 +0200
Message-ID: <87k0opt937.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 14:40, Peter Zijlstra wrote:

> On Mon, Apr 26, 2021 at 02:33:00PM +0200, Thomas Gleixner wrote:
>
>> >> +	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
>> >> +	force_local &= base->cpu_base->next_timer == timer;
>> >
>> > Using bitwise ops on a bool is cute and all, but isn't that more
>> > readable when written like:
>> >
>> > 	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases) &&
>> > 		      base->cpu_base->next_timer == timer;
>> >
>> 
>> Which results in an extra conditional branch.
>
> Srlsy, compiler not smart enough?

gcc 8.3 is definitely not ...
