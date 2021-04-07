Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19735668F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349549AbhDGIVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239443AbhDGIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80FBA613B3;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=NVIQN8yBxcxXrqaw+W39kX1umIsCOr9B30C0jckclFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfPYnMg/u+NVsK6beLz4wA4qyFKiVgNZKf2I0I2oNPkrtiBS1vw6Ubom2DUMwU8Gl
         /phyy2bW3TGIBPQQKr5hbn2NzhHmpLMS/iGujsQkEsGzc3+QZW9DqiU87fYdA1Th5M
         Wi9tFy3nwRkUvjpDv/vWkODQ414edQN/9QT3CbFLt+gB4oStxBRuhnrtDjZdAxoGdY
         N3fmsliFbpUmDrXd29d4yyN1LNvR/8wf76RXNbPqI9BVEeZHhleKhCCPi5VHUiDC1u
         S19H9WC8itUWtnskHHTetl1gDSJlonpqLVVHYIlT2F7DLSpyvZ29WHv3KG9/PFw1C/
         06aGR0gUGNcVQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2V-Kt; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/19] dt-bindings:iio:adc: update dlg,da9150-gpadc.yaml reference
Date:   Wed,  7 Apr 2021 10:20:50 +0200
Message-Id: <79ece2a12759a375bfa0d492e2931f48acc11e39.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset e13b686b18e3 ("dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion")
renamed: Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
to: Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml.

Update its cross-reference accordingly.

Fixes: e13b686b18e3 ("dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mfd/da9150.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
index 763e0b639a82..b7afa39d6260 100644
--- a/Documentation/devicetree/bindings/mfd/da9150.txt
+++ b/Documentation/devicetree/bindings/mfd/da9150.txt
@@ -19,7 +19,7 @@ Required properties:
    further information relating to interrupt properties)
 
 Sub-devices:
-- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
+- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
 - da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
 - da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt
 
-- 
2.30.2

