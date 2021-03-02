Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3932A5C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578155AbhCBNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350251AbhCBMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:14:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE388C061224;
        Tue,  2 Mar 2021 04:11:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y12so10685174ljj.12;
        Tue, 02 Mar 2021 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vI52iVvTMj5vx3Qwhb9RbRYQIWf8TgkxUBk2dPsjIEo=;
        b=GxitPjxoQK3G7UACfRQBWbc8BUczJxFSzvqrjYE+qbNDkNf/YRbfWeAOWCRdA8m552
         nN0L3QK/apYnH5q/QyYHdgCFuGN+bQcjleHcSjuxOzuv7/PmB1axZtSAPzG9774A7zzr
         EiFktC2iiDbFa0cTVZYKpvUcA28WasompsaXDSDEwniXtVBCEQZjm3oD8Nc9JtBnmFIy
         dhG84w6gFRPG/YRC3ep79X0pW1v0ej7EZaWKuB+uw2+eK1+AnMJvoYyZMBAou3cNPrri
         roO/F21i8o6WQrlDKb2x42RPzjtdlEloTi/T2C/wnUgehBciQRO3CBZoPX0hG5j2ebCa
         muig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vI52iVvTMj5vx3Qwhb9RbRYQIWf8TgkxUBk2dPsjIEo=;
        b=QFj4wXNy1fH29hz7KtknGMKP96wTFw/GGfL8I//QTCBhzqED7N1v5+1nTTTKDIvgDS
         eSZONvjwiqZ+Zono6wgYJJk1pOrBcSRRhCrEKGvFIFSeoCOy9JeAcrxaRmgfJJrFG20+
         u3z4dGe1CyVCm+5gQS1TIlbDRH8rO7huS7F+YhOt51wOx1toVH4gnCMwvQ8AFdVVGo4S
         E7pXWO6r99LiKJJbk6/vXy75UXMGSlznghzzY0aLzbTpgioXHqXMcxw6a0HxFkQBQCPA
         HV0UOgqi8occ1oYapVQ+a/fak6peQAEJeJ9o7uCWsnAx4Nkwsgl1T0gi4BRt4X3lPPKS
         2OoQ==
X-Gm-Message-State: AOAM530ZOHDEMia5IycwTrOaQ6LR7VsbO7/12672kXw9/iSU8d0EfAvD
        QL3+wvpVwHVTqOOvN83U3NQ=
X-Google-Smtp-Source: ABdhPJxrzpqD6vklbao4mk5rxBwx2FGtuTYLwakzadqUitTLix+kb3N9htr9sGpzzj19XruIdfLUwA==
X-Received: by 2002:a2e:80c4:: with SMTP id r4mr12172050ljg.87.1614687066215;
        Tue, 02 Mar 2021 04:11:06 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id d21sm835097ljo.55.2021.03.02.04.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:11:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] ARM: tegra: acer-a500: Rename avdd to vdda of touchscreen node
Date:   Tue,  2 Mar 2021 15:09:58 +0300
Message-Id: <20210302121003.15058-10-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302121003.15058-1-digetx@gmail.com>
References: <20210302121003.15058-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename avdd supply to vdda of the touchscreen node. The old supply name
was incorrect.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 8a98e4a9d994..d852527db707 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -449,7 +449,7 @@ touchscreen@4c {
 
 			reset-gpios = <&gpio TEGRA_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
 
-			avdd-supply = <&vdd_3v3_sys>;
+			vdda-supply = <&vdd_3v3_sys>;
 			vdd-supply  = <&vdd_3v3_sys>;
 
 			atmel,wakeup-method = <ATMEL_MXT_WAKEUP_I2C_SCL>;
-- 
2.29.2

