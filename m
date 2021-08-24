Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7DA3F614B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhHXPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhHXPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:08:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:07:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so1994887pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrvJVyQNbZShLMemqxYoBqBYQ2Gzkms2NEqpFCTxgFg=;
        b=GG4p17qQULEkXmJuULN17D8CN5s5hbWcjAhzTs+yEw4sfqEOoxK69v/ddJeJFi9F8l
         nRr3VMWv1O0I/shDr6IAwuZRtAgcbJLsXH8qf7uzcFE8LHl5FJdyOh+SwWYNYvgaEG7j
         j+0UhS8FdDrf18ODv46GBM8Ar3oaL/LsDUZkl4i7XXAUt+kPpX+e5D5+Cs5zKaKUgrGU
         LZ243AZhx8QhYfqM1+gi3U1VdcQo6LDT9n1mEjFJsv16BtbKE/FOpqdexMj7RwT6gFN7
         WaGKuAtV33XawCfgRyynhAqjmRJOblIB+jhuxJsBJDuqie7+igJzw/leNshOIvgiJfZi
         HaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrvJVyQNbZShLMemqxYoBqBYQ2Gzkms2NEqpFCTxgFg=;
        b=LvKiiJk3q3kIytEaTM7MZkqeilmk4YEhkzbpZpzc7+rbmLkdZNx55yJrsueZwvypgV
         I8lhlHZDGRpGvaZ/D6WmurxAsiT24GCyMVAWHiDi5u4/D5KkSYFWjDS8PofLexniL59v
         IyThfluLhdNuElEYBqPZbjs1QTtUVd++rlQ6CH7EZK1HQr7xL3c5X5p43MfgLm0hbFKI
         mHdHUzGvioDxY/j89ukrz1LhBraWTkpu+/6/oU2yq5+qHC8RSBoPAF0c2nLVnnZ20cua
         6FCywTGB0YIVweT84r7S5Uy4IEq91VxhHbzONm3GOYoZ6kMpiUs41liA7RO2sT3DY5Dp
         gAHA==
X-Gm-Message-State: AOAM532hNpqU+5Our4R/ptsv9eg4J7436oFSjWKkcSz4izt6nbWVHEpy
        oRi2NXhD4Ze7uj9plpUJg++6
X-Google-Smtp-Source: ABdhPJzlUc2kfz5lNrVZPHUeOBMRtjZxhr1snXZ66Z5Oy/f4K6sIuxQmhHNRYkNeqRJMPY/QF1SD5w==
X-Received: by 2002:a17:902:c40e:b029:12c:cbce:2d18 with SMTP id k14-20020a170902c40eb029012ccbce2d18mr33623315plk.60.1629817670545;
        Tue, 24 Aug 2021 08:07:50 -0700 (PDT)
Received: from localhost.localdomain ([175.157.61.62])
        by smtp.gmail.com with ESMTPSA id y12sm23800336pgk.7.2021.08.24.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:07:50 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v3] HID: betop: fix slab-out-of-bounds Write in betop_probe
Date:   Tue, 24 Aug 2021 20:37:30 +0530
Message-Id: <20210824150730.9118-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210816201544.26405-1-asha.16@itfac.mrt.ac.lk>
References: <20210816201544.26405-1-asha.16@itfac.mrt.ac.lk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported slab-out-of-bounds Write bug in hid-betopff driver.
The problem is the driver assumes the device must have an input report but
some malicious devices violate this assumption.

So this patch checks hid_device's input is non empty before it's been used.

Reported-by: syzbot+07efed3bc5a1407bd742@syzkaller.appspotmail.com
Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/hid/hid-betopff.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 0790fbd3fc9a..467d789f9bc2 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -56,15 +56,22 @@ static int betopff_init(struct hid_device *hid)
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
 
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
 	if (list_empty(report_list)) {
 		hid_err(hid, "no output reports found\n");
 		return -ENODEV;
-- 
2.17.1

