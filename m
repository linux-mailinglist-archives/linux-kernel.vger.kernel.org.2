Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BC30FF3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBDVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBDVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:19:56 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE283C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:19:14 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e18so5138857lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td739C3KdNkgNh83gIL2Tt3BZl1PMt2p99LplFrfohQ=;
        b=HcKNQmZUwHdOXDwqCks22vHuCoinz+4TTmw/t8GeaesnGvmtVQLzA12dRv7MbHB/dH
         2HTCfgefbLNU9zy2P9UqGQiQKRKdUyCyPOeXmKjzZ64MH+gzjjDzDWVPIy29YMmdhg3o
         dAZg9G21RM2RIGB/dswI5wQjWpmunFrzS9ynuqAjPc/EIClAl5YnigXDpQuyTCqCbu6n
         M3AITY2h7qaWAERNe+T43rxE7mxaJv0l+/sNTo4X6kdLivQDO7whsoSwFqkRy5yZ9tpT
         zgFXmcF5QKp4EyGl0FZsHrrSTtf8xnKNQUoMDQiqw2ne4ZPMPGfQ44Yxc899Wa5JLzm9
         N/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Td739C3KdNkgNh83gIL2Tt3BZl1PMt2p99LplFrfohQ=;
        b=qABA8fbbpVtH+dEbjAW1ovtc0y/uhTuvrAavR8x/bq3h+Cu6bVLY8D3zPxD91GOEDC
         tX2C9cpGbAUBj68lFxYqP/1s6/pd90fg/xsjzhBmDdHoP1SK2wUUD2C+ewSykyHiEwQM
         4X92cuHeyQdKURbxCyBDO8pZJEKh9P5Cf5tGsR6PyptARZpC7K/xKkiAAndAXzdSo5vc
         9GnaEQv0lEmNo1QqDMDeJuasuxuehzQDAJ4FkVr/henhMXIiGA0RDSa3UkK/QlOD8MdN
         NYQqVH+xdO8qxkaELQMu9NAP04ZSOFL+RHBw8Bpz8ln4M0/KDX3BP0VRhFok0jhWYQ85
         oR4w==
X-Gm-Message-State: AOAM5332DL3Its3hLLW1gh6sJ+0ZEyo/JSDkLsYCqmUMk0HtNxEgNGKF
        pCfjrk3fT18jYFURtBTpk04=
X-Google-Smtp-Source: ABdhPJy/7ETacV7VlJfo1Wu3+4YUgoSqKBcH7oTrQ9Mvk5ITtDlMogePPkXVY7Km87s8cnivthAZ7g==
X-Received: by 2002:a2e:9789:: with SMTP id y9mr707396lji.482.1612473553279;
        Thu, 04 Feb 2021 13:19:13 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id q1sm742570lfu.48.2021.02.04.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:19:12 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] intel_th: Constify attribute_group structs
Date:   Thu,  4 Feb 2021 22:19:06 +0100
Message-Id: <20210204211906.42889-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of them is to pass their address to sysfs_create_group()
and sysfs_remove_group(), both which have pointers to const
attribute_group structs as input. Make them const to allow the compiler
to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/hwtracing/intel_th/intel_th.h | 2 +-
 drivers/hwtracing/intel_th/msu.c      | 2 +-
 drivers/hwtracing/intel_th/pti.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 5fe694708b7a..ad9f9acd6b9c 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -178,7 +178,7 @@ struct intel_th_driver {
 	/* file_operations for those who want a device node */
 	const struct file_operations *fops;
 	/* optional attributes */
-	struct attribute_group	*attr_group;
+	const struct attribute_group *attr_group;
 
 	/* source ops */
 	int			(*set_output)(struct intel_th_device *thdev,
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7d95242db900..2edc4666633d 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -2095,7 +2095,7 @@ static struct attribute *msc_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group msc_output_group = {
+static const struct attribute_group msc_output_group = {
 	.attrs	= msc_output_attrs,
 };
 
diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 0da6b787f553..09132ab8bc23 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -142,7 +142,7 @@ static struct attribute *pti_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group pti_output_group = {
+static const struct attribute_group pti_output_group = {
 	.attrs	= pti_output_attrs,
 };
 
@@ -295,7 +295,7 @@ static struct attribute *lpp_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group lpp_output_group = {
+static const struct attribute_group lpp_output_group = {
 	.attrs	= lpp_output_attrs,
 };
 
-- 
2.30.0

