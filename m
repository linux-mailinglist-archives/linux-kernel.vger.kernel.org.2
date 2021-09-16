Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3092140D5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhIPJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235615AbhIPJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:15:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C74C0613A2;
        Thu, 16 Sep 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631783661;
        bh=2SVVmMnkmAjkn1l77UCkyCYYDmTX5xgWflVu9QvAi8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZAbTXy17kJN+nwcFYr+yva1UqShglvl6rX9LlwyOW9GCiaVPgCoQh2W7oSKkI08Y
         1kNKS+z/2FIBcEmxJoR/i6ijt8DVC3Auv1+bmC6aw0m+XJGSxXl4FxEeoAA9gHjihI
         jVC0P/l0SXo7BC++/ImAVqDGrnTHbazY5Ey3/0YFx7w9dULhjY42A83KQjBFMjScp2
         BGfi0OT+4K20M1IZ3T+8NPuUp0exEVq7A/sAgwnGZ3GgeJCjSDXCAwidLLklIRZaI0
         bYCc53klMXEZsHySQKq6REblMFrdJJk73pv9N9M52L407OCRsrlPA/II0H9sIOQ0J6
         QWzVdiuV5G/og==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnTI-001sM9-2h; Thu, 16 Sep 2021 11:14:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/24] MAINTAINERS: update brcm,unimac-mdio.yaml reference
Date:   Thu, 16 Sep 2021 11:14:15 +0200
Message-Id: <39e251389606fb11d0d5888d76aacaf595643da8.1631783482.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
renamed: Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
to: Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml.

Update its cross-reference accordingly.

Fixes: 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert to the json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index de18144b8c52..adce2bdedb9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3757,7 +3757,7 @@ L:	bcm-kernel-feedback-list@broadcom.com
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
-F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
+F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
 F:	drivers/net/ethernet/broadcom/genet/
 F:	drivers/net/ethernet/broadcom/unimac.h
 F:	drivers/net/mdio/mdio-bcm-unimac.c
-- 
2.31.1

