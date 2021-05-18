Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735CA3870E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbhEREpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346364AbhEREpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:45:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD6C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gm21so4834556pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZRMdbjxMxB4jilOYqB66sZPAREoVkPe1v6Lee0oUs4=;
        b=iLWsrAi1bzNb6Ny1SZ+EqLbTmvGKxgXbnO87xCBUV/SioaE7lWKJNfclmiiMll3RVe
         GBT2lZ4zljRObXp/WM/KqkRMM/1tBoc8QegQj10NJ/pH8k6qV15q4rV0wntQxU6CzVTy
         8GCQCvxHzrT8jiGo2QEbirbgRXFaJIDvlT9R8EXJoYm31jw/SJSknfwcEo/6tT1AKrzO
         lhkvPVrzb8KwOBkZz5QoVhxm7WW02QowLJFqpXk0K/LQyYFpCoydwLaike0G9Mlgerfx
         CFx3SwRWUQBelG1nHuhmuxPxBEPBJQJ0h4kk1gB+HWujjhw7+pr8kVyAf11v2V9ko/gD
         asTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZRMdbjxMxB4jilOYqB66sZPAREoVkPe1v6Lee0oUs4=;
        b=EH1cYybjXD7MF9tNMzBHvG1japP/BqBfv1g902WOcBMrZf1Swrxw6eD7d+P7XM+h7g
         vu5c83nf5idFu2a/OOdPozYMShTPNQi8H8kvQBTn3sXhFmt7Dofa+PYPERAVh1Es+LAt
         W+GJtysRFsGQctkMwbdSyukKTaWBQuDpexOg+rIYdmRqxY8zJL5U93RkifKZTKc4gc77
         ugP4YjltsXQS53xMS/3mkQCo7reNcwVuTG/do+tRcISCjOhX7sQy9OjxIz5VbS6RH5IG
         XRw1SkdmKZyNd8DA2imLQE8ze/SaLVCVEngGcT5AUdqTfOMziJIkpI7crJDNSIAC0aDq
         29sg==
X-Gm-Message-State: AOAM532r3yUCNWzpzsc/NTwoAFl7OKQ/CLz2ZDJ933JtTbZ7xsOEoghw
        k9qZUcdGaoqrZLU+GWh5vUo=
X-Google-Smtp-Source: ABdhPJwrEPev0BjXHphGbKgGWulX1v4SAk+tUih50mHbMnYF0UvN0YbbrrzOmiAec3MkuJoGz9CJDQ==
X-Received: by 2002:a17:90a:f18e:: with SMTP id bv14mr3341739pjb.234.1621313067403;
        Mon, 17 May 2021 21:44:27 -0700 (PDT)
Received: from localhost.localdomain ([203.126.139.7])
        by smtp.gmail.com with ESMTPSA id t15sm357538pjh.0.2021.05.17.21.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:44:27 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        dan.carpenter@oracle.com, fabioaiuto83@gmail.com,
        fmdefrancesco@gmail.com, eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        skhan@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 7/7] Staging: rtl8723bs: remove dead code in HalBtc8723b1Ant.c
Date:   Tue, 18 May 2021 00:41:19 -0400
Message-Id: <20210518044119.2960494-8-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
References: <20210518044119.2960494-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes dead code to resolve the following checkpatch.pl
warning:

WARNING: Block comments use * on subsequent lines
+		/*
+		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
index cc7f558903ac..e5464a27c052 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
@@ -2509,12 +2509,6 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
 		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = %d", "IgnWlanAct",
 			   pCoexDm->bCurIgnoreWlanAct);
 		CL_PRINTF(cliBuf);
-
-		/*
-		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
-			pCoexDm->errorCondition);
-		CL_PRINTF(cliBuf);
-		*/
 	}
 
 	/*  Hw setting */
-- 
2.25.1

