Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1A37822F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEJKc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhEJK3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC1F6616EB;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=z3lehbQisRPwcowhdp3sI/EWXe3DUCuO1PQchHhUbNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBzJ/kHwWeaFhrmP1DbHzK4S2rvyQW8frY31dBoOr82eto06eu0K6yiSw1yz1Ee2/
         uDojUFQHlzYbiRL4d5pbeFh6I/b4YIr5/RPtLe/XQn7NUoeuDieA8mpYmyL81FVxyG
         z5ENWiXnDwlAi2RdhO6XB6FZPLMSiZafG+s/s7YAIdeLFHifSv6MJsQK2PHMOnq9tk
         YvdA3vyua/UxKgT36DKRKk7k7u9wT5+LMc8nCf80buD2v6icZxoKOz2EmzuJ88fav4
         PGEkl+7SeYrEgwIyxo3olqmjRIbazVEcOmhICP6Ik5WDuA8t0/1gtfRhKSaw0CIiO8
         uwtcis8vzmlEQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOe-Hh; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Charles Hsu <hsu.yungteng@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/53] docs: hwmon: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:17 +0200
Message-Id: <ccdd1bf45963a7748188a97c75f667b37bd43d2f.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+2010 ('‐'): HYPHEN
	- U+2013 ('–'): EN DASH
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/ir36021.rst  | 2 +-
 Documentation/hwmon/ltc2992.rst  | 2 +-
 Documentation/hwmon/pm6764tr.rst | 2 +-
 Documentation/hwmon/tmp103.rst   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/ir36021.rst b/Documentation/hwmon/ir36021.rst
index ca3436b04e20..1faa85c39f1b 100644
--- a/Documentation/hwmon/ir36021.rst
+++ b/Documentation/hwmon/ir36021.rst
@@ -19,7 +19,7 @@ Authors:
 Description
 -----------
 
-The IR36021 is a dual‐loop digital multi‐phase buck controller designed for
+The IR36021 is a dual-loop digital multi-phase buck controller designed for
 point of load applications.
 
 Usage Notes
diff --git a/Documentation/hwmon/ltc2992.rst b/Documentation/hwmon/ltc2992.rst
index 46aa1aa84a1a..a0bcd867a0f5 100644
--- a/Documentation/hwmon/ltc2992.rst
+++ b/Documentation/hwmon/ltc2992.rst
@@ -19,7 +19,7 @@ This driver supports hardware monitoring for Linear Technology LTC2992 power mon
 LTC2992 is a rail-to-rail system monitor that measures current,
 voltage, and power of two supplies.
 
-Two ADCs simultaneously measure each supply’s current. A third ADC monitors
+Two ADCs simultaneously measure each supply's current. A third ADC monitors
 the input voltages and four auxiliary external voltages.
 
 
diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
index a1fb8fea2326..294a8ffc8bd8 100644
--- a/Documentation/hwmon/pm6764tr.rst
+++ b/Documentation/hwmon/pm6764tr.rst
@@ -20,7 +20,7 @@ Description:
 ------------
 
 This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
-performance digital controller designed to power Intel’s VR12.5 processors and memories.
+performance digital controller designed to power Intel's VR12.5 processors and memories.
 
 The device utilizes digital technology to implement all control and power management
 functions to provide maximum flexibility and performance. The NVM is embedded to store
diff --git a/Documentation/hwmon/tmp103.rst b/Documentation/hwmon/tmp103.rst
index e195a7d14309..b3ef81475cf8 100644
--- a/Documentation/hwmon/tmp103.rst
+++ b/Documentation/hwmon/tmp103.rst
@@ -21,10 +21,10 @@ Description
 The TMP103 is a digital output temperature sensor in a four-ball
 wafer chip-scale package (WCSP). The TMP103 is capable of reading
 temperatures to a resolution of 1°C. The TMP103 is specified for
-operation over a temperature range of –40°C to +125°C.
+operation over a temperature range of -40°C to +125°C.
 
 Resolution: 8 Bits
-Accuracy: ±1°C Typ (–10°C to +100°C)
+Accuracy: ±1°C Typ (-10°C to +100°C)
 
 The driver provides the common sysfs-interface for temperatures (see
 Documentation/hwmon/sysfs-interface.rst under Temperatures).
-- 
2.30.2

