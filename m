Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A73870F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbhEREpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbhEREpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:45:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE41C061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x188so6503529pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds28R/7vwYP+GELrd+7TuWueNiMvgRdKm3879jAJ7HQ=;
        b=M8lRvzvdKFwL0qKWqAeZktmJWVupxq33Q7hgy4nUnWPLh0PPzcs52zIHQo3f5R7j8K
         CM1BHYe23PsIG2UmsKQL/MFejxBcpB+OR4UYWmDUbZ5XRRE7WLSIDoNIJkAG9S9blxwG
         n85pGCXxLff+A+7lfVLg+7oRSZeBEo1mc0+cstI7kQCDW3Qs9fSZWhaGEXJUH2I2h2sC
         AGOxlgqz5BC29EemmLcrGekUH8M7xUV7CwnlneXic47UzbMhM036q2CssbN+bAmp0GnE
         /EdLyjNqoOyLpK1/Gh50VEQ1E1sYwjiEyK2eSeC99nzZHb9hPPWb6Ek9yl9ACUlxSVcJ
         q/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds28R/7vwYP+GELrd+7TuWueNiMvgRdKm3879jAJ7HQ=;
        b=hu7bESnpwvDz9bLLLHLYJxhAsZ7KqjMq5Sqhr9itgjyiJABw3NfUXVc/Ex1SYt/s5c
         XZ6/PsIHz4bYhvS+n7EDZ2uM0xBHJxy+lOJFKmnYHPf4eb5mhazgLeyZfkPgVPsQSlyy
         /mQeu2Qp2jvLONZTlPH71fa+lv6A2Bnc+Ao5G8P2FfRN6xEo6V/HB1maTd5O5vV/Zmj/
         Nl73UkowBXjIG2lWwfWkq+bxbm5aacMmpbac9ejO9uMhzsavBn6zyklGsFINNcWP5qge
         ca4WpviedU1QQD+7F44fzq4bC07ku+6H2hVzBDh4FhYk+Hq2J+wBh9Bd5yHBxvklFi85
         7nDA==
X-Gm-Message-State: AOAM5326GZ5sGSUttHmwoCPGYtErVFvRs02MQnU363d3mPAtkrhnxdwv
        UBshVdcQVHciwaOF5owv+ik=
X-Google-Smtp-Source: ABdhPJxneK2BJTKruRRi+uIH4AUvHRRkbP9aci+ZVV3w7z6Qfpt7pAVSBnuhoSWv6/Qs7/jcm1HrjA==
X-Received: by 2002:a63:1224:: with SMTP id h36mr3138445pgl.296.1621313042678;
        Mon, 17 May 2021 21:44:02 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:44:02 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 5/7] Staging: rtl8723bs: add missing blank line in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:17 -0400
Message-Id: <20210518044119.2960494-6-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch.pl warning:

WARNING: Missing a blank line after declarations
+	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+	halbtc8723b1ant_BtRssiState(2, 28, 0);

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index 97831d04959b..cf36a7de4735 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -1664,6 +1664,7 @@ static void halbtc8723b1ant_ActionWifiConnectedBtAclBusy(
 )
 {
 	struct btc_bt_link_info *pBtLinkInfo = &pBtCoexist->btLinkInfo;
+
 	halbtc8723b1ant_BtRssiState(2, 28, 0);
 
 	if ((pCoexSta->lowPriorityRx >= 1000) && (pCoexSta->lowPriorityRx != 65535))
-- 
2.25.1

