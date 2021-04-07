Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81535668E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349492AbhDGIVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238007AbhDGIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7741A613CD;
        Wed,  7 Apr 2021 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617783662;
        bh=FN9fIYc0xtc0WoRKgICBUgYOcktenG0goqi4S9V1/qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzpyYrPtPrUdIqRancpV4Zj8Q/SAAt5LA1ZhWdWuoPFzFtm/Bz1lvZ9ySsAJ5jGAX
         cdgVHgP+pdiBRiBIbZrJpbM7GcLFREp9+bSPAfytUMofNCSKTRynu7TiQ3Tj9hDccG
         vwmsYekf7tGJsXAKP66+kMnTzWZD4d/WL5Yf+MGKja2LSm0Xzfqg2wa/RosyTiokie
         eadV3spDUMNVvZe5rUHVMsVqPv/rKhPptjI0LhW/raUqqqP6Hy1ZErJst25Nkmyg1R
         XAtxkpFPRlFNeaAlW5PuXYYR6WM2ppkRvv0AQhyI3VMiK9pqjsoSFxTmYs+JKmP/D5
         CKojS5FdMuhPg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lU3Qq-005i2Q-IA; Wed, 07 Apr 2021 10:21:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        devicetree@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 09/19] dt-bindings: i3c: update i3c.yaml references
Date:   Wed,  7 Apr 2021 10:20:48 +0200
Message-Id: <8bb8923b4d98b4e8a6336a4c0b548c714e01aef5.1617783062.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5e4cdca887fd ("dt-bindings: i3c: Convert the bus description to yaml")
renamed: Documentation/devicetree/bindings/i3c/i3c.txt
to: Documentation/devicetree/bindings/i3c/i3c.yaml.

Update the cross-references accordingly.

Fixes: 5e4cdca887fd ("dt-bindings: i3c: Convert the bus description to yaml")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt   | 6 +++---
 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt          | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
index 1cf6182f888c..3716589d6999 100644
--- a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -10,19 +10,19 @@ Required properties:
 - reg: I3C master registers
 
 Mandatory properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
 
 - #address-cells: shall be set to 1
 - #size-cells: shall be set to 0
 
 Optional properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
 
 - i2c-scl-hz
 - i3c-scl-hz
 
 I3C device connected on the bus follow the generic description (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
index 5020eb71eb8d..07f35f36085d 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
@@ -9,19 +9,19 @@ Required properties:
 - reg: Offset and length of I3C master registers
 
 Mandatory properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
 
 - #address-cells: shall be set to 3
 - #size-cells: shall be set to 0
 
 Optional properties defined by the generic binding (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details):
 
 - i2c-scl-hz
 - i3c-scl-hz
 
 I3C device connected on the bus follow the generic description (see
-Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+Documentation/devicetree/bindings/i3c/i3c.yaml for more details).
 
 Example:
 
-- 
2.30.2

