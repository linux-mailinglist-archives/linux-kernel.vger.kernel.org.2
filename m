Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33243E53C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhHJGqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhHJGql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:46:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC175C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:46:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628577978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFP9ghY8Fg5e+/EYvbpFTDNqoMQvRI/FsSOV8DUq0rk=;
        b=UwzOxTG+NI0SOoFaBwwE3YZoVB3ljP7GUsCJFRmtz9uTkmshMMIxSi13aJVgcLY0gJ+b7P
        NuQyEwtYr1mfumoJH61PY1Rg05QBAOf5wthnYUL9nn8WJBPEA1gT7BJvsb/TE91R7z7Dq7
        l8S19wsg3xdeDAwEfmHztj36UApSXLKOhrUuGEWslWj4iHAgyi2WIj6UVteHoGFXHykybp
        YBMHwyfUq6+s/dXmy2V3F++jTOQ/h62VedhnF/egQ05BAnQ1Pj57Udr3J51FDP6Fm0DJel
        T+htlLuAK5oGzXYk4qfPlo/pQTLSCf8VY9PPoEamJoy4onjZNqn/d1eJHvVr9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628577978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFP9ghY8Fg5e+/EYvbpFTDNqoMQvRI/FsSOV8DUq0rk=;
        b=nr3dWOR7qRQKWCa6Hlnou999JzDJjlGCpmryTpaa8vP2HRgLVYkvJ8XF8DI5ffquEac0f7
        1QRo6W4u5gFdKqAQ==
To:     blinkin@email.it
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Bug report for kernel v4.15-rc8+
In-Reply-To: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it>
References: <629765464.1655403.1628264743080.JavaMail.zimbra@email.it>
Date:   Tue, 10 Aug 2021 08:46:17 +0200
Message-ID: <87tujxssp2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2021 at 17:45, blinkin@email.it wrote:

> I'm not sure where and how to report it, the kernel I used for the
> tests is built from the opensuse tree but it looks like an upstream
> bug.  Can you give me pointers on how to proceed from here? I can
> provide informations about the symptoms, the hardware config and the
> workaround but I know nothing about CPU/IRQ management in the linux
> kernel.

Detailed information about the problem would indeed be helpful.

Thanks,

        tglx
