Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64B35E792
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhDMUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDMUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:24:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618345469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puB3GJUkP344AQ6MQj+RwIsjsnRpeaZ2ypqnxOsH/TA=;
        b=izjZVUEjSvnlr5xGZ7zDind+IdlrIZ+35sp/DCrQt58QdytCKsviH8urj+ukR5N7u8Pg3l
        5AlQWLMKkeL0adLwN9ZCbI2HU6/jTRFqPF5x0mDVanPkkbP4sSQBwvnNJ+sNp/sWR3Ka3b
        TO+IBO1BfEkw1pinR4aWGIw+eLLJWRvvkEsOlpudRxNjHdy7aQlVHYPTPcDIKfRWIhG/X7
        yvk5XTF/QErq6fTDoAbKmjpaMrvpjToGTYqR2Yn6YsqcsY5rb3YfiCTQomW+i4J2pSnUwR
        QwTfx/oKRex8/tET3y+4ze+ZLO0+dCH+h47wN6GSUhv6PPntLAfdp1pcEIlb1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618345469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puB3GJUkP344AQ6MQj+RwIsjsnRpeaZ2ypqnxOsH/TA=;
        b=AStz3/WTa1zPeUMPPhSSiyO8mL/M52jaxyy0avpXn7bKAzksr9sZdNUhvsF4nny4B0JaPU
        HkLItS7PoN+fegAg==
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: reduce irqdebug bouncing cachelines
In-Reply-To: <b299bb0c-2997-6f6f-8646-4a7ecb2c79c0@kaod.org>
References: <20210402132037.574661-1-npiggin@gmail.com> <87im4u2vxx.ffs@nanos.tec.linutronix.de> <2dae4501-6f01-1b32-4b69-1dfc94c93425@kaod.org> <87wnt71xmm.ffs@nanos.tec.linutronix.de> <b299bb0c-2997-6f6f-8646-4a7ecb2c79c0@kaod.org>
Date:   Tue, 13 Apr 2021 22:24:28 +0200
Message-ID: <87tuoax79f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13 2021 at 14:16, C=C3=A9dric Le Goater wrote:
>>> We could test irq_settings_no_debug() directly under handle_nested_irq(=
)=20
>>> and handle_irq_event_percpu() to avoid calling note_interrupt(), just=20
>>> like we do for noirqdebug.
>>=20
>> We can do that, but then we should not just make it:
>>=20
>>    if (!irqnodebug && !irq_settings_no_debug(desc))
>>    	note_interrupt(...);
>>=20
>> Instead have only one condition:
>>=20
>>    if (!irq_settings_no_debug(desc))
>>    	note_interrupt(...);
>>=20
>> See the uncompiled delta patch below.
>
> I merged this second part with the first and gave IRQF_NO_DEBUG a try=20
> on P8 and P9 systems and all looked fine. I should send both patches=20
> after IRQF_NO_AUTOEN is merged in mainline.=20=20=20=20=20

Does having that NODEBUG flag set on the IPI irqs make a measurable
difference or is it just too small to matter?

Thanks,

        tglx




