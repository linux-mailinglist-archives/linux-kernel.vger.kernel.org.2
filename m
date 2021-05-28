Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763A8393E92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhE1IQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:16:45 -0400
Received: from comms.puri.sm ([159.203.221.185]:41528 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235905AbhE1IQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:16:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 3E1ACE3C27;
        Fri, 28 May 2021 01:14:38 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b8lat4nIC3qS; Fri, 28 May 2021 01:14:37 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, kernel@puri.sm,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paul.kocialkowski@bootlin.com,
        robh@kernel.org, shawnx.tu@intel.com,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 5/5] Documentation: i2c-cardlist: add the Hynix hi846 sensor
Date:   Fri, 28 May 2021 10:13:36 +0200
Message-Id: <20210528081336.3858700-6-martin.kepplinger@puri.sm>
In-Reply-To: <20210528081336.3858700-1-martin.kepplinger@puri.sm>
References: <20210528081336.3858700-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SK Hynix Hi-846 8M Pixel CMOS image sensor to the i2c-cardlist.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/admin-guide/media/i2c-cardlist.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/media/i2c-cardlist.rst b/Documentation/admin-guide/media/i2c-cardlist.rst
index e60d459d18a9..185e07a3da43 100644
--- a/Documentation/admin-guide/media/i2c-cardlist.rst
+++ b/Documentation/admin-guide/media/i2c-cardlist.rst
@@ -60,6 +60,7 @@ Driver        Name
 ============  ==========================================================
 et8ek8        ET8EK8 camera sensor
 hi556         Hynix Hi-556 sensor
+hi846         Hynix Hi-846 sensor
 imx214        Sony IMX214 sensor
 imx219        Sony IMX219 sensor
 imx258        Sony IMX258 sensor
-- 
2.30.2

