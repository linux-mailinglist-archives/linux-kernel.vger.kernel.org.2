Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C443DF832
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhHCXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhHCXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80286C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:39 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so151568wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCPkD1dwsnQaA+afTXqBn/SyTpbp0k/+8Ot/Elq5978=;
        b=RcBbqFV8YV23LRHzAvE800zfKpPv4CppSzON37JHwqbz1pcSsehZdOFMM6l2TklLs7
         /hi4yLxnoIVo8OWPnBd8GJSLheOX6qRzvbPOHSajdhgdmUPh81Vb1a7zHgvXwt+ElTgz
         Q4W4r5I/fhtiIe0S+nJocOKBybSxoIKuwEaMjpw8UcMU3nwSx9ZXKTWUIHK+U5yf3Z1L
         li7jCW6kKOhQEtFU0feFx6ryMCFHW2Ln/agMNRRMbjIoZFIg3L1tmHmTSYl28D0Y31BZ
         YoR+c6I3T1TKEJgNz4X0Kypqx4dZK+I+PX6EcMGwuAYi+M72FVSkmRVK+utt2WfsseqY
         HZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCPkD1dwsnQaA+afTXqBn/SyTpbp0k/+8Ot/Elq5978=;
        b=HOCuJduxEtSteUNKK1IHGNg8PcxFspYhAQKCZuACkjI1ljUeAALTSDPpnVX1B/7mQ2
         2eG70+k6R/Kr5Wzi21GvNfWWN+r7/gnMjY7x1eCibrE8FYVzFosUOVUf93tvnzdtyUs7
         oODzZOEHlI50CqPd/jkGkhjQnCQZPi1SV7AfJIAWMev3x2PfCK58B+N045OTl1lY7yb8
         2zYVeGWZ1/A0orGAs1DO1r7ogOM0ZDjq2n6gbEnLCxUUZlRvwj8HX4czOSaR+4ANSsnM
         yfZ0X0+BnSu+r4JITbpqVi9/bg7ETex+XxcfQSsbWUHiAHNLUNyUWBGHElk+NI4twO/o
         888g==
X-Gm-Message-State: AOAM530/2ylML+pofMGIFTzmXkX7uF74w2+sso1Ne83BE9pFkQxgjHRO
        e4xVflMolRFOAYh3b5Kzd/wLVA==
X-Google-Smtp-Source: ABdhPJw2shYsqMNCU8gzlCwQeyE4AOekTFHvZGp6BT4M98pSqQY1oucwTUVbcXSChnlzCFyLXZytAA==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr24380664wrs.321.1628031938108;
        Tue, 03 Aug 2021 16:05:38 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_xmit.c
Date:   Wed,  4 Aug 2021 00:05:28 +0100
Message-Id: <20210803230535.74254-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/rtl8188eu_xmit.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e44a01af7f5c..33470170453e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -354,15 +354,11 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 		rtw_issue_addbareq_cmd(adapt, pxmitframe);
 	mem_addr = pxmitframe->buf_addr;
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_dump_xframe()\n"));
-
 	for (t = 0; t < pattrib->nr_frags; t++) {
 		if (inner_ret != _SUCCESS && ret == _SUCCESS)
 			ret = _FAIL;
 
 		if (t != (pattrib->nr_frags - 1)) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("pattrib->nr_frags=%d\n", pattrib->nr_frags));
-
 			sz = pxmitpriv->frag_len;
 			sz = sz - 4 - (psecuritypriv->sw_encrypt ? 0 : pattrib->icv_len);
 		} else {
@@ -385,8 +381,6 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 
 		rtw_count_tx_stats(adapt, pxmitframe, sz);
 
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_write_port, w_sz=%d\n", w_sz));
-
 		mem_addr += w_sz;
 
 		mem_addr = (u8 *)RND4(((size_t)(mem_addr)));
@@ -441,8 +435,6 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 	/*  dump frame variable */
 	u32 ff_hwaddr;
 
-	RT_TRACE(_module_rtl8192c_xmit_c_, _drv_info_, ("+xmitframe_complete\n"));
-
 	/*  check xmitbuffer is ok */
 	if (pxmitbuf == NULL) {
 		pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
@@ -659,7 +651,6 @@ static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (res != _SUCCESS) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("pre_xmitframe: enqueue xmitframe fail\n"));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 		/*  Trick, make the statistics correct */
-- 
2.31.1

