Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32E036FCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhD3OrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhD3OqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93210C061374
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so26946584eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=dWVrzNF1Bv0XidauVaYB+aR7ADoOc9MdcZaPGme44ebKpxVUIIyyebuyMphR86kvcI
         R4vlNdTr8TgmXaUr1pz6etJPrXJLdv4jwRbw5Pa+UnA+A8jl26f5NZTMRtzWxnNVpWqE
         rn2wYYbmwFjkN116NX9Qc5ugw0yx02iDO3dLJTVrLrzguTM4+z7r7HtsD1aR9DQ7cd61
         bQRQpIeGCvq+RQcbUvyCic85lCALzYRT7XuGcOdCHP4VuaQIfccQXwgbSzMN1ZxbxIn9
         n61OwGHcu0OFMcKIBsrt+FDCSUWbzEueIGqVY0pW8iOI6vxQTAhtCYf2gToUBWK2MMSY
         2Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmTLlnaxutpjq4SbPPubfzCaa9R8HdPWxGtl/Jb9hiU=;
        b=T2jcjubNwqLzkBuJJQpznmWpkvrAm9RRjB70MW5HGgqkpCQIm26I/vdZUFtVKP5zCQ
         ypT35+aZyea8yMNUr1M90ujYxQ5aGyLXUZeSETYMoVFY66TLpdW3Y9KkebHCCnpMirgn
         N4jqVV2aMe4yDiwaz1jK6+/8sm7eEco5Kw2EZ3wwV3D1Ng+R9CiOiP9Zmq3opeASUG4W
         bnw2dJUUaWFxXUgIRSRNbjMlvFp7N82M4zA963JEA2roizUPi9TuSMCjloH5MGXy54c1
         PjYdmZ5gO9Srg/4IzxA+lUUvFcY9pNxAoQOxfNdNE8KrCcR/G/TN2cCzABuGCstCLOWO
         Fpew==
X-Gm-Message-State: AOAM530KqR1CubIBBX6FBTHfKmogoZtspQ0Vxd56rNGS6cvEo8RKNf86
        DfebQfHbDNz+kGHohaXk+uo0P57+mP8=
X-Google-Smtp-Source: ABdhPJzGaL6SkLqztt5OCrmuGR+EzIiVgi4XI1zX0RtJ4yzrUbiFVTrKzZGFAdjcxPGuEgg2kvBDYw==
X-Received: by 2002:a17:906:4486:: with SMTP id y6mr4695984ejo.466.1619793911175;
        Fri, 30 Apr 2021 07:45:11 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id i19sm2045855ejd.114.2021.04.30.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/43] staging: rtl8723bs: remove RT_DISP macro definition
Date:   Fri, 30 Apr 2021 16:44:08 +0200
Message-Id: <24bbaec7c37f73338294b84efe036a8c8cce4f17.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

