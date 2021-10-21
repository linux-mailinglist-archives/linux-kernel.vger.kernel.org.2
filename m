Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95967436BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhJUUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhJUUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:01:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9327FC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:59:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id o133so1600952pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhB4mSvRCSPt5nKbZ7JtOxkpWZ8DUrHFAW9kstQCtDU=;
        b=AAAQXcYS4Dwa5cXJ0AsuPY1prSnzBTUxtMO0SbpW3dQ4LLAAx84Blg1CD6W0BmrCH4
         ZEeb6V2h4PloL5ciBnk7+A9IeCQX/NC5OYvbGcm6lT4b5rLgtb+ZmUQDKQkyGOUDmiUU
         oj+XzGFhEETurm4YwSi6LcmQn/fcHiRgxMk/CdjaBwSGllxC95uUkvxDzQ+4FLHmWIGF
         9M1JnzBRFj2gMk8ucjmiP7Ym7STNy/Y7IWAI6krLIcNhaa86lvcz0sSlcHP2im7FSPrs
         PAUiJWVy/dS0WVdej/luVMXK2nYrXxQpvfp8TYNyKpPcKVLX1fIwgCY5taMxukQHiYcS
         4sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhB4mSvRCSPt5nKbZ7JtOxkpWZ8DUrHFAW9kstQCtDU=;
        b=PWLhHcjV/3r+McRR8ttL4+aP/AissDBwj3ydT/kSvrUO9QA2Tvoi+AFey8fN2CbbBn
         qez1ln8AfAIVai///czIK0q2Cv/D13TRcg0PEcUKf+/c02wFLn98kKegkTSA1ex9CpEX
         z40ydj7kQ9/S+p7W00nB5ZcXUQTiMhdkA8qNwyZsfmoRAHz82XLPwgxvCsH2tZ1FMYbN
         subTgfe1scjKGeN+XPja8LYoKDn47qGSMmU40aK1UcwaixZi6GLHWRdxqjOfn9jZX+5f
         0guZqdvvFzQWhtVmX8iBV0IRI7TjHbdNbfy2JSSiil8j+uDEftbeOXHFEATpXUZ0K6ZZ
         YvKw==
X-Gm-Message-State: AOAM532vxbNbJLH8cD8Zv3NRhM1eNrK+opzxg6jqdnd/Hk3hUK801GFa
        z2hoqynF0CSjvCntGSVVOC8bDODJB3b3SA==
X-Google-Smtp-Source: ABdhPJw33+KbBlBAljAa0x1n5ovfNQXeAAeyFlPC6oEcs5wKRTgLX3/d+NprSSO4m0gspKNu8Y6Fyg==
X-Received: by 2002:a62:6206:0:b0:44c:bc1f:aa5a with SMTP id w6-20020a626206000000b0044cbc1faa5amr7620355pfb.5.1634846344131;
        Thu, 21 Oct 2021 12:59:04 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1fee:e3e7:7dfb:56c1:efef:3c0f])
        by smtp.googlemail.com with ESMTPSA id v9sm7198898pfc.23.2021.10.21.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:59:03 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, kushalkothari285@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 3/4] staging: rtl8723bs: core: Remove unnecessary space after a cast
Date:   Fri, 22 Oct 2021 01:27:52 +0530
Message-Id: <f350e30b1e09332dff896b6588d962aab9800a52.1634845504.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634845504.git.kushalkothari285@gmail.com>
References: <cover.1634845504.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found with checkpatch.pl.
Space after cast is not needes

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
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

