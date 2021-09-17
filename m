Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD84101B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbhIQXck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbhIQXc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c190-20020a1c9ac7000000b0030b459ea869so2410938wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=SlufOYExlj4aZRxm2EmVcnoekJOhvXGIiWFEw/AhjCCi+Asg6qjcKCY/9RvWSp7OMs
         ajrExtLazBb37tIw71lQvZx65YfJs2QSeTvZOLLIT8FrlI/umyztBPjbi8F5WVmlVj9y
         u/J0zM/97ZIK3YA/mY0wc4Dfy2hz90NmBsyBGu0PDvItCMrWoGgUYs0O1DBBMOhVu2uT
         gfEX8RVXOqsEiKoLAcMdiQjfRleZaQrmRY/46XNj6Waxs+vais8aojJIa8ufWb1H/nuN
         WnyY6qkAm9ubfDggvuqdkJJxt06n70q1nZo8PP0AYKTw1jnk0M1x7IfPHBbT/Sig7iVT
         NvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytz3TTUDyfzI8gNQwgvUtpk8fGA2obQJcsvCizPAUI0=;
        b=hlCfJQu12jMoBLw2Sai+Y3KCMnbpngJtKRp1A1SS3s+4AutSCygJCR/FYNnK0lVPw6
         2O3Ewb3JFP+HPACtf5GiE4TCXjpzbiwLyBOsmbAFDkCBFiDlBADrJWnNR0HY8ZowzYQO
         eenPYfqerSb8cY4dQ4STzSXYuZfW/fDNBKnL1RIvg/nQ5so38MEQQohj3h2e6Q5DRvun
         4vEw4iTBtb5Ru0VHdfdZ3Zm8i1estx7fKXbS1qUkNsJpSW1bcYx4TrS4kdV2fEcrEJG3
         80C7AZ2039VtWzTIqrz6puoCyk2RI9XXrUk6NISn4CNhm4X4kEqN/H3pnfq0mYhHASog
         m34Q==
X-Gm-Message-State: AOAM533Zztk2VAC7poOh4vgqQCmusz95R5MH9mJMM0OBOkgya9bfcZpn
        4t+jbh51o4m5zPWPXv229z8=
X-Google-Smtp-Source: ABdhPJxa3r+BxkjaWLhEHS+aBJft4ZYR2bF/xhlw3KgQspNUhQu6UnERBA/5oNirTaR6yBglcuf7mg==
X-Received: by 2002:a05:600c:17d0:: with SMTP id y16mr18055721wmo.41.1631921463144;
        Fri, 17 Sep 2021 16:31:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/12] staging: r8188eu: remove unused macros from odm_interface.h
Date:   Sat, 18 Sep 2021 01:30:38 +0200
Message-Id: <20210917233048.31677-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macros from odm_interface.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_interface.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index efc2ca069a3d..d3e46b2a4cea 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,11 +4,6 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-#define _reg_all(_name)			ODM_##_name
-#define _reg_ic(_name, _ic)		ODM_##_name##_ic
-#define _bit_all(_name)			BIT_##_name
-#define _bit_ic(_name, _ic)		BIT_##_name##_ic
-
 #define _reg_11N(_name)			ODM_REG_##_name##_11N
 #define _reg_11AC(_name)		ODM_REG_##_name##_11AC
 #define _bit_11N(_name)			ODM_BIT_##_name##_11N
-- 
2.33.0

