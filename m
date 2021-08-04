Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FEF3E02F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhHDOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHDOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:22:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B60C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:22:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so5743997pji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=n0WYjDn/Hk7WnWbcRBK4RMrec6sKgFH/C1TYM3Ko0Rs=;
        b=lpD5Ve14VY80a7nbPg5IGwwxlbAy9J5Cul+mWTcEk04uYNulKBFe6uXYlfKeDwKDIt
         4kYfy8npJ+Z0S0mB1eXfMaT78akBvzdqthRPkia0TK7G8Mp2vcgLxO1sAtd9f4EdUXV+
         8hEfyvJ2WIroBa78qYBgX3ZuZSJbQ+9bmJWTRB1JS+BQgLQ30HR2hwK/HksKSZ35BmGJ
         RZ5MPfuCh8I9N/V/YgzjZTD7DbYImQo+WdDMWjE3JJIkwUJA9f+feSEvX7HRS7n2KWTn
         QFxP+5LfCc1xla7bFrHspG8kKZGl1X8RNh/PxAnVLcIMldHDGGeUzHT9Lb8sJ3QfBpwo
         yppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=n0WYjDn/Hk7WnWbcRBK4RMrec6sKgFH/C1TYM3Ko0Rs=;
        b=sfJr36ie9QAWPGyEy/uQ+TlAyvLMQSLMa/VBvdCiurqoODr2cqTy1H+5uFxJit4tE7
         xUhAletBAkOQK4u5tnvMMTbqqofw8OVJxcgcBfj/I2BKW7un7HIHwA6lYvfJi2DFpR7l
         LAnaKJv9JIN07cbWMRofYFbz8tHOb9EfECtUzHyNuUVYMgV2RVJRzgbGxVHo5QDZnT8z
         Jza6mbiwOKNCclEkq7nt40RtALKVlehZ910iDBosojiKfUd5faYcsEsDXnF7XUFr35IQ
         INwaxeihSONddmFXMAMUQt9lE6K2hZrmGvNOxSkiEkwRjRH2GBvTSTyP3bm1ZMy+etXY
         1r0g==
X-Gm-Message-State: AOAM533TeKBsL44Dq6AZw1sB3dl9o59XlX/l+XOHzpDwBPueOnYvbEBO
        oH17Rt0M8jTD4hqoKUE90TA=
X-Google-Smtp-Source: ABdhPJz4tO69xbVlNbbINXuBQR5/4rmJSU/BIK7B2v2hJbwTfK8QH08fVrsbi8Lj9c/Z7uvp4d30Qw==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr10256557pju.51.1628086928254;
        Wed, 04 Aug 2021 07:22:08 -0700 (PDT)
Received: from user ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id j3sm3309399pfe.98.2021.08.04.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:22:07 -0700 (PDT)
Date:   Wed, 4 Aug 2021 19:52:02 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        saurav.girepunje@gmail.com, marcocesati@gmail.com,
        ross.schm.dev@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@gmail.com, monu.girepunje@gmail.com
Subject: [PATCH] staging: rtl8723bs: os_dep: remove unused variable
Message-ID: <YQqiig3oIWZ2oz+G@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below unused static variable from os_intfs.c
rtw_enusbss
rtw_hwpdn_mode
rtw_hwpwrp_detect

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 724909078d80..71c9e7eec206 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -109,11 +109,6 @@ static int rtw_antdiv_cfg = 1; /*  0:OFF , 1:ON, 2:decide by Efuse config */
 static int rtw_antdiv_type; /* 0:decide by efuse  1: for 88EE, 1Tx and 1RxCG are diversity.(2 Ant with SPDT), 2:  for 88EE, 1Tx and 2Rx are diversity.(2 Ant, Tx and RxCG are both on aux port, RxCS is on main port), 3: for 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */


-static int rtw_enusbss;/* 0:disable, 1:enable */
-
-static int rtw_hwpdn_mode = 2;/* 0:disable, 1:enable, 2: by EFUSE config */
-
-static int rtw_hwpwrp_detect; /* HW power  ping detect 0:disable , 1:enable */

 static int rtw_hw_wps_pbc;

@@ -159,9 +154,6 @@ module_param(rtw_wifi_spec, int, 0644);
 module_param(rtw_antdiv_cfg, int, 0644);
 module_param(rtw_antdiv_type, int, 0644);

-module_param(rtw_enusbss, int, 0644);
-module_param(rtw_hwpdn_mode, int, 0644);
-module_param(rtw_hwpwrp_detect, int, 0644);

 module_param(rtw_hw_wps_pbc, int, 0644);

--
2.30.2

