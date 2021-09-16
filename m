Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF640D5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhIPJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235493AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7969F6124F;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=xnms5GC6lit9dJFNzsnKKlI7NiqUMzdVKR1SbnEpHVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxpEC4VSaGAhnXiucE1IJqj1hf3Dn/0RTYRvno8GGUH6tLU3zaxokGj0uue5fVMgj
         /8Gr3htFLw6KZweQfIEnU720CU3BBIsXgBfeevWqOxED7cYxRI5abv9RByr+UFrOvZ
         SYomFoeAYM2/A3ko2j++MNNRTQ4dWVUAHZbJ83SBsVu+VkcPUeTnALBHtxkiY9D6G0
         O+QTaLrUNE3PQoA+AMCy9btOSFW8a0OoEaRFKa9Ymz09TUUP9bUG6SuISlnTPjTjuO
         IrKOljIcp6I9ntJ9EvMyNLlp9lVTNUMJ4fkZRSYVpF4HmQTxbuDLY0058oiaEEB1u6
         pWwtN00pCeOpg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTH-001sKp-D4; Thu, 16 Sep 2021 11:14:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/24] dt-bindings: w1: update w1-gpio.yaml reference
Date:   Thu, 16 Sep 2021 11:13:57 +0200
Message-Id: <9562523d1566b2621598930c0ab2b50168c2b6cd.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset dd2c898bc20b ("dt-bindings: w1: Convert 1-Wire GPIO binding to a schema")
renamed: Documentation/devicetree/bindings/w1/w1-gpio.txt
to: Documentation/devicetree/bindings/w1/w1-gpio.yaml.

Update its cross-reference accordingly.

Fixes: dd2c898bc20b ("dt-bindings: w1: Convert 1-Wire GPIO binding to a schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/w1/masters/w1-gpio.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/w1/masters/w1-gpio.rst b/Documentation/w1/masters/w1-gpio.rst
index 18fdb7366372..15236605503b 100644
--- a/Documentation/w1/masters/w1-gpio.rst
+++ b/Documentation/w1/masters/w1-gpio.rst
@@ -11,7 +11,7 @@ Description
 GPIO 1-wire bus master driver. The driver uses the GPIO API to control the
 wire and the GPIO pin can be specified using GPIO machine descriptor tables.
 It is also possible to define the master using device tree, see
-Documentation/devicetree/bindings/w1/w1-gpio.txt
+Documentation/devicetree/bindings/w1/w1-gpio.yaml
 
 
 Example (mach-at91)
-- 
2.31.1

