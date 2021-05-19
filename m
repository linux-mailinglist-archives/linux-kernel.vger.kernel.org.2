Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99477388B22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbhESJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:52:35 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:41966 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbhESJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:52:18 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id E3070F4066B; Wed, 19 May 2021 11:50:48 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: nintendo-otp: Document the Wii and Wii U OTP support
Date:   Wed, 19 May 2021 11:50:42 +0200
Message-Id: <20210519095044.4109-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519095044.4109-1-linkmauve@linkmauve.fr>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these consoles use the exact same two registers, even at the
same address, but the Wii U has eight banks of 128 bytes memory while
the Wii only has one, hence the two compatible strings.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../devicetree/bindings/nvmem/nintendo-otp.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
new file mode 100644
index 000000000000..b26d705ec52d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
@@ -0,0 +1,14 @@
+Nintendo Wii and Wii U OTP
+
+Required Properties:
+- compatible: depending on the console this should be one of:
+	- "nintendo,hollywood-otp" for the Wii
+	- "nintendo,latte-otp" for the Wii U
+- reg: base address and size of the OTP registers
+
+
+Example:
+	otp@d8001ec {
+		compatible = "nintendo,latte-otp";
+		reg = <0x0d8001ec 0x8>;
+	};
-- 
2.31.1

