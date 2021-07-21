Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19143D0FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhGUM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhGUM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF8C061768
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz7so3317146ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4pp5qcKSi8QnZSBiJByHnb/g7VBQHYpXJxy4hBmgsRY=;
        b=rkCNtGpSpqqjgeeoXZfosxai3avAZUS2jR+tCg+vj/TpEUkqh0YW2ARnxyMgRt18Mg
         SsgXib3ETJctErY07BXLdFxziNHx6+6fQaZL7RQ9i7UxLWxusEUZ768Lk9qCQ/Ykx7DS
         rtH0u5NbBzHsS+SC3ulPY7K9UGHGd2oDA5NQgcSzkYilYgk1MWXgvfiTY4f+JOQLwFLL
         TAKT72BZ2XoO5w1pS18H5LpeiNu63tSFKWNJlT+uGSbqq6DL6akyVapoUoKYtw65d2Es
         x/6nOcGHuVWxc43gVDO7YrUybRJwscpe51nlt81DUpeemvmAIJGwsWKjDQjIKTmNNPF3
         bClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4pp5qcKSi8QnZSBiJByHnb/g7VBQHYpXJxy4hBmgsRY=;
        b=Bb+SxjXrN43nFdONzTPHEDFy6RZLdAN5LaH3kfby2ot9PAZmQSbp5Wl53Ey4RZNcz5
         mVtt2GiIlcZtvWRINvlJNIA2ABHEHLY9X9eytgLGtkhgp9IrTfGGGAPOQNauGEYAhh8L
         zkgFmDRQXtutRGNLKcyTJYxSCuD0aB2Ur63FD4GMFV6D99U4jky6zehe2HLwO3KA1Vex
         9Owyd8kmZBUhYfa08DHIKPa0osL7VgAvl8ohzSVa+QLG16TXet8UbjYX737kH2A0dSJW
         au7TKLH6jAYT6Y5sbB11WnhCZKRj5vW0h/6qI5nKvkLP9hcOHR3qmg5LRWXf0E9mYrmu
         WFWg==
X-Gm-Message-State: AOAM5335c5Vi1oG2CfQALFhHO05ejvakEn1HIQ7av+wEUnGqc0jz+QJG
        kjb3f8chXyCrgNU7x87pAvZSYK4AWt8=
X-Google-Smtp-Source: ABdhPJxp74urEDChGi9N6qPtnTSgmwXnrsWnTeGXhxmKQ+cIMRz7K5M4WFeGr6YFu2nYr9RwvZeY/g==
X-Received: by 2002:a17:906:9d17:: with SMTP id fn23mr39568592ejc.191.1626874650052;
        Wed, 21 Jul 2021 06:37:30 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id k8sm10860514edr.92.2021.07.21.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] staging: rtl8723bs: convert function name to snake case
Date:   Wed, 21 Jul 2021 15:37:10 +0200
Message-Id: <78bbc5cb8531bc03eccfa2f67ee71979cbfbf12e.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert Hal_GetChnlGroup8723B() function name to snake
case.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 246a5362a54f..a680fc1d4bea 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2061,7 +2061,7 @@ s32 rtl8723b_InitLLTTable(struct adapter *padapter)
 	return ret;
 }
 
-static void Hal_GetChnlGroup8723B(u8 channel, u8 *group)
+static void hal_get_chnl_group_8723b(u8 channel, u8 *group)
 {
 	if (1  <= channel && channel <= 2)
 		*group = 0;
@@ -2235,7 +2235,7 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 		for (ch = 0 ; ch < CHANNEL_MAX_NUMBER; ch++) {
 			u8 group = 0;
 
-			Hal_GetChnlGroup8723B(ch+1, &group);
+			hal_get_chnl_group_8723b(ch+1, &group);
 
 			if (ch == 14-1) {
 				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][5];
-- 
2.20.1

