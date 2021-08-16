Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4243EDE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhHPUQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:16:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59D0C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:16:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so673634pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uxfQfSQSFoAsFeVFiZhI4kW7ni4FlZYbGclvdDrrQVc=;
        b=HCopz6eKzYD/fcMJb+eHiiJqmesDIwe/gE982cJVCFDGUXqb/jGZFO10HCSwCQWgAJ
         jdR7gRpeVO4HhqTCw6QJ94Pz3I07kyIlZkCon9N2JHNEC6AaejLEM7tMTONIfOQ+sNmK
         G3j86BLUFgpJp3f9ksmUAwCtHuUtU9Rb0trDe0fSM6+LHUY7KhiF2NRlCcTKZG3QhxKb
         HbcDgYNeb3PmuFcqoX95RB1B1uddlrZDELi06bYOOROj+/zR963MztStaGvqbniTG3T7
         1RTXRSD7ryl6AYWiPRbdD8BQKJ/J/94BHCI2ymhQdyb8bIZJrTS9ofednCvA15tCWkee
         5VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uxfQfSQSFoAsFeVFiZhI4kW7ni4FlZYbGclvdDrrQVc=;
        b=TeL9G3vy2ndbvueDO/C4p4LNhBe+DfgE1qd9HatQqUZhVVX1+eom6eGpdL0LuDUZ2t
         eWbF/T8uaFAs72yiHYr5HQZ+5hJL39Y6fRxJawSfji3ihy9S96fgF+irNERBEdYUwD7Y
         enDqKg4JIXSYHGzsahlxVSrmJjpbk7VhZtdj7FxuMzMAgRQYIJHtreIHeroXFLn2UNT/
         Fvw0O5MDW3BoWf43LzBmGKqK/5DehNUjP3fuyOe+SRHc7SlaItVM2y00wZyKCxlv/MRQ
         rE2OVA0l+m6/CMO42SbqSRYKRUPchnN1MxxTder1Z3DHs0vy42cNleMZcliIAnM/C6iz
         ZFYQ==
X-Gm-Message-State: AOAM533ZPJTONAL6zu8o+npTKE9uyyApTCUETsRqPNSVsG5vfTGdmrYg
        jSo7DRq93jgbH6yexA2Bwky3
X-Google-Smtp-Source: ABdhPJxwXsCpKyomKe1LiFyRGDZbW99MV8DkQN6o+CYs5yX4LcLOCRrtGSmfXqM8BcjjFM/WacsR4A==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr517569pgt.125.1629144975001;
        Mon, 16 Aug 2021 13:16:15 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id y13sm6168pjn.34.2021.08.16.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:16:14 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH] fix  slab-out-of-bounds Write in betop_probe
Date:   Tue, 17 Aug 2021 01:45:44 +0530
Message-Id: <20210816201544.26405-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the bug 'KASAN: slab-out-of-bounds Write in betop_probe' reported by Syzbot.
This checkes hid_device's input is non empty before it's been used.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/hid/hid-betopff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-betopff.c b/drivers/hid/hid-betopff.c
index 467d789f9bc2..27b57aef9a0a 100644
--- a/drivers/hid/hid-betopff.c
+++ b/drivers/hid/hid-betopff.c
@@ -121,8 +121,18 @@ static int betopff_init(struct hid_device *hid)
 
 static int betop_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
+	struct hid_input *hidinput;
+	struct input_dev *dev;
 	int ret;
 
+	if (list_empty(&hdev->inputs)) {
+		hid_err(hdev, "no inputs found\n");
+		return -ENODEV;
+	}
+
+	hidinput = list_first_entry(&hdev->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
 	if (id->driver_data)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
-- 
2.17.1

