Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D757F420123
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJCKHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhJCKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:07:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF0C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 03:06:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23so9511193pji.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=P16WnH0VJHDsfubnkfkpcmB3utpmNsLVNCNG7HTYBcE=;
        b=E7fqAknLWuXaPP5p4GKJGmI+A5FkPZE7+ObybOHYXwFA26iDOG9rwfs0s0AWxQzqVh
         DVfZ3gbduRfDjSgDzujTTPhe50al9A6P5nAwY954d83ixY2My87pcNgXQsbZWsNicQrk
         Qw0PLGoxOiKaUid7EshxIhnvJ8WJMHQw+OwN7JEBvRGhB9KNI3zK0qv8qeBfB2/2h1gW
         CVFiYGdExk74cMaWBmYGCXfuW051wYFoxmBWssm6t70P5nTzoRdbthabmvFlmPRnfiAN
         ROSi48Ht1V11/XjJC1q4onITxQnhNW2k0KmZwFnXiv3u63tjwkPyRUaqOu96a+zwwsa3
         xO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P16WnH0VJHDsfubnkfkpcmB3utpmNsLVNCNG7HTYBcE=;
        b=Xb+7a4nQkXn7+M0HyrfcKxXDmhfbalfefttIbjbUU3BPLqT5rSPqDR8HSuaEbZO/xG
         gvxF2hEth7SKzvw5ETh2/5AdfIsaRhMNL7mqVFJwQeGREK5xW6IrQYMlhdKtVjod2l5O
         JRvoWvkWeMXIQm4tjZJC+4swuOw6rrwguafAqWQWWmzCguKWBS0y5ODEZBJOZJxtSguO
         FXeSFIg7s8V8V+5SEKLUC0k/lgEOhQydruZWW3M4b1au3g0zwz0XKnR/Aq6+yuv1T/ct
         mZql7s/mJZeXuk6ilZsjoDOO8QN7vNI0GszTieIxa8+5GiNANevW2z96PWEc1LLECEyE
         AAoA==
X-Gm-Message-State: AOAM531l27q6dfuXOQq7dDk8DLznXfbqOHBl2B9zXWdkzzyAXFNOlChu
        MfyVx5Vmren1htPGqQFqz0c=
X-Google-Smtp-Source: ABdhPJwiv/nONia3tS+eGxG/2QKKbADl99KpLmvw/6TAozeDdnnwY+uCktXgf/oOKGNzr7twR4DzUw==
X-Received: by 2002:a17:90b:3e8d:: with SMTP id rj13mr2955635pjb.183.1633255561796;
        Sun, 03 Oct 2021 03:06:01 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id i13sm900386pjh.0.2021.10.03.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 03:06:01 -0700 (PDT)
Date:   Sun, 3 Oct 2021 15:35:56 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, will+git@drnd.me,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8192e: remove unused variable ieee
Message-ID: <YVmAhOSRB8yc/iwU@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused local variable ieee from ActivateBAEntry().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7dfe7a055876..97afea4c3511 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -10,8 +10,7 @@
 #include "rtllib.h"
 #include "rtl819x_BA.h"

-static void ActivateBAEntry(struct rtllib_device *ieee, struct ba_record *pBA,
-			    u16 Time)
+static void ActivateBAEntry(struct ba_record *pBA, u16 Time)
 {
 	pBA->b_valid = true;
 	if (Time != 0)
@@ -288,7 +287,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	else
 		pBA->ba_param_set.field.buffer_size = 32;

-	ActivateBAEntry(ieee, pBA, 0);
+	ActivateBAEntry(pBA, 0);
 	rtllib_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);

 	return 0;
@@ -390,7 +389,7 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 		pAdmittedBA->ba_start_seq_ctrl = pPendingBA->ba_start_seq_ctrl;
 		pAdmittedBA->ba_param_set = *pBaParamSet;
 		DeActivateBAEntry(ieee, pAdmittedBA);
-		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
+		ActivateBAEntry(pAdmittedBA, *pBaTimeoutVal);
 	} else {
 		pTS->bAddBaReqDelayed = true;
 		pTS->bDisable_AddBa = true;
@@ -490,7 +489,7 @@ void TsInitAddBA(struct rtllib_device *ieee, struct tx_ts_record *pTS,
 	pBA->ba_timeout_value = 0;
 	pBA->ba_start_seq_ctrl.field.seq_num = (pTS->TxCurSeq + 3) % 4096;

-	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);
+	ActivateBAEntry(pBA, BA_SETUP_TIMEOUT);

 	rtllib_send_ADDBAReq(ieee, pTS->TsCommonInfo.Addr, pBA);
 }
--
2.32.0

