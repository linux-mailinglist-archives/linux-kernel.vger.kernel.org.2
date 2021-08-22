Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AAF3F3E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhHVHwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhHVHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B758C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t42so10016223pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgOg6z4ir95Zy10fHRjoUwnI8LbWbKa5Pjct0WSqQUs=;
        b=X1EMayCs/qB2r9f5fK/aqXTaadXkir+n79SFzg5Q6klhYx1INCIJsgHq6PjNAXNHl+
         APcxYE1wbdhjazCPzQ6IBq27fKZFbv7r6EcXIYjy/LL6Tj+VzU90xHQMUDbc6doI+Cnu
         nZ3653fSFZzwk3XojMVyctN6izzx6i2OAarwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgOg6z4ir95Zy10fHRjoUwnI8LbWbKa5Pjct0WSqQUs=;
        b=icSLUKHQoIbkyHay4Adss4y6tpZiyJIVbpBtOCyWdITLrksaoVvajZOPyXEY7mpILY
         Pj0NnEBxXuyDqhKF70c0cRZF6ewQLI2BP2NVLBbIMwY1vgbYfhi174uAwtGRIxVS8DLA
         jYaRJuy/3t/3R1v+46FhPv/zQ893FwidNxn68oPWDMd3INVjbzXfjehSRDhzAgyVFxB1
         A9J3buYDBsBJjs9mjIiVzTdq8WKILuFzwyhSfn7b9DsiSDdjN/mNXMWzV9mxhlhk7bYN
         sOr7IAVoEBC12JWlFiuvfhCcTAAwADY+o9cDG1izeqncTAHPLGyor6T8qcGPU6cv2PI2
         yXvw==
X-Gm-Message-State: AOAM533Olqn0g/33ixDvNCt0tL9Q/dAPMeXxucorTkdgx+AV96fJ8NQf
        T6o5fdDhYdCAT/bWTInGYEx3bQ==
X-Google-Smtp-Source: ABdhPJw7C5xQ5/m+sP33rop6Z8GoQz5BydKBecgPsK39OZJU5KMqOHiB1tDQAvxWx7M6Zvuq175P0g==
X-Received: by 2002:a63:2242:: with SMTP id t2mr25957753pgm.111.1629618690175;
        Sun, 22 Aug 2021 00:51:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3sm12311603pfi.189.2021.08.22.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 06/25] bnxt_en: Use struct_group_attr() for memcpy() region
Date:   Sun, 22 Aug 2021 00:51:03 -0700
Message-Id: <20210822075122.864511-7-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; h=from:subject; bh=2rfmjsXHCFfyDOdRvlFf8r1FgJW3UMhnCJ1YAXz54ew=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH1vwTutLxawm3vMmILurmAXksF5urmT0OkpQYc fUQkmMeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9QAKCRCJcvTf3G3AJgdEEA CqtV3IuBw5t9VSjAEmApP1pCjuuqD8Tv7dsbR6DE5lEGzlIBCFWcqPdSSwSr4L1MvpNuLbQjYDpL5Z Egsyufnt6YK2ulVD7b+zVP4jNuFWs9G5PzbEjtpf1V/GuVz3rwrPyn709rtFvD1ywQg2UDqypJ0aBO A9vtGQH9TSTOIyP1sgR5Ka/IAGcX7FKzwz7MwUtKjJZMA3+XIyvIBd6zZTHRgHD7F44+jqz6/cGaQY mj+w91SIUb4kFe/uyPb1YJFU/tqJSdAc7/tidGhmtbYWe4NgFAw6lYWDckMHdqJxeqfFYM7vl4+fEe sX2ABDZPMTKsmxPny9Q0e2ElMyFFfoHabff3BacYDb68B3yQSSeFy15EGeOlrmLacPIp6o58dOAPJF Ev9s+kkhDeT0+F75F1Mv9eFy49FSWl9LFUfeHuCr0ZESZjOvnkiLc9WVeFZCfXUMtzjZvUL4mbkIsA KqWIrFyr0Y3xgIDLxUmIJuoCVrGFrLydeZ4wvaG/EtxOyIvsNip5nOvQp8VRY2YZaGTYmFEYh/HB4u PU2C50Yh/4qH0WCCimOlVwHUAaewAJlqXRVMX7U0POtwFWLOEuEEK4QExxp0Hg6xL62zLtmLZ+4vWa U22onqiS4WB8wBQTqV/U8pFTTI0ntm6ZbNqXkXeR2VqEeV6mBfDHiq7gPf+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() around members queue_id, min_bw, max_bw, tsa, pri_lvl,
and bw_weight so they can be referenced together. This will allow memcpy()
and sizeof() to more easily reason about sizes, improve readability,
and avoid future warnings about writing beyond the end of queue_id.

"pahole" shows no size nor member offset changes to struct bnxt_cos2bw_cfg.
"objdump -d" shows no meaningful object code changes (i.e. only source
line number induced differences and optimizations).

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/lkml/CACKFLinDc6Y+P8eZ=450yA1nMC7swTURLtcdyiNR=9J6dfFyBg@mail.gmail.com
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/20210728044517.GE35706@embeddedor
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index 8e90224c43a2..2ddebbfc9cc9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -148,10 +148,10 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
 	}
 
 	data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);
-	for (i = 0; i < bp->max_tc; i++, data += sizeof(cos2bw) - 4) {
+	for (i = 0; i < bp->max_tc; i++, data += sizeof(cos2bw.cfg)) {
 		int tc;
 
-		memcpy(&cos2bw.queue_id, data, sizeof(cos2bw) - 4);
+		memcpy(&cos2bw.cfg, data, sizeof(cos2bw.cfg));
 		if (i == 0)
 			cos2bw.queue_id = resp->queue_id0;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
index 6eed231de565..716742522161 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.h
@@ -23,13 +23,15 @@ struct bnxt_dcb {
 
 struct bnxt_cos2bw_cfg {
 	u8			pad[3];
-	u8			queue_id;
-	__le32			min_bw;
-	__le32			max_bw;
+	struct_group_attr(cfg, __packed,
+		u8		queue_id;
+		__le32		min_bw;
+		__le32		max_bw;
 #define BW_VALUE_UNIT_PERCENT1_100		(0x1UL << 29)
-	u8			tsa;
-	u8			pri_lvl;
-	u8			bw_weight;
+		u8		tsa;
+		u8		pri_lvl;
+		u8		bw_weight;
+	);
 	u8			unused;
 };
 
-- 
2.30.2

