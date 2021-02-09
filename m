Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2D315798
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhBIUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhBISZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:25:01 -0500
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BADC061221
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 10:13:02 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:8d8e::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 93A9C15360;
        Tue,  9 Feb 2021 18:12:58 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 87057219FD0; Tue,  9 Feb 2021 18:12:58 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: usb-device: fix typo in required properties
Date:   Tue,  9 Feb 2021 18:12:40 +0000
Message-Id: <20210209181240.28017-1-mans@mansr.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in 'compatible' property name.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 Documentation/devicetree/bindings/usb/usb-device.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
index 7bb25a45427d..d4c99809ee9a 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
@@ -76,7 +76,7 @@ patternProperties:
         maxItems: 1
 
 required:
-  - compatile
+  - compatible
   - reg
 
 additionalProperties: true
-- 
2.30.0

