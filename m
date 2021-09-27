Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD474192D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhI0LMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233924AbhI0LMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4515560F6B;
        Mon, 27 Sep 2021 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632741062;
        bh=BkHsQjcUqqJd+UovClt2vj9iy3OwymogfsOoQT/wzQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZvtExBvyew4zyUkmeu3+tGzsTWPxkuX74vn74LYm8QWvXXeTvbnllsEBk3oAJo6i
         XHI1qtCAQjr68luaIZSgFv3qSwPuVnhUsn2RA7+C3I+urTPc6sfBX8d8Z6cijh7wQt
         y6I+PoOsI69DERvAF6yagtSuz985Ks0GioER31L1HWGLlVqVHdV4eVI8+M1K+ts8uX
         4FDgL13I5XZ8C/OGi5hYpN1+zmCEW2oQ/1ir2w4eXxizOQMxtufv3o+aFIuDrnoDC9
         r9sOi2lMPfvIM7a672LAOXNOVipV3OO6AaW03oZu17r8COZjn0xzhUHNTMYuLOh1Zm
         c9z8TRSh2GSAw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUoXE-0005yC-9P; Mon, 27 Sep 2021 13:11:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Perry Yuan <perry_yuan@dell.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ABI: sysfs-platform-dell-privacy-wmi: correct ABI entries
Date:   Mon, 27 Sep 2021 13:10:51 +0200
Message-Id: <42846621fdf2bf206feb114d06b14cbc47475fb5.1632740376.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632740376.git.mchehab+huawei@kernel.org>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described at Documentation/ABI/README doesn't contain an
Attribute: field.

The way sysfs ABI is supposed to work is that each different
attribute would have a separate file. So, the right way to
map this would be like:

	/sys/.../dell_privacy_supported_type/mic_mute
	/sys/.../dell_privacy_supported_type/camera_shutter

	/sys/.../dell_privacy_current_state/mic_mute
	/sys/.../dell_privacy_current_state/camera_shutter

However, it seems to late to fix that, as this was merged already on
Kernel 5.13, and a change right now would be a regression.

So, instead, let's at least fix the entry to match the expected
format.

While here, fix the format of the contact, which is not a valid
e-mail URL.

This should also fix the current warnings produced when building the
docs:

	Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi:35: WARNING: Unexpected indentation.
	Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi:2: WARNING: Unexpected indentation.

Fixes: 8af9fa37b8a3 ("platform/x86: dell-privacy: Add support for Dell hardware privacy")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/7] at: https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.org/T/#t

 .../testing/sysfs-platform-dell-privacy-wmi   | 60 ++++++++++++-------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
index 7f9e18705861..1f1f274a6979 100644
--- a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
@@ -1,55 +1,71 @@
 What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
 Date:		Apr 2021
 KernelVersion:	5.13
-Contact:	"perry.yuan@dell.com>"
+Contact:	"<perry.yuan@dell.com>"
 Description:
 		Display which dell hardware level privacy devices are supported
 		“Dell Privacy” is a set of HW, FW, and SW features to enhance
 		Dell’s commitment to platform privacy for MIC, Camera, and
 		ePrivacy screens.
 		The supported hardware privacy devices are:
-Attributes:
-		Microphone Mute:
+
+		Attributes:
+			Microphone Mute:
 				Identifies the local microphone can be muted by hardware, no applications
 				is available to capture system mic sound
 
-		Camera Shutter:
+			Camera Shutter:
 				Identifies camera shutter controlled by hardware, which is a micromechanical
 				shutter assembly that is built onto the camera module to block capturing images
 				from outside the laptop
 
-		supported:
+		Values:
+
+			supported:
 				The privacy device is supported by this system
 
-		unsupported:
+			unsupported:
 				The privacy device is not supported on this system
 
-		For example to check which privacy devices are supported:
+		For example to check which privacy devices are supported::
 
-		# cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
-		[Microphone Mute] [supported]
-		[Camera Shutter] [supported]
-		[ePrivacy Screen] [unsupported]
+		    # cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_supported_type
+		    [Microphone Mute] [supported]
+		    [Camera Shutter] [supported]
+		    [ePrivacy Screen] [unsupported]
 
 What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
 Date:		Apr 2021
 KernelVersion:	5.13
-Contact:	"perry.yuan@dell.com>"
+Contact:	"<perry.yuan@dell.com>"
 Description:
 		Allow user space to check current dell privacy device state.
 		Describes the Device State class exposed by BIOS which can be
 		consumed by various applications interested in knowing the Privacy
 		feature capabilities
-Attributes:
-		muted:
-			Identifies the privacy device is turned off and cannot send stream to OS applications
 
-		unmuted:
-			Identifies the privacy device is turned on ,audio or camera driver can get
-			stream from mic and camera module to OS applications
+		Attributes:
+			Microphone:
+				Identifies the local microphone can be muted by hardware, no applications
+				is available to capture system mic sound
 
-		For example to check all supported current privacy device states:
+			Camera Shutter:
+				Identifies camera shutter controlled by hardware, which is a micromechanical
+				shutter assembly that is built onto the camera module to block capturing images
+				from outside the laptop
 
-		# cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
-		[Microphone] [unmuted]
-		[Camera Shutter] [unmuted]
+		Values:
+			muted:
+				Identifies the privacy device is turned off
+				and cannot send stream to OS applications
+
+			unmuted:
+				Identifies the privacy device is turned on,
+				audio or camera driver can get stream from mic
+				and camera module to OS applications
+
+		For example to check all supported current privacy device states::
+
+		    # cat /sys/bus/wmi/drivers/dell-privacy/6932965F-1671-4CEB-B988-D3AB0A901919/dell_privacy_current_state
+		    [Microphone] [unmuted]
+		    [Camera Shutter] [unmuted]
-- 
2.31.1

