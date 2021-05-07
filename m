Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985E43762F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhEGJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:38:57 -0400
Received: from m12-17.163.com ([220.181.12.17]:33157 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234536AbhEGJi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/AQltn/ifDkN6i5uWR
        GDs39lWJtgpoOP2SiEescmcy0=; b=I1xYl//3Z7H5uBJ/onsb7pk4CQsMWEbnEK
        9X1CCiiQPNca1EALZezURfARCoO+kIFEH0vR3I893d/BOv5IWzuQLeTDlvKaveoP
        UOfBYUTtNT60BVwCFV59qIqyzV+uOlBZo1ADCjl4I5JSg3lckwQFV2XPNErJORfW
        sjuhqDPIU=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAB3noKhBpVg82rczg--.50569S2;
        Fri, 07 May 2021 17:21:43 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: [PATCH] mfd: si476x-cmd: fix two typos
Date:   Fri,  7 May 2021 17:21:35 +0800
Message-Id: <1620379295-144373-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: EcCowAB3noKhBpVg82rczg--.50569S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyDCFWfCr13Gr43WFykKrg_yoW8GFWUpr
        1DGry5Ar9YgayUG3W7Gry5ua4YvasYkr98CF17C39Yv3ZxtFn5XFy8tFWjvw1UXF4xK3Wa
        qFW8tFW8uayUAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQyCAUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiEAeL3V8YFzY4YAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Dong <dongjian@yulong.com>

Fix two typos retured --> returned

Signed-off-by: Jian Dong <dongjian@yulong.com>
---
 drivers/mfd/si476x-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index d15b3e7..95c03a9 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -731,7 +731,7 @@ static int si476x_core_cmd_intb_pin_cfg_a20(struct si476x_core *core,
  * @core:  - device to send the command to
  * @rsqargs: - pointer to a structure containing a group of sub-args
  *             relevant to sending the RSQ status command
- * @report: - all signal quality information retured by the command
+ * @report: - all signal quality information returned by the command
  *           (if NULL then the output of the command is ignored)
  *
  * Function returns 0 on success and negative error code on failure
@@ -892,7 +892,7 @@ int si476x_core_cmd_fm_seek_start(struct si476x_core *core,
  *                rest RDS data contains the last valid info received
  * @mtfifo: if set the command clears RDS receive FIFO
  * @intack: if set the command clards the RDSINT bit.
- * @report: - all signal quality information retured by the command
+ * @report: - all signal quality information returned by the command
  *           (if NULL then the output of the command is ignored)
  *
  * Function returns 0 on success and negative error code on failure
-- 
1.9.1


