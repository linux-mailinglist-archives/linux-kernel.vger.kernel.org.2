Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3742860E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhJKEts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:49:48 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:38872 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233967AbhJKEtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:49:43 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 00:49:42 EDT
IronPort-SDR: AQm0ANOKCRJHlQcu1ZeYbcXO2wJXtkaUyiJM7tkZSMLkkSudvQ1VySrwukyNQMzXQ6MjuwsO9H
 fI389ntk+fw8o6Zvq007DHLARvx77oY7Ua7bsiea/j317cvHB+1+vas7UvQeZVeV6ofmH4dywk
 BLysd6B53rk2GztDtJd+WF5gm0U7rQGWOvY/tSR68bOLjQ3ZWZRedB+yiiCUfTRPzX5AcM3G9K
 F9ScdsBHcIPpvamTw2TXo5nOjKrAoidr16g5g5mZ5czh/o3dkeplltOqXTmn8mXHSKsl3KlIU2
 YiRKcHOwT8syNx3uoPo1yJBW
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="36262584"
X-IronPort-AV: E=Sophos;i="5.85,363,1624287600"; 
   d="scan'208";a="36262584"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Oct 2021 13:40:34 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9309FE6806
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:33 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CCAA8FF29
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:40:32 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 8A1714005E9CA;
        Mon, 11 Oct 2021 13:40:32 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [RFC PATCH 4/4] docs: ABI: Add sysfs documentation interface of hardware prefetch driver
Date:   Mon, 11 Oct 2021 13:39:52 +0900
Message-Id: <20211011043952.995856-5-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
References: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
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

