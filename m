Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CE33386A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhCJJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhCJJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:10:31 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6769EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=pLCS94GcTa
        H2GKIiQ+BY02BGYn72s8ZyHkaYsJZadf8=; b=Dj78AAhNHpiAV0NMAY6h8t3Yrr
        3sw6XPMREnBJElkq4dwG8IWTzArjVlAtpw4TemTx470ZVJifwZO+UQUeZG65w0+X
        sntpHaRre/gKbdW1Z3WKONVXaAAbCl+BQW2gQo8AuOfmI5kTMWivzLAogQ94UX/V
        jctVp5nUVFxuMwKD8=
Received: from ubuntu.localdomain (unknown [114.214.224.243])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBHM2AAjUhg5foCAA--.130S4;
        Wed, 10 Mar 2021 17:10:24 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] greybus/operation: Drop reference when message has been set
Date:   Wed, 10 Mar 2021 01:10:14 -0800
Message-Id: <20210310091014.6407-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygBHM2AAjUhg5foCAA--.130S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XryftrW8Cr1rAr18tw48tFb_yoWftFc_uF
        18trs7A3WkJr4DK347uw1fZrnayr4v9r1xur17t39xA34avr1DJr98Wws5WrW7Wr18Xr1a
        ya4DJF1UXrn7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2
        3UUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gb_operation_response_send, get an extra reference
before gb_message_send() with this comment "/* Reference will
be dropped when message has been sent. */". Therefore, we
should drop the got reference not only in the error branch,
but also in the complete branch.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/greybus/operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 296f0b93d171..500b3fe53a04 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -855,7 +855,7 @@ static int gb_operation_response_send(struct gb_operation *operation,
 	if (ret)
 		goto err_put_active;
 
-	/*Drop reference after message send successfully. */
+	/*Drop reference after message send completes. */
 	gb_operation_put_active(operation);
 	gb_operation_put(operation);
 
-- 
2.25.1


