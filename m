Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45DF4165BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbhIWTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbhIWTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CC2C0613E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so20218427wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zLW5/q9hznY+XgxCCcCfBzxU/PyaF17WOIkChCx4sE=;
        b=qFS8mSKuV+hhm9BXS2Xmv3gKHj81OhKA7zEvWOmnf6MsBHuJSu5pfEqewPlSYTeB2y
         RaGnH6BDsSS2LF6WTONxjJwuZHgzoDanq70OFzcH6Ael68kaVVB/1wXXZHtFsQvKA/Fc
         3wDF0UFQtSmBoOAMd+stfuyTjFe3KypNoxSjdA/CxuvrjFKT2cvwTW8vcO4/bZryja1Q
         gNI2XmSNNXfWisvlWGqnwg9c5cPSLQJcJxaEZw7+htqdSFcVDvIP6Ge8vht/L27WmvJy
         Wu1pFpqhURLP10MY79qkcutEwZAkvOb7JQ7Z9gr0mGw+yjjoGU7WxkqBAbqYddCgIejf
         3Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zLW5/q9hznY+XgxCCcCfBzxU/PyaF17WOIkChCx4sE=;
        b=kDwwKdv4Hq2MnRDW41zzGp/ayxn50T1fIh0tMlgnsJw7qcSL8EKxpCpFW9MC/DxCe/
         oaKbG/skI0vhTepAft0CS9+EiFF+Od98RRNl7vqFKUkg1BE/iLzlrpuyArrym1TqQ8Dj
         2UF7CIxBdZw/cHlZvtLP7z0FNwvKS4ym/f0pwwpoiBXldMKn57EWJWSidkcZxjIR+FEF
         mWEPAe8ZoTSl3vpD59ClusXp0JofeCvdvVvBXZLCgJbXiCZ+e/LBnGoM8PbzsYJI4Yai
         B/tH800dquKh1ID5j7pPX2xlpAGUHKdBaZOfBeFepPv/8SxmqBSywhyUFvk4FzKBkPh+
         zBCQ==
X-Gm-Message-State: AOAM531z/1QR3uh4Z4MZjlqLRWM30//C6PtqPw/px/NUl0VVgL0VJtAe
        fdS9yeX4A7tKsUIWFdqcfeU=
X-Google-Smtp-Source: ABdhPJyejryliBu6e6AiSWQfvg5+/9qzatH+0aD9U35uLbmR82DaM0hR+D082pQ0ARbfcv88Rk/zBw==
X-Received: by 2002:adf:fb50:: with SMTP id c16mr7247580wrs.120.1632424182491;
        Thu, 23 Sep 2021 12:09:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/17] staging: r8188eu: remove rtw_setstandby_cmd()
Date:   Thu, 23 Sep 2021 21:09:19 +0200
Message-Id: <20210923190920.3580-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_setstandby_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 32 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 33 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index d8acc6701248..8173756fdeb8 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -334,38 +334,6 @@ int rtw_cmd_thread(void *context)
 	thread_exit();
 }
 
-u8 rtw_setstandby_cmd(struct adapter *padapter, uint action)
-{
-	struct cmd_obj *ph2c;
-	struct usb_suspend_parm *psetusbsuspend;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-
-	u8 ret = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!ph2c) {
-		ret = _FAIL;
-		goto exit;
-	}
-
-	psetusbsuspend = kzalloc(sizeof(struct usb_suspend_parm), GFP_ATOMIC);
-	if (!psetusbsuspend) {
-		kfree(ph2c);
-		ret = _FAIL;
-		goto exit;
-	}
-
-	psetusbsuspend->action = action;
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetusbsuspend, GEN_CMD_CODE(_SetUsbSuspend));
-
-	ret = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
-exit:
-
-	return ret;
-}
-
 /*
 rtw_sitesurvey_cmd(~)
 	### NOTE:#### (!!!!)
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 8895874a654b..6ae0499cd81f 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -744,7 +744,6 @@ struct TDLSoption_param
 #define H2C_CMD_OVERFLOW	0x06
 #define H2C_RESERVED		0x07
 
-u8 rtw_setstandby_cmd(struct adapter *padapter, uint action);
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		      int ssid_num, struct rtw_ieee80211_channel *ch,
 		      int ch_num);
-- 
2.33.0

