Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870FB43761E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhJVLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhJVLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:40:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d5so3398975pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rccfm12KpSvWMnfVMFO4QKNXNCfzMa0oV3Fo5GIqPt0=;
        b=iqI03UhX5hT7fF3H0iiH3I5GYZpNeA+i0X7rTuDM7HLJQ/3FM4vfNLuXwVTTHgk9EJ
         uppdEkgMh16sH68w72mUsFc0Udv/wqv9y4l1JYmN4newEPyG2E+vIwSIMno04hWxw0H0
         Ya64lNEsF+FgE201TgwiY3vrWjZllECqimTXhoE90M3740d3xYcmAP9zmvcp0QAytvC0
         I3cEILn+eW8hMMYOErjQon6ktP9bT5tUFq/0fD2dISqNFNgMUCcffrr2giMyNEU19L25
         ETceSUS0n9AvVHLbEVeiPoK0eng7d7y0dWX8skISjThvQVjZqtZf5TvmJjtb9hajINH5
         BPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rccfm12KpSvWMnfVMFO4QKNXNCfzMa0oV3Fo5GIqPt0=;
        b=FGxelwLoTWQkmYCodZI+XG110VUIDOhZbq+hllfVWcogXIl5s3+PvtK73eSLNxVlcj
         E3bxZsGE/7XyXOVTvn45rzxR7YXRXjow1K1oaZF74mjzG4E3q78I8ve8Rr+UVu+HXKXj
         Gdpso9cn/eVKMcWyMQSzuVuWw3WBygFw8gtUOOHElePPS99mkQO8U44+mNBk0MjciTl6
         uealtgZAHLOuKKPKmCEizz1lcvPL4jbBYM4oOo1iQKnJDwWKnaY0hZcfIsYb2jkacbmW
         jRpVLbiqjVh5Zf8DhHbANOejIVdOP81TnsRz6w7Uo+l7mw13TqLr4pGNnRyjieefqMpX
         nlMg==
X-Gm-Message-State: AOAM532dM2qgjVaMruwKjytcENIZhklFGkoEebRogpE5uhBnwFBzYtBd
        kXsvHF4pOp2nl8NbjJTbymc=
X-Google-Smtp-Source: ABdhPJz+gSN9a9JxjraI8gn6J8uJMUJKpQG4Kw79ZWkTve2qhiLVoDJTeZXpnlt5ASD893PbIfUsxw==
X-Received: by 2002:a62:7904:0:b0:44c:ca08:1956 with SMTP id u4-20020a627904000000b0044cca081956mr12118844pfc.47.1634902713133;
        Fri, 22 Oct 2021 04:38:33 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id t22sm10946224pfg.148.2021.10.22.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 04:38:32 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH 3/4] v2 staging: rtl8723bs: core: Remove unnecessary space after a cast
Date:   Fri, 22 Oct 2021 17:07:37 +0530
Message-Id: <859fedf8146c92b17295a40044007de9dc479525.1634899405.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634899405.git.kushalkothari285@gmail.com>
References: <cover.1634899405.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>

Changes in v2: No changes
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 88f6b7405106..fce3256cc275 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -922,7 +922,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 	memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		psetstakey_para->algorithm = (unsigned char) psecuritypriv->dot11PrivacyAlgrthm;
+		psetstakey_para->algorithm = (unsigned char)psecuritypriv->dot11PrivacyAlgrthm;
 	else
 		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
 
@@ -951,7 +951,7 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 		}
 
 		init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
-		ph2c->rsp = (u8 *) psetstakey_rsp;
+		ph2c->rsp = (u8 *)psetstakey_rsp;
 		ph2c->rspsz = sizeof(struct set_stakey_rsp);
 		res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 	} else {
@@ -1002,7 +1002,7 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueu
 		}
 
 		init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, _SetStaKey_CMD_);
-		ph2c->rsp = (u8 *) psetstakey_rsp;
+		ph2c->rsp = (u8 *)psetstakey_rsp;
 		ph2c->rspsz = sizeof(struct set_stakey_rsp);
 
 		memcpy(psetstakey_para->addr, sta->hwaddr, ETH_ALEN);
@@ -2027,7 +2027,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 {
 
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
+	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
 	if (!psta)
@@ -2042,7 +2042,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct set_assocsta_parm *passocsta_parm = (struct set_assocsta_parm *)(pcmd->parmbuf);
-	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
+	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
 	if (!psta)
-- 
2.25.1

