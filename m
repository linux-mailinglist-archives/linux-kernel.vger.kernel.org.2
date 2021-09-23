Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A374165B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbhIWTLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbhIWTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC94C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so20061250wra.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vBZp68Yhk5l6nMspT4ibXT8y5p8fYROMJidP+c50QI=;
        b=grBf+Tc6UZl9uIjyBXhKCkDh4KCST25IOAS8FUgilsnCFYjAgMxdtggbvxZCy0k0jY
         7ZAT06kza7bjMvvBr7mlqa+VCaGUpyNd4MbK0XrciFgmmJzUL0YgYbdmK8G/2VwkBclu
         qJ/2Qpgmyas4J/XuHP0B6Von3OGXL4E45aaXVUO5JCwA3I4SNzvW9Qbpl92ZXMeHS0r9
         irUJj5N2Z+P1Mp3cf4WqjttoftY9hmH0dK2a2Iwa1WCvFF2E2LE3Evt7AtKdiWDvTxI3
         ohbLZiHg6A6Fp1CQn/ZvkvKNvaldP263/qfLsJJpOcYtWdrgwqvuYeJoNajIciDnTHfh
         obmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vBZp68Yhk5l6nMspT4ibXT8y5p8fYROMJidP+c50QI=;
        b=xbR04VsShIsEzn9jToQgyf/1cUfyHiWaB2wlssYb3xJBCOB5nEZ4/arbQUdToTOf+7
         wesYlaqz5VMuc0wnzPgAPqe0hAAnxrerhqu8r+ZNsZ+ixOWErVfWE2Nxu9sW7CN706Qw
         Fx3jN9BtlTF8fTxhDmeOi0jOnQtGWUwZFfrfo3/ZfaFuI5fFcmooHD8rrTySNJBqZSJp
         MDsMyAm6x+/O5Z/w3EvOyjiGHNFf0+JX/+FCAAEjAw19H8KFbNLG1DCJuY4hoYD7UPha
         1hd3dabx/sKa6yvgBtOpqt0M41shJ5lXwH39DCKGePGBuYCLFd0xIT6wASxccqPg40M6
         4YDw==
X-Gm-Message-State: AOAM533hIjyhGTrc5T3cvoBzSGivnKA+wuqMQNDon0PjdsY1zOWjz32T
        tLabC93u9LzXWQtSYq0dQOk=
X-Google-Smtp-Source: ABdhPJzSqVM5NAYB5oVzcl0SEd2/+oZ6WAlv38jMoS8e+cPztWyRithvPHVzYPQxiqxQjjbdvWGO8Q==
X-Received: by 2002:a05:600c:3b1b:: with SMTP id m27mr17668777wms.15.1632424178166;
        Thu, 23 Sep 2021 12:09:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/17] staging: r8188eu: remove rtw_setbasicrate_cmd()
Date:   Thu, 23 Sep 2021 21:09:14 +0200
Message-Id: <20210923190920.3580-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_setbasicrate_cmd() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 30 -----------------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c2be84b474f9..01e3fcaada3e 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -475,36 +475,6 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 	return res;
 }
 
-u8 rtw_setbasicrate_cmd(struct adapter *padapter, u8 *rateset)
-{
-	struct cmd_obj *ph2c;
-	struct setbasicrate_parm *pssetbasicratepara;
-	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
-	u8	res = _SUCCESS;
-
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (!ph2c) {
-		res = _FAIL;
-		goto exit;
-	}
-	pssetbasicratepara = kzalloc(sizeof(struct setbasicrate_parm), GFP_ATOMIC);
-
-	if (!pssetbasicratepara) {
-		kfree(ph2c);
-		res = _FAIL;
-		goto exit;
-	}
-
-	init_h2fwcmd_w_parm_no_rsp(ph2c, pssetbasicratepara, _SetBasicRate_CMD_);
-
-	memcpy(pssetbasicratepara->basicrates, rateset, NumRates);
-
-	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-exit:
-
-	return res;
-}
-
 /*
 unsigned char rtw_setphy_cmd(unsigned char  *adapter)
 
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 6a8dbfdf0bc4..bb6163941742 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -756,7 +756,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
 u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
 u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
 u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
-u8 rtw_setbasicrate_cmd(struct adapter  *padapter, u8 *rateset);
 u8 rtw_setbbreg_cmd(struct adapter * padapter, u8 offset, u8 val);
 u8 rtw_setrfreg_cmd(struct adapter * padapter, u8 offset, u32 val);
 u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
-- 
2.33.0

