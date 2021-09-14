Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1339840B101
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhINOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3A5461183;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=rfMpabz47Kf6QrjB2iI6nVOHZzo6l9WN7hrjr+mEb+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAeA1iFOMOrza37rU5eD4T/wcycH8jg0fQ4rT0Kb1I1+hcBeOxan5c3RBUuZYwt9W
         n6kvqvtWMU3HFpNiVCm/rhTKRncmxIfuedOHmfl0Js/U9PKrZIzfTgrU/MPN3+5PqX
         PSyDjG2qaEXidsrj/eU5UrEZh1NZPpKfm2W9PbNMf9pLr7OLm8P4P9dglH2LHcCXvn
         +t9dSf5pyMOOC5gFshJFuagmRRihcz9w9HbMNbov/JsD44THmEhzU8DPxPTgOlIOws
         ubjs/bNEUT23S26xU/eXtk+RAjDt+ner4CWFjMhKuZ4uh87M6F4eX3LCMqfpUSHp+6
         ng1tZ0+QChSKQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Kls-I4; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Carlos Bilbao <bilbao@vt.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/29] ABI: sysfs-devices-system-cpu: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:41 +0200
Message-Id: <a0bbb519e67d57b0fa38e2b9fb4d0ac7ad942531.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
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

