Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2023355216
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbhDFL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:28:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16357 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245514AbhDFL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF4vQ02j0z9409;
        Tue,  6 Apr 2021 19:25:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:27:25 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 07/10] tty: tty_ldisc: Add a blank line after declarations
Date:   Tue, 6 Apr 2021 19:24:45 +0800
Message-ID: <1617708288-14847-8-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after declarations, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/tty_ldisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 2992319..df0b589 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -771,6 +771,7 @@ void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
 int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 {
 	int retval = tty_ldisc_open(tty, tty->ldisc);
+
 	if (retval)
 		return retval;
 
@@ -829,6 +830,7 @@ EXPORT_SYMBOL_GPL(tty_ldisc_release);
 int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_get(tty, N_TTY);
+
 	if (IS_ERR(ld))
 		return PTR_ERR(ld);
 	tty->ldisc = ld;
-- 
2.8.1

