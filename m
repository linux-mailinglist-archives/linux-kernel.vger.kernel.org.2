Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066C41B36D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhI1QDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241568AbhI1QDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:03:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65D1E61206;
        Tue, 28 Sep 2021 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632844931;
        bh=z3QOuMCLwE8gCMMYL+YHNc3qW3u42YxmsLNVQ7oHBVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2IOdXcHTnH0RlGxG9smsvm1+7JNZAeK761Ua6BqIBaQuvaQtxcz7J+5F63uD1YnI
         L7cijgmunHj6uks1/npCBIKtJvnN84FwnIwFQY+z+UaqUDV/J4jQcVROLolV58uoSs
         hvQ0E4rDpZn0zdqMOYvIVHrDEV0C80oGEZuV7xUdn7o7i5U6NRKZD727wwL1+33N2f
         GiMTNddd/No1k7cqSD56sx/VtvaoJuW2pODlo51hGUqStlV6bL07S2qfZW/BD1sKIR
         /YTpV5dgLuksPuWLQu6OHNlfPkaQPcFSo3qcPDvcL3OhWA82MeeB2xQdb+DeNnHzlM
         niXAHiDAIWVmw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVFYX-000Y0y-DL; Tue, 28 Sep 2021 18:02:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ABI: sysfs-mce: add a new ABI file
Date:   Tue, 28 Sep 2021 18:02:02 +0200
Message-Id: <91031a1005f014899554e5079e6d859f00473fb7.1632844726.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632844726.git.mchehab+huawei@kernel.org>
References: <cover.1632844726.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the gap of missing ABIs for Intel servers with MCE
by adding a new ABI file.

The contents of this file comes from:
	Documentation/x86/x86_64/machinecheck.rst

Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1632844726.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-mce | 107 ++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-mce

diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
new file mode 100644
index 000000000000..d0f5095da08b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -0,0 +1,107 @@
+What:		/sys/devices/system/machinecheck/machinecheckX/
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		(X = CPU number)
+
+		Machine checks report internal hardware error conditions
+		detected by the CPU. Uncorrected errors typically cause a
+		machine check (often with panic), corrected ones cause a
+		machine check log entry.
+
+		For more details about the x86 machine check architecture
+		see the Intel and AMD architecture manuals from their
+		developer websites.
+
+		For more details about the architecture
+		see http://one.firstfloor.org/~andi/mce.pdf
+
+		Each CPU has its own directory.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/bank<Y>
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		(Y bank number)
+
+		64bit Hex bitmask enabling/disabling specific subevents for
+		bank Y.
+
+		When a bit in the bitmask is zero then the respective
+		subevent will not be reported.
+
+		By default all events are enabled.
+
+		Note that BIOS maintain another mask to disable specific events
+		per bank.  This is not visible here
+
+What:		/sys/devices/system/machinecheck/machinecheckX/check_interval
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		How often to poll for corrected machine check errors, in
+		seconds (Note output is hexadecimal). Default 5 minutes.
+		When the poller finds MCEs it triggers an exponential speedup
+		(poll more often) on the polling interval.  When the poller
+		stops finding MCEs, it triggers an exponential backoff
+		(poll less often) on the polling interval. The check_interval
+		variable is both the initial and maximum polling interval.
+		0 means no polling for corrected machine check errors
+		(but some corrected errors might be still reported
+		in other ways)
+
+What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Tolerance level. When a machine check exception occurs for a
+		non corrected machine check the kernel can take different
+		actions.
+
+		Since machine check exceptions can happen any time it is
+		sometimes risky for the kernel to kill a process because it
+		defies normal kernel locking rules. The tolerance level
+		configures how hard the kernel tries to recover even at some
+		risk of	deadlock. Higher tolerant values trade potentially
+		better uptime with the risk of a crash or even corruption
+		(for tolerant >= 3).
+
+		==  ===========================================================
+		 0  always panic on uncorrected errors, log corrected errors
+		 1  panic or SIGBUS on uncorrected errors, log corrected errors
+		 2  SIGBUS or log uncorrected errors, log corrected errors
+		 3  never panic or SIGBUS, log all errors (for testing only)
+		==  ===========================================================
+
+		Default: 1
+
+		Note this only makes a difference if the CPU allows recovery
+		from a machine check exception. Current x86 CPUs generally
+		do not.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/trigger
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Program to run when a machine check event is detected.
+		This is an alternative to running mcelog regularly from cron
+		and allows to detect events faster.
+
+What:		/sys/devices/system/machinecheck/machinecheckX/monarch_timeout
+Contact:	Andi Kleen <ak@linux.intel.com>
+When:		Feb, 2007
+Description:
+		How long to wait for the other CPUs to machine check too on a
+		exception. 0 to disable waiting for other CPUs.
+
+		Unit: us
+
-- 
2.31.1

