Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B183F2D04
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhHTNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbhHTNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:20:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23679C061575;
        Fri, 20 Aug 2021 06:19:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b7so14024651edu.3;
        Fri, 20 Aug 2021 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpSdbGaGGvseZuthabvo5swHjhPO42GEnluiUhjUz2w=;
        b=aGFnnYQZPGwcHdCCHq/8sR1CEerR9Uf5lowV+WMB2gZZT2ahsOdPDXwUIFE1sYIN7o
         Kej7eq2lmQs7P6xnPDaRyNcdohb39erSbzPgffuZi9FrH5iuG2LC+VAsTw4EKi3fd9ay
         xxEUY7ruFFLzpFI2E+kFlGc5U/N8iEcQHFOEfHIVyqZ5+eSJzyGl4zTjkroCBVztmT8N
         1IiDYPd6vM5x0oa3XfPuxe6CdsTw/67RTJQA/HlNqHo8NaxKUNco//puqruuS94Hy/WQ
         snsBRAVslKqQxx8jKSCSPr35JesII+wgZlFCqZgYTvqikOctgR9Nm1U20NxowLSOvwgx
         JTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpSdbGaGGvseZuthabvo5swHjhPO42GEnluiUhjUz2w=;
        b=YGPSdwJVPFg8V5tH3WbdHdQVWTZkDvX0J6Se1D9TIrUITc2jGwFTqOG4maUa3Bf24j
         E4FhxJTzv2GmdLur18/+EMAnl+rhlcU5y6Rx9CsFQIFtts74kT+hm6sVtRAfLCqyKNTk
         P+8a1IcdPxfxYlNadV0MRZEaWKcsu3B83c6ZP6mJ3519QErAlIwtKocS8pDmK7uVLXDo
         F+Hf15w0j0qhSAdATzTwPYsl92L4jspTvEwarf9CI3/rr3GIZ1L70XNhLqlvoH7L4E40
         VLzKB005dWKDLh+xh6ucmManqVIJdnZDTWO0vGvn3GjEoJykliserpoX/ZbGZ24r3E4/
         CYog==
X-Gm-Message-State: AOAM533V0Nhp+Nd0ang3cmyu/GeNfX2AOphZ7FJnnmzZZSpAVwmBxX02
        ZtBKNdOxAOMy7ay/EXCx2ncJ864YOkOrF8IX
X-Google-Smtp-Source: ABdhPJz7VRothmfynTiiB81ygwvYR0grWdYfw5gXh6QcORB/+YKSNnsOhe6LseA+WrFxu6maD66ODg==
X-Received: by 2002:aa7:de05:: with SMTP id h5mr22638041edv.174.1629465570732;
        Fri, 20 Aug 2021 06:19:30 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r19sm3559052edd.49.2021.08.20.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:19:30 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paweljarosz3691@gmail.com
Subject: [PATCH] ARM: dts: rockchip: remove cap-mmc-highspeed property from mk808 &mmc0 node
Date:   Fri, 20 Aug 2021 15:19:20 +0200
Message-Id: <20210820131920.1831-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the MK808 only a microSD slot is connected with the SDMMC Host Controller,
so remove the cap-mmc-highspeed property from the &mmc0 node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 9790bc63b..b67f5cb51 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -123,7 +123,6 @@
 
 &mmc0 {
 	bus-width = <4>;
-	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	vmmc-supply = <&vcc_sd>;
 	status = "okay";
-- 
2.20.1

