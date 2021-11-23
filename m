Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C21745A651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhKWPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhKWPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:16:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DCC061714;
        Tue, 23 Nov 2021 07:13:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 08AA11F45693
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637680403; bh=5yclq61tC9OT1axKpxNYWbXncAz8as8HZ6hFfQzLQQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOcdObXIwIJyEBVMX3VJnZ0vwWxjP7JPtGJ6DustrXlWk5k4EnP7Kdz1YN89VJGmc
         VXApxztyjrdXXHpHwDYzFpi+dtGOncREy3TszcbBNgImOVIQfgF/NnAVmZjg/6oV6A
         bqtSXlgbBQ0qEy1INWYE3GxriUxJIb1GJFf2SyS4H3cwxAf/GUirQb92MsdB9Spxey
         mu+FuZ1SwfkxpPCCvqiF8fmzAxyANQ3PeSa0PlLqO+8yfDKm4pDg6ZdIHKQMuI/liD
         Uf7lYDj9tKIS7jJmup1hNww/Yu058KI4pArVcZkITacjXW3uzInjZdt9RLYUC/tK15
         921DuSmZXoT+Q==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com
Subject: [PATCH v2 1/5] dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
Date:   Tue, 23 Nov 2021 12:12:48 -0300
Message-Id: <20211123151252.143631-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vendor prefix for BSH Hausgeraete GmbH ('BSH Home Appliances',
B/S/H/) manufacturer.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..5f35d7ad9760 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -187,6 +187,8 @@ patternProperties:
     description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^brcm,.*":
     description: Broadcom Corporation
+  "^bsh,.*":
+    description: BSH Hausgeraete GmbH
   "^buffalo,.*":
     description: Buffalo, Inc.
   "^bur,.*":
-- 
2.30.2

