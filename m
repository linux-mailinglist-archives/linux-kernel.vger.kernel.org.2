Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67A3EC828
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHOIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhHOIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 04:32:55 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D27C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 01:32:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w6so10311227plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UHcKuv5O/mzdpWQ8UofB89FE5dbzLYR4/iV02jGFcSE=;
        b=tjwJykmV95oRLTxd/WxhXOqC5QfUo6q9jxsPpnqXoPMyiENyY7O0n4Xh9tOLIpK2xS
         8GlGXE675dAykuZVHBjoUkvuQXOjrS3fsLTdff+tewr903pRtA/qSzcpoqXVR0+wQDm/
         wbJTvj0OuLiRYBGIwQlZUOc010miqSxsqkBQSPaPoUBoGq60zwou3PlQPiM1m9VORyYT
         Bxq/1pC3hUcnWC7z61w3HZKo6v0ZSuMvZPN6YKk78lIgKuraKrIV7yY0Bylt0u9ClC92
         +xxoTXXlQxVoXRMRtecrKVXiYzxyQCmvn8W621djcA6Teq6QQY7nCwgPZILuT0ANwKWm
         cHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UHcKuv5O/mzdpWQ8UofB89FE5dbzLYR4/iV02jGFcSE=;
        b=IO8Cz227F37l5uoSY6ezcXcFDueO0GOxmh3bXN0k+F+zvf5lmKFiw659rWqX36Bx7p
         tbRypPS40DHc7O1aZg6BS8N+o6gGciedcvDaH6FC4nk4gIPwPGgY92MRYbCQZ9VMfObA
         xKVX1aLjbI/mt1ARCgSYRv1UfptPXBpTpqA0lySUpz4CJSnmrir5qh8bmfIBEnpGZSX3
         GWRnG5TS1pMQ5V8DQe622rUSRNbG4m8OVmweFmEW4LcZoDqm43KbOTEO/XQY/wzFgOVN
         PcPUdSvld/oNUlR7Ru5bUMgPdnB+vRASo6FZy9opReUchbDaRYLVW0iOt8VnOCZuW34y
         m0dA==
X-Gm-Message-State: AOAM532LbHq+1VSV47m5oxZwtOj7VipEXW0PG0vMfMoAUf5B7j+k0Ou4
        pkF/XcWQVXY72oBlWPWcZwDo
X-Google-Smtp-Source: ABdhPJzxXrxHbClgwJUtfcwgOQ6Fy/Rzy6VmQ0cxKiiw/99piS75VSnpeNRYDvdz+xN4qrF+urV30w==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr11065068pjg.118.1629016344371;
        Sun, 15 Aug 2021 01:32:24 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id q140sm7587812pfc.191.2021.08.15.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 01:32:24 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix slab-out-of-bounds in betopff_init function
Date:   Sun, 15 Aug 2021 14:01:55 +0530
Message-Id: <20210815083155.10559-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the bug 'KASAN: slab-out-of-bounds Write in betop_probe' reported by Syzbot.

Patch resolve the bug by checking hid_device's hid_input is non empty before it's been used.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/hid/hid-betopff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 0790fbd3fc9a..6a1f894b0e97 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -56,19 +56,20 @@ static int betopff_init(struct hid_device *hid)
 {
 	struct betopff_device *betopff;
 	struct hid_report *report;
-	struct hid_input *hidinput =
-			list_first_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput;
 	struct list_head *report_list =
 			&hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	struct input_dev *dev = hidinput->input;
+	struct input_dev *dev;
 	int field_count = 0;
 	int error;
 	int i, j;
 
-	if (list_empty(report_list)) {
+	if (list_empty(&hid->inputs)) {
 		hid_err(hid, "no output reports found\n");
 		return -ENODEV;
 	}
+	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	dev = hidinput->input;
 
 	report = list_first_entry(report_list, struct hid_report, list);
 	/*
-- 
2.17.1

