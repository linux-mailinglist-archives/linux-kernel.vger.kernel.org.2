Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8C540D571
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbhIPJCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235505AbhIPJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5063C6137B;
        Thu, 16 Sep 2021 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782803;
        bh=y83gaW55yksloBuWX0OKO49iArybMqGw/eZJ7F2ASQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwSlOUN3DE4CgKwHy7xaSWTpq3vTxOCIYCPTXEabg8/O5wU4sghPNQhdNFbTRR3b5
         B7Z5yTncwqP6UO7PqFbrJXO8+5bEcVFDvHjvlNOSNuxOeTF1ttC74aKij7P/D9zO4x
         CxmUyoxKJ+Tz7GXMzvaRkjXuucGknyfW1xztbKINahr3zgWKu9FSKikEoZSGgVyBsc
         E44kJJI9JCmKc2/5w8s3/Lqm61PEJxthOma0RBJHO93vgjps5qXIfKso5VfAcvPJqw
         Au0aqfkEjITZJpHk0t/6Tq7rnhovkZZcdB1dWHyl+VSV+b3CyO3iTG3Gb95pypY2t8
         Pnp+iozUXJUJg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFR-001qlL-I5; Thu, 16 Sep 2021 11:00:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 27/30] ABI: sysfs-firmware-efi-esrt: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:54 +0200
Message-Id: <44f63335333d019490297903609a8a1754a66183.1631782432.git.mchehab+huawei@kernel.org>
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
 .../ABI/testing/sysfs-firmware-efi-esrt          | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi-esrt b/Documentation/ABI/testing/sysfs-firmware-efi-esrt
index 31b57676d4ad..4c2d440487dd 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi-esrt
+++ b/Documentation/ABI/testing/sysfs-firmware-efi-esrt
@@ -24,14 +24,14 @@ Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	The version of the ESRT structure provided by the firmware.
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/
+What:		/sys/firmware/efi/esrt/entries/entry<N>/
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	Each ESRT entry is identified by a GUID, and each gets a
 		subdirectory under entries/ .
 		example: /sys/firmware/efi/esrt/entries/entry0/
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/fw_type
+What:		/sys/firmware/efi/esrt/entries/entry<N>/fw_type
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	What kind of firmware entry this is:
@@ -43,33 +43,33 @@ Description:	What kind of firmware entry this is:
 		3   UEFI Driver
 		==  ===============
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/fw_class
+What:		/sys/firmware/efi/esrt/entries/entry<N>/fw_class
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	This is the entry's guid, and will match the directory name.
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/fw_version
+What:		/sys/firmware/efi/esrt/entries/entry<N>/fw_version
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	The version of the firmware currently installed.  This is a
 		32-bit unsigned integer.
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/lowest_supported_fw_version
+What:		/sys/firmware/efi/esrt/entries/entry<N>/lowest_supported_fw_version
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	The lowest version of the firmware that can be installed.
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/capsule_flags
+What:		/sys/firmware/efi/esrt/entries/entry<N>/capsule_flags
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	Flags that must be passed to UpdateCapsule()
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/last_attempt_version
+What:		/sys/firmware/efi/esrt/entries/entry<N>/last_attempt_version
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	The last firmware version for which an update was attempted.
 
-What:		/sys/firmware/efi/esrt/entries/entry$N/last_attempt_status
+What:		/sys/firmware/efi/esrt/entries/entry<N>/last_attempt_status
 Date:		February 2015
 Contact:	Peter Jones <pjones@redhat.com>
 Description:	The result of the last firmware update attempt for the
-- 
2.31.1

