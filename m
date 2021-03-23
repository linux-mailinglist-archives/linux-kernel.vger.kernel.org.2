Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA8345619
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCWDPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCWDPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:15:19 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB76FC061574;
        Mon, 22 Mar 2021 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=DyAETVd4CQ
        zBRJvRBRGktAwsmZMdD9Pe0/YWVrKxwYE=; b=D8mOk9P+roI4mRWvZ/GfB/akkx
        dlDc0kE89LXtaEkx2SApAz2zndLkZC176qoSvF3oW7vmHYmFKhE/KZmeIOBINGPf
        ByKEZLspfs3Mg5ema9sEDkjYv8Fow1TamV3ZhOM8c68LeDel+m9RqCN4x2YWYPUs
        4nrlIlcw85NK+o86g=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAXHExDXVlgYLIZAA--.1020S4;
        Tue, 23 Mar 2021 11:15:15 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] thunderbolt: Fix a double put in tb_cfg_read_raw
Date:   Mon, 22 Mar 2021 20:15:12 -0700
Message-Id: <20210323031512.12234-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygAXHExDXVlgYLIZAA--.1020S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw1kCw43CF4rJr1fWFWxWFg_yoW8Jr48p3
        98WFWj9rZ8Xw4jya1DKa4UuF1rKw42ka43GFW8KayruFZ0grn5CFyDJFy2qr17ArWxJrW7
        XrnYvrs8ua4avFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUnF4EDUUUU
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tb_cfg_read_raw, req is allocated by tb_cfg_request_alloc()
with an initial reference. Before calling tb_cfg_request_sync(),
there is no refcount inc operation. tb_cfg_request_sync()
calls tb_cfg_request(..,req,..) and if the callee failed,
the initial reference of req is dropped and req is freed.

Later in tb_cfg_read_raw before the err check,
tb_cfg_request_put(req) is called again. It may cause error
in race.

My patch puts tb_cfg_request_put(req) after the err check
finished to avoid unexpected result.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/thunderbolt/ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index f1aeaff9f368..bb60269c89ab 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -890,11 +890,11 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
 
 		res = tb_cfg_request_sync(ctl, req, timeout_msec);
 
-		tb_cfg_request_put(req);
-
 		if (res.err != -ETIMEDOUT)
 			break;
 
+		tb_cfg_request_put(req);
+
 		/* Wait a bit (arbitrary time) until we send a retry */
 		usleep_range(10, 100);
 	}
-- 
2.25.1


