Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2EF34B7A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC0OZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0OZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:25:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B4C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 12so4371513wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZs3dNT9UWakhsTbiMCB3Wvkb6oFdQ1r8pcWmig7jjY=;
        b=C9fCJYstJj7CbOqKdDBp60KrVwyfq2FGBkX1zsfPZNuwcVqM8z2mVte4BKu40ArSql
         9Pw0XdtjkBUA/HNtnJ4bVj8fxsdmjURcbO44QS6xpRPgBFrx6blhlWr3MepwSRnjAzmV
         rFLj0Kie7lSCvT5CNQ3VzfW3yhR6Ef96Scfh7FrS/r2bKKWG6g791Etc4gnCvN4hUma8
         XQP/1XDHuY6IOuCzdSHv6E4hXP9BQrlSi8hMTEATa0o+xRLyW/EllzQq0VjE0WW5JOJ3
         mPvGoRVV3SpMj7hisbZGaDjTxgS9tIItSkh3UjPTuZArP2Dw3ekArvnbBmL0xpffNo7w
         TcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZs3dNT9UWakhsTbiMCB3Wvkb6oFdQ1r8pcWmig7jjY=;
        b=QlTwvSdeuvV5LshiZA5os26L2m2CZJj6p2csML0wrJeGbGKEZmUHU6cENKGGII6kd3
         4YNPpnxMXHq9WawanCepaMMQzOM8F7SzC+poGxwlIPRx678s0kdi8VsO4BG+b79ZUAqp
         s+mbeBLw5Q1eKxP0BiqFDRS8vFp8RhCznnp2Np3tFsCabYbno/+FYXAtd/q5hHCmMWMD
         eIngppPEb2a9WZ9n8GHzl+6PCELfb4LdXs8jrf7e1XBG83jkGc3pZAF8eUHtp9OpMRnb
         FsPZU+Jp4xQp7TKXYjOlQGUIPAB9wdgNExHF7lCn0yGrGEPmTzAoE4XM8LVB5NuvKv6X
         X7ZA==
X-Gm-Message-State: AOAM5325obNcmCFv7TC2H4TcK8IO582bGACr7V8is3NdKy82JHPVzDqP
        TH4qQ5ksf73EXW68pSlo6KY=
X-Google-Smtp-Source: ABdhPJwjwck/w27yLLLbvTWh+mKMy4ooh6xCxb1Twm0F22kBoIT8e7zkt6+rY6snoMjrKHpNC5y2XA==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr17308862wma.167.1616855121029;
        Sat, 27 Mar 2021 07:25:21 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id w11sm19298209wrv.88.2021.03.27.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:25:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 18/20] staging: rtl8723bs: remove unused fields in struct security_priv
Date:   Sat, 27 Mar 2021 15:24:17 +0100
Message-Id: <b7ff4cda1cd4cd4e73120f8526ff53a745bcffa8.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616854134.git.fabioaiuto83@gmail.com>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused fields in struct security_priv

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_security.h  | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 60b05a620eee..b71f0959108b 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -168,29 +168,6 @@ struct security_priv {
 
 	u8 bWepDefaultKeyIdxSet;
 
-#define DBG_SW_SEC_CNT
-#ifdef DBG_SW_SEC_CNT
-	u64 wep_sw_enc_cnt_bc;
-	u64 wep_sw_enc_cnt_mc;
-	u64 wep_sw_enc_cnt_uc;
-	u64 wep_sw_dec_cnt_bc;
-	u64 wep_sw_dec_cnt_mc;
-	u64 wep_sw_dec_cnt_uc;
-
-	u64 tkip_sw_enc_cnt_bc;
-	u64 tkip_sw_enc_cnt_mc;
-	u64 tkip_sw_enc_cnt_uc;
-	u64 tkip_sw_dec_cnt_bc;
-	u64 tkip_sw_dec_cnt_mc;
-	u64 tkip_sw_dec_cnt_uc;
-
-	u64 aes_sw_enc_cnt_bc;
-	u64 aes_sw_enc_cnt_mc;
-	u64 aes_sw_enc_cnt_uc;
-	u64 aes_sw_dec_cnt_bc;
-	u64 aes_sw_dec_cnt_mc;
-	u64 aes_sw_dec_cnt_uc;
-#endif /* DBG_SW_SEC_CNT */
 };
 
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
-- 
2.20.1

