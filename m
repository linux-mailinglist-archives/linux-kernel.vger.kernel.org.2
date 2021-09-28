Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFC41AD03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbhI1Kd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:33:59 -0400
Received: from ni.piap.pl ([195.187.100.5]:50256 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240241AbhI1Kd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:33:57 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 6AE52C3F3EF3;
        Tue, 28 Sep 2021 12:32:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6AE52C3F3EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1632825133; bh=WoVDNhQMPQNf8fBFW/duGgdi5jbWcZ7Due6pY8dEoZo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dGf7SYmXeY2vuytf3b2Aruwno4eu87WKIQHGYE/PVh6e1FNoctpiOhdyBtdUp2RHj
         yoRE3ewLEFKkeFVxVliz3mhvp2rPkAKodOJi6NiD7xebQlWWMqNpj3a1VTZpxMvo1v
         82rGMHST/5kcuAom7FbQaxzsb/nf1ndiaj7v4l2k=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linusw@kernel.org, kaloz@openwrt.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: intel-ixp42x-welltech-epbx100 no longer boot due to
 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regression")
References: <YVLD/UMRYA55WiGI@Red>
Sender: khalasa@piap.pl
Date:   Tue, 28 Sep 2021 12:32:13 +0200
In-Reply-To: <YVLD/UMRYA55WiGI@Red> (Corentin Labbe's message of "Tue, 28 Sep
        2021 09:27:57 +0200")
Message-ID: <m3r1d9ng7m.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 166359 [Sep 28 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 462 462 1a6116ea9b31dd376a9cb3bdb1669e517de75784, {Tracking_Text_ENG_RU_Has_Extended_Latin_Letters, eng}, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t19.piap.pl:7.1.1;piap.pl:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/09/28 07:42:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/09/28 08:11:00 #17329835
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Corentin,

Corentin Labbe <clabbe.montjoie@gmail.com> writes:

> I am working on puting my ixp4xx board on kernelCI.
> But it no longer boot since 4.14.
> It only prints "Starting kernelUncompressing Linux... done, booting the k=
ernel." then nothing.
>
> I bisected the break to 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel=
 mapping regression")

I guess you build your kernel as big-endian.

These parts seem suspicious to me:

-    str r8, [r5]            @ Save physical start of kernel
+#ifdef CONFIG_CPU_ENDIAN_BE8
+    str r8, [r5, #4]            @ Save physical start of kernel (BE)
+#else
+    str r8, [r5]            @ Save physical start of kernel (LE)
+#endif

and

-    str r3, [r5]            @ Save physical end of kernel
+#ifdef CONFIG_CPU_ENDIAN_BE8
+    str r3, [r5, #4]            @ Save physical end of kernel (BE)
+#else
+    str r3, [r5]            @ Save physical end of kernel (LE)
+#endif

IXP4xx, being ARMv5, uses CONFIG_CPU_ENDIAN_BE32 (when configured as
BE), but it needs the ", #4" as well.

I'd test with: #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDI=
AN_BE32
--
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
