Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B53351E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhDASlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236983AbhDASSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C741F61105;
        Thu,  1 Apr 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279475;
        bh=trfI3RModrzK+dm2v1y2mbmJI2GJrsD8BjwL5Jg6EoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSVmTMZlEN2cqt6oYF5FeS1JYbW37t9MuDRRrQDLqoWVrAbQmwc4IHtySKdbgcyuA
         Uc6A4YGjNTmm/dOz98BL5Y/43FwhuZcuLERTU3lJ7bdavzO3ppexkiujfKMs1N/AdT
         1qH1galmdvne8AHSpYZh1J6YCiutI4OkbJrjKu++BcuiQvIQbI0da1obDrIVtoUSLk
         kBSH53P1azV3wWnCWEkpZXeoZ2J0TgT3PsUIzGTdrKR1EqHlNP7Wg0e2TUFHSqmjzG
         ytOKZ26PB8XZ++XXqEwqPHEARO4hDtpBqygDUDY4xmO3LXlDQHPMiozRlwRX2I69I6
         z9yDqLWdUcTZg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGn-001c2q-Ut; Thu, 01 Apr 2021 14:17:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] MAINTAINERS: update lego,ev3-battery.yaml reference
Date:   Thu,  1 Apr 2021 14:17:32 +0200
Message-Id: <be4e2f1c7f6b2cfbda4fc98ca2177b048a3ed575.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 3004e581d92a ("dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema format")
renamed: Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
to: Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml.

Update its cross-reference accordingly.

Fixes: 3004e581d92a ("dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema format")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce675a0b3819..b16830f54226 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10173,7 +10173,7 @@ F:	drivers/misc/eeprom/eeprom.c
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
+F:	Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
 F:	arch/arm/boot/dts/da850-lego-ev3.dts
 F:	drivers/power/supply/lego_ev3_battery.c
 
-- 
2.30.2

