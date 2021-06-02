Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B4398F18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhFBPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhFBPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EB65613D6;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=hpXbDM2W0XIRVHBJt/AqiqfdKM51B7DZ/aXLWW+eEKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUz8k06v2MR2+bSsf0jpiwoZjN/L8zABLedlhpBC0t7/GD6zYbk6oxBy/iZ3QvbW3
         wsJsCvgPTgX9uc1JaBz53qhYhmZ6ibJp5wfS0MrXqKCpOlzylmF8jjazMl5iyoBd27
         O27Tiql2mhtEI5/4ckor0lCsYJenUgqw3Calv1h+apT00SJ7f/Y2YFYVCYnzdWv+Cp
         D7+F3Usb84b756yGVfu1TY22Am1bBzI3dW0CFUFIe1XlHXjsjuzRqs1At5npvfG4h5
         uX7ZaFtqNR6Cn7dI/4R6G9Ma6yLGxC8hIThbw4yIOTuCdC25nDPooqjQpBPTD+/VH8
         Z4NOcT0ddNF6A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xbe-A0; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] dt-bindings: power: supply: cpcap-charger: update cpcap-charger.yaml reference
Date:   Wed,  2 Jun 2021 17:43:08 +0200
Message-Id: <e9ce216362b7b9dcf84d707a3854247123440bf7.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ce49e4282200 ("dt-bindings: power: supply: cpcap-charger: Convert to DT schema format")
renamed: Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
to: Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml.

Update its cross-reference accordingly.

Fixes: ce49e4282200 ("dt-bindings: power: supply: cpcap-charger: Convert to DT schema format")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
index e656e6f08fed..190230216de8 100644
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
@@ -17,7 +17,7 @@ The sub-functions of CPCAP get their own node with their own compatible values,
 which are described in the following files:
 
 - Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
-- Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
+- Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
 - Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 - Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
 - Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
-- 
2.31.1

