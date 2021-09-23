Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67234165B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbhIWTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhIWTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44AC061762
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u15so20112167wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hc0JmDX9InuYV/Fu51J33tmC0KeTskY4XhLTBr56OcQ=;
        b=cNAEmNvy5SHAXhnlFeeHUHeSURzBka1CGFT5zUZKpqzdadTW15ZFTemnvbQqZjyX/W
         dpzsfg/Z/xlERzU2FIgswJwevvHwhwkrq5NyUc6kFrU7bUWAUHhpY1QIopoazPu/RmGx
         HpjVQzwsmspfZh3o19mKjvi2/qWzSlCfG6KPXPHY1rUgDOJ1zRPOU0JXihXNohSa6UKg
         JzGRd5F0GQbvhmQQ4R6HM1qrsSnIsuI3HmmiHcaqzr7Bz35MAjmi4dB4ldD1mHMXZzjd
         rKkmalP42WZzUwzqhWcPhydUsCZUzq69888WnpBCQZE5lZ6VKnuDaP66ytDyFnbz/8wT
         dG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hc0JmDX9InuYV/Fu51J33tmC0KeTskY4XhLTBr56OcQ=;
        b=tmJPRJO7IX9bknPSXv5dYiuL2Bd3aeohWYg5No7UjOYv3ST/fQyCOwgi0EiGZAh/Fo
         PKNBYgvYa+QwaYjqFXxAv1pdcjBKD+woszRyZsuBGy4KXy3PmaGeOWX6a0eIqOke2rXJ
         dW1xYNkF5VlOiE+ATGbTPYHsV4gtR76sztv3uHPAwFrxXszQTsqPUBE4kFwOIQSx2AZJ
         7/V6sKXqiL20N1Ea6aJR6Kz+q1jI3rx8+s0aEzTHSNyWgJGy9L1FnSQ+iTIg3u/k1ciX
         iw8a2fFB/7d76nXgy8Irj5x48LbzdNaMRkQA2x9cgB/HMQq7iPD4zrBM9ZTAue0ZNiNI
         U6ZQ==
X-Gm-Message-State: AOAM530cSZr0jvzLxpX6sVvWsiE6eGh6ak2cdiTzsDTYP6x2kp9wCGvc
        YlZJjrM9WovcK78qszBhAEk=
X-Google-Smtp-Source: ABdhPJwlCUs6iGD+7OZ3ZdUzdDbI8QQuPKbzGgIoQfz1eqpVZ/AGigXOc5Pz5Ca/m+iM9hKQ1C0c0Q==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr6169920wmb.30.1632424175996;
        Thu, 23 Sep 2021 12:09:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/17] staging: r8188eu: remove rtw_set_ch_cmd()
Date:   Thu, 23 Sep 2021 21:09:11 +0200
Message-Id: <20210923190920.3580-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_ch_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 51 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 52 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 0b5472558899..a10fde30dc69 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1085,57 +1085,6 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 	return res;
 }
 
-u8 rtw_set_ch_cmd(struct adapter *padapter, u8 ch, u8 bw, u8 ch_offset, u8 enqueue)
-{
-	struct cmd_obj *pcmdobj;
-	struct set_ch_parm *set_ch_parm;
-	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
-
-	u8 res = _SUCCESS;
-
-	DBG_88E(FUNC_NDEV_FMT" ch:%u, bw:%u, ch_offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev), ch, bw, ch_offset);
-
-	/* check input parameter */
-
-	/* prepare cmd parameter */
-	set_ch_parm = kzalloc(sizeof(*set_ch_parm), GFP_ATOMIC);
-	if (!set_ch_parm) {
-		res = _FAIL;
-		goto exit;
-	}
-	set_ch_parm->ch = ch;
-	set_ch_parm->bw = bw;
-	set_ch_parm->ch_offset = ch_offset;
-
-	if (enqueue) {
-		/* need enqueue, prepare cmd_obj and enqueue */
-		pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-		if (!pcmdobj) {
-			kfree(set_ch_parm);
-			res = _FAIL;
-			goto exit;
-		}
-
-		init_h2fwcmd_w_parm_no_rsp(pcmdobj, set_ch_parm, GEN_CMD_CODE(_SetChannel));
-		res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
-	} else {
-		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != set_ch_hdl(padapter, (u8 *)set_ch_parm))
-			res = _FAIL;
-
-		kfree(set_ch_parm);
-	}
-
-	/* do something based on res... */
-
-exit:
-
-	DBG_88E(FUNC_NDEV_FMT" res:%u\n", FUNC_NDEV_ARG(padapter->pnetdev), res);
-
-	return res;
-}
-
 u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 {
 	struct	cmd_obj *pcmdobj;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 86819b0219aa..bca7a0dba601 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -779,7 +779,6 @@ u8 rtw_ps_cmd(struct adapter*padapter);
 
 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
 
-u8 rtw_set_ch_cmd(struct adapter*padapter, u8 ch, u8 bw, u8 ch_offset, u8 enqueue);
 u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
 u8 rtw_set_csa_cmd(struct adapter*padapter, u8 new_ch_no);
 u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option);
-- 
2.33.0

