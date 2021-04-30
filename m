Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1736FD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhD3PAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhD3O7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C414C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id zg3so24107102ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=cbTTL8bq32QfkNoTj0g8T7+tQ0ynfgr9/dYZvbZOWjtm6C0bYFEY2AONl394cWuGkL
         66X4AYRlQmUNXVdaiP9tnfA+OvbP+PEuPTeZtEOaT/QRtrTuKC25vQdEcC5zKpn/D/dU
         3gm3ZIgXiZ9CjhQYZQad7vBM0peH1uquOoYpJxNp2z1mx39OYbv4nzerNWkn6UC7qEFj
         qLEkSsEkAteVRIOyPI5p4ePt08kGF+rhJEmyIGZqXfJCJM6+T3lHzG+VGMpKW/EbQzRW
         mn6SQIznh3g36m6n4u6/OvrExrgrSb8jRSItPupWrsj2gRQL7I8L6PTWYhjNQmmwtaAk
         +R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=HjXVcT5jOHT+9Wvd6jr9hk2AZra1pQndFg1AKGFFdxq6hw4cw7FiRMXew7Vul+POeM
         baja05bIUBnpXaClmy+RN9Io3KPNCVh4utPQGT3BFXmvdbQ0nLD5t9TOEyGJW0xAfvMg
         BnXzO5L7D8HY6/iMBUVZEL6lAS7kFz3ZVE8o9L9e5LIr/ypbr2uQZA+kY4OvnYgItCdx
         wJy5hjbmgxtyqLw0l0Tgjw37cqaZuRz8IfSI0qEi6F3q0JkU+VPso34mpGPms571gEVk
         xsdzclUfGWsvSkHviJGfr3rQp6X4756+1Oehhqm/IymRLkaomNsV7H6j6HOrwPrvwoTW
         F4qA==
X-Gm-Message-State: AOAM533ec6LjTGYMnqFfVM2W8P5R4rabCwx8wPdbrTfoouSSc9f34+zM
        qDQw01kDQy4fwvFV8bCK90Rf4mBTp4o=
X-Google-Smtp-Source: ABdhPJy0nItkoE3sEk5/0AU/L4ejFhE2O1A7kqJ0z1775MlpLYqnDdZt1NeoU7Zg0//TpuT7hFHjZA==
X-Received: by 2002:a17:906:4153:: with SMTP id l19mr4752294ejk.109.1619794685826;
        Fri, 30 Apr 2021 07:58:05 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id d1sm2165089eje.26.2021.04.30.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/43] staging: rtl8723bs: remove unused DbgPrint macro
Date:   Fri, 30 Apr 2021 16:56:58 +0200
Message-Id: <00e9b407fa1a7c911295b2fec215d82f5da058f8.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

