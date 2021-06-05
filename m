Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37239CAF4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFEUkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:40:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E3C061768;
        Sat,  5 Jun 2021 13:38:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d2so12152955ljj.11;
        Sat, 05 Jun 2021 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKbR2AxMhkvgt+6DcMtzv8cm+g89CGCrtx2XQZqlC7k=;
        b=V/og/t1CacEousT7DRKqXOhm3pQwr1KyCxA+lDZUZ3iM1nPUDRukD9ONJmCJmVui2S
         tAk2/N1IZow7uH7yw6mCEVp8WOCLFlj73I9YYYuA+7B+XgDk18WDCZRTDzhxqblLbNO0
         Dz7++uto+US0bdpB81twyrJbNzQkiXpUZasgnJog38j7Ay+n4EmKGmcZl9Xsd9kO4jPq
         3jwCeEboLt7AkRnlKIC4BYvQTt9557T+4wrSPLRh09CyG0L3jT33iI0p8GjUoCeh90zB
         9EhtDxNvCIrb6n/OrEEHZiOuqiWPTn/UmQrXbs8YTK8cww/OYNDMiKL0D0gSzOd23BdM
         vOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GKbR2AxMhkvgt+6DcMtzv8cm+g89CGCrtx2XQZqlC7k=;
        b=aHjBfWvBunbvyDDmum98isocq0TLLnq2fZutpfPiac+mBdWKVKFvFWihXFLXwf9Lsr
         GR6z2SLqIMwn3kinBc8HGq85VnnKbGydWHHph/jOyud5Cvp42v3BOfDQ/4kI1MaEyivk
         BfnwfLHLzhpgFPlUczWA9JHkSJ78XTaSELcDAkzJLbN2+adSZ6xWYrgpuCr2PCOo/MlO
         3rRsa57OpX75R7Ux7K5Oz80BbhPUNmc5ANq2dh+w2QP1vuZJAWplgjNi9w6bPTczIfns
         kbdCHfuQg2biVP2B+53BbidfG2GCDxJrAfa4BkPoI3lu3UH2ec7uOrcyK0wnwFmQCKGk
         T9Pw==
X-Gm-Message-State: AOAM5315yFLzaV94MMECHF/0fhEVtAkL4Nk9iYoE5Mnd0r28FgZrLIqV
        Y/KeT8cFodK8ACJv5cJjnxw=
X-Google-Smtp-Source: ABdhPJyyEqK+9W97f3zSN6NNW9IeVTX5ucq9+mHBZEI3zgmNk+p7mw+293nR+Yd9wIgqR9xTITHH4w==
X-Received: by 2002:a2e:a373:: with SMTP id i19mr8376028ljn.49.1622925503160;
        Sat, 05 Jun 2021 13:38:23 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id k24sm1170063ljg.43.2021.06.05.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:38:22 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/4] x86/platform/uv: Constify static attribute_group struct
Date:   Sat,  5 Jun 2021 22:38:07 +0200
Message-Id: <20210605203807.60547-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of base_attr_group and hubless_base_attr_group is to pass
their addresses to sysfs_create_group() and sysfs_remove_group(), both
which takes pointers to const attribute_group structs. Make them const
to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/x86/uv_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 7badcfa3f384..956a354b57c1 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -778,7 +778,7 @@ static struct attribute *base_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group base_attr_group = {
+static const struct attribute_group base_attr_group = {
 	.attrs = base_attrs
 };
 
@@ -823,7 +823,7 @@ static struct attribute *hubless_base_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group hubless_base_attr_group = {
+static const struct attribute_group hubless_base_attr_group = {
 	.attrs = hubless_base_attrs
 };
 
-- 
2.31.1

