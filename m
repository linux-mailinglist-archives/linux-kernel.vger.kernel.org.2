Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7981640D56E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhIPJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235519AbhIPJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589896137C;
        Thu, 16 Sep 2021 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=rfMpabz47Kf6QrjB2iI6nVOHZzo6l9WN7hrjr+mEb+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbhqk46Hgq8PHutzv+/zJOCltZF61m5AhOAwnN66Q707KvM/V2qWzg5csvgniv8yX
         CaudP6Hw5zmrvGs5SxOsmPfep+zDKj524OSU9Z5LFhXDTyaXNB1b9dHuzVggwfuEMZ
         8ruPhTqDw5mOci1/DDWkh8Vi8GJcCnaTtv9X9k3OkcoDG4H2cG95+s7c2pcfrVk745
         H8EuYrI+AXEfhLMpqQUsHV/mIuRr3XpDbbm3D0XZLgk3FA0VpR5HZwwfEqZIlnQkI4
         Lo/nw8Ml0CEy+txovMJnxVAW+XlHa2xEF87hX0nSVPxu30QFA5LgQBwb7fImPFGM1X
         UHr6Ny6Ubh56w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qlG-Gj; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/30] ABI: sysfs-devices-system-cpu: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:53 +0200
Message-Id: <d18385a391b6797373a5d1382ea024857fb29987.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/testing/sysfs-devices-system-cpu         | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index b46ef147616a..4ffc7e6ef403 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -135,7 +135,7 @@ Description:	Discover cpuidle policy and mechanism
 		Documentation/driver-api/pm/cpuidle.rst for more information.
 
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/name
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
@@ -174,7 +174,7 @@ Description:
 			      (a count).
 		======== ==== =================================================
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/desc
 Date:		February 2008
 KernelVersion:	v2.6.25
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -182,7 +182,7 @@ Description:
 		(RO) A small description about the idle state (string).
 
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/disable
 Date:		March 2012
 KernelVersion:	v3.10
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -195,14 +195,14 @@ Description:
 		does not reflect it. Likewise, if one enables a deep state but a
 		lighter state still is disabled, then this has no effect.
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/default_status
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/default_status
 Date:		December 2019
 KernelVersion:	v5.6
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
 Description:
 		(RO) The default status of this state, "enabled" or "disabled".
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/residency
 Date:		March 2014
 KernelVersion:	v3.15
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -211,7 +211,7 @@ Description:
 		time (in microseconds) this cpu should spend in this idle state
 		to make the transition worth the effort.
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/s2idle/
 Date:		March 2018
 KernelVersion:	v4.17
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -221,7 +221,7 @@ Description:
 		This attribute group is only present for states that can be
 		used in suspend-to-idle with suspended timekeeping.
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/time
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/s2idle/time
 Date:		March 2018
 KernelVersion:	v4.17
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -229,7 +229,7 @@ Description:
 		Total time spent by the CPU in suspend-to-idle (with scheduler
 		tick suspended) after requesting this state.
 
-What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/s2idle/usage
+What:		/sys/devices/system/cpu/cpuX/cpuidle/state<N>/s2idle/usage
 Date:		March 2018
 KernelVersion:	v4.17
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
-- 
2.31.1

