Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB724165B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbhIWTL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbhIWTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CAC061767
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so20158328wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ft3bNDgT8B4W6g5ne4vHNsmYverSTcCb65Lz7xgYY8=;
        b=Nc4GZg2C9kgkHmghD+zHSlCoYLkBCiIlWl7EN7uOp4XFPwg4xp4HN1eNnWAZgFcZ09
         R3nfG4pVVEoFiuNybmuEQIGPXhWiFu3lbV3NUTeGINHEdBieCthKORapJJfbGHDjcq1A
         jD86gvecjydPtZExzRYFdWRQiaeLzBjoX4Zyhna37LhrIjl/kDVtvpdWGQlsumxMtC5s
         C/x8AJh8t7GpV1glolFLmYdSSwlIHJF1IiepyyiwNP3o4wWfQBkrBtBhklKeIJcqKxL/
         CRcXYGh6CBGTonUUSLMHiYn/92EnugHZBONMsljRZal+v4VbR6Op79UecXyODPhQxMqD
         eDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ft3bNDgT8B4W6g5ne4vHNsmYverSTcCb65Lz7xgYY8=;
        b=AgDMdFErIcrfQ9uFX9VpNd23M1mLxJ83XLiIjOridv2rZqNYxzR5tSE7YEtEc4UDsk
         R7lsCWgEuGSv0QV8ne5priocRrIgVJBl/6sA4bNdHB09WPL2iMJV/LE2g9fJKwhFeSsU
         gv4CMFdQlYHjIEXbF9it9OeNtXX84glFinFeNJWeYIPFSEoGNibDaGv/O+w7BbL15s+n
         Q8PaquVVTQlR3tsQlOkfAGlzam57yYzPCFizPG6LL6iAQzj9In9gT7iFX2dMCU+/eH1Q
         Fgrn02q3D6/lxmYbYV+zbHUM77mMW07YfhvG4fRg3kczEpQ1a1V4oXlN7Udbe0EL4uyr
         nNmw==
X-Gm-Message-State: AOAM533knvFULImFmCpKoVW4FlsktBg6R7KeSkPZge9kLP/ZfN8EL9hw
        hzLfOkm/8pwKgiH+WiEm4hw=
X-Google-Smtp-Source: ABdhPJytoltHNrNXwCxE1DrHQjKYXWPtUIusEYct+oIUbbNb9/a295TXwlAabd4ltY8hid4HtIz29g==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr17301400wmg.184.1632424176677;
        Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/17] staging: r8188eu: remove rtw_set_csa_cmd()
Date:   Thu, 23 Sep 2021 21:09:12 +0200
Message-Id: <20210923190920.3580-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_csa_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 32 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 33 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a10fde30dc69..c7ac4a100367 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1136,38 +1136,6 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	return res;
 }
 
-u8 rtw_set_csa_cmd(struct adapter *padapter, u8 new_ch_no)
-{
-	struct	cmd_obj *pcmdobj;
-	struct	SetChannelSwitch_param *setChannelSwitch_param;
-	struct	cmd_priv   *pcmdpriv = &padapter->cmdpriv;
-
-	u8	res = _SUCCESS;
-
-	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!pcmdobj) {
-		res = _FAIL;
-		goto exit;
-	}
-
-	setChannelSwitch_param = kzalloc(sizeof(struct	SetChannelSwitch_param),
-					 GFP_ATOMIC);
-	if (!setChannelSwitch_param) {
-		kfree(pcmdobj);
-		res = _FAIL;
-		goto exit;
-	}
-
-	setChannelSwitch_param->new_ch_no = new_ch_no;
-
-	init_h2fwcmd_w_parm_no_rsp(pcmdobj, setChannelSwitch_param, GEN_CMD_CODE(_SetChannelSwitch));
-	res = rtw_enqueue_cmd(pcmdpriv, pcmdobj);
-
-exit:
-
-	return res;
-}
-
 u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option)
 {
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index bca7a0dba601..0881c9b99dac 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -780,7 +780,6 @@ u8 rtw_ps_cmd(struct adapter*padapter);
 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
 
 u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
-u8 rtw_set_csa_cmd(struct adapter*padapter, u8 new_ch_no);
 u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option);
 
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt);
-- 
2.33.0

