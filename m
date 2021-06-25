Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A903B39FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhFYAL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhFYAKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u8so997582qvg.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBfveMBFusywj9cSVD+Uz4e7bJ4plmXSooGcOIkcK7g=;
        b=ywyVLUSCFBc7bu5IALFg2rZq97d5MiqQTQT22I+aYSMSio5k1ALf8asC5BgWiZ6ANM
         HjFS7E5tmC6VRYDsizQuXAxpx5lBYQ5BmZ+tAslVCP1sCcR1x4k6IJ8g6E+0RYDyGlwC
         rHb73//DeLJO1B3jCO4UZ5hG9GEY1hrmF7QIbHB2MfCTwaKrH031X87G1ycgWmqO9Hb5
         pFJLakmmGGyXXIyqaZNB+D9/hBewiNDcSoOsr5HEgbTp8fVqRyHseiTNesev2s3iShdc
         y6AlihJIzBAdqdHAYLkGrkjbznbjUDYOqPufGzOm1HC7+xTIjrPyLvgEGq9g2FDMIvt7
         cQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBfveMBFusywj9cSVD+Uz4e7bJ4plmXSooGcOIkcK7g=;
        b=njaYptHWQFUjlyesDvQ9L0kLsuoDRyrXct8vd9iygHaDsugrqkBOXfH8xoKfXsI9+I
         VugGvRVhtAHNJwUvGZiQP3YAbs5eWzjiJQlCpt8dvxlLT9p45fY2kTRiEFupMFPYXcnb
         QJNMJw979nw+KzooA3B31VSW7BgZyvl0hKWcimk/CdnY1tQ+XF2iajm9IdI13/ACgiqA
         k52W0dDvHBnbKHi5YYoDA0007+U0j7/vz1gYVp/60Tbh3uJ5x0EOubDZsBRIY/RHIUTk
         hw5fG68eC4ZsXqcUaeiaSiIv+NfmPCb1+0OEe6WF/GOdFdGjSED/YQ5P5UGFo84IppBe
         Rq7g==
X-Gm-Message-State: AOAM531ylye5k7/q2UyYwngpV4cpM4dgRdd6wxC4hSlqevnAMnNcEcDj
        T1b1iwG6lOHn2UbwxL+2a0HISA==
X-Google-Smtp-Source: ABdhPJzQoeZuyClHEwoMN5Kg/Qp0GRiFaXbvMYoycHZUkZQgr9ph6gNugr1BtvFpqJxQOfw3SDMnYA==
X-Received: by 2002:a05:6214:1028:: with SMTP id k8mr8314493qvr.13.1624579706215;
        Thu, 24 Jun 2021 17:08:26 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:25 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 17/23] staging: rtl8188eu: remove all RT_TRACE calls from hal/rtl8188eu_xmit.c
Date:   Fri, 25 Jun 2021 01:07:50 +0100
Message-Id: <20210625000756.6313-18-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from hal/rtl8188eu_xmit.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 729d3bbf4343..1fa558e0de38 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -341,15 +341,11 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 		rtw_issue_addbareq_cmd(adapt, pxmitframe);
 	mem_addr = pxmitframe->buf_addr;
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s()\n", __func__));
-
 	for (t = 0; t < pattrib->nr_frags; t++) {
 		if (inner_ret != _SUCCESS && ret == _SUCCESS)
 			ret = _FAIL;
 
 		if (t != (pattrib->nr_frags - 1)) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("pattrib->nr_frags=%d\n", pattrib->nr_frags));
-
 			sz = pxmitpriv->frag_len;
 			sz = sz - 4 - pattrib->icv_len;
 		} else {
@@ -372,8 +368,6 @@ static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 
 		rtw_count_tx_stats(adapt, pxmitframe, sz);
 
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_write_port, w_sz=%d\n", w_sz));
-
 		mem_addr += w_sz;
 
 		mem_addr = (u8 *)round_up((size_t)mem_addr, 4);
@@ -430,8 +424,6 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
 	/*  dump frame variable */
 	u32 ff_hwaddr;
 
-	RT_TRACE(_module_rtl8192c_xmit_c_, _drv_info_, ("+xmitframe_complete\n"));
-
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
 	if (!pxmitbuf)
 		return false;
@@ -626,7 +618,6 @@ bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (res != _SUCCESS) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("pre_xmitframe: enqueue xmitframe fail\n"));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 		/*  Trick, make the statistics correct */
-- 
2.31.1

