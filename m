Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45029351E60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhDASkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239661AbhDASQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 726AC611CA;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=BnEWnVkqMrbAWG8jRB7Ad1C4L7HMZywQ6hzq4TbT8UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPnQs3u0SA4q5hbHfq4RzSQs+FvcWBNcfhCTKN6bcNlYj9sKG8msZVimUxSaFruSC
         8f1cqbBCUwjkAGluou0uqBj+uvjPB8fqBsalkQmfIuD+D3wwo5qv8hiqVsQ59y9VCe
         kbXqitfXDA+PXFQ7KGEcMYafOmZA6tKtx8Ill50H7BtHyJLojLog+YntFnsrwsTSa9
         bT5TlGv2GcTzHNPMD7kXNU4DfRmzv7R5HmIeqHBXovFPOROhDgi4oEYGohT0HzVJtu
         qflkxbJCbDg+Xx/5q6vRLu1FjoQlsj3yct872Nt8rh29A1TOt+ToVBfFbGzycP4PiK
         hnOfig097Jhdg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3a-HY; Thu, 01 Apr 2021 14:17:54 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/32] dt-bindings: i3c: update i3c.yaml references
Date:   Thu,  1 Apr 2021 14:17:47 +0200
Message-Id: <22b7b53af1907f7cae27e26be725470c04b84725.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
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

