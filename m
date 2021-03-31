Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959D934FD55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhCaJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhCaJlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bf3so21519756edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3fTzoidO6ZyW84yUTCHM+6nHXSxCL5GT3iM7s0uLfg=;
        b=qIIuBgRStNV1oCbnidfgP10MM11nltS/U9FkpqJZdry2fOb9sInoEQx1FsusnE7rOG
         r20YqmBy/whPkJijxwW4H1JHIuXxmrO86ATNjA3wVC12prbNaFh9DFPoPzjbm0xz3FZA
         ovvH3iNJMXW+20Ks1Taey/ZIf/5Gp6w4yNFL74BJJxE48bX6hqQEmtJs02oy7kp+uTFN
         Pupc+7MAY2J9oxORJapQp5R1VPMPCcQGXA+JduiyuiLknT6hADyr14aXQVIjI0WjJooT
         rQVBjCuipiCY7VqCn6ZD3BcbPDCeR1y85lYWW+FoUow52BU3/4mhijKyIKcxNnn4+G//
         kJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3fTzoidO6ZyW84yUTCHM+6nHXSxCL5GT3iM7s0uLfg=;
        b=DmLSQVr0KyrCFbobFx7yvPeOUVySXVa4HDDeM67W7TBT8RO2xwPwy06lVGvXhOi1Ns
         uGPpyeFiwnPaEy42tfhPhvDsRCSt2dZ3fcpzSHNOh0jYTJbRUvEdWBAMrU7tXosbJyiR
         JuDERAORfwhnjG43wekgOrJ1esZOneOYqkensmiUPY2KU3AxFeZjDUjSgXQizBG2KoKX
         B64KnqhKUKTrDuMGt1MPPW87tcfyWzfVs4doCwW8s/0scM4+LwK/W89ingcbP84WbDkL
         BOpnTWx0HBGqXxYave+8Kf0/zBnt1u14WjIigh9s42uUcuhuqs5I4A2/D5yHJu3sMy0u
         cpiw==
X-Gm-Message-State: AOAM533uZ0mauH3Hl/L2hvedLcz+5akHaO00XduHHAGOPI9ta7khunVT
        IsAhn0qfcEjn1NzY/rViBt0=
X-Google-Smtp-Source: ABdhPJwFA1PCM4mSwjwJWKmWLkWGNYJsHrCdjnEvDPIs1PsZqjcG4ikuk9+rnHngD5CZ/Lvw5onSKw==
X-Received: by 2002:aa7:c1d8:: with SMTP id d24mr2570042edp.290.1617183679220;
        Wed, 31 Mar 2021 02:41:19 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id l1sm1111471edt.59.2021.03.31.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 36/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/recv_linux.c
Date:   Wed, 31 Mar 2021 11:40:04 +0200
Message-Id: <0f736de5c7eda8a5cda2a89fc588e7d72cec9cba.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index fbdbcd04d44a..5e1ee9783c32 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -202,13 +202,19 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	skb = precv_frame->u.hdr.pkt;
 	if (skb == NULL) {
-		RT_TRACE(_module_recv_osdep_c_, _drv_err_, ("rtw_recv_indicatepkt():skb == NULL something wrong!!!!\n"));
+		pr_err("%s %s:skb == NULL something wrong!!!!\n",
+		       DRIVER_PREFIX, __func__);
 		goto _recv_indicatepkt_drop;
 	}
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():skb != NULL !!!\n"));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("rtw_recv_indicatepkt():precv_frame->u.hdr.rx_head =%p  precv_frame->hdr.rx_data =%p\n", precv_frame->u.hdr.rx_head, precv_frame->u.hdr.rx_data));
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("precv_frame->hdr.rx_tail =%p precv_frame->u.hdr.rx_end =%p precv_frame->hdr.len =%d\n", precv_frame->u.hdr.rx_tail, precv_frame->u.hdr.rx_end, precv_frame->u.hdr.len));
+	pr_info("%s %s:skb != NULL !!!\n", DRIVER_PREFIX, __func__);
+	pr_info("%s %s:precv_frame->u.hdr.rx_head =%p  "
+		"precv_frame->hdr.rx_data =%p\n", DRIVER_PREFIX, __func__,
+		precv_frame->u.hdr.rx_head, precv_frame->u.hdr.rx_data);
+	pr_info("%s precv_frame->hdr.rx_tail =%p precv_frame->u.hdr.rx_end =%p "
+		"precv_frame->hdr.len =%d\n", DRIVER_PREFIX,
+		precv_frame->u.hdr.rx_tail, precv_frame->u.hdr.rx_end,
+		precv_frame->u.hdr.len);
 
 	skb->data = precv_frame->u.hdr.rx_data;
 
@@ -216,7 +222,10 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	skb->len = precv_frame->u.hdr.len;
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n skb->head =%p skb->data =%p skb->tail =%p skb->end =%p skb->len =%d\n", skb->head, skb->data, skb_tail_pointer(skb), skb_end_pointer(skb), skb->len));
+	pr_info("%s skb->head =%p skb->data =%p skb->tail =%p "
+		"skb->end =%p skb->len =%d\n", DRIVER_PREFIX,
+		skb->head, skb->data, skb_tail_pointer(skb),
+		skb_end_pointer(skb), skb->len);
 
 	rtw_os_recv_indicate_pkt(padapter, skb, pattrib);
 
@@ -225,7 +234,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 
 	rtw_free_recvframe(precv_frame, pfree_recv_queue);
 
-	RT_TRACE(_module_recv_osdep_c_, _drv_info_, ("\n rtw_recv_indicatepkt :after rtw_os_recv_indicate_pkt!!!!\n"));
+	pr_info("%s %s: after rtw_os_recv_indicate_pkt!!!!\n",
+		DRIVER_PREFIX, __func__);
 
 	return _SUCCESS;
 
-- 
2.20.1

