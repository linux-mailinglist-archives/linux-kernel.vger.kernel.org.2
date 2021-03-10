Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45917334026
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhCJOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhCJORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:17:50 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5ED1C061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=//Y60BMpOF
        SBS4gIQV7QmVdL1NFNEwj66V4nPJtQgrk=; b=Wtgf8I0jmwyOasQODR/3JhjWjn
        SKY4zG7PRZ+dkx2V6BUnKi5cfzxb/PWJTrMJVGruhPlgfcNc+6pj7EVWcxm+rvJL
        6acrPPpqQsagHbRFc4Tl2mK7AGmwjwvnz0SsJvEdxwoNDjYeHOfGp6gbpU2Vjcxl
        4Uvl2upVQEv0GRgBQ=
Received: from ubuntu.localdomain (unknown [114.214.224.243])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAXBGEE1UhgCM0EAA--.2042S4;
        Wed, 10 Mar 2021 22:17:40 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH v2] greybus/operation: Drop reference when message has been sent
Date:   Wed, 10 Mar 2021 06:17:36 -0800
Message-Id: <20210310141736.3459-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygAXBGEE1UhgCM0EAA--.2042S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XryftrW8Cr1rAr18tw48tFb_yoWfCFc_u3
        W8trsxAF4kJrs8Kasruw13ZrySyr4v9r18ur1ft39xA342vr1DJrWDWr4kWrWUGry8Xrnx
        Aa4DJryUXr1xujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUlQ6LUUU
        UU=
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
 drivers/greybus/operation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 8459e9bc0749..500b3fe53a04 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -855,6 +855,10 @@ static int gb_operation_response_send(struct gb_operation *operation,
 	if (ret)
 		goto err_put_active;
 
+	/*Drop reference after message send completes. */
+	gb_operation_put_active(operation);
+	gb_operation_put(operation);
+
 	return 0;
 
 err_put_active:
-- 
2.25.1


