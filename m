Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52738AF78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbhETNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243580AbhETNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:00:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A5C0438C4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:26:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y14so15386591wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+6eFe0//mxcph1fEdMR/oudTRijIDHPmUlkJgKgFDM=;
        b=HUUVtVuwkJcTAy5nTIXfnqZtDzNOAKYCAnczlPd2SWHkg1+YeVwOdR2nmTzi4Yhn3U
         TpiZRyL5dNt+2lO+9baiZ44eh5ubyhT+UmB3xa20hQqCgbz3REj0nNKN5bsrhyF8eO0c
         FxrWBzKBjuRRUHW6Eoa3TXE3O7JWzlrji9baS+HTIRapYClZCuu144UmjNm/yXj31BZx
         veXvbVBLsmu2yMATKjV0xVCXZ16YKkvf+yiZzmD+IZWml2bEETcE849M3KtdeFS7Ehf3
         t57kqrjpy+eRAvAZMCYkNaTwasxm7321YxRErW8vBH4UfpQpKm4j0w3YgTp9mSfzfZeH
         S+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+6eFe0//mxcph1fEdMR/oudTRijIDHPmUlkJgKgFDM=;
        b=KETfZ9WJkv4kgZ3NU2hqYFi5DWkxbDqGpJGBAaYIMu5YWBz4VS8lfjnT17+b3BWL5S
         0VNGfo8Q0YxJ/eVxWEduPFeTz+I2ky45HCe54uCxPuLz47+s56WNMrAFcCQ4ELo1zuL3
         IK7MC94xbc/qCpVw9JmQ5IeVzg3gzd3rw1RBW+iH07phDa3HrX7OBva5AVKk6ZJPmZZP
         7AZCutklhneDDgP6KLkC/FWlGuyPvRBe/PwK04T5IAFnK0ICpys7YLXlE7f1KjY5jaiN
         aSGT2GVOI4sotPdJD7W9ocl0GvzJU5Px3osxBJwe9lJeo1PTJ9mRvVavO67DcCV8qM9S
         IbCQ==
X-Gm-Message-State: AOAM531Jz2Z/qeWnsxSh97wKdjpMoTsXtyanU7RXfUqty5a7cLlECsQq
        p7BbJfzz+5ncWZVAU5wjxzDSWw==
X-Google-Smtp-Source: ABdhPJyMvFpEqzIK5NWmes//QY2PtnhBv3UkZRvDeSoY2Q5Ur40HJhMejlzCAGRe3e1/P/qSCNLmcQ==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr4122373wrr.218.1621513584091;
        Thu, 20 May 2021 05:26:24 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r5sm3001817wrw.96.2021.05.20.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:26:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Cesati <marcocesati@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>, Stanley@BB.SD3,
        linux-staging@lists.linux.dev
Subject: [PATCH 2/2] staging: rtl8723bs: hal: rtl8723b_hal_init: Remove unused variable and dead code
Date:   Thu, 20 May 2021 13:26:20 +0100
Message-Id: <20210520122620.3470450-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520122620.3470450-1-lee.jones@linaro.org>
References: <20210520122620.3470450-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c: In function ‘CCX_FwC2HTxRpt_8723b’:
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3355:5: warning: variable ‘seq_no’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Cesati <marcocesati@gmail.com>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: Stanley@BB.SD3
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 33942ab587720..0270724ccef03 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3204,14 +3204,9 @@ void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
 
 	if (GET_8723B_C2H_TX_RPT_RETRY_OVER(pdata) | GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(pdata)) {
 		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
-	}
-/*
-	else if (seq_no != padapter->xmitpriv.seq_no) {
-		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
-	}
-*/
-	else
+	} else {
 		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_SUCCESS);
+	}
 }
 
 s32 c2h_id_filter_ccx_8723b(u8 *buf)
-- 
2.31.1

