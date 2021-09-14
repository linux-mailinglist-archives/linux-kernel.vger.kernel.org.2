Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B714F40B106
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhINOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233876AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D82806124A;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=LYe9oOSzt+kJG5LBerNEEaYI0BlPAHReLL+PyWjMW7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiB0U9Qd02sGjsmjsxVuerMvy8H3s6D3FfF61j2R5g/3ORdiFmJnj5ekGh3zhqNQb
         fEXNRSnk9LQvoFNHdeZqr/u17rs6MUTb9oItZ7TZvAY3TnftPgjCYqy7alwEOVdmZl
         IZ3HcAFHEC8wnkK+gTwkTbQzXijx5Rni3NEq1akx3HCnqKcJ6YmaaUohwhvN20BzJq
         71UWrFJZKxHRp5dX1smVjFcfUo76WETwygbaV2pTXAbMKSC0LwhET9NdJXuhegyxQi
         P2IhS0KtN2Wxd066D52Qt3Ce+i6Dg0DcqraFc0CkHyNIk3fqFLsO4jU4S6VggKpFvP
         YoFQqw8YEoj4w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Klg-D5; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/29] ABI: sysfs-class-uwb_rc: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:38 +0200
Message-Id: <434dd46b3615d4b15a8f800bb7b6f1ff143d1e67.1631629496.git.mchehab+huawei@kernel.org>
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
 Documentation/ABI/testing/sysfs-class-uwb_rc | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-uwb_rc b/Documentation/ABI/testing/sysfs-class-uwb_rc
index 6c5dcad21e19..a7ea169dc4eb 100644
--- a/Documentation/ABI/testing/sysfs-class-uwb_rc
+++ b/Documentation/ABI/testing/sysfs-class-uwb_rc
@@ -18,14 +18,14 @@ Description:
                 and it will be removed.  The default is 3 superframes
                 (~197 ms) as required by the specification.
 
-What:           /sys/class/uwb_rc/uwbN/
+What:           /sys/class/uwb_rc/uwb<N>/
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
 Description:
                 An individual UWB radio controller.
 
-What:           /sys/class/uwb_rc/uwbN/beacon
+What:           /sys/class/uwb_rc/uwb<N>/beacon
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -43,7 +43,7 @@ Description:
                 Reading returns the currently active channel, or -1 if
                 the radio controller is not beaconing.
 
-What:           /sys/class/uwb_rc/uwbN/ASIE
+What:           /sys/class/uwb_rc/uwb<N>/ASIE
 Date:           August 2014
 KernelVersion:  3.18
 Contact:        linux-usb@vger.kernel.org
@@ -56,7 +56,7 @@ Description:
                 Reading returns the current ASIE.  Writing replaces
                 the current ASIE with the one written.
 
-What:           /sys/class/uwb_rc/uwbN/scan
+What:           /sys/class/uwb_rc/uwb<N>/scan
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -75,7 +75,7 @@ Description:
                     4   scan (with start time of <bpst offset>)
 		   ==   =======================================
 
-What:           /sys/class/uwb_rc/uwbN/mac_address
+What:           /sys/class/uwb_rc/uwb<N>/mac_address
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -85,7 +85,7 @@ Description:
                 controller's EUI-48 but only do so while the device is
                 not beaconing or scanning.
 
-What:           /sys/class/uwb_rc/uwbN/wusbhc
+What:           /sys/class/uwb_rc/uwb<N>/wusbhc
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -93,7 +93,7 @@ Description:
                 A symlink to the device (if any) of the WUSB Host
                 Controller PAL using this radio controller.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -102,7 +102,7 @@ Description:
                 as part of a scan or is a member of the radio
                 controllers beacon group.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/BPST
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/BPST
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -111,7 +111,7 @@ Description:
                 interval superframe timer) of the last beacon from
                 this device was received.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/DevAddr
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/DevAddr
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -119,7 +119,7 @@ Description:
                 The current DevAddr of this device in colon separated
                 hex octets.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/EUI_48
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/EUI_48
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -128,7 +128,7 @@ Description:
                 The EUI-48 of this device in colon separated hex
                 octets.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/IEs
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/IEs
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -136,7 +136,7 @@ Description:
                 The latest IEs included in this device's beacon, in
                 space separated hex octets with one IE per line.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/LQE
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/LQE
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
@@ -146,7 +146,7 @@ Description:
                 This gives an estimate on a suitable PHY rate. Refer
                 to [ECMA-368] section 13.3 for more details.
 
-What:           /sys/class/uwb_rc/uwbN/<EUI-48>/RSSI
+What:           /sys/class/uwb_rc/uwb<N>/<EUI-48>/RSSI
 Date:           July 2008
 KernelVersion:  2.6.27
 Contact:        linux-usb@vger.kernel.org
-- 
2.31.1

