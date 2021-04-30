Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998BD36FD20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhD3PAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhD3O7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CB3C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j28so18967159edy.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=j0YTVWc/INk9q8Jh7pY9pgiAZz1xGLKrZEEj0yE/3pCx8oQPecKgpLbGhbYsOJ7pKJ
         JjRKuEWs5ZclMDFlh+B4lPfz1dXDKibhW6k3XOrG74bsMItQIVWP3tnQnlvZYBQZIqOh
         HR4udTG4O5oKFc9UODEufZRoFPjD1cXt0RcEExUYcF8R9rYEAm+IF0VPDvlBFtTM+ofJ
         IXIw1FsG49FgBWIIA5bBBW1QsrQQoQgbxGtua9HS/DWsGrpdN7y1l0/iUU8/wjpEd9eB
         DGtMSlT4o0hFL2RreDUTOHhhfDOR7CaNAJtuoooS6SJ7pDxqL2N1nF4QoMceoi7MMNgd
         p17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=cds89JWo9e7vr8JGhSvQulYxsYAJdtWblF2dChYqxOoZzkiDdxcNX6gQdIo25qElJQ
         Nj+brC3WxJp+KImLGElfEhJhNH7Zy/UeB3UyHDFpa5GQrCI5nsUszHtJPc2bf/leCdhQ
         TCKwHaYr785S6LwmJQqkvn/vtpQBaAwAvqZn7AkHcDNsLBvIt0ySsABjFpfLWgrv2zk8
         QJjhTo7gS9fvO8CcQs9TnLlACDTTiLHyIGqRfoyL09TNd/cYWmVU2qHMB5nW7c4NJfMH
         29f1py9wmKf9Sm4f6YHPCMiFunfk0OoALf+rDJYZxbbxldOjK9E/JMKU5zRPFe+oceX4
         hLSg==
X-Gm-Message-State: AOAM533QdQAxjzCndS9hjPwiuz+DlehXnd1vodOXUAKLj9exu96bfb60
        0SJpdCR7UxeK9cnKw3tvPZGegto+2aA=
X-Google-Smtp-Source: ABdhPJzPEFffmEaM53ijOk3DOoKZhxBKSkOEVb26hkRVFEGpJ+wWAAcA/6714TJf3e+h0Vk1HBz1Hw==
X-Received: by 2002:a05:6402:254c:: with SMTP id l12mr6362027edb.278.1619794688963;
        Fri, 30 Apr 2021 07:58:08 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id ch30sm1445519edb.92.2021.04.30.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 38/43] staging: rtl8723bs: remove RT_DISP macro definition
Date:   Fri, 30 Apr 2021 16:57:00 +0200
Message-Id: <8983c3077979830aec02427ed895507213b38f95.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

