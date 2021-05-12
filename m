Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC637C65B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhELPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:50:48 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57510 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234339AbhELPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:24:51 -0400
Received: from [185.56.157.72] (port=51864 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lgqi1-00017K-QI; Wed, 12 May 2021 17:23:37 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dt: remove stale property-units.txt, link to current schema
Date:   Wed, 12 May 2021 17:23:11 +0200
Message-Id: <20210512152311.7399-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

property-units.txt is not maintained anymore. New suffixes are now
supported that have not been added here.

To avoid people incorrectly think a given suffix is not in the list remove
the file entirely and point to the authoritative place where the
recommended suffixes are maintained.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../devicetree/bindings/property-units.txt    | 48 -------------------
 .../devicetree/bindings/writing-bindings.rst  |  3 +-
 2 files changed, 2 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/property-units.txt

diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
deleted file mode 100644
index 218f99fa311f..000000000000
--- a/Documentation/devicetree/bindings/property-units.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Standard Unit Suffixes for Property names
-
-Properties which have a unit of measure are recommended to have a unit
-suffix appended to the property name. The list below contains the
-recommended suffixes. Other variations exist in bindings, but should not
-be used in new bindings or added here. The inconsistency in the unit
-prefixes is due to selecting the most commonly used variants.
-
-It is also recommended to use the units listed here and not add additional
-unit prefixes.
-
-Time/Frequency
-----------------------------------------
--mhz		: megahertz
--hz		: hertz (preferred)
--sec		: second
--ms		: millisecond
--us		: microsecond
--ns		: nanosecond
--ps		: picosecond
-
-Distance
-----------------------------------------
--mm		: millimeter
-
-Electricity
-----------------------------------------
--microamp	: microampere
--microamp-hours : microampere hour
--ohms		: ohm
--micro-ohms	: microohm
--microwatt-hours: microwatt hour
--microvolt	: microvolt
--picofarads	: picofarad
--femtofarads	: femtofarad
-
-Temperature
-----------------------------------------
--celsius	: degree Celsius
--millicelsius	: millidegree Celsius
-
-Pressure
-----------------------------------------
--kpascal	: kilopascal
-
-Throughput
-----------------------------------------
--kBps		: kilobytes per second
diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
index 45ff426d0019..f7dfb98c156e 100644
--- a/Documentation/devicetree/bindings/writing-bindings.rst
+++ b/Documentation/devicetree/bindings/writing-bindings.rst
@@ -52,7 +52,8 @@ Properties
   constraints specific to the device.
 
 - DO use common property unit suffixes for properties with scientific units.
-  See property-units.txt.
+  Recommended suffixes are listed at
+  https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-units.yaml
 
 - DO define properties in terms of constraints. How many entries? What are
   possible values? What is the order?
-- 
2.31.1

