Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E091441A64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhKALEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:04:47 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:22928 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhKALEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:04:44 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1A1AceDn037906;
        Mon, 1 Nov 2021 18:38:40 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Nov 2021 19:01:24 +0800
From:   tommy-huang <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 4/4] dt-bindings: gpu: Add ASPEED GFX bindings document
Date:   Mon, 1 Nov 2021 19:01:07 +0800
Message-ID: <20211101110107.29010-5-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1A1AceDn037906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ast2600-gfx description for gfx driver.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
index 958bdf962339..29ecf119cef2 100644
--- a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+++ b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
@@ -3,6 +3,7 @@ Device tree configuration for the GFX display device on the ASPEED SoCs
 Required properties:
   - compatible
     * Must be one of the following:
+      + aspeed,ast2600-gfx
       + aspeed,ast2500-gfx
       + aspeed,ast2400-gfx
     * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
-- 
2.17.1

