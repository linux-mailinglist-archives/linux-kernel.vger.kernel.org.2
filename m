Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A16345DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhCWMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:08:53 -0400
Received: from foss.arm.com ([217.140.110.172]:45230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhCWMHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:07:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47C59D6E;
        Tue, 23 Mar 2021 05:07:40 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B59393F719;
        Tue, 23 Mar 2021 05:07:38 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 18/19] Documentation: trace: Add documentation for TRBE
Date:   Tue, 23 Mar 2021 12:06:46 +0000
Message-Id: <20210323120647.454211-19-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210323120647.454211-1-suzuki.poulose@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>

Add documentation for the  TRBE under trace/coresight.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
[ Split from the TRBE driver patch ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../trace/coresight/coresight-trbe.rst        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst

diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
new file mode 100644
index 000000000000..b9928ef148da
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-trbe.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Trace Buffer Extension (TRBE).
+==============================
+
+    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
+    :Date:     November 2020
+
+Hardware Description
+--------------------
+
+Trace Buffer Extension (TRBE) is a percpu hardware which captures in system
+memory, CPU traces generated from a corresponding percpu tracing unit. This
+gets plugged in as a coresight sink device because the corresponding trace
+generators (ETE), are plugged in as source device.
+
+The TRBE is not compliant to CoreSight architecture specifications, but is
+driven via the CoreSight driver framework to support the ETE (which is
+CoreSight compliant) integration.
+
+Sysfs files and directories
+---------------------------
+
+The TRBE devices appear on the existing coresight bus alongside the other
+coresight devices::
+
+	>$ ls /sys/bus/coresight/devices
+	trbe0  trbe1  trbe2 trbe3
+
+The ``trbe<N>`` named TRBEs are associated with a CPU.::
+
+	>$ ls /sys/bus/coresight/devices/trbe0/
+        align flag
+
+*Key file items are:-*
+   * ``align``: TRBE write pointer alignment
+   * ``flag``: TRBE updates memory with access and dirty flags
-- 
2.24.1

