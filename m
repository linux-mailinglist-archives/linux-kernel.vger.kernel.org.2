Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB265441039
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 19:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJaSia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 14:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhJaSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 14:38:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05F8C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:35:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so6865606plf.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FqJ1bvNTk5XEClTe8nnRDg3TVpytraonloSvcp2T6IA=;
        b=eaxZwSdkRuRpn4adOVGygVJzWpGamHn4/HCmwlK8u1El8RbIy7ZnRezkMuubWBPpcz
         akpkE4asMZXM6NFrHA0QAzGB57nD61w5rcZhDj0S+OBFUDF/9wNSweSMSwwIxr4k+gd8
         f3ZTLPHLggPBPIyyUjnqFsnc6xTYAB22Na+ElJ1Rt4aHge/Exe9uVVqpbAD7h2xoJ1GA
         nCnhNGoPHEZnZKjrQVstKVKX/lFtc+/UzC5Xs+MUjO7U1nJ88KCEpO83hVZ3F8VT27v1
         rbCAQ4pumocJeo9SrIMD8y7exFiYCnw8aRNqDOJFVtXPtdJYMt5Tan+bHBpFS62mMOYh
         2QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FqJ1bvNTk5XEClTe8nnRDg3TVpytraonloSvcp2T6IA=;
        b=uYUbCHdbs/7zd8ztq2erscEAc7sY718JHQbxRszMRiFC2b/UCENV3mreOU+sDo4yzZ
         WqcVVxQsyBYN4ZpLIlNQSvSrQgM+44EliwoaRDtNG2Fkn/3R/xwIAUbaDwyzOrrUXr3z
         vk5RwDkP2RPnviMCrb2XpZyLR3nPEcYIpcosC4+k4de3oGYPAFMs5ZFILYLswdbzAACL
         rqJI5IJCG3j8rl6GkNK+QW0ocetrSuoe3TMkozBnNdmev7RCA4zSdIPx7O+CxRxd3Nsu
         zGiFgmORysYSllqLBD6AvihwSyHjhuS6Ts53o9y5N0pjUhr4x0vP9iTMmhGm2WjMtDHN
         VoXQ==
X-Gm-Message-State: AOAM5323jiBY3pEYUPufoBG4YipYJ2yE5HP3+I2p/mx6DxxIyIdUAOLp
        pF2LEdDhYbRsWiUnmQUpY18=
X-Google-Smtp-Source: ABdhPJz0oWDcvGvA5XmoLJmdkm15GEd5oPPdgXt4+y6Gj2HMPJpApIV2RAKhHOC71bfTanNaoITMag==
X-Received: by 2002:a17:90b:4b06:: with SMTP id lx6mr32683665pjb.220.1635705357040;
        Sun, 31 Oct 2021 11:35:57 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.84.6])
        by smtp.gmail.com with ESMTPSA id mg12sm391506pjb.10.2021.10.31.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 11:35:56 -0700 (PDT)
Date:   Mon, 1 Nov 2021 00:05:50 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: hal: else is not useful after a return
Message-ID: <YX7iBmKKNZfj8Gca@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function rtl8188eu_hal_init() else after the return statement
of the if section is not useful. As if condition is true function will
return from if section, On the other case if condition is false
function will not return and statement after the if section will
execute, So there is no need to have else in this case. Remove the
else after a return statement of the if section.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 94a2b3e32fe7..bea5d147b2a1 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -687,10 +687,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		Adapter->bFWReady = false;
 		haldata->fw_ractrl = false;
 		return status;
-	} else {
-		Adapter->bFWReady = true;
-		haldata->fw_ractrl = false;
 	}
+
+	Adapter->bFWReady = true;
+	haldata->fw_ractrl = false;
+
 	rtl8188e_InitializeFirmwareVars(Adapter);

 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MAC);
--
2.33.0

