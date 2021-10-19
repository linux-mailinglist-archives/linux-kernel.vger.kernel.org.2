Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8274E4337C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhJSNyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhJSNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:54:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41ADC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y74-20020a1c7d4d000000b00322f53b9bbfso2779241wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uajmj1YgSvRkUX34I9MKZYDxwuicYCwxleBLDv7Pa4=;
        b=L4MKbPboOjuQfZ+MuVhn4BOeBMDc2apxjo+B+h31CWFVt44wwhYQL5/2g10UbILlPX
         j3lAIA5qXO8XJAVXPU9z7nPH2kBDRrSPdTBVKCKKhkrLSLHJYPwNkfqjvZsGOWM227oK
         XctO8l0g7NPprioJu+8YgoRsFE9GACshuAY1lp8KmW2n54UvnwjMj2BGFuxPEf6CSjqj
         v6rBzy8VzZIksQIsCIlaVF57MkveQ5mtBVUW4M2KbRRyD2VmuE6GreQCdUzBJUHRR3E7
         L4aCmlCWiBvxSxdPrqSukzQC8A6ckSQSAgtshVmAvrZyyFUR6f1ozWe3Icu7fzCMWhON
         WNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uajmj1YgSvRkUX34I9MKZYDxwuicYCwxleBLDv7Pa4=;
        b=v11g2qrxmzEFXoY8S5Fgdj3pEZTgwfT8XvmGMlFnyCms+PyszGIWA0Bri8tVMBlpWd
         MRfHkE2uEQQ9ylZe8PEFTaj7k11GhspucgrEqiDFS2FcF8W6J/VBsA2+NjtbD0KKOhYM
         RLZ87kGkRrmn9Zpr/rSYgfK8YynYrSFURjcPIYc3frtuftvyALlrcCKXsI1vpdqoKdV5
         rwaxJWUddjpGEC+BbIv4P3HN1b8YqcLXmx6wN4oTCqFaX4BBdhE1TOW+vZ+KptizF9A/
         9Sn1vs6CEGW9y4yxX9l3j3VrYEDbGDm7IB62NEJWcrd2Fb8RiQESe5zZ8jbH/+W6tIyQ
         ROfA==
X-Gm-Message-State: AOAM533jlcAHeIOZddyfbN9v1sHl8PvANzFLZeX/aLNh6RfkvCErMAhr
        5KafApv2iTPyxCzXnu8utBA=
X-Google-Smtp-Source: ABdhPJy+PPiu6sj8YeA/vP3HKM37k8CAYjttrIOafbhOoH8zmKDYqxMM5u+U9XcEe32wAh7+xorOjg==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr6211887wmq.21.1634651506269;
        Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: remove unused fields from enum odm_common_info_def
Date:   Tue, 19 Oct 2021 15:51:35 +0200
Message-Id: <20211019135137.9893-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused fields from enum odm_common_info_def.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 1ad7ee5919ef..97a24f8d2f53 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -246,7 +246,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_SCAN,
 	ODM_CMNINFO_POWER_SAVING,
 	ODM_CMNINFO_NET_CLOSED,
-	ODM_CMNINFO_MP_MODE,
 /*  POINTER REFERENCE----------- */
 
 /* CALL BY VALUE------------- */
@@ -255,11 +254,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
-	ODM_CMNINFO_BT_DISABLED,
-	ODM_CMNINFO_BT_OPERATION,
-	ODM_CMNINFO_BT_DIG,
-	ODM_CMNINFO_BT_BUSY,			/* Check Bt is using or not */
-	ODM_CMNINFO_BT_DISABLE_EDCA,
 /* CALL BY VALUE-------------*/
 };
 
-- 
2.33.1

