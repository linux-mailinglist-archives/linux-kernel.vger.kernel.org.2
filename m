Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2239DA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFGKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:51:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4336 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFGKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:51:03 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fz93S6hLMz1BKYB;
        Mon,  7 Jun 2021 18:44:20 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:49:10 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:49:10 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] vt: vt_kern.h, remove the repeated declaration
Date:   Mon, 7 Jun 2021 18:48:53 +0800
Message-ID: <1623062933-52943-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function 'vt_set_led_state' is declared twice, so remove the
repeated declaration.

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 include/linux/vt_kern.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 94e7a315479c..0da94a6dee15 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -166,7 +166,6 @@ int vt_get_kbd_mode_bit(int console, int bit);
 void vt_set_kbd_mode_bit(int console, int bit);
 void vt_clr_kbd_mode_bit(int console, int bit);
 void vt_set_led_state(int console, int leds);
-void vt_set_led_state(int console, int leds);
 void vt_kbd_con_start(int console);
 void vt_kbd_con_stop(int console);
 
-- 
2.7.4

