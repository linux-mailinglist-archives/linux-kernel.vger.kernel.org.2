Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A163CACA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbhGOTki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244292AbhGOTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:14:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C49EC613E7;
        Thu, 15 Jul 2021 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626376213;
        bh=6JATwP12G/64FbgrNsJhSq7lJ8aC9o29Lv6SkZrlzBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRNml4EfeuuMepcf8Ddg+iSQfsisogeavWlogEFjsnsBHRnvMXm4I9YVN7gmyUK/1
         +MFMN+b5FbQacwZ07wx9rA07XG3h8w4MHnwl3d1dwESW696WB67dA9sE4u3j078QVg
         ELGhDwldinnton07iBt4if6qr1HFtliKP5l05ae8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolaus Schaller <hns@goldelico.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20 ?= 
        <zhouyanjie@wanyeetech.com>, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 176/266] MIPS: CI20: Reduce clocksource to 750 kHz.
Date:   Thu, 15 Jul 2021 20:38:51 +0200
Message-Id: <20210715182643.011387382@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715182613.933608881@linuxfoundation.org>
References: <20210715182613.933608881@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

[ Upstream commit 23c64447b3538a6f34cb38aae3bc19dc1ec53436 ]

The original clock (3 MHz) is too fast for the clocksource,
there will be a chance that the system may get stuck.

Reported-by: Nikolaus Schaller <hns@goldelico.com>
Tested-by: Nikolaus Schaller <hns@goldelico.com> # on CI20
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 8877c62609de..3a4eaf1f3f48 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -525,10 +525,10 @@
 
 &tcu {
 	/*
-	 * 750 kHz for the system timer and 3 MHz for the clocksource,
+	 * 750 kHz for the system timer and clocksource,
 	 * use channel #0 for the system timer, #1 for the clocksource.
 	 */
 	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER1>,
 					  <&tcu TCU_CLK_OST>;
-	assigned-clock-rates = <750000>, <3000000>, <3000000>;
+	assigned-clock-rates = <750000>, <750000>, <3000000>;
 };
-- 
2.30.2



