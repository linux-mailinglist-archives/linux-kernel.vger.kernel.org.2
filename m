Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E433AFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhCOKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCOKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:14:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:14:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so2021101wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQOBEyLYdYQLwsFjsoZC+4HNJORLWbz6l9M/l9A8vgI=;
        b=DLeUlgl2zpkPYM+W54rpptv7s5OIErLTMH+G4VGB9vxqnEjUF0L0jhHJdO6CMpI6eA
         DE2m/tnWe4w3ekHnXQ99li8M82FMQDwN3wz5XedObL2xWGHnCwNVPoTVoeJEBI3B3iMS
         gyLbwfO3W6h6+EJrKr5WPyTAuCGDsyDX3eY1cLtlnQO2EEMCLyeaaVLdiVkTTI+j6TbZ
         AwFJrUxVo3y0gIDO06DYwLIQJDmQ0ghDJuzyHby6zdYCweAZiiaUpRTSga1bBf8oG4ur
         Y/sbAdn+lyquheac9EEwnDCgCE5n9WAP45bocOh3RTbXR7NFI2ezrDUfteCAODN5MA4W
         kKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQOBEyLYdYQLwsFjsoZC+4HNJORLWbz6l9M/l9A8vgI=;
        b=ciO7wzq6QF/d3/C9MpYNWR6YFV+Cwz9AKzXRIv90KPA4VaaRhNu1yOjp+if2+7bXQM
         TnOPR3tx4UMyORzlUnbpWVVVV+QHQOpl6pnLULnEQoWTUJ/hNqZxPHjTgNHfoiScLmk3
         UGd2Fn13MPkfXPFIKk76+a1RizU049wUlXvI1qrwfyBj7lYyWf1WhrdqFiohMLg1Feor
         3jBIOh9Wd8PA5K1n6OEtzGVxRUbXFR8C3CcefGOndy3/jtB0/GIBWhRayWoNiWQvhMvh
         XpsZTYV/bVlpb+wcPrCquc7M1sOAhR3pa80GPqx6ju8MGLMWVTNgwWrBkRiWwbnwxMXJ
         xv0g==
X-Gm-Message-State: AOAM532CRhLSSCcnh8Rb1LskU6hDwRIBmiRfXOv8ki0XC4bjF+XMXjov
        UYwOyNsH8RFZfJmnxHO2HRA9RzkenKY=
X-Google-Smtp-Source: ABdhPJyNK7zMaQleVZUz0Ju+KCytVu/+knSBFoen8mfYpueyoJPzCTyRaXRNxcawOUzZxHaUaxwKfw==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr24557292wmc.119.1615803267757;
        Mon, 15 Mar 2021 03:14:27 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id s18sm20718524wrr.27.2021.03.15.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:14:27 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:14:25 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_HW_PWRP_DETECTION
Message-ID: <a7330c5f934a49ebba43b671d6fb78b50c903504.1615801721.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused CONFIG_HW_PWRP_DETECTION

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index d8cdce0539af..d643e9a59e6b 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -113,11 +113,7 @@ static int rtw_enusbss;/* 0:disable, 1:enable */
 
 static int rtw_hwpdn_mode = 2;/* 0:disable, 1:enable, 2: by EFUSE config */
 
-#ifdef CONFIG_HW_PWRP_DETECTION
-static int rtw_hwpwrp_detect = 1;
-#else
 static int rtw_hwpwrp_detect; /* HW power  ping detect 0:disable , 1:enable */
-#endif
 
 static int rtw_hw_wps_pbc;
 
-- 
2.20.1

