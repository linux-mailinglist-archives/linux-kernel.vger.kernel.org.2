Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7688A378290
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEJKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhEJKcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:32:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49E1F61958;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=Pg2qv1PyBmV/3qvZjOeKfPkzyVnt5zIKcDMwAHh0fIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FI1HvE98acQIgu11DzaWCi14QJL3FKr9lDE/GSDDFL/YQlxOjFqcTbVOZGZw3boxU
         ESsLthtJmj6eeZxK+2eg5YNor8j+W/dNZm0rwfdJMkirYVKYCRAvwNbp/ia1KvwEu9
         4iEFnu9h6PkX9xUAp78jZzew1kk2gqguMbqfgGxbLOptCAyTUtaCw1bDrlOKGbTD1l
         Yv7rVMa0DYeggtCI3joATQYYFjuvqDNzb0bweg6gIW9tvePoRNeTNQn/EnoTogaaK1
         65+TlilASfwCZjz8ulgPWunna6NtIpGCNyUDmubv/ZQYHU6Rlp0hKyCOPwCWfDJpsJ
         BpV25e00QE/1g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UQy-AA; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 41/53] docs: ABI: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:53 +0200
Message-Id: <16298d18c8bada9775e32d5f7f9edf664bce820d.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2013 ('–'): EN DASH
	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar  | 2 +-
 Documentation/ABI/testing/sysfs-class-net-cdc_ncm             | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ipmi         | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-trackpoint   | 2 +-
 Documentation/ABI/testing/sysfs-devices-soc                   | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
index 57a037791403..a7fb8f1169f2 100644
--- a/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
+++ b/Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
@@ -29,7 +29,7 @@ KernelVersion:	4.2
 Description:
 		This allows you to control each LED segment. If the
 		lightbar is already running one of the automatic
-		sequences, you probably won’t see anything change because
+		sequences, you probably won't see anything change because
 		your color setting will be almost immediately replaced.
 		To get useful results, you should stop the lightbar
 		sequence first.
diff --git a/Documentation/ABI/testing/sysfs-class-net-cdc_ncm b/Documentation/ABI/testing/sysfs-class-net-cdc_ncm
index 06416d0e163d..41a1eef0d0e7 100644
--- a/Documentation/ABI/testing/sysfs-class-net-cdc_ncm
+++ b/Documentation/ABI/testing/sysfs-class-net-cdc_ncm
@@ -93,7 +93,7 @@ Contact:	Bjørn Mork <bjorn@mork.no>
 Description:
 		- Bit 0: 16-bit NTB supported (set to 1)
 		- Bit 1: 32-bit NTB supported
-		- Bits 2 – 15: reserved (reset to zero; must be ignored by host)
+		- Bits 2 - 15: reserved (reset to zero; must be ignored by host)
 
 What:		/sys/class/net/<iface>/cdc_ncm/dwNtbInMaxSize
 Date:		May 2014
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
index 07df0ddc0b69..3935cdedea0e 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-ipmi
+++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
@@ -52,7 +52,7 @@ Date:		Mar, 2006
 KernelVersion:	v2.6.17
 Contact:	openipmi-developer@lists.sourceforge.net
 Description:
-		(RO) Lists the IPMI ‘logical device’ commands and functions
+		(RO) Lists the IPMI 'logical device' commands and functions
 		that the controller supports that are in addition to the
 		mandatory IPM and Application commands.
 
diff --git a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
index df11901a6b3d..82a38ac0435c 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
+++ b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
@@ -105,7 +105,7 @@ KernelVersion:	3.19
 Contact:	linux-input@vger.kernel.org
 Description:
 		(RW) This parameter controls the period of time to test for a
-		‘hands off’ condition (i.e. when no force is applied) before a
+		'hands off' condition (i.e. when no force is applied) before a
 		drift (noise) calibration occurs.
 
 		IBM Trackpoints have a feature to compensate for drift by
diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index ea999e292f11..7f90c6a44610 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -27,11 +27,11 @@ Description:
 		(e.g. DB8500).
 
 		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
-		this will contain the JEDEC JEP106 manufacturer’s identification
+		this will contain the JEDEC JEP106 manufacturer's identification
 		code. The format is "jep106:XXYY" where XX is identity code and
 		YY is continuation code.
 
-		This manufacturer’s identification code is defined by one
+		This manufacturer's identification code is defined by one
 		or more eight (8) bit fields, each consisting of seven (7)
 		data bits plus one (1) odd parity bit. It is a single field,
 		limiting the possible number of vendors to 126. To expand
-- 
2.30.2

