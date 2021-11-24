Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44545B473
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhKXGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhKXGr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:47:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E3C061574;
        Tue, 23 Nov 2021 22:44:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o13so2191157wrs.12;
        Tue, 23 Nov 2021 22:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWWqy+D7G645krxdawFLSscKLW/Yyf2y0tCXPAu6wfc=;
        b=k7Yl0+1fXiFKzNXn4zXtaxLVNGtBoAbhJSndq+AOZ1+oDeXgZCstbaAiRRIIRtPjK0
         q8r+mlx5S6jrcjEvUDdZOkRSnZKPdaux4vsXOXQuvNKxE5rH9pE1+iyWDgHouSB+xK2D
         JS8npviIHFBOpWPtw3WQ3siauUs8IpIkKpViQ87HI4jjft3AtMvSYEEqpKSxW8RBFkar
         Tr0NW9SljQW1FPJ9b96G2F7/lD7qPboZpi4MRL12KcfP1ddoMI8ebkiZTl9D065KvM5f
         2fC61t8YSdwRzbOVFDUAtiqfdlQg/Qh7USRmo4VrqlXMqTQBzC3AtdzSaIUIYXF2+TaK
         eiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWWqy+D7G645krxdawFLSscKLW/Yyf2y0tCXPAu6wfc=;
        b=WzRTqwrFJmx6HxhGYG3SXfkHTwbEE80tQyuZtXn1Q9xJjr/ywKbzDob/XscuLfU6C1
         lRawvaFC0gdRa3F29C5ZrSkBGUcqqBGDQ+KdaP+8x9Vj+eMcXfRUXTTRaA02tZFClGxr
         LPq5ANytR3DH4HmfB2uTNleNbn3i5GFXZt5dyclnfH00Duz2FpoxuKD/Zghw/lb+WEwN
         EGIX7BoMS+C/NE5mPfXfKcwg6cPXPjbZkhWUhG8/VPDFj72FqpC5bnG7PmVGrJAsWsf+
         Q1g5n1Ww3gtWNi77YuQYAxpRxTi73SdaIhHwIzkNooCFjA8MkwjZcmVt8KlTCVeu7kHj
         7mOQ==
X-Gm-Message-State: AOAM5309oJRr0VgOVvEaFo1Fnks7exve2SD0udQ9pVJYhW5pTFs1u7qL
        uThsGHHkis9UbvSH4VSee01gNSXX9ZVxCQ==
X-Google-Smtp-Source: ABdhPJwcwZWqXxwwVSifqiRmucqnhx8GmRZxA8/lI+x1gZ1MItOIK+r44GwnYVYiPfeWLcFl4X0Oqw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr15685868wrd.362.1637736287635;
        Tue, 23 Nov 2021 22:44:47 -0800 (PST)
Received: from localhost.localdomain ([94.179.31.148])
        by smtp.gmail.com with ESMTPSA id b197sm3425801wmb.24.2021.11.23.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 22:44:47 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ed Brindley <kernel@maidavale.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] hwmon: Fix warnings in asus_wmi_sensors.rst documetation.
Date:   Wed, 24 Nov 2021 08:43:28 +0200
Message-Id: <20211124064328.16048-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124162243.7db9ad02@canb.auug.org.au>
References: <20211124162243.7db9ad02@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 9d07e54a25b8 ("hwmon: (asus_wmi_sensors) Support X370 Asus WMI.")

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
---
 Documentation/hwmon/asus_wmi_sensors.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/asus_wmi_sensors.rst b/Documentation/hwmon/asus_wmi_sensors.rst
index 408fd3b4a0de..8f2096cf5183 100644
--- a/Documentation/hwmon/asus_wmi_sensors.rst
+++ b/Documentation/hwmon/asus_wmi_sensors.rst
@@ -29,7 +29,9 @@ ASUS mainboards publish hardware monitoring information via WMI interface.
 
 ASUS WMI interface provides a methods to get list of sensors and values of
 such, which is utilized by this driver to publish those sensor readings to the
-HWMON system. The driver is aware of and reads the following sensors:
+HWMON system.
+
+The driver is aware of and reads the following sensors:
  * CPU Core Voltage,
  * CPU SOC Voltage,
  * DRAM Voltage,
@@ -64,7 +66,7 @@ HWMON system. The driver is aware of and reads the following sensors:
  * CPU VRM Output Current.
 
 Known Issues:
-* The WMI implementation in some of Asus' BIOSes is buggy. This can result in
+ * The WMI implementation in some of Asus' BIOSes is buggy. This can result in
    fans stopping, fans getting stuck at max speed, or temperature readouts
    getting stuck. This is not an issue with the driver, but the BIOS. The Prime
    X470 Pro seems particularly bad for this. The more frequently the WMI
@@ -73,4 +75,4 @@ Known Issues:
    sensors frequently, don't leave you computer unattended. Upgrading to new
    BIOS version with method version greater than or equal to two should
    rectify the issue.
-* A few boards report 12v voltages to be ~10v.
+ * A few boards report 12v voltages to be ~10v.

base-commit: 9d07e54a25b84099983f56e33e00f2914f06b53f
-- 
2.33.0

