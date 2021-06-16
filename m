Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934AE3A9275
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPGaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6024613DB;
        Wed, 16 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824867;
        bh=AWUVfjHntj18JrWVyyrbUvVXvdLBBNxY88EfYBbgiKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG1N2s51a7CIcBslXycR2EJkZiDJTmLeTH4LIES9o6ce/yiCZvv0rrMSnWuTEZeTY
         UBXxaxexEWQjNSCx05kxGqWHHndVzVlKCiC1G/kjRskjKrW7M0lEdL8/YrHSOXwg1C
         wLTx60Rjm/FB1VbeYfuYSJEeQIilKl53kczqMBqF4l5fruhWmcBIYGox8fbCzuTRQO
         eB9F8Kxa81VcgmRtNqBQiyWhQmkh747WFA6G91ZbnhZGEMG28r1Az3zjSlSW9jKcrb
         dGkBFH/CctGl+P/qKsM2wjkSvEDxAPf0EF2uAU8WJGvogOmhPl/mL2X0GSSHJUBZcW
         NVcSiOBxAFlbg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIc-2S; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Lepton Wu <ytht.net@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/29] docs: admin-guide: sysctl: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:20 +0200
Message-Id: <12abd2290c7ebc05c89178d2556bea740bd70fac.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/abi.rst    |  2 +-
 Documentation/admin-guide/sysctl/kernel.rst | 37 +++++++++++----------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/abi.rst b/Documentation/admin-guide/sysctl/abi.rst
index 77b1d1b2ad42..4e6db0a2a4c0 100644
--- a/Documentation/admin-guide/sysctl/abi.rst
+++ b/Documentation/admin-guide/sysctl/abi.rst
@@ -11,7 +11,7 @@ Documentation for /proc/sys/abi/
 
 Copyright (c) 2020, Stephen Kitt
 
-For general info, see :doc:`index`.
+For general info, see Documentation/admin-guide/sysctl/index.rst.
 
 ------------------------------------------------------------------------------
 
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index c24f57f2c782..10df7fc6495f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -9,7 +9,8 @@ Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
 
-For general info and legal blurb, please look in :doc:`index`.
+For general info and legal blurb, please look in
+Documentation/admin-guide/sysctl/index.rst.
 
 ------------------------------------------------------------------------------
 
@@ -54,7 +55,7 @@ free space valid for 30 seconds.
 acpi_video_flags
 ================
 
-See :doc:`/power/video`. This allows the video resume mode to be set,
+See Documentation/power/video.rst. This allows the video resume mode to be set,
 in a similar fashion to the ``acpi_sleep`` kernel parameter, by
 combining the following values:
 
@@ -89,7 +90,7 @@ is 0x15 and the full version number is 0x234, this file will contain
 the value 340 = 0x154.
 
 See the ``type_of_loader`` and ``ext_loader_type`` fields in
-:doc:`/x86/boot` for additional information.
+Documentation/x86/boot.rst for additional information.
 
 
 bootloader_version (x86 only)
@@ -99,7 +100,7 @@ The complete bootloader version number.  In the example above, this
 file will contain the value 564 = 0x234.
 
 See the ``type_of_loader`` and ``ext_loader_ver`` fields in
-:doc:`/x86/boot` for additional information.
+Documentation/x86/boot.rst for additional information.
 
 
 bpf_stats_enabled
@@ -269,7 +270,7 @@ see the ``hostname(1)`` man page.
 firmware_config
 ===============
 
-See :doc:`/driver-api/firmware/fallback-mechanisms`.
+See Documentation/driver-api/firmware/fallback-mechanisms.rst.
 
 The entries in this directory allow the firmware loader helper
 fallback to be controlled:
@@ -297,7 +298,7 @@ crashes and outputting them to a serial console.
 ftrace_enabled, stack_tracer_enabled
 ====================================
 
-See :doc:`/trace/ftrace`.
+See Documentation/trace/ftrace.rst.
 
 
 hardlockup_all_cpu_backtrace
@@ -325,7 +326,7 @@ when a hard lockup is detected.
 1 Panic on hard lockup.
 = ===========================
 
-See :doc:`/admin-guide/lockup-watchdogs` for more information.
+See Documentation/admin-guide/lockup-watchdogs.rst for more information.
 This can also be set using the nmi_watchdog kernel parameter.
 
 
@@ -586,7 +587,8 @@ in a KVM virtual machine. This default can be overridden by adding::
 
    nmi_watchdog=1
 
-to the guest kernel command line (see :doc:`/admin-guide/kernel-parameters`).
+to the guest kernel command line (see
+Documentation/admin-guide/kernel-parameters.rst).
 
 
 numa_balancing
@@ -1071,7 +1073,7 @@ that support this feature.
 real-root-dev
 =============
 
-See :doc:`/admin-guide/initrd`.
+See Documentation/admin-guide/initrd.rst.
 
 
 reboot-cmd (SPARC only)
@@ -1158,7 +1160,7 @@ will take effect.
 seccomp
 =======
 
-See :doc:`/userspace-api/seccomp_filter`.
+See Documentation/userspace-api/seccomp_filter.rst.
 
 
 sg-big-buff
@@ -1329,7 +1331,7 @@ the boot PROM.
 sysrq
 =====
 
-See :doc:`/admin-guide/sysrq`.
+See Documentation/admin-guide/sysrq.rst.
 
 
 tainted
@@ -1359,15 +1361,16 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
 131072  `(T)`  The kernel was built with the struct randomization plugin
 ======  =====  ==============================================================
 
-See :doc:`/admin-guide/tainted-kernels` for more information.
+See Documentation/admin-guide/tainted-kernels.rst for more information.
 
 Note:
   writes to this sysctl interface will fail with ``EINVAL`` if the kernel is
   booted with the command line option ``panic_on_taint=<bitmask>,nousertaint``
   and any of the ORed together values being written to ``tainted`` match with
   the bitmask declared on panic_on_taint.
-  See :doc:`/admin-guide/kernel-parameters` for more details on that particular
-  kernel command line option and its optional ``nousertaint`` switch.
+  See Documentation/admin-guide/kernel-parameters.rst for more details on
+  that particular kernel command line option and its optional
+  ``nousertaint`` switch.
 
 threads-max
 ===========
@@ -1391,7 +1394,7 @@ If a value outside of this range is written to ``threads-max`` an
 traceoff_on_warning
 ===================
 
-When set, disables tracing (see :doc:`/trace/ftrace`) when a
+When set, disables tracing (see Documentation/trace/ftrace.rst) when a
 ``WARN()`` is hit.
 
 
@@ -1411,8 +1414,8 @@ will send them to printk() again.
 
 This only works if the kernel was booted with ``tp_printk`` enabled.
 
-See :doc:`/admin-guide/kernel-parameters` and
-:doc:`/trace/boottime-trace`.
+See Documentation/admin-guide/kernel-parameters.rst and
+Documentation/trace/boottime-trace.rst.
 
 
 .. _unaligned-dump-stack:
-- 
2.31.1

