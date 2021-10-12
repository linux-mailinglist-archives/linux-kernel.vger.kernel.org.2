Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD6429D92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhJLGTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:19:49 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:3020 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhJLGTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634019466; x=1665555466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YpFcZBAr+S3nQ054+3YBdSJLgE6Lh4TGi48Xh5Pas+I=;
  b=fQaG+bhbIruEKWoIjkbwXfKZg6TR9ADlJ1kOQMbjwJtCkdkkRKtdUDy7
   AyC7UoBfzKFMR9KxFu53u+EDeOEs5FLD9gb1Wg9er1O69VsiaYqIAOnGK
   pKn+x/DcQ8hYltZMACLELCRR/dXa2ySL9N4Tm5V695pgHAsr6O5Nb8DCY
   jf+Z4O8uc6z6WhKtl1LrjlU+aQbpAV18yOD03RtXN8zK7g85VCg8LWT/w
   cOzrBlUgGgSDDfzd3V08SaEiKwxnYDYZ+0l33yPZZFhQdbfYKeFUtJvzp
   T4t3JRUVy+Rz6p7Clndl5zMYoMU79lTVKa8YK8BoTSrG0sbZU3JPgoPOp
   w==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624312800"; 
   d="scan'208";a="19984096"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Oct 2021 08:17:45 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 12 Oct 2021 08:17:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 12 Oct 2021 08:17:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1634019465; x=1665555465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YpFcZBAr+S3nQ054+3YBdSJLgE6Lh4TGi48Xh5Pas+I=;
  b=GC4vQp5fIftm/llfBYmJM/aZaYfpmCbAmCWUeqnq+8OGw6tZmjDNBC/q
   5nMzIX3+0wzrVJzShrJ0NxRSm2JcpBuBm9fKSYa2zARVoZBb8t7JSlLMk
   89mQvaEGmVeyOy+wB7QdiQ5BLqzHMdJl6WfWmhy9BPMX8sl8aeLCjaA0R
   Yns8PahskYcYelgV+/uUvvbgaAgqbfZXcBQMGiLrR2P/YuF59Co/5JxYm
   ol3KQv3BEagp8RZZTIvQIzFzkM8WsEi+iGyGP6luGWEyMl7aELK8aSgQN
   FQE9z1t5Mf3XpJxwFKumcmwy+F9vOBn8SMF2ECaH5HPY7wJ7Y2GpCKD2p
   A==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624312800"; 
   d="scan'208";a="19984095"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2021 08:17:45 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4AE7F280065;
        Tue, 12 Oct 2021 08:17:45 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add output-driver-strength property
Date:   Tue, 12 Oct 2021 08:17:03 +0200
Message-Id: <20211012061704.284214-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is for optimizing output voltage impedance and is
specific to each board. It overwrites the default set by the flash
device. Various flash devices support different impedances.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Updated the property description and the commit message accordingly

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..4c3c506a8853 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -72,6 +72,14 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  output-driver-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Output driver strength in ohms which optimizes the impedance at Vcc/2
+      output voltage. This property overwrites the default set by the flash
+      device. This is board specific and should be determined by the
+      manufacturer. Various flash devices support different impedances.
+
   label: true
 
   partitions:
-- 
2.25.1

