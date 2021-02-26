Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AB3263AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:04:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:53446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBZOD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:03:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F9FEB040;
        Fri, 26 Feb 2021 14:03:16 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 01/13] dt-bindings: Introduce 64bit-mmio-broken
Date:   Fri, 26 Feb 2021 15:02:53 +0100
Message-Id: <20210226140305.26356-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses might not be able to handle 64-bit sized MMIO accesses, on
otherwise 64-bit systems. Introduce a boolean property to cater for this
limitation.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../devicetree/bindings/common-properties.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
index 98a28130e100..3783510102c3 100644
--- a/Documentation/devicetree/bindings/common-properties.txt
+++ b/Documentation/devicetree/bindings/common-properties.txt
@@ -83,3 +83,18 @@ gpio@0 {
 	      #gpio-cells = <2>;
 	      #daisy-chained-devices = <3>;
 };
+
+Broken 64-bit buses
+-------------------
+
+Some buses might not be able to handle 64-bit sized MMIO accesses, on otherwise
+64-bit systems. This property is only relevant to MMIO bus nodes.
+
+Optional properties:
+ - 64bit-mmio-broken: Boolean
+
+Example:
+pcie@0 {
+	compatible = "name";
+	64bit-mmio-broken;
+};
-- 
2.30.1

