Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1333F3440F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCVM2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:28:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC13C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:28:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so12094663qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGeujgLiCOmPS0n6saoq+FGBAGBFECX5N0Yzgj/oqfM=;
        b=fefLSd2hOcSUaWBKCAWohN7ObKf7dc29tcV4nCLi3hov+C+0oFlp88QNPCNPTsTDYC
         D1eKMEmYt+uyQZcePrirOdC86YiwRag1ALR1aaghS6uVlzlBtZsJaU25OwD0HxsvT0VN
         NMGtM/aL8+oTPeoe2D83y8G9j3KkPa0mi/L7lCS8I5ZhTaVaV2PcxClr83oXsi7KcBpo
         WwtEH3F9SFplf9x9ADipCv5vwvJHaCWcG7dp6uufDxlCaaBJUw0Bj23espcEj8ybqYAW
         aG+6xV74VXhNYx14ie861CvkY2rtcIFEytfLJ12Y5xeNIKAS6n13Djy6vpcTYyQECfK3
         OkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGeujgLiCOmPS0n6saoq+FGBAGBFECX5N0Yzgj/oqfM=;
        b=o7bTmrDOtCI6Y7+d5zuxb93bq/2rbl/8J3d7JkHByhaYjP7mnOpJjM3PZG3UFUbKmG
         uY+DeUwVz4vqJwyaruPWl3KuO13lPr1ZesqD0l90nm8eM28DCvdglBNllJkCTmvTqN0+
         Qr2Tz5gdIvMHxQvslmC8adMq/FzKcRY/PRYEdG8p8Xb34nWgqHMy/Mp/LVBnrnTj3VI7
         nWo8lYXFtdPLhOt9owtJR7ApDHRKw8QUo+RSM8635KRHMSAUvkkJsj3kkqVNOKjVOjAk
         T33y+Cwr3453yksJOweC0XRNdkUhKvw4bzKjrAmpDy4La9urpskKyCdchdDJEwhXZAnA
         jPFQ==
X-Gm-Message-State: AOAM531GrnsGo2BvGEhRtvKPcylHvsDkrccC1VZvY2vKxuCko+0suoL7
        7qzMbBRD3dgsIci+uObPiO8=
X-Google-Smtp-Source: ABdhPJz/qxCTRMstWrnwXc8n9foSSLckGAg4dOoqWPFBQOesadn5JMLsR+FIj30Z4nwIlhyk3Qrinw==
X-Received: by 2002:ac8:7352:: with SMTP id q18mr9257500qtp.65.1616416111431;
        Mon, 22 Mar 2021 05:28:31 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id u11sm8600784qta.91.2021.03.22.05.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:28:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     vgupta@synopsys.com, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: arc: Fix a typo
Date:   Mon, 22 Mar 2021 17:58:19 +0530
Message-Id: <20210322122819.2704169-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/defintion/definition/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 4392c9c189c4..e47adc97a89b 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -31,7 +31,7 @@ endif


 ifdef CONFIG_ARC_CURR_IN_REG
-# For a global register defintion, make sure it gets passed to every file
+# For a global register definition, make sure it gets passed to every file
 # We had a customer reported bug where some code built in kernel was NOT using
 # any kernel headers, and missing the r25 global register
 # Can't do unconditionally because of recursive include issues
--
2.31.0

