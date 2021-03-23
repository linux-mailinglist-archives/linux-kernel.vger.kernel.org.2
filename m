Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D42345EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhCWM66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhCWM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D06C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a7so26924218ejs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BEr+U22XVWAeunLqffU23P7ZmiKVWme3aB7fB0BhsU=;
        b=Bu0wUoUuz1wp4qC0myYiSysjpCzJGg7qtL/shN6UeWhuNGcl1RRclKt8GE2kD3I41I
         WQGunxeKEuXfrqNdkhMh9p+Ktge6N6vhrrzPzQG4QoFlMiP8sHSMqjgRmS/mpVeCJMKM
         qPRHKL/2L3wG6MA6YlWeVSkZZjMjtdiP6kF3AAMvpPcMzpP6O9n5i5Te6S/sxz1lWTfN
         8tA0vTAo9pLX1hO+qrBAZElwTWhdsgXk83mfneJVbH8OtibvAYkRB/5qWOwajD+1Owbp
         tAZspJv2hM5JD5TZDCxOorzPGZmbXTMAPHio7RYvK0TlpEEMYWjRHztxg9ayEqS8t8DV
         z6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BEr+U22XVWAeunLqffU23P7ZmiKVWme3aB7fB0BhsU=;
        b=dGc9MVDxHCqJeysy6eznTf8+ie9Rsh46q7loR8aV3zFVLdXiPAY085DmN02wHk/A3y
         MXiQ4b3d2cQfjm+gtrfSFwdGoB5lkUVGeall3EuEFVDgkpbi1WGJ+7Rc8Y+la3MtVpRt
         N+oW73CyQXijQuhgdZWKG1HPqz7XJQNpu61WBRwBZz27np2eTuPfl1+WcwgGB4xW8eU6
         cqRL1w0z6ZpES0AqGgzCHwcrrHNW4Hxm/+nkat2oue8YHKNx6gwVOUzSwvJhTua3VUZT
         uPwtwfcnRrs5NSKZO1zYrYEmcDFYDe2SMxqzesfZDD8dA6RlkDDlzSf2IRfwzGB80wm3
         Pxtw==
X-Gm-Message-State: AOAM533fNMVZR2DnlB8MoICt4EGgJ/Rnp1lTVuLjaKNz5k/QlibT/Wp/
        4fkTe+984p3vKiLjTitpDKY=
X-Google-Smtp-Source: ABdhPJyE9D3WHGsEbIx8bY0TH3jF70SgioS9FdTIYwv5jEhQ5ME02F/tb+Q77SbNgFs/xg2gH4cf4w==
X-Received: by 2002:a17:906:a049:: with SMTP id bg9mr4835328ejb.186.1616504300959;
        Tue, 23 Mar 2021 05:58:20 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id g26sm11005758ejz.70.2021.03.23.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 4/9] staging: rtl8723bs: delete extern declarations in core/rtw_wlan_util.c
Date:   Tue, 23 Mar 2021 13:56:31 +0100
Message-Id: <0fa08b70af86b2ee88564179a22d908a643bed1f.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
28: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:28:
+extern unsigned char RTW_WPA_OUI[];
--
WARNING: externs should be avoided in .c files
29: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:29:
+extern unsigned char WPA_TKIP_CIPHER[4];

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index bfd55a0356f5..760b0ea4e9bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -25,9 +25,6 @@ static unsigned char AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
 static unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 static unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 
-extern unsigned char RTW_WPA_OUI[];
-extern unsigned char WPA_TKIP_CIPHER[4];
-
 #define R2T_PHY_DELAY	(0)
 
 /* define WAIT_FOR_BCN_TO_MIN	(3000) */
-- 
2.20.1

