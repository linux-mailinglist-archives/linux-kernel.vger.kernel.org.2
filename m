Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD836F6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhD3Hrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhD3Hp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351FC061344
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so25139091eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=PZ91C6J5IbzmZSX2fvjiTZcUxo2IPdsDl2aV1WCjj0KV8ktmGXNE4IK1qX7M1ojKfm
         lhKAJCIW4MpxDQvNn35XF69tyUtJI+Tec3vHrHXy3yXjU8NDa7S42I4hbHo1GNsk3qIm
         1wtfUsyHrnW+DnEUSQRqd3ao8sHfl/2Ruvc8gCjI1xEOkQdnTJ6Cpfczz2nS/yC4/LVY
         XqPnt21W6cW2QfGF1p206prkjVbKCgcOny+D5sm/DqtBbc6A37NlXTmGMKge2H4/mwVC
         BLOJmsaki930Y/JJLVxgLSEbwFLNTW+d6GOl1eW9AMUv1VsT1OoUvWcb/kfjEXvfigIJ
         E6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=lp4X3czZmtd5JnbBcbM2ZFfvaqby8tMvs8i9x/IzcunubAzqkeDt+84oLQb+TuEi8v
         nVmnLW3BN5LeonWckvvdHD4IbeSjyKW69ylEmwoQ+I4Zm3FRcPUPE3gEEhQ/BDzgy3rn
         gD1doM8RhCuLrR1y4nRklyAKrGAIk0+TNKELLk8aJ7T5kTDYF86fQsExuaOkub8gt44y
         ukWN0rFRD9YU1HwSaUOIxvKnbEnZ5a7CnkkmBWZaXV5PNSnKXvLFkjGzAtytXB1hDbvb
         +S3zP7PWmUQgAJgjuPTvJRC4bsMakMzXNtGEBttG6cP1aZVdVPqKYxGLiTMHYBnpz9Sx
         d/+A==
X-Gm-Message-State: AOAM531XgaIbabRZHqqw3RMHriXuswh2BfGpY6fozai7Hg+OCtP8MGdH
        76Gr3bD47Viu6FgfSXmyZdtLkALS7AOB/w==
X-Google-Smtp-Source: ABdhPJxRdEqrlfDzZcNRFNV5BcjA1wAtqT5/0hnDODofhaWOAo37sfUDEpL6lJ7W1iZbTuyBT5Q+bA==
X-Received: by 2002:a17:906:5a83:: with SMTP id l3mr2849949ejq.50.1619768708581;
        Fri, 30 Apr 2021 00:45:08 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id hp29sm1383025ejc.47.2021.04.30.00.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 38/43] staging: rtl8723bs: remove RT_DISP macro definition
Date:   Fri, 30 Apr 2021 09:43:56 +0200
Message-Id: <311b2575ed641cfc36c7e47fd4335e1caa77b1e5.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RT_DISP macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index c6c62bed5f3c..c7c7865dd7e2 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -85,9 +85,6 @@
 #define ODM_COMP_COMMON				BIT30
 #define ODM_COMP_INIT				BIT31
 
-/*------------------------Export Marco Definition---------------------------*/
-	#define RT_DISP(dbgtype, dbgflag, printstr)
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

