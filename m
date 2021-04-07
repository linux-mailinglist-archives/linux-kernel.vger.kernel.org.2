Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444093564C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbhDGHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:09:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16804 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhDGHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:09:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFb7F194Lz941J;
        Wed,  7 Apr 2021 15:07:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 15:09:26 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v3 01/10] tty/sysrq: Add a blank line after declarations
Date:   Wed, 7 Apr 2021 15:06:41 +0800
Message-ID: <1617779210-51576-2-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617779210-51576-1-git-send-email-tanxiaofei@huawei.com>
References: <1617779210-51576-1-git-send-email-tanxiaofei@huawei.com>
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
 drivers/tty/sysrq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 959f9e1..0372ed7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -118,6 +118,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 static void sysrq_handle_SAK(int key)
 {
 	struct work_struct *SAK_work = &vc_cons[fg_console].SAK_work;
+
 	schedule_work(SAK_work);
 }
 static const struct sysrq_key_op sysrq_SAK_op = {
-- 
2.8.1

