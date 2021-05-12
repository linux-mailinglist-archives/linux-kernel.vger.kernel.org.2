Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190FF37BD73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhELM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhELMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C63E6188B;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=j6DIEEgrDdmsa6vlovG+W3lTJsaTQQADW76v2QtOJRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuHrE/8cnNkSvEikAD0T12AKzFrpPbkQ8uXSWeouu06bs2YJaZAuc9tQ/3SuwXDAP
         OlqDV393Tk/OF5FhZm5j+pvdx5N07ZOnlUbquT7bgWSRCj94YP30y/LIy/uCRzIuZz
         KoYDa+J/EvC1DYW/bx4TVBM9X5VZvmEgVPuJV0L0DjrnM6a8SMN+lx1QTPIYGo+YiR
         GayR1XixWqskRTbYLn+ExStvioXxzeoAekh5q+6XJQNi7EDP7ddvTJTVbI6WX7mjot
         9m1Lm4EQT4/xcN5BebFHVjKZ4UGPCmr2uVYN9FWVbG4R2aiyLle2Zmzqi73lGZkLiR
         r5WMPY7VvUp5A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018ik-BR; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/40] docs: ABI: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:34 +0200
Message-Id: <5109b6739272e1faa637ba2acb33b3129131d4aa.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar  | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-ipmi         | 2 +-
 Documentation/ABI/testing/sysfs-devices-platform-trackpoint   | 2 +-
 Documentation/ABI/testing/sysfs-devices-soc                   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

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

