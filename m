Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FB3245AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhBXVUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhBXVUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B6C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w36so5259236lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjXyN2YZhZ2XF11j3DNqBy4PmqPHJZAyQHRBelDop8I=;
        b=Mf/dFfVrOfzHj93+e4gTrMtBgfAmwGs5R4wmdk9ygWQAh19ZpM73kAfxio4mvv1ftS
         AKvPy2YUDn9u/Y1Ty/Zk1jr7LSXu2mXgfOfIrd5rTla1xn0lx829CZ7Hs9xL6/kTFaqy
         sdyauTkVwGWIYqyKxHwJsr1DxaIy/Iy33Zyb/v0VXnZF9NP5QrrSmpKgN3ZuWOywnQPL
         eUNvQoAFWYNlOPODjIGyu95OcnP6BSXIor8s+u31eoDo1GzrakUm7m5RRonIdTfsFGdR
         O9WB85Va7RvaD0g/MqBJFcyuusmAnxuCXXICStv3DN79GiSwaPc2mu93FLdTbkp1fBWH
         sgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjXyN2YZhZ2XF11j3DNqBy4PmqPHJZAyQHRBelDop8I=;
        b=hc5mX1iWjjA5UEhECgNmhOXwjfPx7vXQ6zHXxhYd1xsCHYP3UPQNQM5VQEGpVDey9k
         ItIa0BTdYxApd/EyOWayjrjtf2jgnD/9yuhl26HMA9R619gsAc+fMdJn3t4GpxW9aN5Q
         9pSZfqQg1R/UBVHS054mWE3oB1Sttm9kK5uwrIONUwJ4xmO/81IMAjn/ZJPAe/urHotL
         dPivbvixcLlRnd20DCFEUs01QI8h8nD6XEF65yjr8CphkK+GDOc/XPBplNh30G8CygEK
         vKrG/9PzEgjU6/ArzNkqHw4q7B6/Z2xcjQ4QXf+DrMF0lTJfRG5/Y03ogR5XSVyTnmJB
         WfwQ==
X-Gm-Message-State: AOAM531fx1wgrvFHrcrORS3jc1S3F7uOCWsq78o6zyQKaRT+kSedhVRU
        lhgsd9T4zlwicZorDQOQCFU=
X-Google-Smtp-Source: ABdhPJy8+vyE96eTWkPeG29uK18NtTKl+8CUKxn5wfqxakdR1h2RLFaBiSIC5eXBefHN7fY1NPiI4Q==
X-Received: by 2002:a19:5505:: with SMTP id n5mr19598230lfe.401.1614201568154;
        Wed, 24 Feb 2021 13:19:28 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:19:27 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/4] ASoC: rt*: Constify static struct acpi_device_id
Date:   Wed, 24 Feb 2021 22:19:17 +0100
Message-Id: <20210224211918.39109-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt1011.c | 2 +-
 sound/soc/codecs/rt1015.c | 2 +-
 sound/soc/codecs/rt1016.c | 2 +-
 sound/soc/codecs/rt1305.c | 2 +-
 sound/soc/codecs/rt1308.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 098ecf13814d..6877be5f36b9 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -2151,7 +2151,7 @@ MODULE_DEVICE_TABLE(of, rt1011_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1011_acpi_match[] = {
+static const struct acpi_device_id rt1011_acpi_match[] = {
 	{"10EC1011", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 501cc45240b4..3cd967ae999d 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -1121,7 +1121,7 @@ MODULE_DEVICE_TABLE(of, rt1015_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1015_acpi_match[] = {
+static const struct acpi_device_id rt1015_acpi_match[] = {
 	{"10EC1015", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1016.c b/sound/soc/codecs/rt1016.c
index 483375fc16ca..c14a809da52b 100644
--- a/sound/soc/codecs/rt1016.c
+++ b/sound/soc/codecs/rt1016.c
@@ -623,7 +623,7 @@ MODULE_DEVICE_TABLE(of, rt1016_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1016_acpi_match[] = {
+static const struct acpi_device_id rt1016_acpi_match[] = {
 	{"10EC1016", 0,},
 	{},
 };
diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 4e9dfd235e59..16aa405fb8f0 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -975,7 +975,7 @@ MODULE_DEVICE_TABLE(of, rt1305_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1305_acpi_match[] = {
+static const struct acpi_device_id rt1305_acpi_match[] = {
 	{"10EC1305", 0,},
 	{"10EC1306", 0,},
 	{},
diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index b75931a69a1c..76e65844543d 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -790,7 +790,7 @@ MODULE_DEVICE_TABLE(of, rt1308_of_match);
 #endif
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt1308_acpi_match[] = {
+static const struct acpi_device_id rt1308_acpi_match[] = {
 	{ "10EC1308", 0, },
 	{ },
 };
-- 
2.30.1

