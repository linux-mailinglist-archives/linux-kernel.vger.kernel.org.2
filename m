Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E714377CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhJVNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhJVNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:16:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1968C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:14:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso3570924pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QweeGM4aqSjgNfs+asUhXTu86Il96HRIIEZ/a5PtZnc=;
        b=NT/km3+Yigt6OoB3H5RMs83c7Xs53jjfJWSfp3YsEmB7d21FlEhj6UDGVL+1qxPZOZ
         rreraVJGG5bJb8Cag8FMSLF+kiMNBJwOl3M98H0iXngcM0rl4rwjM1UiI3OGlwtb+Mbz
         LWqCDuUg7RRZ9uiWxilThsJQnIWMuxloomtrJGE8vfDTo51Ee4Fx6PAsRa5h8NboGVLz
         SUkZG2Km1ARlwGczRbDNYza/u1rFnkUDkafCan06JQTKQY8tziq9LZERoVUBlPRqbIbD
         XeS6Qedoy2HxmK33ecPec9hEQLjkTPtI2+6X1VyvPSqEbsPyHhQIvRsPY01KFWIq9jAB
         b3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QweeGM4aqSjgNfs+asUhXTu86Il96HRIIEZ/a5PtZnc=;
        b=rg+ZoHJTpLTGUf1tYT3vzvrS52jwm3yXu2uVTuquoCjh89i9SQpVJmqstZzTk1oi/e
         h+ZJNe3MCz3yX6i6vh1BqMG4/PVDQdKX/Tc8o7Lz+2HWz1xu3idpawd5XuzBDQ+Aal9a
         vGIOS0Yxu6zlNsnfirVlDTIalf5WgAzrw34VYRIycnlBHgI+Rav65q5DR6xGBUjTaGbf
         sYh84Qsi4hE+BldqJpvXW2NFxnO1CVfo1hzDKgXZ3IEcbhTcLwMJ1WwGb2pVWvG4egKT
         AEXhSOlRUnzem2gp8OXgqJIzo13ZdanRoP1zXGOd1koCLz48YpG5RK9Rfb8dCh/nmRbr
         JovQ==
X-Gm-Message-State: AOAM532GAea4nnBPqUvYB5N/8wv/jQeFarqtW0aUe0iZS9Pnq0rjYgjr
        TDsVybDBz3C/IlkxOsV2t0E=
X-Google-Smtp-Source: ABdhPJx81G2JMJus9PahAl92Dd51u6CIUCMLFeBrW5Z7J1nbTqnAGzQDagcI/XDRnMm/l9qDEdDb3A==
X-Received: by 2002:a17:902:c410:b0:13e:cfac:45ad with SMTP id k16-20020a170902c41000b0013ecfac45admr11505841plk.68.1634908447432;
        Fri, 22 Oct 2021 06:14:07 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id mq3sm11932413pjb.33.2021.10.22.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:14:07 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     kushalkothari285@gmail.com, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: [PATCH v3 3/4] staging: rtl8723bs: core: Remove unnecessary space after a cast
Date:   Fri, 22 Oct 2021 18:43:20 +0530
Message-Id: <528ac3f0fa7b164fe3c2a86d2476dad0f23f7181.1634906059.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634906059.git.kushalkothari285@gmail.com>
References: <cover.1634906059.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>

Changes in v3: Enclose the version number inside the square bracket.
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

