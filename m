Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41303372C85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEDOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhEDOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:52:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4DEC06138C
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 07:51:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f24so13615163ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=KPJ06GykRFITdlNEv2SiENZ1qS2NqNVmwqkaKf/QGA99iaVZKrMGifOeIwaTATX3pO
         Di5SzTE6Gk/QUoHbPgsk74gGIrafT5BRRzyNcLhwMOMcRt3RSAZOa9+5dZnbUy7Ll9WU
         w2hJdbq3gombr2fKfxErzj4+obEUIr9b13gBtYry5ghI6X4pjB2OV3nT+CPElcek7NjP
         2ksMmZryQZD1YaqGYttYkiKtB9idzrwbAhvWZFUGGnC4M7QS8gqHFNibLjfiMvmqHpH6
         DjZlVDILTl3NvIuhXZVTVRbQjULg9q6UGechcvxONdxuKnyfghCtQyEiGhgN5/kRcdCp
         dQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXRitWWRRFW0ojzwHJ4zpfVrafyqDHpLGDB/FMLEkjA=;
        b=JrDWQzDxQ+NIpJZXCBUS/9jEIz6g4p+fdDz9aFY+5y5SqRQanBhur9H8gIqAo+jQVe
         gNeKZt7ogzGNRDZw4+rVEL53H3ybfbEffgnTgs3wJXjmhOn+RILTOGQ2jRMU9yFrDDeZ
         x+XvtRX3WqOx2fOC0rjMM9QzdFyvZ+2bS1qmaVlYmwu1VUqqpiTq6qGmiDGfqJuM57j7
         +mPi6adO3soCKpFH00jAKZWmc9bMNnm7d5ChiP6Q8iwrUrEXOQUht1IESebyi8sgeKZA
         lSExucmFwPvgB7+nyZ5sLurh0U8SJu0joaFT/6Cj8l940h4nvFDoVbit8JCADCdF+pBO
         C0og==
X-Gm-Message-State: AOAM532WioKwyhpAkoBmFphU13mWygdDNMTVsYCrf3Xtqmev7XxyE1wW
        p6aKtCAqDtHqo4fww8uqFCrEnMvseY78vg==
X-Google-Smtp-Source: ABdhPJwbeM1BHUhdBCa8Z9fGtMiQ2Zf9JgIOajJHeew+miB64OV87e7Am4ta9iBCuApKJQcvNe7hpQ==
X-Received: by 2002:a17:906:17c8:: with SMTP id u8mr18317300eje.57.1620139904195;
        Tue, 04 May 2021 07:51:44 -0700 (PDT)
Received: from agape ([5.171.72.210])
        by smtp.gmail.com with ESMTPSA id q25sm1523792ejd.9.2021.05.04.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 07:51:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: rtl8723bs: align argument position in a new line
Date:   Tue,  4 May 2021 16:51:38 +0200
Message-Id: <f195bc7d72c122e5e16b3857cf99ae1f84734915.1620139727.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620139727.git.fabioaiuto83@gmail.com>
References: <cover.1620139727.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

align function arguments position on a new line to
open parentheses.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index e4f3049ac351..0cb603aa4ee6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -2056,7 +2056,7 @@ static void aes_encrypt_deinit(void *ctx)
  * (SP) 800-38B.
  */
 static int omac1_aes_128_vector(u8 *key, size_t num_elem,
-							 u8 *addr[], size_t *len, u8 *mac)
+				u8 *addr[], size_t *len, u8 *mac)
 {
 	void *ctx;
 	u8 cbc[AES_BLOCK_SIZE], pad[AES_BLOCK_SIZE];
-- 
2.20.1

