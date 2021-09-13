Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62659409CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbhIMTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbhIMTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:22:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB32C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so535102wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZV13C/zz+ZK4eN3oVLerUIs4y8cKEdw7JYNg/SDTwQQ=;
        b=DgezZRIPqBxnzmgssoZORn/3koTutjN3ojuI01tX9ewMCJ8nxwhqCffov+lPuMBqCB
         j5/rYH9ysjf7sA5x20M4EnjwcA4OICg54TG2LRTemEJU20NY8eMzZ3i9x+nU4+BgB/jK
         9588sc8yV3bsfaI5/29W7ZHz+TDMfUKycielH5ebYFmN/v/B/V6GG2vLEFNUVNOrPhlL
         yF4yW8QE3bAuL7mntLPEPithm4LV2kAEfvRvQ+NWVLGM1/2KupFSqlqe1L639BOuvpa9
         vp8QRteTVJGfx+MALtK0Oriuo3C/NzvwQHewFIpAJHm1BKK2ZBHo9skmCZwdUGnVlSky
         k2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZV13C/zz+ZK4eN3oVLerUIs4y8cKEdw7JYNg/SDTwQQ=;
        b=pQLS4pQ3vLaU+vRiJyfJ9aYVOUxSy4TMp+7pkocSQBOWtEs3g8eAbVXMB2ttFpne4+
         cHWQ9lT7ubRXSWdGAnozy+8FKhr1yNzZgbXi1S8TeU3VrVrL+Ap9FCUFogAiOICTeb5Q
         AtzcSZ2R3H4SxJlcTGMm88AmmIJKm/jSRuPtvcCp2g/73e6lKQwGzA0Mp1aQMAS8O4rr
         VS+rU/vMRAg5duAWaXfqaPVDvUyx3yc09tHV87yHq/ZEysUHCOOeUSHQZx9B3VeTA1wk
         EZYVgueDD7vux9fbYFGp0s3oVG9msh1Lz62QoJKr/MZTMrBs1OuJ8X8ZJ11a082wUkx+
         yNMA==
X-Gm-Message-State: AOAM533sZk62wurRhC0oFjtryO/Bry3ub+MLQ67fEhURSN4A1T33cO0x
        cPcNY5J80xSKvEmJJSdMUHw=
X-Google-Smtp-Source: ABdhPJznzcdnB6lpZhJKjUySGe8qzzvRB4At5/cRk1IQYna+qigNrgQ7jpb/hZUTLWvqgYe3WTgCFw==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr13119651wmq.194.1631560872076;
        Mon, 13 Sep 2021 12:21:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id m2sm475021wmm.3.2021.09.13.12.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:21:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove unnecessary include from odm_types.h
Date:   Mon, 13 Sep 2021 21:20:43 +0200
Message-Id: <20210913192043.26527-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913192043.26527-1-straube.linux@gmail.com>
References: <20210913192043.26527-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including basic_types.h is not needed in odm_types.h.
Remove the include.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index b8a8465f08f9..7b6a3c392f2a 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -17,8 +17,6 @@ enum HAL_STATUS {
 	HAL_STATUS_FAILURE,
 };
 
-#include "basic_types.h"
-
 #define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
 	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
 #define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
-- 
2.33.0

