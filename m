Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F28312765
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 21:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBGUZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 15:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 15:25:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D2C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 12:25:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p21so19046067lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/vAPmh0R53an8nKm6BSYsJvWd5kBfpY7yHqH7Xhw7Y=;
        b=ReGGTWk2QE21HGEzGkzy9Bx/iONxHazIx4C0ngeYdV56APcL0fta50hXx92QoG+Dwh
         nh1Eyp+Hx4P78OXqPC/dDEQy82P1WnrzxQnw3lHYLeE9SF39hUr2kAbsQC4YuSowfVD7
         yH5W0ymi4jiSx3LEWWR/OD5zxoL2yJDG6uvQ4NtGHyU6Wf315r7QU9X/WyAYDXSKeSbU
         fCaGuNZ3lLwS9LFQ3FrQT9q8foVoz1YOijLXWh3YoOzG39cuVhiziXWiOcz6swIHlhSH
         plvw+DrXD8oJDPWQllNQvTEZxePrsck5rCi26njxcCzwk76AOu3zshBHLjubETwE2tZE
         Zm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/vAPmh0R53an8nKm6BSYsJvWd5kBfpY7yHqH7Xhw7Y=;
        b=omD4VCsQ293KnIiLFwUZydkLEUEpVM4rsqgVs76GIE89AvLkERcpJIQSRVoWLaLl4g
         fvGd4TDeflUStj3Vj3/6rrwTxRRTi5BQze44DjOzh5zV8kbPsfhQ0m3msoiUPViY0Hq1
         k62aKOxtci0rZq12ETPsXgECo0odrDEgIEpJVs+yy2Rei/7UMkEEPxNbAHpUY3hTWtfo
         YKcnbLvD8wammQ75tBQlpQaOq+83C644+BBMmw6cc3H2xjWzOIGMD1sYdSzkbNRJ7DGF
         zuwyLNiSNhIxXPEjJlkIEUqGJamPrcw0mVmecWQIb5eZB2s1jIBu9QlW+8UagAI9hkAk
         kylA==
X-Gm-Message-State: AOAM531A1hwPtKhcaYYGp9lYU7PfMN2aNOX+2TqfzCoWdGfpygaDrLxD
        aiBrb/dRWy0W3kL89eypxGLjgQElUXu2WQ==
X-Google-Smtp-Source: ABdhPJydNwkjiW3SmaSqHhHrZdhg8jYWcbm8Rq8paKZDWGlKEwpEN8R6puHe/7ZLWepGy3RRxoKfsg==
X-Received: by 2002:a19:7414:: with SMTP id v20mr8605075lfe.436.1612729505919;
        Sun, 07 Feb 2021 12:25:05 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id b17sm1813044lfa.42.2021.02.07.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 12:25:05 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] staging: fieldbus: arcx-anybus: constify static structs
Date:   Sun,  7 Feb 2021 21:25:01 +0100
Message-Id: <20210207202501.9494-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify two static structs which are never modified, to allow the
compiler to put them in read-only memory.

The only usage of controller_attribute_group is to put its address in an
array of pointers to const struct attribute_group, and the only usage of
can_power_ops is to assign its address to the 'ops' field in the
regulator_desc struct, which is a pointer to const struct regulator_ops.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index b5fded15e8a6..9af2e63050d1 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -185,7 +185,7 @@ static struct attribute *controller_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group controller_attribute_group = {
+static const struct attribute_group controller_attribute_group = {
 	.attrs = controller_attributes,
 };
 
@@ -206,7 +206,7 @@ static int can_power_is_enabled(struct regulator_dev *rdev)
 	return !(readb(cd->cpld_base + CPLD_STATUS1) & CPLD_STATUS1_CAN_POWER);
 }
 
-static struct regulator_ops can_power_ops = {
+static const struct regulator_ops can_power_ops = {
 	.is_enabled = can_power_is_enabled,
 };
 
-- 
2.30.0

