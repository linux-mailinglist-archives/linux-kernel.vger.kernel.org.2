Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72C3F3FC8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhHVOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhHVOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92114C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g13so32013554lfj.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssEJXS5mWPr1Oq2NWHBdclycHEgmiyzEVQ1hB54zJfc=;
        b=pjAn+uBvIPFIFfp0yCINIP8zg+2OhZDpzQMbzAwWNzOelpi0j8ERk1d20oSj2FCZ7p
         pYtH98cS7JE3IJ+xIetFZPSEAvTazBSGucfLf4UrT5SDEUWV63/czSFidMlnttKVlKg2
         /hf/u8vxHuvoU1/mFKbwYsI25NX2AIA4YmmnOxW0KN+BUYRqjEfUhAwThIbqfAQOwps/
         9cE4Y3d8eu63jnSQG3muAv//A1KvqmlImnSjv5jUG3YPtIJ7XwmogVhS0AcTm+ZJ6/9a
         4baOQB3aKTWoKQqNqFvFnkvQIBJGDCqwvlOpLLQ3WJP0lAnwE9bQaPV6wANq4YUhoEP7
         nO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssEJXS5mWPr1Oq2NWHBdclycHEgmiyzEVQ1hB54zJfc=;
        b=Vv3JZIoPEM+U1xfl0eBj0tFVtcGqvEKr1MNcWH5oN7oEVxUs2m2Ue6JRQl12saLRCG
         5QPQGnNxmWwuCjyxugyd0TVxZqmV6fxINzhNSgLMFlIV2YDPvlFw5jeQ/d3y4C4R7Zdj
         AVHOu++0E9pdSfw4Vz52gozx6pbSjWsghWH6Ct62XLRXy5K2hwOZY34SrnTdE5atgpwA
         lhNWyu+6gzZp46rqjz03P/Wp/40hgmVs2EUD3d22cYhcciJrJiLWj2hdEUQIClf5WsHe
         3xqcTOSWMdb6oErPP+3nErCOisV80uiOQNjPsxQxb3rtZ4em2Kmm27SFIWwuen/7skO1
         hRCg==
X-Gm-Message-State: AOAM531O171QZjgf8+aaJ2fDXCWK35wFvohtimc1jYVCyTAHKdHQ2Eu8
        O3kne05KV05nZ6x9Mh8PHeg=
X-Google-Smtp-Source: ABdhPJytcLAVyW85XS85pjOeTzUTLzU8DGHCcOLZLHwBA9FDE+CGIMmalAKyDzN4pJ2I83BJdeAI8g==
X-Received: by 2002:a05:6512:3e11:: with SMTP id i17mr21737643lfv.613.1629642935914;
        Sun, 22 Aug 2021 07:35:35 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d4sm1204424lfg.178.2021.08.22.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:35:35 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 1/6] staging: r8188eu: remove {read,write}_macreg
Date:   Sun, 22 Aug 2021 17:35:33 +0300
Message-Id: <d591e29d77da73790c71f7a8e508a8b16fd48f65.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 functions are unused, so they can be simply removed

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c    | 39 ------------------------
 drivers/staging/r8188eu/include/rtw_mp.h |  2 --
 2 files changed, 41 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 93bb683b628f..0a0a24fd37b0 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -7,45 +7,6 @@
 #include "../include/odm_precomp.h"
 #include "../include/rtl8188e_hal.h"
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz)
-{
-	u32 val = 0;
-
-	switch (sz) {
-	case 1:
-		val = rtw_read8(padapter, addr);
-		break;
-	case 2:
-		val = rtw_read16(padapter, addr);
-		break;
-	case 4:
-		val = rtw_read32(padapter, addr);
-		break;
-	default:
-		val = 0xffffffff;
-		break;
-	}
-
-	return val;
-}
-
-void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz)
-{
-	switch (sz) {
-	case 1:
-		rtw_write8(padapter, addr, (u8)val);
-		break;
-	case 2:
-		rtw_write16(padapter, addr, (u16)val);
-		break;
-	case 4:
-		rtw_write32(padapter, addr, val);
-		break;
-	default:
-		break;
-	}
-}
-
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask)
 {
 	return rtw_hal_read_bbreg(padapter, addr, bitmask);
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index b64b16554343..3a259d991348 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -410,8 +410,6 @@ void mp_stop_test(struct adapter *padapter);
 u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
 void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
 
-u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
-void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
 u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask);
 void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
 u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr);
-- 
2.32.0

