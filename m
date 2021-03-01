Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BB327A86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhCAJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:14:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhCAJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:13:59 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614589997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eaN0GLkpvxq4H2WhMZJuMDc0+wEhRVfWSwLjNj11LuQ=;
        b=121e2GMlQ72jXhYmjUf15Hdbe6efchPOnDmntbthSNGfOUOjPfBLZiKHCmfGbGYbBb2vWs
        kOlT6d3CnZNcVTzM6Bod/NNlBkRNO/KR6hhchZWyhPALp1NDt6u3Qecq7J2dfZ1XDaHKYE
        L2jYuZwjbdJ0BuY1HgNWMp6KH30aqQf2hqn2x0EhDumWvmUd3DpSDwOaN/ondeM6zXDfQe
        xQ910hwVg32V1k0knNjOpp/om+456xfZqUTfYIsHZRrEEVdc0g8abU4A1lDDFSmVCteVwt
        quKXMHdPqMcAuaxIe29C2s9mc/9EHA3nnTtwkmuxAQmg4WP8Jf/43GuB8tUB4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614589997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eaN0GLkpvxq4H2WhMZJuMDc0+wEhRVfWSwLjNj11LuQ=;
        b=Ei1why0BXayLBKwouqVb+nsd81oTknwh7ZuguNBV9QkkPCD0Hd+Aann7VaoN3RD9MF0lUD
        limwh7JoVumBcLAg==
To:     Mikael Beckius <mikael.beckius@windriver.com>,
        anna-maria@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mikael.beckius@windriver.com
Subject: Re: Sv: Sv: [PATCH] hrtimer: Interrupt storm on clock_settime
In-Reply-To: <20210225111814.8383-1-mikael.beckius@windriver.com>
References: <alpine.DEB.2.21.2102231638540.1861@somnus> <20210225111814.8383-1-mikael.beckius@windriver.com>
Date:   Mon, 01 Mar 2021 10:13:17 +0100
Message-ID: <87k0qrtexe.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micke,

On Thu, Feb 25 2021 at 12:18, Mikael Beckius wrote:

>> The proposed change breaks the reprogramming logic. To keep it working
>> cpu_base::*expires_next is only updated by hrtimer_reprogram() and
>> hrtimer_interrupt(). I will send you a patch for testing in reply to this
>> thread. The patch is compile tested only.
>> 
> Ok. I kind of guessed that would be the response as I noticed a similar comment
> during the review of the original patch which introduced the softirq_expires_next
> logic. Anyway it seemed logical to update softirq_expires_next
> when updating softirq_next_timer.

yes it seems logical to do that, but unfortunately the logic there is a
bit twisted and could do with some deobfuscation.

Thanks,

        tglx
