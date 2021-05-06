Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7A375336
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEFLus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:50:48 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:30482 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhEFLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:50:46 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 52B17C2019C;
        Thu,  6 May 2021 19:49:46 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] dt-bindings: phy: cadence-torrent: update reference file of docs
Date:   Thu,  6 May 2021 19:49:39 +0800
Message-Id: <20210506114940.22215-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkMZGlYZQkgfTRhLSR5MSxhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6CCo6HD8SQ0IWSR0YMQNP
        GUwaC0JVSlVKTUlLSEtKTENNQ0NJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSE9ONwY+
X-HM-Tid: 0a7941832da0d976kuws52b17c2019c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fd7abc3c5b87 ("phy: cadence-torrent: Use a common header
file for Cadence SERDES"), phy-cadence-torrent.h was renamed to
phy-cadence.h. Fix it of the Documentation.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 01dcd14e7b2a..320a232c7208 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -118,7 +118,7 @@ patternProperties:
         description:
           Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
           EXTERNAL_SSC or INTERNAL_SSC.
-          Refer include/dt-bindings/phy/phy-cadence-torrent.h for the constants to be used.
+          Refer include/dt-bindings/phy/phy-cadence.h for the constants to be used.
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2]
         default: 0
-- 
2.25.1

