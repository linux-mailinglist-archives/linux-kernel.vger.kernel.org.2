Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C240B0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhINOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhINOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93BD56113B;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=y83gaW55yksloBuWX0OKO49iArybMqGw/eZJ7F2ASQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhODY8aFqwgVKH21JzlyjGW0cQKw6SgXCzp5VvqDNIWs5Ob71JQlrN4+3G6JxeFxP
         6BWVruT4kRN92cgNQ1Oe571RTGqA3it2a1/yB4WPXdGl0Ithzk7deExfrP2Lmrpg3g
         FN9PsKSar/IU3E4oibappobztr1OYzEeSuxRPifNBCkgzG+8O3577KzicrXMGYMfcD
         6FCBLhYgre+r//3ltb+e/LXecpAW4yR7nz4koqXyRvfaZXtjsWD1j7UMuHb6hNbS8d
         QNIvMAO7Tb5WLr7u9/AHAoCGnzNbm8Nc7GbAAU4XGovyRAmRy8rWfp6UedMYt+uQG1
         aSYhY0n1TnmHA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UO-000Klw-Jv; Tue, 14 Sep 2021 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/29] ABI: sysfs-firmware-efi-esrt: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:42 +0200
Message-Id: <1480eb6c86fbb27c8fad6db614249cae8e39df09.1631629496.git.mchehab+huawei@kernel.org>
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

