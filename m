Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A143356691
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDGIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239529AbhDGIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F7D2613E2;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=mzZg6w7IW+ulvjiLP2xr/SkHASNdM+Fj7l8VJI4S/wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HU7Sjvg59J08gpghaaJJjtSam9wrvuZp53y5KntDT3FwVzlQfBxb+xT6EbmlzLEiu
         hYAeZWOwMguMw4w71MZsfM+Z8XZbEMZ1Apo9+Ne7G/lpEeZ5C38pRhF+u3pSsodDFk
         qfYeSp+kdJJ7PmdOWCPWw1OgCtegcVc2rV0/l8PwOaFpSXQ0vRkTw+ANxkFV+zyNSn
         2cLZl1+/EhJKORkmLhSaNsEbmln8G4Yzv/k8xHJidCjMzZGrjs4fWE1oT1TLgce/t3
         4wcoKlxV9GZcx81suipCniccnzV+Eflv8pqd6OJHIptdVT4pMrQe0yKng5vRaERi91
         65B1yPBBBLwlw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2Y-Md; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/19] dt-bindings: power: supply: da9150: update da9150-charger.txt reference
Date:   Wed,  7 Apr 2021 10:20:51 +0200
Message-Id: <77aa40c58600dfc1f047ce2d86ad1d1cd67d67e4.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f3332532463f ("power/supply: unify DT documentation")
renamed: Documentation/devicetree/bindings/power/da9150-charger.txt
to: Documentation/devicetree/bindings/power/supply/da9150-charger.txt.

Update its cross-reference accordingly.

Fixes: f3332532463f ("power/supply: unify DT documentation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mfd/da9150.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index b7afa39d6260..f4db2b520327 100644
--- a/Documentation/devicetree/bindings/mfd/da9150.txt
+++ b/Documentation/devicetree/bindings/mfd/da9150.txt
@@ -20,7 +20,7 @@ Required properties:
 
 Sub-devices:
 - da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
-- da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
+- da9150-charger: See Documentation/devicetree/bindings/power/supply/da9150-charger.txt
 - da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt
 
 Example:
-- 
2.30.2

