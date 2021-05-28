Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B139485D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE1Vfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhE1Vfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:35:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 14:34:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q1so7289232lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW5/ZGR2GdWjiv2lO3A6lPu+CPRyVAA0auOrwAPUigo=;
        b=hsHNrajX0rHFtCPbcsqG982PeSxsAkizK+1zF5q1wAhBbDzZriYXAGCsb23ZFnrJjV
         RfYusF5//CgCMfNMVP0l71MG/8YFis1ij8GZSWWLqh99AvznamyoGsEwDaUHctOizVjj
         izsvHRnTeZtLYyH6zDDDpnSjbHlwZFwHW0Ul5y/YA3knO/uDWJvYB4/6NfY97EPwvGCK
         z5ISPfg7CiXDTMoobRFI7Rtz0jZ6/iPlZRrzBJ+Xj2F6SeB09J4mfJiFTAHBS4u9gDRZ
         XqI2UrVqD4j5SjGpeq+c1qSi4CNSCJPz8x0oeEjZdOGkNDlhvlc2Ngqj2E7qoTgL0r8k
         eLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW5/ZGR2GdWjiv2lO3A6lPu+CPRyVAA0auOrwAPUigo=;
        b=WPAVPUTEjnEsweXH5P9LslO1t/XsNcAWQkGLrnMsmk3fK4johLvyGS/wQaoV2YNpm/
         cuw8Wvj+nbJxIgI2kGpLjk4Q2xtZP45TlZiEbPxmmOBJcz7zN2kYykk5NCXXDKr2ux6S
         QwlvTALsf/26pERYFuo+beKOxhnk1iWC4NkzgHiYdGp1Mi6ibIejOakMKmjyQgtA6FSp
         dREFOsU7E+ds96sgGY+27UIXdOgsurMnrdIeIvp6ZqNQwmvL6jfWZbebtE34h5/+Vw/K
         lg0nMdUIHd+vTLo7XeY3V5kVQK4Zh/+GnAV7EadoZ3WJlMVdtc4xzE9CBT0mmgBCy4Jr
         MKVw==
X-Gm-Message-State: AOAM530jfkIdKIOqo7dt8G3DIVuDIKLi9dcs6HuR6GUCs5jrBjmS/vNF
        Lg1vfiUs2/dLu0SEIwu4PkE=
X-Google-Smtp-Source: ABdhPJwOuoYXEU1ArodI3A5OAFIaf1sSBgP7PmxxYp/MnjkxUM3Hu3QxIB4O+83L29R5bxfFqrO3yg==
X-Received: by 2002:ac2:5fae:: with SMTP id s14mr7642063lfe.588.1622237654454;
        Fri, 28 May 2021 14:34:14 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id u26sm616965lfu.50.2021.05.28.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 14:34:13 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] drivers/base: Constify static attribute_group structs
Date:   Fri, 28 May 2021 23:34:08 +0200
Message-Id: <20210528213408.20067-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only used by putting their address in an array of pointers to
const struct attribute_group (either directly or via the
__ATTRIBUTE_GROUP macro). Make them const to allow the compiler to place
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/base/cpu.c      | 4 ++--
 drivers/base/memory.c   | 4 ++--
 drivers/base/node.c     | 2 +-
 drivers/base/platform.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2b9e41377a07..5ef14db97904 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -175,7 +175,7 @@ static struct attribute *crash_note_cpu_attrs[] = {
 	NULL
 };
 
-static struct attribute_group crash_note_cpu_attr_group = {
+static const struct attribute_group crash_note_cpu_attr_group = {
 	.attrs = crash_note_cpu_attrs,
 };
 #endif
@@ -475,7 +475,7 @@ static struct attribute *cpu_root_attrs[] = {
 	NULL
 };
 
-static struct attribute_group cpu_root_attr_group = {
+static const struct attribute_group cpu_root_attr_group = {
 	.attrs = cpu_root_attrs,
 };
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b31b3af5c490..600ae518c02a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -596,7 +596,7 @@ static struct attribute *memory_memblk_attrs[] = {
 	NULL
 };
 
-static struct attribute_group memory_memblk_attr_group = {
+static const struct attribute_group memory_memblk_attr_group = {
 	.attrs = memory_memblk_attrs,
 };
 
@@ -772,7 +772,7 @@ static struct attribute *memory_root_attrs[] = {
 	NULL
 };
 
-static struct attribute_group memory_root_attr_group = {
+static const struct attribute_group memory_root_attr_group = {
 	.attrs = memory_root_attrs,
 };
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4cef82c1b079..4a4ae868ad9f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -1038,7 +1038,7 @@ static struct attribute *node_state_attrs[] = {
 	NULL
 };
 
-static struct attribute_group memory_root_attr_group = {
+static const struct attribute_group memory_root_attr_group = {
 	.attrs = node_state_attrs,
 };
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9cd34def2237..d093ba4371b8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1355,7 +1355,7 @@ static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute
 	return a->mode;
 }
 
-static struct attribute_group platform_dev_group = {
+static const struct attribute_group platform_dev_group = {
 	.attrs = platform_dev_attrs,
 	.is_visible = platform_dev_attrs_visible,
 };
-- 
2.31.1

