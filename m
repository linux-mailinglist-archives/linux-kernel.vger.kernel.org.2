Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F55E36F69A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhD3Hqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhD3Hpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F02C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gx5so11748790ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=thH0C61hU2D4xp55V7rsZqJPTjyHLJZFuMZhrAOgPxTiQCZHXvbKfyrVD6eKyIWctz
         4Ix8cOc32UapMn0/eee01pwP3hnf4qaPzvCbCbJfgLuGWj/So+AJs02An7qPpxgYeV3+
         9abDpJMzufhJtwE7uKVfNocwGVUvN7/VxLi2skka54cDGzTAg5ZegQ/8/8p8ZGhQ8bVV
         cZpa18qRM1ABuApV4Hg1ayE3TdepmMS2URcsPw/MomFhx/NYhnCl2pgKSeNq5yivtftH
         AuzAxqKn0CesQKGeo+VhlP2oguEVeiPJMGgKY2zRiGIcHfTjwlyst+jvtGN2ThuyY3wx
         uf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMN4zuhUHvB3cXnh9Uh5ILIZdfR0r9cSa/aL/onWxjs=;
        b=JWcojoRDY80sm6ym3JhDZPuPlPzgGynGXurn1jxtUL+Ot/OCCYWTbQZfXCdNTA5Y3w
         FHgzedVAb+7KMXQvaoGFvcc2/FrV64wbg2yJ4M3oLB2SVT+dcBgdrmKLSpDclAjiskiE
         w4/fGqLR2304cI9tPZyDbXMY7A8UX3/Df9q0AQo13ryBbC0s3Fvk6u+qLY8pw4js8DTq
         3JbkIzYBFfJDy7eS/qEfnOTDgUTbbWctwgkvXL2vfM+wtC5eFIN+Ht+8hACpGvFBBJp6
         LCvnHKaASvcgs5WRu7t5s23AF/xjtLqSiidkAkHZN9GY39skIzar+jlpQ3tlgExY5xaa
         53nA==
X-Gm-Message-State: AOAM532MUmDhfyfao3UWJn0VRYBEb8+IhL3oHnkwBt50Z2ZnfgmLwJzh
        iGNeQ0S0gsJwrwD7pxV5z2Q0LHc1vE2tRA==
X-Google-Smtp-Source: ABdhPJwaYejqCz2dYUv46+N4WfReOlFcrVp9pUU+GXtfVdojDzCaG6AgaYm4XuHWc2ysVHkX/B+vrA==
X-Received: by 2002:a17:906:87cc:: with SMTP id zb12mr2924254ejb.138.1619768690083;
        Fri, 30 Apr 2021 00:44:50 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id o6sm650449edw.24.2021.04.30.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 27/43] staging: rtl8723bs: remove BTC_PRINT_F macro definition
Date:   Fri, 30 Apr 2021 09:43:45 +0200
Message-Id: <892fb6bb161ac4357eb3d2b6962a937e7159e540.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_F macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 36636ad62aac..9c9ad29870e2 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -115,7 +115,6 @@ extern u32 		GLBtcDbgType[];
 /*  The following is for dbgview print */
 #if DBG
 #else
-#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
 #endif
 
 struct btc_board_info {
-- 
2.20.1

