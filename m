Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D13402D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCRKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:10:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCRKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616062207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YV79GQE7RAvEFxHJLf8jtJW4XGj4ZQ7NMj/seY0rDi0=;
        b=2N2x7NqRIu5Nh3AkQJSt8Q+r7uXXEaeJ1hpTF/07Y4iKum0BYLNTp1CuF7cmddSyXk+qN2
        5WSc6ACHsHDtdqzBSGC7aXoKPxrryxx23JTyvROF4CW/Fuxw60S3XDt9g3QFefeWIbNo+K
        h/TJeRErl7XoKWvyaqF+jvIHbZ/ux1gEt/1tuKitNSlqlqoIRXANy5ma0sx60X6OARp19g
        UJIQ0br3jHRp/CUDYjdRbny6t3vDTHBUeB8NF4dqVZi/g1iqtFV2FvP+ESwcpzg6REGLKe
        HqlKOdOtQHpv1o7TFa9RqlrcSke5VyEWsg66N4T6yjbzRKvFKylPvRC/6TxiYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616062207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YV79GQE7RAvEFxHJLf8jtJW4XGj4ZQ7NMj/seY0rDi0=;
        b=NKskUvh7mixZ4pjDcTeS09Wve00Vwpr6/08hL/WmIf9ZNMcjuc+F+ek9bsbQj36qQQs8JW
        f1ESXZq71kadd5AQ==
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
In-Reply-To: <87blbg7tlo.fsf@vitty.brq.redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com> <20210219113101.967508-2-vkuznets@redhat.com> <87im5py1ty.fsf@nanos.tec.linutronix.de> <87blbg7tlo.fsf@vitty.brq.redhat.com>
Date:   Thu, 18 Mar 2021 11:10:07 +0100
Message-ID: <87tup8wz5s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2021 at 09:29, Vitaly Kuznetsov wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Out of paranoia I'd rather ignore that IO/APIC pin completely if it
>> claims to be IRQ2. I assume there is no device connected to it at all,
>> right?
>
> The original issue was observed on Amazon's r5d.xlarge instance
> type. Your assumption seems to be correct, I don't see any device on
> IRQ2.
>
>>
>> Can you please provide a dmesg with apic=verbose on the command line?
>>
>
> Here you go, attached.

> [    0.931305] init IO_APIC IRQs
> [    0.931312] IOAPIC[0]: Preconfigured routing entry (0-0 -> IRQ 0 Level:0 ActiveLow:0)
> [    0.931316] IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)

There you go:

> [    0.931320] IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 2 Level:0 ActiveLow:0)

Yet another virtualization feature :)

Thanks,

        tglx

