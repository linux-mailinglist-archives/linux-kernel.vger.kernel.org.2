Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F054391248
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhEZI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:28:28 -0400
Received: from ni.piap.pl ([195.187.100.5]:34466 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhEZI21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:28:27 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 4658B444197;
        Wed, 26 May 2021 10:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4658B444197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1622017611; bh=3LRQt2E5u2Et0YwP2CERJJ7UAiUDgL0XQ3wycJ4BWRY=;
        h=From:To:Cc:Subject:Date:From;
        b=MFDncosxgB1wXc2KmWoV/9r+W9SJJ2HjJbbB3Ns9fO5uBnU9ry0kYNfX4SWjK7UNk
         RQO/CSX7YwltiuDuOnU2k5O5O7KP9rkXUyfMlotFPWFnvMgVWPh4DJm09UGn90tSkP
         DXP03CMpbXiw25WTclU2k0oRd0cEZ1eFCSUTfhwM=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Data corruption on i.MX6 IPU in arm_copy_from_user()
Sender: khalasa@piap.pl
Date:   Wed, 26 May 2021 10:26:50 +0200
Message-ID: <m3y2c1uchh.fsf@t19.piap.pl>
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

Hello,

I've encountered an interesting case of data corruption while accessing
IPU (Image Processing Unit) on i.MX6 (rev1.2, Cortex A9). What I'm doing
here is basically:

openat(AT_FDCWD, "/dev/mem", O_RDWR|O_SYNC) =3D 3
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x2630000) =3D ptr
write(1, ptr, 32)                =3D 32

Normally, the write() should end up with:
 04008A00 02FF03FF 02FF03FF 00000000 00000000 00000000 00000000 00000000

However, with current kernels, the first 32 bits (the first IPU
 register) are dropped:
 02FF03FF 02FF03FF 00000000 00000000 00000000 00000000 00000000 00000000

0x2630000 is IPU1 CSI0 address (i.e., a register block). The same
happens with other IPU regions. Writes shorter than 8 * 32 bits are not
affected.

write() uses arm_copy_from_user() and since commit f441882a5229:
    ARM: 8812/1: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS

    ARMv6+ processors do not use CONFIG_CPU_USE_DOMAINS and use privileged
    ldr/str instructions in copy_{from/to}_user.  They are currently
    unnecessarily using single ldr/str instructions and can use ldm/stm
    instructions instead like memcpy does (but with appropriate fixup
    tables).

apparently uses 8 * 32-bit ldmia instruction to copy data:
    .macro ldr8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
    USERL(\abort, ldmia \ptr!, {\reg1, \reg2, \reg3, \reg4, \reg5, \reg6, \=
reg7, \reg8})
    .endm

Before this commit it used ldr instruction (single 32-bit value) and the
problem didn't show up (reverting f441882a5229 on v5.11 fixes it as
well). The i.MX6 errata doesn't seem to list this problem.

I wonder what the theory says about this case. Is it at all valid to
read 8 IPU registers at a time using LDM instruction? If so, should
something be done with this problem, or should it be left as is?
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
