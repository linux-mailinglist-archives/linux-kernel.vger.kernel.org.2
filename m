Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27823949D7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 03:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhE2Be3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhE2Be2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 21:34:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B90EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:32:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso5567736pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgjB0C4SFgfKtXPVhbC0TiKnh7C8iLZ2llOTHFW/6e0=;
        b=ZTyJHI1z/47v5GRmXBFzFL1WGOdaRHNQMgkxQff77atRTj8McUT7W0HlwZgZYevsUv
         ThJNpfELRBRaDAvNjKgjqItbOLc/Qp59Jpg6fc6p2lFdzxleIqcQ33fStsxt4nLjqESb
         E2GbawH2rhtz/8IqCdsH7kj8mSGSgiapzfwJXOB2ArGBsG3fSlZi7FyAek+UZoy4a7Yw
         kBEq1ekihcnWzb0gK1tsN/VISqQtUODNIsHiV/GUYwqV6VeXARW1fz5ee2H3/su4E8gR
         x/DDKau4his6tr4QgAjt+RrGdndV/Vx5OueDaxSrHiIN5bFudIrrQPpSsN81MZaYBL40
         GSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgjB0C4SFgfKtXPVhbC0TiKnh7C8iLZ2llOTHFW/6e0=;
        b=di1mfm64hH7RM8eCxpt4ITAmMOaCmYm9Oho1E0cH0bB4uUhMyBAT+zMnPBilftHOWV
         hdndNHX6O2jTYbjrAJok5bKxnTGBXsha9IYmtS3ByU+SIoiXxZSYKxek1dGMBAuSTrV4
         LSCYzfO9GUBju7IF/nETkhiiNdZmA0TZ2txppHCX+oKiyiqHTEmDhQryWeKppDWQ5X29
         W1jtDvzoHfLXpdr15Op6XmU0ifmlq70TsyKkJ4JKy5t+Axl2KTyoU/wT6oYeYSsdH9d4
         SITyxn+B9PK8ZuDyRQlrz101qGn9c9081k7O82qZgdNCLwdz5jKYky17cypr4xzqfxJZ
         0AUQ==
X-Gm-Message-State: AOAM533lwDX7TIECPgIwdEVum52btQx6w8RDtsmLlclUBF/SRmVSAo8r
        +cOwN9FoDHup3P9BEtbuqiE8WxUfLkmZGfgA
X-Google-Smtp-Source: ABdhPJwCnbTZRCXbYeHR6jhKmYNChbHICmhG2/hJ3DTKiFwp1DQ9/X05xdWTELrja1PUUmUjO+HVHA==
X-Received: by 2002:a17:90a:7601:: with SMTP id s1mr7533956pjk.66.1622251970857;
        Fri, 28 May 2021 18:32:50 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f3sm5108211pfd.21.2021.05.28.18.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 18:32:50 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: hi6421v600: Fix .vsel_mask setting
Date:   Sat, 29 May 2021 09:32:36 +0800
Message-Id: <20210529013236.373847-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take ldo3_voltages as example, the ARRAY_SIZE(ldo3_voltages) is 16.
i.e. the valid selector is 0 ~ 0xF.
But in current code the vsel_mask is "(1 << 15) - 1", i.e. 0x7FFF. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Mauro,
I don't have the datasheet to confirm, please check it.
Thanks,
Axel

 drivers/regulator/hi6421v600-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index c00afd9246e7..c5f41651223a 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -82,7 +82,7 @@ static const unsigned int ldo34_voltages[] = {
 			.owner		= THIS_MODULE,			       \
 			.volt_table	= vtable,			       \
 			.n_voltages	= ARRAY_SIZE(vtable),		       \
-			.vsel_mask	= (1 << (ARRAY_SIZE(vtable) - 1)) - 1, \
+			.vsel_mask	= ARRAY_SIZE(vtable) - 1,	       \
 			.vsel_reg	= vreg,				       \
 			.enable_reg	= ereg,				       \
 			.enable_mask	= emask,			       \
-- 
2.25.1

