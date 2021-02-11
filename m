Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61B731935D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhBKTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhBKTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:47:31 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD775C061786;
        Thu, 11 Feb 2021 11:46:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w2so11811262ejk.13;
        Thu, 11 Feb 2021 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Md7oHiTHjbwRSktyunhTsYtpsxjjWEPdbXs75rlCNs=;
        b=MmXnwiKdJLt7LshNzh5XcJ35HCflv4JBPU5HgrBRyNXZVmBokK2RurFn0WQbw+Zsgq
         Ct9asVuD98dvjXf+AljEGYGPmIzb0Z9x1mP1Oxpz4ua6S0Th24DXxr7vN1dhz53tivr3
         r2C2R/9QqAZTyVeduJ4TtD8hxkkQe/3KfyfBRTn50yPrEDsMk/26mfOBSLLBCaoElisn
         YThfV+Y4nsjJIUClD0B+Z9svldJPncazEzPvOSyo4b4GnxJ/U168TBOKiTL/Ol9bSHNI
         R7IQT7/ABVOmjPP2BjBIb9i57rwS/DGYHrcDMkMIhoipUqLRDiuOK9DfmZFN6kBnqwXZ
         pc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Md7oHiTHjbwRSktyunhTsYtpsxjjWEPdbXs75rlCNs=;
        b=KN65ugy1aVEmwERtbMswwd0ZfkFsVjWugeadhRhdymj4vc5OcPxk/hURwrFbc4nHw8
         dAnmHswPgx6SjuYj9X+t5+ucZfQ4csexnkRYOsnU1L/RQALj60bYuZvAFIWOUTeokw2Z
         5iWk+uzoFgXEfmVJl3SfTh4Gm+PJHd5WafFukHEJNUdoRdKQ2SE2v9IR+8xmuoBWL0g2
         Qq7XJROZ39ivqlzNm2fmz9OGQtydZFR2FLxxraU4e/NpNLrY3DldJmNrQmdBJ0Y/NWRI
         Rd59Z/CJczFWQPg9utfU55KiSAO1lA9R5HJ0fH+EkcEM7zCPOj96Q2JIulqiRxqAc6tC
         PsKw==
X-Gm-Message-State: AOAM532ipjFSEy2b+uQ7Ew/MpcJ7O7m/W10DIMHL+XMTbx9nUfG52lxw
        6mw6KZGPhA+OhDzGyOIReIA=
X-Google-Smtp-Source: ABdhPJz+BW5uSrHPq5w96159eZcbGebzggQq2bq0wdRHQ/7WNjjKxObFUHnohxqV01ZlFAWA9jYWAQ==
X-Received: by 2002:a17:906:d214:: with SMTP id w20mr10152707ejz.284.1613072809447;
        Thu, 11 Feb 2021 11:46:49 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id f6sm4728728edr.72.2021.02.11.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:46:49 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] platform/surface: aggregator_registry: Add battery subsystem devices
Date:   Thu, 11 Feb 2021 20:46:33 +0100
Message-Id: <20210211194636.568929-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211194636.568929-1-luzmaximilian@gmail.com>
References: <20210211194636.568929-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add battery subsystem (TC=0x02) devices (battery and AC) to the SSAM
device registry. These devices need to be registered for 7th-generation
Surface models. On 5th- and 6th-generation models, these devices are
handled via the standard ACPI battery/AC interface, which in turn
accesses the same SSAM interface via the Surface ACPI Notify (SAN)
driver.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../surface/surface_aggregator_registry.c     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 0d802804594c..7e7b801bc606 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -47,6 +47,24 @@ static const struct software_node ssam_node_hub_base = {
 	.parent = &ssam_node_root,
 };
 
+/* AC adapter. */
+static const struct software_node ssam_node_bat_ac = {
+	.name = "ssam:01:02:01:01:01",
+	.parent = &ssam_node_root,
+};
+
+/* Primary battery. */
+static const struct software_node ssam_node_bat_main = {
+	.name = "ssam:01:02:01:01:00",
+	.parent = &ssam_node_root,
+};
+
+/* Secondary battery (Surface Book 3). */
+static const struct software_node ssam_node_bat_sb3base = {
+	.name = "ssam:01:02:02:01:00",
+	.parent = &ssam_node_hub_base,
+};
+
 /* Devices for Surface Book 2. */
 static const struct software_node *ssam_node_group_sb2[] = {
 	&ssam_node_root,
@@ -57,6 +75,9 @@ static const struct software_node *ssam_node_group_sb2[] = {
 static const struct software_node *ssam_node_group_sb3[] = {
 	&ssam_node_root,
 	&ssam_node_hub_base,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_bat_sb3base,
 	NULL,
 };
 
@@ -75,12 +96,16 @@ static const struct software_node *ssam_node_group_sl2[] = {
 /* Devices for Surface Laptop 3. */
 static const struct software_node *ssam_node_group_sl3[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
 /* Devices for Surface Laptop Go. */
 static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
@@ -99,6 +124,8 @@ static const struct software_node *ssam_node_group_sp6[] = {
 /* Devices for Surface Pro 7. */
 static const struct software_node *ssam_node_group_sp7[] = {
 	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
 	NULL,
 };
 
-- 
2.30.0

