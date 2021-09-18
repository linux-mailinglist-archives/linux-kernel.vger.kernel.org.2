Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9D410570
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242703AbhIRJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhIRJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C39C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so5366845wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=kQ9KO2/nNuI6hiiWH8rqqADGsuXgTijLD8jNCF59UbxYzuHIGu8fgpLKGZBDxQTvW9
         C9XbfCMCEPPgmR41Pvi4NEgh6omZ7MYqWUpdodilA6kTurhHmuMYBDG6Tlw/kB5a4OOW
         0YwXrPGjeBOM2156Cm3cAqbguFQjyOpoS5C55q7s2GNGusM5eBx3+OKqZyP3cD5a7Qdl
         n4/Pu7tqY5KbsV/nk52j/WqtQLA+b65RADfDxovZf2I66qcsrbZKVq8d39aEljhoymG1
         HB+ctOCpcc1NrHdIF7iK9OubU/Yf2396SkYngzksVF8DYtikL4KIbrFibFgQ3V6aVStr
         ihEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVr0STWCT0vadAEVLvK4H+2tlmiDZVUwHL67IoyY9r8=;
        b=l7Zqtk+azSS2wW1Usrua6RwKw/ZWLmzPBkd4TslUDJW6uCavUAKBIXVIM+Tj/jArVb
         ilkafCUgTGDZ5zBDe7Eiv32954xNyQkniG+QKjdbdiyy7ygNj1rlCYM4m8EGo2n8jItG
         ffgXOEsoixH5rCdpnyYmXvrL3z87YUKE+NihxE0OBXKGH20zRUWVus1Sv2Tn4pD51OkM
         ijg3wB6JvNiTgUcoYBh7IRNUS6dBiAPLw9k7RTBfyE7hDawpq4cETdQuX3yXp4tJ6PMP
         p1zhY3d0OjRPrkPlmmUPvBc5pQIvqrAuxqlP85lOi47UI4mmbNDakGJgJb9IQve3Ssb4
         oQbA==
X-Gm-Message-State: AOAM531SlHSGjXWQLRbHVllMUBab/GbpJXajDuRyukC8XUZ1XLUWfki7
        HvO/yJGyP4XzwEIszn5SU1STWGEmgEXMpA==
X-Google-Smtp-Source: ABdhPJzjsNyBIjX4bx17UNZ9Z4Ae6kt79Gs460i4/7S+3NYf8IkAJCKgXffDAuaUybV/STVUP84BSA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr14744852wmg.21.1631957113711;
        Sat, 18 Sep 2021 02:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 11/12] staging: r8188eu: remove macros ODM_IC_11{N,AC}_SERIES
Date:   Sat, 18 Sep 2021 11:24:42 +0200
Message-Id: <20210918092443.8724-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros ODM_IC_11N_SERIES and ODM_IC_11AC_SERIES are unused now.
Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 265583a43494..0d85e4fff6be 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -460,11 +460,6 @@ enum odm_ic_type {
 	ODM_RTL8821	=	BIT(6),
 };
 
-#define ODM_IC_11N_SERIES						\
-	(ODM_RTL8192S | ODM_RTL8192C | ODM_RTL8192D |			\
-	 ODM_RTL8723A | ODM_RTL8188E)
-#define ODM_IC_11AC_SERIES		(ODM_RTL8812)
-
 /* ODM_CMNINFO_CUT_VER */
 enum odm_cut_version {
 	ODM_CUT_A	=	1,
-- 
2.33.0

