Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25E9398F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhFBPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhFBPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695AE61406;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=6qXUkFnfiQfecs6mzHsdnwU/nAODiuGruDmsYLHNq7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZ6iTswno7Z5eDssTs9LpH56tcpYZGtYCWMOnrkhw7TttWKtUMj7JDX9LN5KubBxE
         FYQnsbxGGGOzlQtx9ktFH6knIcs/1cjl9U0+0B13m3gYty05uQWHtUZ1sGdlrLa9qi
         NC5GiH8q5K3YGyOd1MaBOPqZ5SryUThO/c3XlyNeBKj0ZV7ee40QOyPcltzYkjsbbm
         IhsHY0jip++71qxUB5Aqv7rW7qVtNLkPVMTs/f3JYh9YCdJkehGCrt4RR8BA31nF8H
         ElKvf4SX0ScIIarT1Ew1sM+YTUn0YNwLkTR4Uotx3tidMlZrFVRxV9tyHqT1+b4QgX
         TKMAx78Y2Q+yQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xbb-8t; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] dt-bindings: power: supply: cpcap-battery: update cpcap-battery.yaml reference
Date:   Wed,  2 Jun 2021 17:43:07 +0200
Message-Id: <1d0c8d50db22d9e5540a42be874fcd39fb7fc2a7.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 3c5be0454972 ("dt-bindings: power: supply: cpcap-battery: Convert to DT schema format")
renamed: Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
to: Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml.

Update its cross-reference accordingly.

Fixes: 3c5be0454972 ("dt-bindings: power: supply: cpcap-battery: Convert to DT schema format")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
index b52e7a33f0f9..e656e6f08fed 100644
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
@@ -16,7 +16,7 @@ Optional subnodes:
 The sub-functions of CPCAP get their own node with their own compatible values,
 which are described in the following files:
 
-- Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
+- Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
 - Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
 - Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 - Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
-- 
2.31.1

