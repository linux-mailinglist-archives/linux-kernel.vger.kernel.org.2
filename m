Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DE40057A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350965AbhICTGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350626AbhICTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:06:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4AFC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:05:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so88042wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGpbVUpB1ZSjIB26fuOiFReTvqkT22B0vGQOaBlorDE=;
        b=UGQwdB0Rc8yoUmNmflZqPBS78FTs1cSqinvz61E9nY0c4R3txiPd+VdQrWEICHLQr0
         T2SqQL6/vyKrd+lsB2b8yrE7ilCw70DzRpqHHv+zUAgYzSNYow/xG8Iboe0h2lV/eFVT
         VHbQqDuT8WUQ95wMgodEnEXnMHC628dnyXWV8tpvIIRP3n/uls4uML4cBc+G6YH5lxRW
         8vKp6ivGJsyeOqjuFHmVkRtpWrHMKJd5Psm1QIJCdzox4XA9ffCzdGW0f0/zTlzMpHH2
         Wjh+2e+0OGSpSENIbSR+hDbdZM6+XEYBfflkNcZVIjI1+YGu2ZCgQlAdQxpJr4D62czn
         HewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGpbVUpB1ZSjIB26fuOiFReTvqkT22B0vGQOaBlorDE=;
        b=mvIhMsXyWUxmE3NW1gPXIQExtv2ZMN8ycoTHMF1IyMJAqnrlYitexZpwZYZWAQao7U
         Yna+RUWO6gsPdf91PbWK8KA6TCZJKUhyc13aXtHgP+fABlIwUINgv96LojkHynNnKmHX
         YU/TyePh5hCHflyJ/kIxWQ/BVJPiWJ9YqhJK93Ejsx32vQGCHTsMHZWW8DglnpvjW5rP
         c940aaIiJR0Lj3AkQ+8dNm3rdUHIZhr+fKwLZLqtyzpVj8hx3KjU+qkOQXLA5v6d3xwg
         I4Ue5o7dXPth/uc48fJuUi1Z1PMR5OK8xiMrVINYwTcu1zdxayRbA5zEaWDhbBDXEjQF
         y2aw==
X-Gm-Message-State: AOAM531XcYRZobUlkpR2g+5h8qQkW/5HauvfD8WLwDnTohowgpmOAHAd
        2XyPSuTcgIEnU7qP20Pskuw=
X-Google-Smtp-Source: ABdhPJwT63B09dBAz4AI7PHqMXGulzxzHx3OQlhR14HA6hSGApTkooNMFAp2xRQ+l7N9GECwsjaX3A==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr528324wrn.365.1630695902754;
        Fri, 03 Sep 2021 12:05:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::848c])
        by smtp.gmail.com with ESMTPSA id u25sm229291wmj.10.2021.09.03.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:05:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove rtw_use_tkipkey_handler()
Date:   Fri,  3 Sep 2021 21:04:44 +0200
Message-Id: <20210903190444.15585-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903190444.15585-1-straube.linux@gmail.com>
References: <20210903190444.15585-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_use_tkipkey_handler() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_security.c   | 19 -------------------
 .../staging/r8188eu/include/rtw_security.h    |  1 -
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index a7f769048a44..82987255400a 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -1568,22 +1568,3 @@ do {									\
 	d##2 = TE0(s##2) ^ TE1(s##3) ^ TE2(s##0) ^ TE3(s##1) ^ rk[4 * i + 2]; \
 	d##3 = TE0(s##3) ^ TE1(s##0) ^ TE2(s##1) ^ TE3(s##2) ^ rk[4 * i + 3]; \
 } while (0);
-
-/**
- * omac1_aes_128 - One-Key CBC MAC (OMAC1) hash with AES-128 (aka AES-CMAC)
- * @key: 128-bit key for the hash operation
- * @data: Data buffer for which a MAC is determined
- * @data_len: Length of data buffer in bytes
- * @mac: Buffer for MAC (128 bits, i.e., 16 bytes)
- * Returns: 0 on success, -1 on failure
- *
- * This is a mode for using block cipher (AES in this case) for authentication.
- * OMAC1 was standardized with the name CMAC by NIST in a Special Publication
- * (SP) 800-38B.
- */
-void rtw_use_tkipkey_handler(void *FunctionContext)
-{
-	struct adapter *padapter = (struct adapter *)FunctionContext;
-
-	padapter->securitypriv.busetkipkey = true;
-}
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 8ff583cdc0a6..9bbda86a6641 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -341,6 +341,5 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe);
 u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
 u32 rtw_tkip_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
 void rtw_wep_decrypt(struct adapter *padapter, struct recv_frame *precvframe);
-void rtw_use_tkipkey_handler(void *FunctionContext);
 
 #endif	/* __RTL871X_SECURITY_H_ */
-- 
2.33.0

