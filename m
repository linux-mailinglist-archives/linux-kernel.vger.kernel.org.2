Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586B394096
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhE1KFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:05:24 -0400
Received: from ni.piap.pl ([195.187.100.5]:47424 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236134AbhE1KEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:04:49 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 4422C44423C;
        Fri, 28 May 2021 12:02:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4422C44423C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1622196173; bh=rBrr8No9YxW9GxRteQ/5coCNcDbxv/wQgs4N3978vXk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eGE0MnbetMS2eEZUzbFmwD29gGEtxpxbnwuSvMjeolTvuLLMFVnp+hInW8hzTHE6p
         YdQB50+FRr5kEX89uXgyDrd6Mg5QPvhWoYvwleaswpUw6sB8b91SK7sC47OoBYsgtu
         R/+jsPq0kEwjbKUttSO6MR2NLQJhnyJCsfEcX1zE=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Data corruption on i.MX6 IPU in arm_copy_from_user()
References: <m3y2c1uchh.fsf@t19.piap.pl>
        <20210526100843.GD30436@shell.armlinux.org.uk>
        <m3r1htu19o.fsf@t19.piap.pl>
        <20210526131853.GE30436@shell.armlinux.org.uk>
Sender: khalasa@piap.pl
Date:   Fri, 28 May 2021 12:02:52 +0200
In-Reply-To: <20210526131853.GE30436@shell.armlinux.org.uk> (Russell King's
        message of "Wed, 26 May 2021 14:18:53 +0100")
Message-ID: <m3h7intbub.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> In any case, looking at the architecture reference manual, LDM is
> permitted on device and strongly ordered mappings, and the memory
> subsystem is required to decompose it into a series of 32-bit accesses.
> So, it sounds to me like there could be a hardware bug in the buses/IPU
> causing this.

It seems so.

I modified the kernel IPU module a bit, initialized a bunch of IPU
registers to known values (1..0xD). Results (from 1 to 13 IPU
registers) obtained with different instructions:

readl(13 consecutive registers): CSI =3D 1 2 3 4 5 6 7 8 9 A B C D
1 =3D register #0 and so on - readl() results are obviously correct.

LDM1:  1 (not corrupted)
LDM2:  1 3
LDM3:  1 3 4
LDM4:  2 3 4 4
LDM5:  1 3 4 5 6
LDM6:  1 3 4 5 6 7
LDM7:  1 3 4 5 6 7 8
LDM8:  2 3 4 5 6 7 8 8
LDM9:  1 3 4 5 6 7 8 9 A
LDM10: 1 3 4 5 6 7 8 9 A B
LDM11: 1 3 4 5 6 7 8 9 A B C
LDM12: 1 3 4 5 6 7 8 9 A B C D

The last one uses:
        ldm r4, {r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip}.

I haven't tested more than 12 registers in one kernel LDMIA instruction.

The results don't depend on the address offset (adding 4, 8 or 12 to the
address doesn't change anything).

The arm_copy_from_user() is a specific case of the same corruption. It
uses a number of PLDs and 8-register LDMIAs (and then possibly LDRs
which don't fail). Each LDMIA ("LDM8") returns again:
LMD8:  2 3 4 5 6 7 8 8
(the same with subsequent LDMIAs: 10 11 12 13 14 15 16 16 and so on).

Summary: it appears all 64-bit and longer LDMIA instructions fail. The
first or the second 32-bit access is skipped (possibly somewhere between
AXI and IPU). In case of 4- and 8-register LDMs, the first (#0) value is
skipped, otherwise, it's the second (#1) value.


Now the PLDs ring a bell:
"ERR003730 ARM: 743623=E2=80=94Bad interaction between a minimum of seven P=
LDs
and one Non-Cacheable LDM can lead to a deadlock". Looking at the
disassembly I can count 6 PLDs (the first two seem to be the same,
though I don't claim I understand this (source) .s code). Also this
problem happens with IPU and not other devices, so I think it's not
related to this erratum after all.


size_t arm_copy_from_user(void *to, const void *from, size_t n)
... for n =3D 32 =3D 8 * 4 bytes:
2c: subs r2, r2, #4     ; =3D 28
30: blt  e4             ; NOP
34: ands ip, r0, #3     ; r0 =3D destination
38: pld  [r1]
3c: bne  108            ; NOP
40: ands ip, r1, #3     ; r1 =3D address in IPU
44: bne  138            ; NOP
48: subs r2, r2, #28
4c: push {r5, r6, r7, r8}
50: blt  88             ; NOP
54: pld  [r1]           ; duplicate PLD?
58: subs r2, r2, #0x60
5c: pld  [r1, #28]
60: blt  70
64: pld  [r1, #0x3c]
68: pld  [r1, #0x5c]
6c: pld  [r1, #0x7c]
70: ldm  r1!, {r3, r4, r5, r6, r7, r8, ip, lr} ; <<<<< fails

I also wonder if STMs may have similar problems - will check.
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
