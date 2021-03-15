Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE0D33AFD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCOKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCOKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:17:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l11so8369623wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LHhMN1YGR0iqaipxc7BR00dcApJPdqJZdaOY7Fx6YMo=;
        b=DwILB34mOdPJkDR9my/JHGbgkxCyB4VBDIaWNewFFPLM7Y27y4PsQJaK7GXcHXZorx
         eQvCv22dOHDFWj3cQuS97ECY1fa3cGG+UDBbbe4p9Phlnq5w9DJGYrUsS+k3BSQ02hzP
         FXYBp50YBk87poF2768RYddQ7cLga8ncmuH9u/7FCjpWNlkbogcug/Lihk5HZkzQqDrX
         MY0Sd+gXd6uKH/tW0IkWyxdMYcesJfVy5yxORWKp+o6zbkRlTPoEReKLbPL+m6ZvoTxC
         +pLUr3Y9w557GYxbDSrfEb2qcModYfiopOrBFajQ0rI2vOy31BR8fON9q65MqrlulJgy
         rL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LHhMN1YGR0iqaipxc7BR00dcApJPdqJZdaOY7Fx6YMo=;
        b=G8QZql8EGA3czdTybXKI7pTyXa9iP6nYMvj7GygvrKVIMq5KY4i7Y0swtnQIpgGnfF
         RCAscM2IknEc3n4Q2vYQ4/yl/F1WZmznHnergGhDPowg/JtIGNiZ7Eapg4UzNmFvJ64e
         24lUy2YnVb7kuYs42Bm25vxSGjKLfUU5DuyuzZN42F6wMJOEghx8dlySWbnrj7mX/UQk
         0oIHwTrytM7KbRERCdNyxtjXw2lXJjNvEgq/Kfwosz80z3BiJb3LcjnNRlQGZkt2L+hl
         w0M6i2/uSRr3AM4CLxHJ2ggiy23hox/Sfhe8Tvk7vi46mv/53q68t2AIiGakWU4AiV+f
         VGeg==
X-Gm-Message-State: AOAM5301SYLktnCBJtshguh+uPeOcJITXVYs9/k7KtDQvszkLQ02wo8T
        DXtOcU8CFg96liCX8ThqoCk=
X-Google-Smtp-Source: ABdhPJzOx00IiAPNbP5/QQf12m390irZGnb0eUfmGCx/3aJF9OAdiPeAP7SGu+/Mh1rlVw0SZyO4dA==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr25954449wrq.278.1615803420922;
        Mon, 15 Mar 2021 03:17:00 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id t8sm17799380wrr.10.2021.03.15.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:17:00 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:16:58 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_SDIO_TX_TASKLET
Message-ID: <e7f5f364d9f1f6ab271841b203c4de6c82ecfc9f.1615801722.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_SDIO_TX_TASKLET

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ----
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c    | 8 --------
 drivers/staging/rtl8723bs/include/rtw_xmit.h      | 4 ----
 3 files changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 5854590e5811..eddf01c71e24 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4398,19 +4398,16 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum HAL_DEF_VARIABLE variable, v
 
 void rtl8723b_start_thread(struct adapter *padapter)
 {
-#ifndef CONFIG_SDIO_TX_TASKLET
 	struct xmit_priv *xmitpriv = &padapter->xmitpriv;
 
 	xmitpriv->SdioXmitThread = kthread_run(rtl8723bs_xmit_thread, padapter, "RTWHALXT");
 	if (IS_ERR(xmitpriv->SdioXmitThread)) {
 		RT_TRACE(_module_hal_xmit_c_, _drv_err_, ("%s: start rtl8723bs_xmit_thread FAIL!!\n", __func__));
 	}
-#endif
 }
 
 void rtl8723b_stop_thread(struct adapter *padapter)
 {
-#ifndef CONFIG_SDIO_TX_TASKLET
 	struct xmit_priv *xmitpriv = &padapter->xmitpriv;
 
 	/*  stop xmit_buf_thread */
@@ -4419,5 +4416,4 @@ void rtl8723b_stop_thread(struct adapter *padapter)
 		wait_for_completion(&xmitpriv->SdioXmitTerminate);
 		xmitpriv->SdioXmitThread = NULL;
 	}
-#endif
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index a3bd9c2002c9..597cf3a88c51 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -124,10 +124,6 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 	/* pxmitbuf->priv_data = NULL; */
 	rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
 
-#ifdef CONFIG_SDIO_TX_TASKLET
-	tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
-#endif
-
 	return _FAIL;
 }
 
@@ -601,11 +597,7 @@ s32	rtl8723bs_hal_xmitframe_enqueue(
 
 		pxmitpriv->tx_drop++;
 	} else {
-#ifdef CONFIG_SDIO_TX_TASKLET
-		tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
-#else
 		complete(&pxmitpriv->SdioXmitStart);
-#endif
 	}
 
 	return err;
diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index a6fb8be8c63a..b482821c9af8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -412,13 +412,9 @@ struct	xmit_priv {
 
 	u8 wmm_para_seq[4];/* sequence for wmm ac parameter strength from large to small. it's value is 0->vo, 1->vi, 2->be, 3->bk. */
 
-#ifdef CONFIG_SDIO_TX_TASKLET
-	struct tasklet_struct xmit_tasklet;
-#else
 	void *SdioXmitThread;
 	struct completion SdioXmitStart;
 	struct completion SdioXmitTerminate;
-#endif /* CONFIG_SDIO_TX_TASKLET */
 
 	struct __queue free_xmitbuf_queue;
 	struct __queue pending_xmitbuf_queue;
-- 
2.20.1

