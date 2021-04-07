Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6682356DE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbhDGNvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbhDGNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71516C0613DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p22so1256457wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ATocqzISrvJhii+4mqvqB6jnvgXhMORzZO+oZXnMLk=;
        b=F7SMBjXMoQNt/S4a54onFYpu6SDPHVjbXyfXEls5sPeUr+sdCwYQVzNSx5qED+3o8u
         eiQVv0tzteF5QWlGBjY1HLYj1SKc6twX3pBjuasV6feOe6XgBIFKcHY6P9S3n7+1Cvqn
         r4rltEDzlNnxDYTxM4Cm0Fdjxg4KQNfOVgef6Ak0UQDN5ckD2+zFh1rAp7ssvRyWalS1
         JRxHErS3tgJqye+FuHQ9fwrQrn+4+nT5IvahkgwFAeQ3lGjPuziXTbh1vSr+VAuKrYh5
         YXre5KCPciSyn+33Pansm6vKIMRx2hqh5ncZkpkk+/07nH972+EP9hgxSZgWnAbwno3H
         wMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ATocqzISrvJhii+4mqvqB6jnvgXhMORzZO+oZXnMLk=;
        b=INjkPH+jmZUnnh6y58yyw0UQwxs9RwWyHsU+j24hF9SO4POCvwZnQdPwmoLNLVZRrP
         NDuiOWYVU4U+d4OTbRGIJg6sFpByfgK4BrF27cp0Xf3NOf1F3tTk2HdA1+xL0iWPbdRi
         8x39WlF45fYonKmelPoimDHDS2P+uWlHFSkDbifN3B5v8fwQazD3gmTkQtWEpTO0C/1l
         dtjAAAQqr6nCIwZvmzaDsSmwU08m75v/6a3UcW/g2mi/bF3n1UvtshMbdkSvu8LC8n4r
         rmeRtHMEXWW0lGZFVV4m76RC59Cy31z4OUm2aGWcaRrJqdX7bOpzdsu5M8lNgJh3H8tD
         7EJw==
X-Gm-Message-State: AOAM532IxBm8YAWNBEWCQn05w54shbqwfpi33mnI3N9l4FGf23XxURgm
        I5Vk7FyLyftv7/HKZcY5A7U=
X-Google-Smtp-Source: ABdhPJwxZOSviwk8T2n9bCN+M0nwC98LmNBuf2OsEeMRkttoVNgTu/deYLLOSemwtCVpcg6nPopWQg==
X-Received: by 2002:a1c:1d53:: with SMTP id d80mr3220568wmd.62.1617803427225;
        Wed, 07 Apr 2021 06:50:27 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id c2sm8663811wmr.22.2021.04.07.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 19/19] staging: rtl8723bs: remove unnecessary parentheses
Date:   Wed,  7 Apr 2021 15:49:43 +0200
Message-Id: <a45ec5059ea315db6509989f320340c1816068c5.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit checkpatch issue:

CHECK: Unnecessary parentheses around
'padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X'
84: FILE: drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:335:
+	if ((padapter->securitypriv.dot11AuthAlgrthm
			== dot11AuthAlgrthm_8021X) &&
+	    !(padapter->securitypriv.binstallGrpkey))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 893c7a417587..f7465cf90c46 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -332,8 +332,8 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 	)
 		return false;
 
-	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) &&
-	    !(padapter->securitypriv.binstallGrpkey))
+	if (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X &&
+	    !padapter->securitypriv.binstallGrpkey)
 		return false;
 
 	if (!rtw_cfg80211_pwr_mgmt(padapter))
-- 
2.20.1

