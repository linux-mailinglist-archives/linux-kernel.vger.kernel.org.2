Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C6B36FCB9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhD3Opy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhD3OpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A180C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so105668366ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=s3aSTG0QCXhLUQnIvPffbrLJw63VFz7pA7qDtBTSJhEaf1oLeFyGHHoojFQvaRMyvN
         EuaTDjOQn+MSoHH22IhwMV+NaohGXq8nPYo6ZFSBxgLtR8GiDeuq8ZF8K4waFLus3u2f
         lx8bzP118kIXBN0hI5CMTOkNpw1N52vgY9o4Ke/sUYZJVfWJ9RUSwNmL+pyifojng5jd
         GaqC8hNiTrhl2c7bhEqbF9tIA4QOi4SkiYHvzrMzYMicL9oSA0AvrnO1e32blduZPdMb
         k96furf3xoYw8TPQSvWfXeHIcH1Srcp0iu7J8v0dKrjPpuaEb+GLcd4YeT7n/AdL58NH
         o5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmk90qSfuSLmAzINt8x7JaHcuQoCwpmT2qAtZaxL5BQ=;
        b=Tn8XIOL2Vr5FOMkApxgImiWHrgnW/BTfdH7gzbP3/KlOegb4N1jOfiMKTEGPtJKrmN
         ULMLrVTKBzQWP+ikOIbOAEz0S/Y+G6XlJxVKJcU2lk/22NZSNwR/EuGMGYeUAZPeWodk
         RH3W9cuZHqeEC5SwHLmB62DY70HnXrtCea/h7PGVzSfaIfL0Ifdeh7BW7YyrG8jWdBbQ
         F/wX67NUdIOXtDOFvAbN8F1Bztxq+xSnMHo2qV9r5ZrVEInckbLmmbEMbYsXOA7MjAMK
         xr3snELv3BdGTN0itBuRb2ng3qrJLfRaFLRBHqqRgDZX0Ahdp/pLPzShqMvOtk/WPu8P
         iNSg==
X-Gm-Message-State: AOAM530qCVkGiHBQbCPt9QthBPiqg5lVuvuQHsTsI9PK2ztXRdAWS7LT
        pBqKmi4JLXOaEGkQrInXdSNYTh/r62Y=
X-Google-Smtp-Source: ABdhPJxP2uzEyrMyryvwcFoCOVH3SZ2waILD9TL0WuyEqtvtj0H3mnyYgBT4N/cTptAzFIaI4BtYXA==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr4844697ejs.522.1619793874161;
        Fri, 30 Apr 2021 07:44:34 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id bh14sm2065976ejb.104.2021.04.30.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:33 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/43] staging: rtl8723bs: remove unused ODM_dbg_enter
Date:   Fri, 30 Apr 2021 16:43:43 +0200
Message-Id: <9e3c2dc5d9f4005ca44d20e12c8278874c1c9e91.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_enter macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index cd68c583699a..7c9a87fb8e51 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,7 +97,6 @@
 
 #if DBG
 #else
-#define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #endif
 
-- 
2.20.1

