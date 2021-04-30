Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB436F6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhD3HrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhD3Hpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D7C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u17so103939393ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=HRrszr5nYMYCpniOomzpgSFfA8wNnO2d7NRcrzhSm0N+CcuBKqLWdlmVrH6mVog0fR
         7K5f49yIWqHFo33xdYaG39D812b7auHvf6zrHtekbaVZ1BM4x41M9ExMiDwgpAkEg/V7
         Thvwxe1EHlh7aI4OGWHPLemccleCiWbntUHJb07Wi4LosKUjI/JyyDSoLL7TgyzkBhUU
         ifFGWKyzdnPLi5GILO7BzVaBAhxrb7ojciebKQH1wvdcplvhxb9iZeCXPet4BCOp8mvR
         0sGhkb0DDuUoY24S+BBD/jPNavucRlnC41bQsVaMupEK6ihubYXftoqW3+BkVz38tn3W
         IC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=ts+BKyFuiCcHwlXs55T33SWvdisyk9xoPJoaoO2G3S9nITojVvz37/DKSSrnt//48i
         fVOzEdbyO4wEhSjTLiWssz28Yqz65/rEwKDU6OXG3yJlf8fnMIWbCWnS2McKicV3IFiv
         d6jRcezo/4vmXkGIVtS+yYPH2aoDfGXtGRm6cJGrAbfJ7mCYrm81R+0YsyESORJkZTQR
         ssvNqW158tynQhhb1dD5hi2u1MNE67BRzOZj9sGSiUKNT1ZcuLs5bzKBVmxfuTqm4Dem
         LSmN+BCrig4GqYB7u7Krn4GpFnl5P3pRKhPEpgR5t1NYf/V2yhLa6SfnVsxXVe2TzJrn
         xUgg==
X-Gm-Message-State: AOAM532mreMYCYcbowO2Go906V5lkSPjJbHUkQmVwyoKkckAbzd0Ycid
        pwtsqTgCoOIBUnMpIa+uOzPDoFeEwKL63A==
X-Google-Smtp-Source: ABdhPJwkCLTaNB/Z+B56sFyyJK1pP9EjVjZBY3Io8sEPyN+wPL29gRYULbToCY+zl7vUO2y6lmY24w==
X-Received: by 2002:a17:906:151a:: with SMTP id b26mr2835193ejd.492.1619768705227;
        Fri, 30 Apr 2021 00:45:05 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id bh14sm1438591ejb.104.2021.04.30.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 36/43] staging: rtl8723bs: remove unused DbgPrint macro
Date:   Fri, 30 Apr 2021 09:43:54 +0200
Message-Id: <1344732e30b029b3031eebcb0527159fce034147.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused DbgPrint macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 5c4412bf6fbd..c6c62bed5f3c 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -86,7 +86,6 @@
 #define ODM_COMP_INIT				BIT31
 
 /*------------------------Export Marco Definition---------------------------*/
-	#define DbgPrint printk
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

