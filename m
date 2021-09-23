Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85964165BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhIWTLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242988AbhIWTLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821CC0613E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so20154130wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXCipzl9B56mKxod5ijOn6eiX+PEO+AJkhtqSl6kGI4=;
        b=ZJzST3r+CA9lBGzY3CaQqlpPJx/tgcQlZpizV1JlmMNPOENwdZxOqZRHI81+0L1fd9
         ATgQne5y0bS0a3y5j6vSkxcgEHBUVfaWZuKOmRIjSOU52YucmLCkdNsPr+m3nT3jL/ZB
         9kfAsESrfYYi71qoW7cZkVLrgba8Hw+Qt6B0ubus5YKrRT7+koeaCI1xvHhTdL4o/Num
         +A1aiGyZ08YdOMd/RH6qYS2X6CKf/hz8LNlhDgk5FaEQn//BAexgDhG9IlJRLPg/t6qg
         jhrFJ1C25WdrN/1JD0W43e7tkMaTo2edroqUKKCr/BwisY2Cx4QJtuQnhHH2N69NSR/X
         AREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXCipzl9B56mKxod5ijOn6eiX+PEO+AJkhtqSl6kGI4=;
        b=V1DhfNw6lvbz7gt2ley+79vRFyohjqEk1Mkss+A1rmaouzeKwFNtnIgpTLyNSvdMOs
         KnCM+1nY8ZUSxNX3IsgjQQIfrNcnIeq/gKyYO0Wz3ZwSPWyPcyYi1otW9kSYI/yK7tW8
         iUYIlG0U4ZFosqygrk8Eugs83H1HuRZVVJM1rgXmw0PzT2M2WvISimPrTyJIBMJQGUoC
         eSOAkWiFr53DcwXkQOhIhrdET2WFDjR6bLYsVzAJA1sz5YYprn+YrXYyQH0wagXysHug
         sh6IDyWB2EjKuCv9W0uL2wN9aoByb8epKONJn6D/HUvfIkeJDVcQTWcRe/vrhagB+WaX
         JnOQ==
X-Gm-Message-State: AOAM530OKj7jkm0a4aUvYIEz8nJwZWXPYN9xmP2z3qS9wF35v9VhyipR
        je9V/jP76iMHSqr/b4V0gcw=
X-Google-Smtp-Source: ABdhPJwEve5TqBZzzuhVP3S+YKCIlu/pqB2yEWi+lrVE6jFUbCD/aCs2n+Uost4KUD7uZqe/18WTWw==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr18334524wmg.88.1632424181658;
        Thu, 23 Sep 2021 12:09:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/17] staging: r8188eu: remove rtw_setrttbl_cmd()
Date:   Thu, 23 Sep 2021 21:09:18 +0200
Message-Id: <20210923190920.3580-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_setrttbl_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 30 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 52edf3def405..d8acc6701248 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -815,36 +815,6 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue)
 	return res;
 }
 
-u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_table)
-{
-	struct cmd_obj *ph2c;
-	struct setratable_parm *psetrttblparm;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-	}
-	psetrttblparm = kzalloc(sizeof(struct setratable_parm), GFP_KERNEL);
-
-	if (!psetrttblparm) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetrttblparm, GEN_CMD_CODE(_SetRaTable));
-
-	memcpy(psetrttblparm, prate_table, sizeof(struct setratable_parm));
-
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-
-	return res;
-}
-
 u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 {
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 9ec0332e96f4..8895874a654b 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -756,7 +756,6 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
 u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
 u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
-u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_table);
 
 u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
 u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
-- 
2.33.0

