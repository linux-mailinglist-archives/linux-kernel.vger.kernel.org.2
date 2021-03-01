Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE5C327E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhCAMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:52:08 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:5150 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233519AbhCAMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:52:06 -0500
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgCXf4ox4zxgXTncAQ--.45304S4;
        Mon, 01 Mar 2021 20:51:01 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: misc: ad525x_dpot: Add missing check in dpot_read_spi
Date:   Mon,  1 Mar 2021 20:50:57 +0800
Message-Id: <20210301125057.28819-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCXf4ox4zxgXTncAQ--.45304S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr4kGFW5Aw4fJrW7KFyfJFb_yoW3JFb_K3
        45urn7GrnagrnFgF9F9rsxZrySyan3ur1F9wn2gFsIyry5C340qr1vvFs8u3ZruFyIva9x
        AwsIv34I9r18AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgkLBlZdtSjhUQABsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of dpot_read_r8d8() after checking dpot->uid is similar.
However, we check the return value and return an error code only
in one path, which is odd.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/misc/ad525x_dpot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index 6f164522b028..5d8f3f6a95f2 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -139,6 +139,9 @@ static s32 dpot_read_spi(struct dpot_data *dpot, u8 reg)
 			value = dpot_read_r8d8(dpot,
 				DPOT_AD5291_READ_RDAC << 2);
 
+			if (value < 0)
+				return value;
+
 			if (dpot->uid == DPOT_UID(AD5291_ID))
 				value = value >> 2;
 
-- 
2.17.1

