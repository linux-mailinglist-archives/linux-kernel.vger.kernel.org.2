Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2933DC87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhCPS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:26:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43628 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCPS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:26:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615919162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+G5l2ZyXKfPHWIjfEkFRDIpP0OgtWKQdZM7dN4jPv1U=;
        b=xUkS0kG4omrjwop5jDWp+T4Qz3nAxQLDt8xud+XYe5Ah0h6Ny7/F3FKOlSZR1JRVGMU4GP
        AgtYn1zX/+/n4X4wz+xxAL9NnpI2Py6LSIZxq2GZCmsK5i3vw/QHZ3AhRnaCzrPKBd7EaO
        rbXYG8tobyrmEELV3wiZJZgQlZurwpFcxTp3TmvhjzqrXZ6Kg/60F1jjZXt9uSHqlYYAk2
        zdjgA1cBscis1Nej3yojo9uJVGUYafuDqjTW8CTBAiUumjmZLF37R91n585YkNXYyndUrv
        hnyzM2jxc05UafJbmew1ePBzMzeh2P5Aslkf1BvaJckXtVwViB0i28Q7QD/QQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615919162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+G5l2ZyXKfPHWIjfEkFRDIpP0OgtWKQdZM7dN4jPv1U=;
        b=HhowCkxdMPqJjyCBuXzCZv6hPm1yiFkPUiVzl2tN6dHcVkWXCOlcb9TiE1w5yhHqIbYzc2
        iidN/AqFzqKQDmAA==
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
In-Reply-To: <20210316181022.GA25986@redhat.com>
References: <20210201174555.GA17819@redhat.com> <20210203231944.GA17467@redhat.com> <20210316181022.GA25986@redhat.com>
Date:   Tue, 16 Mar 2021 19:26:01 +0100
Message-ID: <87r1kfymyu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16 2021 at 19:10, Oleg Nesterov wrote:

> On 02/04, Oleg Nesterov wrote:
>>
>> It seems that nobody objects,
>>
>> Andrew, Andy, Thomas, how do you think this series should be routed?
>
> ping...
>
> What can I do to finally get this merged?
>
> Should I resend once again? Whom?

I'll pick it up then
