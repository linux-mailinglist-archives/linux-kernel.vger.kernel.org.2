Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225F533EB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCQI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:28:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:28:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b130so38037199qkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SR/Ra3v+mm4TqJpj8isYbo7fm9tci00xrSdRoI8mv8g=;
        b=pL5A6sp8fZ4wspwkQeV84TETMlGd+bQyctwUKZJhtAzxlagOCXwo0QEK6r22SMB+AO
         LBAq+seSa+DHpJ17PfYUKyY4515KGR4fPmrCBz77LeFX/kSOk7tJUshjjABoK7ihicMe
         MaPpTjelQR1HCWmmmo3AnYCamC2s5TV5pSpDi3Q6K4B7TqD4QO/A2wgD+Nzc7gTq35/r
         PYw7ahBDV1O0iYGWO4pvf668+KJm3fabPzR6HGEyBQ2PZ953KyTomSCmIu58jT0xaaQ2
         +VWDuLvm3Z0rl3N6DqvT3BgTuSfYrhUk+hD3bh5V0i6xSLt/iUhSjFhPXMKSVG6+94p2
         5CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SR/Ra3v+mm4TqJpj8isYbo7fm9tci00xrSdRoI8mv8g=;
        b=R9GvIjWXy+p4038c637Y2p4kryQRtsC3v4yQqeg96qqC8CBKgIUQd5I49WS94HFKjM
         4RRI0jgLga7BUN1QZOMUW/NK/dInVKoUvYZRGo+m4P40SRURzmN7FrY19kgHDBY2xrbG
         QdwqzSmD2+EnAB4KwYrna8s7Mjy5gmGQg4EBP6V5MyStgthi1iYsEs4tzFVlrY4Z4v+E
         6UTjfcR06sgcuEHjx5vVVFFePaiQo/Wd+351s4RZ7XHBSkyj4bMGwLhJnKYLHaYJdh+j
         u193qD5+QY3txTFgPZdbnpCz+MhMLOWn1/tN4Qiz5olgWBCt+F9Cy/ZwX/ysHj30mH+7
         VGrg==
X-Gm-Message-State: AOAM530ttyl3eZBoZBgqbUGVMBWpQDPW2os8bQIq6KjWnZ98vtEfxiOD
        RsKi/sSJDCvUyjhl8CbQG8w=
X-Google-Smtp-Source: ABdhPJwcs8DE8VH30jyKknxdMB7I1blbVeSrDEmHxoYJM3oPDK2SnkxS9GQSwBKXCsVEBvixCWHFWA==
X-Received: by 2002:a37:a488:: with SMTP id n130mr3473634qke.49.1615969697198;
        Wed, 17 Mar 2021 01:28:17 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id l6sm17621562qke.34.2021.03.17.01.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:28:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        rppt@kernel.org, unixbhaskar@gmail.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] xtensa: kernel:  Fix typo in the file vectors.S
Date:   Wed, 17 Mar 2021 13:57:58 +0530
Message-Id: <20210317082758.3785266-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/markt/mark/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/xtensa/kernel/vectors.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
index 1a7538ccfc5a..bb4243de8ba3 100644
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -202,7 +202,7 @@ ENDPROC(_KernelExceptionVector)
  * See the handle_alloca_user and spill_registers routines for example clients.
  *
  * FIXME: Note: we currently don't allow signal handling coming from a double
- *        exception, so the item markt with (*) is not required.
+ *        exception, so the item mark with (*) is not required.
  */

 	.section .DoubleExceptionVector.text, "ax"
--
2.30.2

