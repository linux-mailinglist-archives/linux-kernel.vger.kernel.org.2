Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201C381649
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 08:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEOG0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 02:26:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42231 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhEOG0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 02:26:34 -0400
Received: from [IPv6:2601:646:8602:8be1:e512:4e99:5d16:dcc6] ([IPv6:2601:646:8602:8be1:e512:4e99:5d16:dcc6])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14F6P2uK3245252
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 14 May 2021 23:25:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14F6P2uK3245252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621059906;
        bh=K2JDn0iVIHW+Qwi8Co3+G0Lt201NrH/X9imNdm2N4FY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=mphwezTPdEDxoESNYe9uWi/iKoIcOfKQRzSrM/gyp+UBmAcQTOCYhauxv5wWaAGEd
         OwDDlzmPKJiTKhXVJ06y4RZgqcEebdDUw8KqDH2DL3MMv/XPP+FyVJ/t5jNe6DQjJ+
         k3VBDpqQmVMfumGfVYy+zfBEwgeJf/K1MSbzpoQq8HKwBFCEWmUywUpUS39+TC4HPG
         15Tlvt6IZINmKCp7Q8iqqar3f9rPNTdjV4BFbKfyv/scDzMCJlZaJznVRL9G/6oZFd
         xMNAewZocnaGe55sfBAcalCBIF6T1QB13kxGETDY7cCamteWSoSkxq5B78yr4hJ/7W
         7K6WB8kmwrSWw==
Date:   Fri, 14 May 2021 23:24:53 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20210515014400.2999028-8-hpa@zytor.com>
References: <20210515014400.2999028-1-hpa@zytor.com> <20210515014400.2999028-8-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/9] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <09189009-FB0A-4DFA-917E-F447EB21798D@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh=2E=2E=2E I could swear I had fixed the patch description=2E

On May 14, 2021 6:43:59 PM PDT, "H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote=
:
>From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>
>The current IRQ vector allocation code should be "clean" and never
>issue a IRQ_MOVE_CLEANUP_VECTOR IPI for an interrupt that could still
>be pending=2E This should make it possible to move it to the "normal"
>system IRQ vector range=2E This should probably be a three-step process:
>
>1=2E Introduce this WARN_ONCE() on this event ever occurring=2E
>2=2E Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range=2E
>3=2E Remove the self-IPI hack=2E
>
>This implements step 1=2E
>
>Suggested-by: Thomas Gleixner <tglx@linutronix=2Ede>
>Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>---
> arch/x86/kernel/apic/vector=2Ec | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/arch/x86/kernel/apic/vector=2Ec
>b/arch/x86/kernel/apic/vector=2Ec
>index 6dbdc7c22bb7=2E=2E7ba2982a3585 100644
>--- a/arch/x86/kernel/apic/vector=2Ec
>+++ b/arch/x86/kernel/apic/vector=2Ec
>@@ -939,9 +939,14 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_cleanup)
> 		 * to this CPU=2E IRQ_MOVE_CLEANUP_VECTOR is the lowest
> 		 * priority external vector, so on return from this
> 		 * interrupt the device interrupt will happen first=2E
>+		 *
>+		 * *** This should never happen with the current IRQ
>+		 * cleanup code, so WARN_ONCE() for now, and
>+		 * eventually get rid of this hack=2E
> 		 */
> 		irr =3D apic_read(APIC_IRR + (vector / 32 * 0x10));
> 		if (irr & (1U << (vector % 32))) {
>+			WARN_ONCE(1, "irq_move_cleanup called on still pending
>interrupt\n");
> 			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
> 			continue;
> 		}

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
