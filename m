Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911173552E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbhDFL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:56:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15917 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhDFL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:56:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF5Y26qclzkht2;
        Tue,  6 Apr 2021 19:54:30 +0800 (CST)
Received: from mdc.localdomain (10.175.104.57) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:56:08 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <huangguobin4@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] tty: n_gsm: use DEFINE_SPINLOCK() for spinlock
Date:   Tue, 6 Apr 2021 19:56:03 +0800
Message-ID: <1617710163-48158-1-git-send-email-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guobin Huang <huangguobin4@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
---
 drivers/tty/n_gsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9e12f9cb1a98..d60cffc70a0c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -266,7 +266,7 @@ struct gsm_mux {
 
 #define MAX_MUX		4			/* 256 minors */
 static struct gsm_mux *gsm_mux[MAX_MUX];	/* GSM muxes */
-static spinlock_t gsm_mux_lock;
+static DEFINE_SPINLOCK(gsm_mux_lock);
 
 static struct tty_driver *gsm_tty_driver;
 
@@ -3257,8 +3257,6 @@ static int __init gsm_init(void)
 	gsm_tty_driver->init_termios.c_lflag &= ~ECHO;
 	tty_set_operations(gsm_tty_driver, &gsmtty_ops);
 
-	spin_lock_init(&gsm_mux_lock);
-
 	if (tty_register_driver(gsm_tty_driver)) {
 		put_tty_driver(gsm_tty_driver);
 		tty_unregister_ldisc(N_GSM0710);

