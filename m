Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B869A4048E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhIILGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhIILGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:06:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F2C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:05:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s25so2153987edw.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7xGDBdz64wmEzOneTZADBd1QDtzlZv4vk2FOyjlh/4=;
        b=MeqHvM0PrVC2fWIc1pNOHOwKVAOufi/brwvOBCw6klHF9cJQ03rAfdJe09jm3VvKqk
         NvPONbHgmT3n93U977Egcm1tesnF7+sgUW6iJOPLuES3Pk279DuTeCJYNIPfE9XDSvDD
         rnIBOe2CEOEKlFE/r8iavtTMvSiZYuMQSugSFGfL2VgChPVif/t1d9ek7lXvnlR68Y5f
         A5QlpqKi6t4DoD+Ll6LTIE3fHxSesABasIsu6jBn0BtKvpWsSQ5yvNiUY+WYJLwi7Jvv
         LPnyjNLQGhYLUCoiVccLxHZTTNKowKIdKuz0ilj7WlJVE80G890do5G7aYKhOhmB8Or/
         Vs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7xGDBdz64wmEzOneTZADBd1QDtzlZv4vk2FOyjlh/4=;
        b=PMlbRDamMq9glA9o/wcPVnXIggFxGoelrG0bn1IChzPdB7Rf1vBfhu3fRUrZXjsMtj
         fYzQm2WnMCjyPglWkjpz981RZAhTpNU6yG4g5iTYASSWAFJu9k8kRo9fYyxt7kmzIsoD
         jfGcKs3ZhuiurLj6SeztrFSkltppu5bzPiK9i5LmYqrt1vtbWvtOItu3CgTMI6zbeWJY
         w5dfdqeLxChWKGOKoAR+kSrYkeM4GkfMix3omYlQ4Hhp56malMnM1H+eiu821pScXQ4X
         KELMMPa/ZYyD6GUxd0OfK748tiYL7fxSkBUgEY3DGsMGNUhRiVfwuqtLe091HTjzByc3
         Seew==
X-Gm-Message-State: AOAM533IdEgUeBw2ti9H1EVHyEei/giSp1PuXFOQIQEl/rYhqWvzgKct
        Zaf6O3ilPdxtUq0llCjw5YM=
X-Google-Smtp-Source: ABdhPJwRK9B7E3eQNxRZEQ9Y/3PSW4oHHGD36jxRVY6zpXr600GahEmUHyg44d0ZFDs7JQdcmzGckA==
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr2578628edr.233.1631185531863;
        Thu, 09 Sep 2021 04:05:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc38])
        by smtp.gmail.com with ESMTPSA id g9sm883373edk.54.2021.09.09.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:05:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused macro READ_AND_CONFIG_TC
Date:   Thu,  9 Sep 2021 13:05:17 +0200
Message-Id: <20210909110517.15243-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro READ_AND_CONFIG_TC is not used, remove it.
Found with GCC -Wunused-macros.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index ada22a526fee..058d04f6aa58 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -6,7 +6,6 @@
 #define READ_AND_CONFIG     READ_AND_CONFIG_MP
 
 #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
-#define READ_AND_CONFIG_TC(ic, txt) (ODM_ReadAndConfig_TC##txt##ic(dm_odm))
 
 static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 {
-- 
2.33.0

