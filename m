Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E403511E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhDAJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhDAJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A4C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dm8so1167494edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRu29DMfgjgESM/r4ngIdYBCudXkF27Ad4jVLeKHA2o=;
        b=SagP9juGlx0d8N1URCqzoKr4uIwe1e1lb0D09qxZyMnQDc9VEto+da08oaiKoXZV7N
         l2/o1aI/uAkTDefgDez0S9WmqyDMjdeMTRhtwn3CZL92/fRlMNp2k+/WfPnVrgUG3PcB
         sGumwAThB3rDhOyp4fotCZYjxqTdiW+pgEoEaQToMy+fZFyVWHHMFarj8F3AvCjt43Kg
         lSxHBbDZUYJlehNQG4l8UdeWbI/g42UHrSt0cP3l40JKZK3LIi8JG7AhDd/CTQRL9Fkz
         uA47UkPt2SEIoVi397YaSeWGubvC5PnUe2sHWQr9bywE7kAEGQJ047unAIEzyUU4ipCK
         Zz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRu29DMfgjgESM/r4ngIdYBCudXkF27Ad4jVLeKHA2o=;
        b=R0U5lFpOYfcI9fe2Ik7eM5w3Ssg7/hZVNikQ3DolIso8SZUkRl3TQi7P9q1au1mKT8
         B0X9YTq8pyjTH1IHQp9W2gX6+DEva+8bHlZ1dkaFe0AxdVeuxXqb6HS3wBrAxr+M88mM
         UFxXx9lhgZCJfd1mDZ9lzf+NFeqweBy4XPonFM1P6M1kYRVUnQ9/aQhrjAkVVb1WYR2b
         vakPwJU7A0eeyVg1NmMRBlMpucV/ag/auDDI2wYCZtzsYI/g4di1z4vN/E3th6muktz6
         eFa9Dq5H8SY+ergWDtRAXkmV9pRnX5ixxoknzYl9oaWgsaxlq3zAhQQFLdKXZEmIS1fk
         8W+A==
X-Gm-Message-State: AOAM532LP99oZjQ9mgJLMn4kyaPrvHKXeOZhwCSkEXn7W3dQT3T0fKp+
        wi6214kOpIGt11vgYgx0P8U=
X-Google-Smtp-Source: ABdhPJyurGqa9bX0BwPFi/uwuofzVZBrk2ngT+9mrfk1hczIv/7ZHgZ6RVcVVcEWb0Vsi8uplP/Hnw==
X-Received: by 2002:a05:6402:168c:: with SMTP id a12mr8867493edv.344.1617268897592;
        Thu, 01 Apr 2021 02:21:37 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id ha5sm2482266ejb.39.2021.04.01.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/49] staging: rtl8723bs: remove empty if-else blocks and unused variable
Date:   Thu,  1 Apr 2021 11:20:39 +0200
Message-Id: <f76f909bb92a95bc538a5db1173364e3b401397e.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty if-else block,
remove unused variable as well, to suppress the compiler
warning:

drivers/staging/rtl8723bs/core/rtw_cmd.c:
In function ‘rtw_createbss_cmd’:
drivers/staging/rtl8723bs/core/rtw_cmd.c:661:22: warning:
unused variable ‘pmlmepriv’ [-Wunused-variable]
  struct mlme_priv   *pmlmepriv = &padapter->mlmepriv;

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index e143f89ea39e..e6d507ed60c5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -658,14 +658,9 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
 	struct cmd_priv 			*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv 		*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex		*pdev_network = &padapter->registrypriv.dev_network;
 	u8 res = _SUCCESS;
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		;
-	else
-
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
 		res = _FAIL;
@@ -751,10 +746,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	u32 tmp_len;
 	u8 *ptmp = NULL;
 
-	if (pmlmepriv->assoc_ssid.SsidLength == 0)
-		;
-	else
-
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
 	if (pcmd == NULL) {
 		res = _FAIL;
-- 
2.20.1

