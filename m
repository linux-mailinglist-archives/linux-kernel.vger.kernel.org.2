Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D888D402024
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbhIFTEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbhIFTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:03:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g22so10607613edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYfDSWWLfbRbSNVuId0vyBxYwKOU4bWEtZJKFkrF65E=;
        b=mVMMFtWojmvkwy1ZiTea5EpVlP1GnhalgNZCiTDcbS51zW0+9yykvMDw7H2IYdbFvh
         1SuJ8U+uAeA+p/AmWtQ6FnpacOGh2CiD2qPib/Dx8liT0pp49s6Q08uv2nA3V/4od/3c
         77T0xBHuLnJ/JUqXf3us1uopYc9A5ngH0S8B2n+QWZXJKq+/15UIjDERaZ2DvraTW3M8
         xjMPH05itNIZXomhAOEcdCO9K7GDvPfi5OYysgFKex7yFHGFuXcMXKSUxTMAVwQbQ9It
         Ff7fzQaalbSQQOFLdN+SvbTqpXNTwll/ppMl0OdICFP6rGxgsmvyOgMZUU9xi21tLgf5
         NNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYfDSWWLfbRbSNVuId0vyBxYwKOU4bWEtZJKFkrF65E=;
        b=hjksXV/u83oBP1NYBGgLndYn9ReLEQA7UQPEu1h/99O05UNDOsBmr9/r7iXUW5tyrY
         taRFH38wkEbeThy2pDOpd8aRkW2hcI3nFXv+L6Z+9HOJZ4Q0o/sRKpK15kmVDLZNPxAW
         bUb5pPo4qCy4epl1NT20T5BjJuV3RBUMldY2W6UfVLuPrwPrfNOB21gv/UeS7UGNbYfp
         j6t+BNjdGouvW2tIVDTIuuhddUo5KDbIhZtV6b2LAOXHSiizG4zK30IOciYMpMuEkhBB
         FciWsHA9pDXOt4BnO8c9aNdlCUjZYISUsV4DmXSO1To64XXRxB9Y5UFpBmuBxVKZ/BPW
         IiRQ==
X-Gm-Message-State: AOAM532uvjyl/0DqBD6vycLCMP09f0qtnc1T/rlNCb4/BJIeu0PNt+Kn
        KWlJeRtSNzkmnHwl0FuBHxo=
X-Google-Smtp-Source: ABdhPJyaWT7nm45C3Kk3YTkno9eFpYoLPMnU0ivEEbloEWLULeMJC46Cwe/TFKnD+0YwETE0NRHW2Q==
X-Received: by 2002:aa7:d2cb:: with SMTP id k11mr14746208edr.227.1630954970696;
        Mon, 06 Sep 2021 12:02:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 07/40] staging: r8188eu: remove unused function rtw_interface_ps_func()
Date:   Mon,  6 Sep 2021 21:01:50 +0200
Message-Id: <20210906190223.11396-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtw_interface_ps_func().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 8 --------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index c3897b29121c..00750394c50b 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -473,14 +473,6 @@ void rtw_free_pwrctrl_priv(struct adapter *adapter)
 
 }
 
-u8 rtw_interface_ps_func(struct adapter *padapter, enum hal_intf_ps_func efunc_id, u8 *val)
-{
-	u8 bResult = true;
-	rtw_hal_intf_ps_func(padapter, efunc_id, val);
-
-	return bResult;
-}
-
 inline void rtw_set_ips_deny(struct adapter *padapter, u32 ms)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 543f928e8089..8446dfb50f34 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -251,8 +251,6 @@ s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
 void LPS_Enter(struct adapter *adapter);
 void LPS_Leave(struct adapter *adapter);
 
-u8 rtw_interface_ps_func(struct adapter *adapter,
-			 enum hal_intf_ps_func efunc_id, u8 *val);
 void rtw_set_ips_deny(struct adapter *adapter, u32 ms);
 int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms,
 		    const char *caller);
-- 
2.33.0

