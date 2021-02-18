Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCB731EB61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBRPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:15:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12978 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhBRMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:23:49 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DhDL91s8kzjPKQ;
        Thu, 18 Feb 2021 20:20:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 20:21:22 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v6 0/2] fix a NULL pointer bug and simplify the code
Date:   Thu, 18 Feb 2021 07:26:18 -0500
Message-ID: <20210218122620.228375-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a NULL pointer bug and simplify the code

v6: Just add if (nbd->recv_workq) to nbd_disconnect_and_put().
v5: Adjust the title and add “Suggested-by”.
v4: Share exception handling code for if branches and 
	move put_nbd adjustment to a separate patch.
v3: Do not use unlock and add put_nbd.
v2: Use jump target unlock.

Sun Ke (2):
  nbd: Fix NULL pointer in flush_workqueue
  nbd: share nbd_put and return by goto put_nbd

 drivers/block/nbd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.4

