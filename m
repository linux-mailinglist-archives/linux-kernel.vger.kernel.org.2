Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224B13408D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCRP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhCRP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53378C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so5979338wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuXuquJSPXh4uSZyOAEbuoqGCSemWYbmYBGp6zbceho=;
        b=A8a8iRiLdgIRExwuI1wmNUd/SlhxoOpwOi2niPev2pFifFcP/jH7I5sEWAwjRyAh7i
         7zEcW4xq2VrntqI40p5G5VvdDJ5CTXLDGiUJJjgcRvexuTB8foAdfp9VNVf+VpHO5Upr
         LWeYF82urRYb1e8hi5dbYemhHcVVpl9A5nr/4cnLXv/sI1Zvh1EJeZVplQipdn4VatVl
         w8NTihfhrqwAWUkcwk3Eh3eDDAyf2IlqcAYgpa6OtRItyNuHvMpAS82/DcOyeRfo2cYm
         SnLAWw7GgY64HYe1d54e0iDM9xB/4oKkHivsn7r3Dp7dVQS3PGgf8q1zVnQ+ATNSuXKW
         unVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuXuquJSPXh4uSZyOAEbuoqGCSemWYbmYBGp6zbceho=;
        b=D/i/bzpRZlpCuptwB67oYFwqCMbgVudsf/EomfX9Lh0c1IMwvxacpeIWt7BCVFgWK7
         X99AYIanwz5s7AnTvYBC8ASTIDsBoUzeDD2WVb3SRX2wvwbklrmwFIFFwSIzVyc2IuqT
         6rCCt+HE7T9N74ktfh2vqat8GNbrFyzhMenxYiEfzN4usoMM2smIYQgz6uO0Fsm4JZOB
         zuSyC8DJn9axLn4EUWzhoULt/QcwyWU20S6Wkw+YZ6pHdvj2Vxg2B8YJdJxzH6I8Z7N8
         uqSio249cJdmJgvhrvGKVWisKTZ2xKMIXDF8uP/T7LHIhP8kj4A7XH2XKDCanWLB7Mm6
         HMFg==
X-Gm-Message-State: AOAM533iGr5bISh7NgzIVqRNSTqFnZmmwZMmKZP8pwpeVAQ3vmgwzIIV
        b9DBCgLcA22sTctnDH1gZww=
X-Google-Smtp-Source: ABdhPJx7DsRfXOoojfNtACF9jRIonP2Hbfg6ICex5wPgjk205f8KCw4Nx8rWrZ4fspIfF7D8PdtYig==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr10470550wrb.24.1616081229161;
        Thu, 18 Mar 2021 08:27:09 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id c16sm4179827wrs.81.2021.03.18.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/15] staging: rtl8723bs: remove unnecessary logging in hal/rtl8723b_cmd.c
Date:   Thu, 18 Mar 2021 16:26:05 +0100
Message-Id: <20210318152610.16758-11-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
129: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:129:
+	/* DBG_871X("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
222: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:222:
+	/* DBG_871X("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
329: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:329:
+	/* DBG_871X("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
696: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:696:
+	DBG_871X("%s()\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
794: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:794:
+	/* DBG_871X("%s---->\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
965: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c:965:
+	/* DBG_871X("%s---->\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 61fd643c244f..f6c191863747 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -125,9 +125,6 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	struct wlan_bssid_ex *cur_network = &(pmlmeinfo->network);
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-
-	/* DBG_871X("%s\n", __func__); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	fctrl = &(pwlanhdr->frame_control);
@@ -219,8 +216,6 @@ static void ConstructPSPoll(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	/* DBG_871X("%s\n", __func__); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	/*  Frame control. */
@@ -326,8 +321,6 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	/* DBG_871X("%s\n", __func__); */
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	mac = myid(&(padapter->eeprompriv));
@@ -692,9 +685,6 @@ void rtl8723b_set_FwPsTuneParam_cmd(struct adapter *padapter)
 void rtl8723b_set_FwPwrModeInIPS_cmd(struct adapter *padapter, u8 cmd_param)
 {
 	/* BIT0:enable, BIT1:NoConnect32k */
-
-	DBG_871X("%s()\n", __func__);
-
 	FillH2CCmd8723B(padapter, H2C_8723B_FWLPS_IN_IPS_, 1, &cmd_param);
 }
 
@@ -791,8 +781,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 
 	struct RSVDPAGE_LOC RsvdPageLoc;
 
-	/* DBG_871X("%s---->\n", __func__); */
-
 	pxmitpriv = &padapter->xmitpriv;
 	pmlmeext = &padapter->mlmeextpriv;
 	pmlmeinfo = &pmlmeext->mlmext_info;
@@ -962,7 +950,6 @@ static void rtl8723b_set_AP_FwRsvdPagePkt(
 	u32 TotalPacketLen = 0, MaxRsvdPageBufSize = 0;
 	struct RSVDPAGE_LOC RsvdPageLoc;
 
-	/* DBG_871X("%s---->\n", __func__); */
 	DBG_8192C("+" FUNC_ADPT_FMT ": iface_type =%d\n",
 		FUNC_ADPT_ARG(padapter), get_iface_type(padapter));
 
-- 
2.20.1

