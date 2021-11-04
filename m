Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28534445711
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKDQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhKDQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93DC06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:18:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636042709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSqcLy+DUHQRd9FuNWlvzSLgx+Fm62O+vLwxzUq6H/M=;
        b=bD7pBJSO/BC18bv/zf4ftodRlJ1yAKpX3XY+ICZVolh2cC3E7JeUR0B9MpAOY7r/eOZsoU
        S8LWjW9pwpp3CFRSe/Tt57xSb9on9cAggmUvvVqx5stF0QODXEDoK4Y4CC5mTgBG1tivlM
        7BCfABCOX8FtUJmOQjOkN3O2jF74G0ReyqRdxhu+nZovLNPKD65Gr9GU4sVYKfMzpwOwJ5
        7J0uruyU16uS6SLJNjay0jcoUmlc0lssk9Fz1Jy2SVmNzmzdLvTdCaRZUIaX8O72SWy+KW
        1VEdRzG39SEwkQR4tP4yIbXvykcE17jv/GuDdQfD3Y0pxDedTcQbNSS3dugsFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636042709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSqcLy+DUHQRd9FuNWlvzSLgx+Fm62O+vLwxzUq6H/M=;
        b=x652L11rOgwIvWYYS5x79GbxANiBef1U4bQTqIu1H1skRsctsncZG5CQcE1kpNVGEAKkkF
        GLUQmXHvEpjclxBA==
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Removal of printk safe buffers delays NMI context printk
In-Reply-To: <1636039236.y415994wfa.astroid@bobo.none>
References: <1636039236.y415994wfa.astroid@bobo.none>
Date:   Thu, 04 Nov 2021 17:24:28 +0106
Message-ID: <87ee7vki7f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
> It seems printk from NMI context is now delayed indefinitely and
> there is no printk_safe_flush equivalent (or I can't see one) to
> allow a NMI buffer to be flushed by a different CPU.

NMI flushing is triggered using irq work (for the same CPU). This should
not have changed recently. Are you reporting a new issue?

> This causes hard lockup watchdog messages to not get shown on the
> console. I can call printk from a different CPU and that seems to
> flush the stuck CPU's NMI buffer immediately.

Perhaps we should be triggering the irq work on multiple CPUs if from
NMI context?

> What's the best way to expose this? Can we have something like tihs?
>
> void printk_flush(void)
> {
> 	preempt_disable();
> 	if (console_trylock_spinning())
> 		console_unlock();
> 	preempt_enable();
>         wake_up_klogd();
> }

We are planning on implementing a pr_flush() that will do something
similar. But I am wondering how you are planning on triggering a CPU to
call that function.

John Ogness
