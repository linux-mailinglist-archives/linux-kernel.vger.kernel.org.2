Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404B401255
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhIFBDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhIFBCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB98C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n39so1699446wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j86XDM0GDC7BV9w7mmZcIhaBO49C22/Ru8DZmaP6PMI=;
        b=YDv1V+yQtAsSAT+drkjuKAhSfeVeMtx6CTyn5rVmHGkIFqu3ofh/2FpuMWoCvAXhiC
         j/yxjAjqdlLAKSzkGsO65LLFfztLNiCfcJD1eg/O98OqCQN6ygzMxOSPhXMxKCIQ+7p3
         PNu7LHdAPgdOSXWIrGam9WHafyEcIJrchnVrznm9FhptU8HXeT3ALnEyYo8d+/wsL7Ps
         sjKTvoxWpf+T9Zde7w07215L6gvEVyQ3Et0lMThFeUPAOpkMJRlumfuxigEmBSm6B6X1
         4r9FuOd/QSaI2ypVEYiuhr2UaVY+ex3cd32+40brqG530xeo8B3jiPpnabEtvgTmvwN6
         yt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j86XDM0GDC7BV9w7mmZcIhaBO49C22/Ru8DZmaP6PMI=;
        b=ksybUbI90h0UTlHmIAfcoEdaxyt/lOkC+p+NZhJZuY/ZCv1unjHfXyWDsoM/4VrTlf
         E2UjXrAjob+KJ685TViBoaJtytrddGlKYAspKgK5P8YrcczE0d33B5ZobVAmJahq4rc7
         eFxFXt6ArzFAsdIALD3P8Ih/8+XblFFcsjTf7h/Lfj1U73WdJRG4R8q3CYwqiOp/zvvJ
         sKepkWCWi7Fa+BEAVoXIh6VbTRdq1RWm5b1g/kBa4e8+5aiOJZBf7h6pAw0928V2ZyrC
         aIRXg8bbJ0JQF+16yS4QhgCUQdM9a9gqU/6fv/UGzw8j4O43eLh7RM1LCugmQUH2l+Lq
         AlcA==
X-Gm-Message-State: AOAM530/GyibtavtWo3aFxzAiQqDE39XKJsm4CTOExfdVpj7f3FzU22G
        VKtxvFswYWjRs8l8xgQ3QHUM+A==
X-Google-Smtp-Source: ABdhPJxSYrvjbkKDFU7OmH8D6Cz4lljKMeXdgRPr1x7g8Ku1/YhIziU+BvPHvxSMzOdro2amuC6bYw==
X-Received: by 2002:a05:600c:3b17:: with SMTP id m23mr9072336wms.41.1630890077952;
        Sun, 05 Sep 2021 18:01:17 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:17 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 11/14] staging: r8188eu: remove Efuse_PgPacketWrite_BT function
Date:   Mon,  6 Sep 2021 02:01:03 +0100
Message-Id: <20210906010106.898-12-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove static Efuse_PgPacketWrite_BT and its one caller from
core/rtw_efuse.c. This function is a wrapper function which calls
the Efuse_PgPacketWrite_BT function pointer of struct hal_ops
unconditionally. As this function pointer is never set, and this
function call is possible to reach, this could lead to an attempt to
deference a NULL pointer, which would crash the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index c1c70648f5bc..e1a9c031435b 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -351,15 +351,6 @@ int Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *dat
 	return ret;
 }
 
-static int Efuse_PgPacketWrite_BT(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool pseudo)
-{
-	int ret;
-
-	ret =  pAdapter->HalFunc.Efuse_PgPacketWrite_BT(pAdapter, offset, word_en, data, pseudo);
-
-	return ret;
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	efuse_WordEnableDataRead
  *
@@ -676,9 +667,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 				DBG_88E("0x%02X ", newdata[i]);
 			DBG_88E("\n");
 
-			ret = Efuse_PgPacketWrite_BT(padapter, offset, word_en, newdata, false);
-			if (ret == _FAIL)
-				break;
+			break;
 		}
 
 		if (idx == cnts)
-- 
2.31.1

