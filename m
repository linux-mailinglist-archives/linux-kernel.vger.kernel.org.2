Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB0369574
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbhDWPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbhDWPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD40C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so1404073wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ko6Q/RilYLQvwkCUUa2QBQ+wUnQsOzFNJX5UmfxpZZQ=;
        b=RHdeWqAbybvxppCP/ujb3JcIGK/WuIKPTjmg0F/35ebt2w/h64OFEq5cJwHt0ALagq
         AtIOes9p1wDxAVEm5kZvUGY5fpP6uV+VriCCSKZC+QfGbKke7dJCR4cx9CVNVIHS66EP
         TfVZYzdqmU137NULWzItrn8/ZRrAIRs8Inw6WA3oDFrsgX6t6W7BhT0sjgUx368YskHq
         Es6Nw5m8YWIWbdPvOv8nhQ4zJxqtA67H01itXzHVFv2GGy14xlND3SiUkuN68hyfyczo
         IJ4LuJOKkGxvGZA6+xaRgqLVzZRNnauBls/mztgcPm4mLFeNxkSsutSH78kkTbY8hUmH
         iFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ko6Q/RilYLQvwkCUUa2QBQ+wUnQsOzFNJX5UmfxpZZQ=;
        b=TKdTe5iKD4uFJDDUTvqaa9SKWO2dsyFBeruafnssgvTVDaUPcA712Lxy+3Gy94KPJA
         LOSaxbIOFD8QxIPPkZ6Rmul2Tv+CROz4NLgkLz/1ZpssKvTXy91cQPG2+ox31jPFPekf
         bvLN9y8KGrLSpSSyTsHZmomVby11NHH4LR9nrnzLKDh1Q4hfygwwJ+G8eTsiMk8lixtm
         kF3hGRJpcSuT4sDhcK9KD0ICeNZBZtWQ/qDqtVPHxJjxGNvIW97oz/tZOU34pqzVJtqA
         NBqKi9QPlx/AY9d0Ss5dCgDAh6MG20hbGfeVfsKjwYgsDAxsAXUpASTzcOl6u2sGlisX
         Y8dg==
X-Gm-Message-State: AOAM533flaoYpCZICyLkvHmbA6iGIFGptBPZiylrwq8MuLHGCbLuUeha
        MFru4AapebeUQzHUqRQQHF6SKWKOB4k=
X-Google-Smtp-Source: ABdhPJyWwgvVm2yGDZ7EuZevkdToqFYrF+fyAPE2s3eIDCMHL2iYY5AVmbYE2BVAiqcEkQrr/lkB1g==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr4770215wmj.125.1619189989975;
        Fri, 23 Apr 2021 07:59:49 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id c16sm9229866wrm.93.2021.04.23.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 41/49] staging: rtl8723bs: remove unused macros tied to _HCI_OPS_OS_C_ definition
Date:   Fri, 23 Apr 2021 16:58:32 +0200
Message-Id: <361d91e6e853d33517ad557b9730e5788aa9cd6d.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_HCI_OPS_OS_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 261317b07635..a6c2956133ed 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_ops_os_c_			BIT(24)
 #define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
@@ -19,9 +18,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HCI_OPS_OS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
-#elif defined _RTL871X_IOCTL_LINUX_C_
+#if defined _RTL871X_IOCTL_LINUX_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
 #elif defined _RTL8712_CMD_C_
 	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
-- 
2.20.1

