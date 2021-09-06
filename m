Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AF5402011
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbhIFS5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbhIFSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9369C06129D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h9so15110028ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=LNdzJzddMn24GyNR1FVqSJ3QHORwEHzxwAHPDi52yMvhBDilz6Ss+vGO0GLCQRoesq
         FVTaLrFJZXs9v2Ms8EvmzNW6lth6Ncfex59B3t37qbJO56/blu1pqsZUwepONDN9CTCB
         6a01Wj/1AEl0ZMpeKqlc2xn0xEZtBWa/5FLo8S0HYDhdk0vTdt3pA6qfxpUePEa5vaOY
         39avMS1E/upFRbq1YPJzIYyUHbbbZyo4PlS8vP5vCFd6svCox5gtcm9UF5Om7OFOXU00
         8pvku694quC1CYnkBxHUBKT1EMU4JevTuIfwFcpAgYECSGmLF3Ys8t2Df9tcvaeRB8eF
         1vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vh8+u22pNgFmmQDYhuLqazbVUqiifTDWeSKfb70Q1zQ=;
        b=JpToInvlPLVvj4YS8h2LnI75jMG5ThOVec+0lse14H+iRtkyveiTyFtYX4Z21J0dlh
         OKdFyp4WWiRr3+N47folNBhIKoLqJTuS0JaYBHx0rUnIE0ZQAYcN0Qieduh1XpqvNenk
         GUTy2KTIpRkyAi2Up+lAfgs0U1a/ZazZPAxa/9Z0E7aXgenHINe/tkCYX5x/IqmgP3Ec
         3/SCLBvVedJEeeeJds2W6iEfHHjMeWmul9/sYeM+/o1zx7uNETliSHp433UPJfLncVtD
         f/Yim3pQGxYbvgsm5yf7xXjK35vHvSIIh1ItVFf4YFWwOROexjONAuf1mGJVoY6OwJ2T
         MYkg==
X-Gm-Message-State: AOAM532uVI73hm1tmnH2SiJTgbfvvGDbikbgQAVpaeb3jJ1R+GCSMpP2
        Z5rFzHTyytRRsu121TBu9MGEvLsUYOJpZg==
X-Google-Smtp-Source: ABdhPJzx/Kt8tgEmR5LYzWvqrw8nIa84yfuuCBdma4lDuuE14PVPxAR5+Ai5KrSOE8cCYfnZbze+cw==
X-Received: by 2002:a17:906:c9c2:: with SMTP id hk2mr15318173ejb.328.1630954470478;
        Mon, 06 Sep 2021 11:54:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 38/40] staging: r8188eu: remove unused function rtl8188e_clone_haldata()
Date:   Mon,  6 Sep 2021 20:53:25 +0200
Message-Id: <20210906185327.10326-39-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtl8188e_clone_haldata().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 22750cd40d45..760ca114a7cc 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1741,11 +1741,6 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 	}
 }
 
-void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_adapter)
-{
-	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
-}
-
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 40bc00a9b23b..13217789d495 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -438,8 +438,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
-void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
-
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
 s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
-- 
2.33.0

