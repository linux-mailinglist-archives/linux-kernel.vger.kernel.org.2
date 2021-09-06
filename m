Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51980401FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbhIFS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbhIFS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB7C06129D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id x11so15049013ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=bvMSPibRhbo3R/MKPkdA6DnQtWiICCn0WUrNtSzkFHF5ytLdSnewA90aBwKJGOlQ8Y
         SD/1WWtD+FZub4r1iDYVRRL+MCbBpM11KYYvorOEcUPf+WM/R+YW7J0aLkUpZfh4kluz
         1Kx6S7z0+UQIM4cnEtZ2hHWBDS4/31AKU7HC9E4KigbcZl9CkWWuUcBc4UVaFplSyZrV
         /hRoMhcZyjS9biKgGryJYcl38bEuG7qO4trBUegPpKwEdSJ0zynRpdvqxhlh3jXs/YLG
         7ldnOE6ftGxENua5wHn67gRpQg1XME5PMP3Upr1X874SKgQeSZCudpZo7yd6VogpSeV8
         k7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=iKeUD9alju35r6d328iSLkxD1YnWTiNF/OId0LTTDVGx0UysBDvhtcgw7h6NEMnOD7
         djXYG/91ZItXUMhw8OO1vE1W90Nn4ERusFscXPePyTs3tzwthOzsfcUDddMg1sC6RMWZ
         +uOyvoq9S6DCdBhLVdIkLJAGvSFgxihjjziAkSDl6C42djMuPMp9Zkt9tem9L4iv+4dA
         gtxoR3zcMrON4+COvXw0UvoVoME1lsCIC/4eyFletuF5Lyyi34dIkAy+JSDhlqa2+q26
         Rv1OA1ErxsIhifYzRMC7o3OhbYsnULJxKcNwvEvO/0CR63AyBAt/6SfUwtB25gIyKNkF
         NjFA==
X-Gm-Message-State: AOAM532aMkgFiNw8riRRkmgY0CooipGNmQRT6gzJFNP/eNyKYlmzQVkv
        4w0HP4REWBGefh6lgv9qYdQ=
X-Google-Smtp-Source: ABdhPJxTIwHtIus3wW03vt/NmFrP19e5d5HiAzykbBazZxUmwEKDt+Dms0I2rIjaYiJZyTgNi2OXhQ==
X-Received: by 2002:a17:906:6b0c:: with SMTP id q12mr15226982ejr.0.1630952717530;
        Mon, 06 Sep 2021 11:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 22/40] staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
Date:   Mon,  6 Sep 2021 20:24:20 +0200
Message-Id: <20210906182438.5417-23-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename hal_EfusePowerSwitch_RTL8188E() to get rid of a wrapper.

hal_EfusePowerSwitch_RTL8188E() -> rtl8188e_EfusePowerSwitch().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index c7edb9ba4085..b5d0cd332165 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -707,11 +707,7 @@ hal_EfusePgPacketWriteData(
 		struct pgpkt *pTargetPkt,
 		bool bPseudoTest);
 
-static void
-hal_EfusePowerSwitch_RTL8188E(
-		struct adapter *pAdapter,
-		u8 bWrite,
-		u8 PwrState)
+void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	u8 tempval;
 	u16	tmpV16;
@@ -757,11 +753,6 @@ hal_EfusePowerSwitch_RTL8188E(
 	}
 }
 
-void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
-{
-	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
-}
-
 static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
-- 
2.33.0

