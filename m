Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33829353339
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhDCJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhDCJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05277C0613A5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q26so847309wrz.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zv6blgVUmmcg0rrTba28HSVxaCH1kZzMtYvEm8Uvvjg=;
        b=QwMUK45sJB1AoxIsZTJePadnQG0x8fzcg6IQe88ZSQ0dPC98Ug8ehoSPGJhmJ5IdU+
         FyASs/QBumX24NezXi9V3jrfyN5Ja6axWdwuAMbjvbPv+LYECcA6DCr4UWSYVaijDYi/
         EBsEmraTl7RY589ckauLuDbBHg15wrs37DGoZoRpxQKFh95OKc3F/Zmbd8o+QnkJ46g+
         r0zagdZbiaTiVQLvMPtLUBlORVdtkwuuATcvx5cdz6080x6yaOG+ma+fLWZL/wI8clrI
         o9Oc62Zp2rQesiCVywEUxbtbr6pWmU/o65CMTsP5g1jOdupIDXQ4CEi1/iBuYL0rL/tb
         F5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zv6blgVUmmcg0rrTba28HSVxaCH1kZzMtYvEm8Uvvjg=;
        b=Xh5VGPra04Ff6iTx/bQXhru1lBGvx+X0f1qWFEfxMGGlmWlA0ULyBFvA8bQmZtkj0f
         kZWyjmYe3WpZh1gV9z0NGYm5ZCVer6KYRJ+TLcG3fXqBPSptAyvHZWM69HCfcYw3cNyK
         LttOJL3U5sgB4gdwMyOSlMAXtTCCZkhUDW3VWXHPvPZ/wh57VydBuTCw0jpe1QeXXgzU
         VqGEp6jFrwjL/7gK0DIoXQ53eADBo88zBaUEpBYJlfQb9hJ0UWAcH2RNN4xn9rkzP4yy
         nLO7PPveQRQ58Bm5wDzkQR+TBUjx65tygqG5lzPzhOAndvu6y++sQPgDBQvGaIoVThXa
         z6jw==
X-Gm-Message-State: AOAM532GPpjZ+PVkP8tG9ruo/tGMHCxxM3+Ud/bAtXxmxW3DQVyGb8yY
        /8ifhBAFg06jvuzaObMHqM8=
X-Google-Smtp-Source: ABdhPJzKuayUYrFevfUBNHgJr+PnRG3hfvrwzpq9VqD1Y+JvaVgDUq387IyxV2MQgtP/EWkZEgkVWQ==
X-Received: by 2002:a05:6000:10cc:: with SMTP id b12mr20078560wrx.29.1617441285784;
        Sat, 03 Apr 2021 02:14:45 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id m11sm17958154wri.44.2021.04.03.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 20/30] staging: rtl8723bs: added spaces around operator in core/rtw_recv.c
Date:   Sat,  3 Apr 2021 11:13:42 +0200
Message-Id: <7f5152d0cae2d6624fc00471db2178f9046578da.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

CHECK: spaces preferred around that '+' (ctx:VxV)
60: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:359:
+				if (miccode[i] != *(pframemic+i))
 				                             ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 2d749341d47b..953351f896c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -356,7 +356,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic+i))
+				if (miccode[i] != *(pframemic + i))
 					bmic_err = true;
 			}
 
-- 
2.20.1

