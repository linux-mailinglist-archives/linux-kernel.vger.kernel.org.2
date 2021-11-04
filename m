Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC0444E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKDFcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:32:10 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:57703 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhKDFcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:32:06 -0400
IronPort-SDR: N1+vjAna10DS4k3CJp5K7aBypkEqLgk8AkCie25y6MB/acWTUKX5L0p8sMNCsY68f0aFKuV7A0
 zfgf5WYNbJ4s/ihhNOXjaCNlGPHK4iNKsXz/sZBadBZZ5GgV7ltXG6pSakmEf6bhkwKI8qZbdY
 229gjcOrqfLs7jW1gFyMgutrjVVsZ0WrgqY7u5A9sQngjHRLZ4njw3Q9hpCZa8+Q9nNahLOldK
 IKxxa96mjc++zSttqS/Db31SJFR1sgRWCHpTPsgeX0jbEirYEHagUSEf9IAAVup8TDdCvDyWzi
 u2RN5s3FLhoCIwNdgovSChVt
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="30959910"
X-IronPort-AV: E=Sophos;i="5.87,207,1631545200"; 
   d="scan'208";a="30959910"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2021 14:22:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A3C3E13E0B7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:18 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8723343E0D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:22:17 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 4E1B0400C07D4;
        Thu,  4 Nov 2021 14:22:17 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH v2 5/5] docs: ABI: Add sysfs documentation interface of hardware prefetch driver
Date:   Thu,  4 Nov 2021 14:21:22 +0900
Message-Id: <20211104052122.553868-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
References: <20211104052122.553868-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This descrives the sysfs interface implemented on the hardware prefetch
driver.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b46ef1476..caeefd320 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -666,3 +666,61 @@ Description:	Preferred MTE tag checking mode
 		================  ==============================================
 
 		See also: Documentation/arm64/memory-tagging-extension.rst
+
+What:		/sys/devices/system/cpu/cpu*/hwpf/l*/enable
+		/sys/devices/system/cpu/cpu*/hwpf/l*/available_dist
+		/sys/devices/system/cpu/cpu*/hwpf/l*/dist
+		/sys/devices/system/cpu/cpu*/hwpf/l*/reliable
+Date:		October 2021
+Contact:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
+		Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Parameters for the hardware prefetch driver
+
+		This sysfs interface provides Hardware Prefetch (HWPF) tunable
+		attribute files by using implementation defined registers.
+		These attribute files are corresponding to the cache level of
+		the parent directory.
+
+		enable:
+			Read/write interface to change hardware prefetch
+			enablement.
+			Read returns hardware prefetch enablement status:
+				0: hardware prefetch is enabled
+				1: hardware prefetch is disabled
+
+			Write '0' to enable Hardware Prefetch.
+			Write '1' to disable Hardware Prefetch.
+
+		available_dist:
+			Read only interface to get a list of values that can be
+			written to dist.
+
+		dist:
+			Read/write interface to specify the hardware prefetch
+			distance.
+			Read return the current hardware prefetch distance value
+			in bytes or the string "auto".
+
+			Write either a value in byte read from available_dist,
+			or the string "auto" to this attribuite. If you write
+			a value less than these, the value is rounded up.
+
+			The value 0 and the string "auto" are the same and have
+			a special meaning. This means that instead of setting
+			dist to a user-specified value, it operates using
+			hardware-specific values.
+
+		strong:
+			Read/write interface to change hardware prefetch
+			strongness.
+			Strong prefetch operation is surely executed, if there
+			is no corresponding data in cache.
+			Weak prefetch operation allows the hardware not to
+			execute operation depending on hardware state.
+
+			Read returns hardware prefetch strongness status:
+				0: hardware prefetch is generated strong
+				1: hardware prefetch is generated weak
+
+			Write '0' to hardware prefetch generate strong.
+			Write '1' to hardware prefetch generate weak.
-- 
2.27.0

