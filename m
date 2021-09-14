Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5F40B0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhINOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233816AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A073861164;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=swRIG9LljGAFZs0bx42creS9NDiqYNdO/6An/2Vp5co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqZs9IE6rIE24cGaExZlHUsE59gG1rbgkrKSxxuh8feSstlA5IzGXU0wOJu5SooC8
         y+Azo6WA9PxKoE9wO97h+OCNOSED8Ae/+Rl2vviNsLtHvWTCx0I7G2LgDiq2fVdvy5
         naK0VgAE9iWl2R0rnhCd19F10JHv38M27S8ZgYPTZcNzmLDAJ76/Z4sNbXlbWYokLE
         BxdsaHMmuE3AnSWmnsXHMHzo2zzHutaFYpql+EnfIt5Ed5GhbTAQxuFuNF8y03UMXa
         pgx7P2rusGdQ8N8HVeyY5nx9IK+cLib/N/UzaTqQBZf/o+Eqx7TUgGYKT4FPgJ4fWS
         +rymnci9/1Q5Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000KlM-59; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/29] ABI: sysfs-class-mei: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:33 +0200
Message-Id: <488fe53f7e969cf9c238f322d1106bc28ac32408.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-class-mei | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index 5c52372b43cb..1db36ddf8e58 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -6,7 +6,7 @@ Description:
 		The mei/ class sub-directory belongs to mei device class
 
 
-What:		/sys/class/mei/meiN/
+What:		/sys/class/mei/mei<N>/
 Date:		May 2014
 KernelVersion:	3.17
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -14,7 +14,7 @@ Description:
 		The /sys/class/mei/meiN directory is created for
 		each probed mei device
 
-What:		/sys/class/mei/meiN/fw_status
+What:		/sys/class/mei/mei<N>/fw_status
 Date:		Nov 2014
 KernelVersion:	3.19
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -29,7 +29,7 @@ Description:	Display fw status registers content
 		Also number of registers varies between 1 and 6
 		depending on generation.
 
-What:		/sys/class/mei/meiN/hbm_ver
+What:		/sys/class/mei/mei<N>/hbm_ver
 Date:		Aug 2016
 KernelVersion:	4.9
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -38,7 +38,7 @@ Description:	Display the negotiated HBM protocol version.
 		The HBM protocol version negotiated
 		between the driver and the device.
 
-What:		/sys/class/mei/meiN/hbm_ver_drv
+What:		/sys/class/mei/mei<N>/hbm_ver_drv
 Date:		Aug 2016
 KernelVersion:	4.9
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -46,7 +46,7 @@ Description:	Display the driver HBM protocol version.
 
 		The HBM protocol version supported by the driver.
 
-What:		/sys/class/mei/meiN/tx_queue_limit
+What:		/sys/class/mei/mei<N>/tx_queue_limit
 Date:		Jan 2018
 KernelVersion:	4.16
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -55,7 +55,7 @@ Description:	Configure tx queue limit
 		Set maximal number of pending writes
 		per opened session.
 
-What:		/sys/class/mei/meiN/fw_ver
+What:		/sys/class/mei/mei<N>/fw_ver
 Date:		May 2018
 KernelVersion:	4.18
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -66,7 +66,7 @@ Description:	Display the ME firmware version.
 		There can be up to three such blocks for different
 		FW components.
 
-What:		/sys/class/mei/meiN/dev_state
+What:		/sys/class/mei/mei<N>/dev_state
 Date:		Mar 2019
 KernelVersion:	5.1
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -81,7 +81,7 @@ Description:	Display the ME device state.
 		POWER_DOWN
 		POWER_UP
 
-What:		/sys/class/mei/meiN/trc
+What:		/sys/class/mei/mei<N>/trc
 Date:		Nov 2019
 KernelVersion:	5.5
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
@@ -91,7 +91,7 @@ Description:	Display trc status register content
 		status information into trc status register
 		for BIOS and OS to monitor fw health.
 
-What:		/sys/class/mei/meiN/kind
+What:		/sys/class/mei/mei<N>/kind
 Date:		Jul 2020
 KernelVersion:	5.8
 Contact:	Tomas Winkler <tomas.winkler@intel.com>
-- 
2.31.1

