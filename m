Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2566E3B2417
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFWXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBEAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m15so2373593qvc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3iZq93qJlhlHyJJ5kBsLs80OLUbQCBovB25rjj6nBk=;
        b=MDTcxN6PgmSYgHfdoQZsKxxj0lM9G2XTHOctwJ//t/yRrurpZDRCjzB+PEtrgmIYH6
         0e+PWS9nxQyRJ6TuJROprV2kHstrbzteByQ50G2wGFw53HgW/Y2GTnCnbqlY8or74Sbc
         z4SDd4L7BjgbSuBIVJEcewclr+fpX762EKj4cIxdSZ7f0lafo6hTtgk6lJ3lnyIPJxMp
         TkbW1FCQzbQ+nLmu74IgkqfK9Fp+KYVG7iN+n+bdp5gbYpWo5QExEu6CdSV04TOPW01s
         B976T6laDypJOYQ69TMzJL7Q+i6ncuDM8NVj/Dfw89fw/OrJOMN8FE8PVJZRgJWwZ7Pe
         2mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3iZq93qJlhlHyJJ5kBsLs80OLUbQCBovB25rjj6nBk=;
        b=YuPF0U6B+aD2kepXSJNkPYGO78niuv6Rg/fcrSd2q6zHJLj5amwyCLROat6SgsUFP8
         M81NBCipBAQe2rnCHTb1B4SJMryie8C2kBQOSdu2Ul1ZGa4U2hb2vaXrGmIrPCzTP4rG
         aJpRAeJNNPX1+72cTre5anUimOrhLxds5K5B1ZcfR+Ie/+g4abIFMcny9nn+Kv/PIyHq
         60mbzl6ar1ISxjrQe8hpzAyPllID0iW7rR4Gg2wXSyHENnTD9LkKwT8vRrpx5znuGVCp
         h0tmRqycO0CZCYvGOIm/B/EbXSUQRMNc2Bs1wVUxQkduFyfli6s/poTNhpJX2PqdAWFT
         MVvQ==
X-Gm-Message-State: AOAM5334Gdms4tSZqXsQiheNs74nqDX9cZjdf5Gf8NgFGf6J54h4DmuP
        usDgmT3+rpjHi9H5ZaWQVR3fyQ==
X-Google-Smtp-Source: ABdhPJx6FK4Vr5U43TGDZ73KbHRZUMRXatqX0Ot94wWOHZbKqVv6HVERl5XQdaSt9qnUMmTVo5Nh8Q==
X-Received: by 2002:a0c:d7c4:: with SMTP id g4mr2367407qvj.23.1624492152287;
        Wed, 23 Jun 2021 16:49:12 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 4/9] staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_pwrctrl.c
Date:   Thu, 24 Jun 2021 00:48:57 +0100
Message-Id: <20210623234902.7411-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E_LEVEL calls from core/rtw_pwrctrl.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index f6fe43e0965d..95e2eea23e42 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -112,12 +112,8 @@ void ips_enter(struct adapter *padapter)
 		return;
 
 	if (pxmit_priv->free_xmitbuf_cnt != NR_XMITBUFF ||
-	    pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF) {
-		DBG_88E_LEVEL(_drv_info_, "There are some pkts to transmit\n");
-		DBG_88E_LEVEL(_drv_info_, "free_xmitbuf_cnt: %d, free_xmit_extbuf_cnt: %d\n",
-			      pxmit_priv->free_xmitbuf_cnt, pxmit_priv->free_xmit_extbuf_cnt);
+	    pxmit_priv->free_xmit_extbuf_cnt != NR_XMIT_EXTBUFF)
 		return;
-	}
 
 	mutex_lock(&pwrpriv->mutex_lock);
 
@@ -129,7 +125,6 @@ void ips_enter(struct adapter *padapter)
 	pwrpriv->ips_enter_cnts++;
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
-		DBG_88E_LEVEL(_drv_info_, "nolinked power save enter\n");
 
 		if (pwrpriv->ips_mode == IPS_LEVEL_2)
 			pwrpriv->bkeepfwalive = true;
@@ -161,8 +156,6 @@ int ips_leave(struct adapter *padapter)
 		if (result == _SUCCESS)
 			pwrpriv->rf_pwrstate = rf_on;
 
-		DBG_88E_LEVEL(_drv_info_, "nolinked power save leave\n");
-
 		if ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_)) {
 			set_channel_bwmode(padapter, padapter->mlmeextpriv.cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			for (keyid = 0; keyid < 4; keyid++) {
-- 
2.31.1

