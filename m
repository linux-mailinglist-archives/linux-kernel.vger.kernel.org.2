Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29C84391BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhJYIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhJYIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:51:30 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E1C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:49:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D41171C91;
        Mon, 25 Oct 2021 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635151742; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=qw+rUZnGqbazk5VM2kTqSsujsqnEaRKekmOX893lBO4=;
        b=yJDbkNvztyUPw4LzDojvhtyLysI9TWDR3WmSB2KjfLtGlCCuLBs4k4/yhBYmjLBf6fQ1tH
        6iPpdXKY8SUx1zYo153MJFhslXF0ma37TWMM2YJhJuQSy0Yj7VWhNXzeNGCRsR7r2YBxLe
        mXFyXsNhryJMDsvQjetoj+pG+0Ypbm5jYQ7CstIiA0ozTnJsJGApEatu5hVt9EDkoaaScL
        0Ty9D1DkNMlQFzjiBxrcWTC5RI8JeGMLZc1eNGOVdO27s7p0amlYwDxtqPMDWLb0q2Unpv
        96HjXCL6DWkrmXJsL1MXpKNnoO4Kjv+OMU25iGN7HoG+Nxe7Dk2sRN2xsCtbyQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Mon, 25 Oct 2021 11:47:05 +0300
Message-Id: <20211025084704.173755-3-adeep@lexina.in>
In-Reply-To: <20211025084704.173755-1-adeep@lexina.in>
References: <20211025084704.173755-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power reset via enable-gpios in h5_btrtl_open function.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0c0dedece59c..ab7c929cc25d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -968,6 +968,11 @@ static void h5_btrtl_open(struct h5 *h5)
 					 SUSPEND_TIMEOUT_MS);
 	pm_runtime_enable(&h5->hu->serdev->dev);
 
+	/* The controller needs reset to startup */
+	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	msleep(100);
+
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
-- 
2.30.2

