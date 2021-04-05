Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABB73545AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhDEQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDEQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B973C061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c8so11440138wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY2cZl4jmtqee28Wid3oWUq3bqH3JHfeDzZ9nthtBOY=;
        b=Y1+T+GzxranPSfFpVG88DfAIeUZ7+KfkL0ArlGPMbbvuK/JYjJgF2+FkQJQgmmtdaT
         ODCuqrDb21sZBjw/2Gxjg4iRFCNzM59rD2FaWNhwgJUYf33TycTOB6dP2lDMV97XGzzC
         u3vsYukqQxQWOSPn1RJr9m2TNvTTCRXkC7NJP2YEA3Xklde4GlXaquLbecJviTlvE1cY
         Zylp3c0SRlo+UQ55FNZE00ioCZCNl8aObrx9N2Eu3kcls0VuTTeOFUh+bGrtOkR6X6zQ
         +UnGD1tBrXirEdtS0+IifmfJQgLqV1S9ax4i8TTR2YrhftviyVcKK1UPGLoyL7PGnfEY
         khvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY2cZl4jmtqee28Wid3oWUq3bqH3JHfeDzZ9nthtBOY=;
        b=fbg773zkyddNmbdXnWsm8NDhMQzbBGnGEBDWuuHsfr/ovxCXLYEu213XuTIYLShOlP
         JcTbXUame7ogh1MTZ7tIzs36e62bLnCntiZF//7nkWkiSnJn2Gho70tNL7sq/+5xfqoK
         3OEtY++ZMwJVhXe2DI9SFq5BJUJLhLsc61gOIVLwJzxWVDmdpOp1vBnNqwWxLnAqkRjT
         +pg0y0EYJjtT/UBtfXenLydJje83L7a5UQSFCaXE/ICocyULcpsi8wjQr/p8MpEjO1hF
         ueGlxuY4323c8F+eVgjAYJ5BWkqrXPRZn2RpNwx1XrUYIGssG20nBItkSj6ANz41AZNG
         yeOg==
X-Gm-Message-State: AOAM533cu3eCuPej6NG+gLhx+g0QjruqSIOfsL669pUcpEBtz9g2Osiw
        d8mFfzfPWVfIVIxXt0cxGus=
X-Google-Smtp-Source: ABdhPJwrABX4IxFOcIS3MXPr0hk2kBOFhli6e4mmcChdEhXzunvTkXDMalAbeNfypfQ7kW/XSxfChQ==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr8154449wrl.133.1617641428026;
        Mon, 05 Apr 2021 09:50:28 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id r1sm35488857wrj.63.2021.04.05.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/10] staging: rtl8723bs: rewrite comparisons to null
Date:   Mon,  5 Apr 2021 18:49:55 +0200
Message-Id: <92edc9da10838dd99f96a99121343f4ec11b5d90.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch issues:

CHECK: Comparison to NULL could be written "!pwep"
147: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:442:
+			if (pwep == NULL)

CHECK: Comparison to NULL could be written "!skb"
226: FILE: drivers/staging/rtl8723bs/os_dep/recv_linux.c:204:
+	if (skb == NULL)

CHECK: Comparison to NULL could be written "!dvobj"
275: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:398:
+	if (dvobj == NULL)

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 2 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 03360af0645d..297287cff5be 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -439,7 +439,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL)
+			if (!pwep)
 				goto exit;
 
 			pwep->KeyLength = wep_key_len;
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 63a7e7fe2bb5..975aceb7b45b 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -201,7 +201,7 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
 	skb = precv_frame->u.hdr.pkt;
-	if (skb == NULL)
+	if (!skb)
 		goto _recv_indicatepkt_drop;
 
 	skb->data = precv_frame->u.hdr.rx_data;
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index f8e1d15f54ef..deba03ad6c6e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -395,7 +395,7 @@ static int rtw_drv_init(
 	struct dvobj_priv *dvobj;
 
 	dvobj = sdio_dvobj_init(func);
-	if (dvobj == NULL)
+	if (!dvobj)
 		goto exit;
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
-- 
2.20.1

