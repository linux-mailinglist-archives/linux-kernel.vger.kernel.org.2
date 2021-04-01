Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D36351216
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhDAJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhDAJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDDDC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j3so1133956edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yx+72Epx+NUmisxn0SR/nVRJ35Oi3tLmnqMdM+YV3RY=;
        b=Q27FYDA23lpDWJV/fvWPA5uAILasjXzE9vUUpKmLCpWRMXc8wz0c8GYe08V+Ld/6n8
         bWwHMiekG46yvOYx77BimmmunVA38ZY2cqm7xrPIy+DNlqfNt63UPgtVztxEecbezmkn
         hS01qpNImXoHeHzeCgA9aBQOKgKkg8eWwLNCPam6/j5LRXQby8nWCGKv6UNWMgg3HHuw
         tp1cwkK5y2SxOprJ8e9Dv6ItCtyoa1APi35PmkkcQAMXTXHxQJnrHVjvVdK3JvK26uFV
         OXH2j+FZe24V7R72IgqrUR8p3a6B+F3DV2CW3d067FQ10M7MlEINRjmqqugsJd1SkXTd
         C2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yx+72Epx+NUmisxn0SR/nVRJ35Oi3tLmnqMdM+YV3RY=;
        b=aI5Rn/WdsZwGPzPS+ljnpwAQv4g31Sspd54v+FjF5yzKpomC1mlR3Zr+Wknz3/m2Zz
         97OOtrD6pcKY0Vy/KigLnYADnVWDH5/aQqCiVH0NEjD+/6N+XFpIC4btd5wwfHdM2GrM
         jgrhuGis/enChka+Hy6b8x0CA5LHFIYNUrPbjsh1GYPDIUnMYcunvswY0+hLIq6V70J2
         D/EaCZIffICjm+GqT7tuP1YaeeYV/yo+JgUWybOZfA8fmq7fr7RlmTETtOGDfIu1LpMT
         hTm7ftDHPeXUUUjGBH8L5nyyKJttMaACb5aOOyXDVdTX0ZDnZyi7ZX2iRT/SdNjfayYI
         Iehw==
X-Gm-Message-State: AOAM531ZHPXXePZSy81shWd5mt83hK7PuYIHoRNvCRGH8oz7pp+7+69U
        A/MD7dMmj7wxEP4lq6m6EGc=
X-Google-Smtp-Source: ABdhPJxXj0e1SrScqhvCIunTcW48FMFvhjTlzJlEbNCcfK22JlhNZwG6coQ9up6oiPJCKPKtgPfEgw==
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr9092777eds.199.1617268939166;
        Thu, 01 Apr 2021 02:22:19 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id wr20sm2472855ejb.111.2021.04.01.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:18 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 34/49] staging: rtl8723bs: remove RT_TRACE logs in hal/hal_intf.c
Date:   Thu,  1 Apr 2021 11:21:04 +0200
Message-Id: <bdefcae9217453774e97cbecc08d8f8bd194048b.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE LOGS

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index aa4356327636..7fbac4c8f2f8 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -108,8 +108,6 @@ uint rtw_hal_init(struct adapter *padapter)
 		DBG_871X("rtw_hal_init: hal__init fail\n");
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_err_, ("-rtl871x_hal_init:status = 0x%x\n", status));
-
 	return status;
 }
 
-- 
2.20.1

