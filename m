Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5817936A330
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhDXV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 17:26:36 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:32860 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhDXV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 17:26:34 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 4ADD4F40540; Sat, 24 Apr 2021 23:25:54 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] dts: eeprom-93xx46: Add support for 93C46, 93C56 and 93C66
Date:   Sat, 24 Apr 2021 23:25:43 +0200
Message-Id: <20210424212543.13929-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210424212543.13929-1-linkmauve@linkmauve.fr>
References: <20210424123034.11755-1-linkmauve@linkmauve.fr>
 <20210424212543.13929-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These devices differ by the size of their storage, which is why they
have different compatible strings.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
index 7b636b7a8311..72ea0af368d4 100644
--- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
+++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
@@ -2,7 +2,10 @@ EEPROMs (SPI) compatible with Microchip Technology 93xx46 family.
 
 Required properties:
 - compatible : shall be one of:
+    "atmel,at93c46"
     "atmel,at93c46d"
+    "atmel,at93c56"
+    "atmel,at93c66"
     "eeprom-93xx46"
     "microchip,93lc46b"
 - data-size : number of data bits per word (either 8 or 16)
-- 
2.31.1

