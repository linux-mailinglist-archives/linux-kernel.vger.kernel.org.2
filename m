Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6F3D2196
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhGVJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A24F661285;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=IJuf24QWVfrptH2CqeiwtQNcE6tFFQxKGEiBSAq1ncs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaE/fJZBHiSPe+iU6BpAqhhiNY0hi4NWc2VJBNneeCpi0UN9jrMEQaJPudbJEHPR7
         pXko3yCM2Jgj0ulQeJx50aAD/96XyifxI88Tw/hDZwnDBhUW5rxmpxXliG0S69LsLT
         MqNM3ECeDpXOafoXBAPg9VBgqAShB/e04K0AVRTCp0fvy781B8DrCoCTFlnpHj8jYI
         a8MayOAo4VS+6FFhfrjrwjWvJYJna76r+f4FJPdr1vMCnXc7cDHijF82Mf1zC+Lpwr
         +2FGOXS0XePWxaN5WMBDx1h5KSqGMzwMXyRwuo0JbNxIsYHMldxYGi+21r0GyAifnR
         CyOyEKedt0brw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VV0-008mI0-6O; Thu, 22 Jul 2021 12:00:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] MAINTAINERS: update gpio-zynq.yaml reference
Date:   Thu, 22 Jul 2021 12:00:09 +0200
Message-Id: <e6f6fa5cebf94753ad8c4b30103459a8eea4bce0.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
renamed: Documentation/devicetree/bindings/gpio/gpio-zynq.txt
to: Documentation/devicetree/bindings/gpio/gpio-zynq.yaml.

Update its cross-reference accordingly.

Fixes: 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76236b2c1d7a..7e1e5385d971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20382,7 +20382,7 @@ R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
 R:	Michal Simek <michal.simek@xilinx.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
-F:	Documentation/devicetree/bindings/gpio/gpio-zynq.txt
+F:	Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
 F:	drivers/gpio/gpio-xilinx.c
 F:	drivers/gpio/gpio-zynq.c
 
-- 
2.31.1

