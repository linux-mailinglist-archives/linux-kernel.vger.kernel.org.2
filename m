Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9000436004
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJULN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:13:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94911C06161C;
        Thu, 21 Oct 2021 04:11:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so421138wmd.0;
        Thu, 21 Oct 2021 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zReu5LZZqZ6XzLqTlsHxDdEsRb+VMY4CZOS8twEJM0=;
        b=q49JHrsBJJFNjBbC0i18peksSxR61U7hA+24AaY+PgfCe1SBMWsVi3pknabRH7tahc
         fxQV72cSSpgJmanG3EFQD2TN/plWumML1UOs0ev7wKLufmHTFB4FW+r43YDiM0AbHIai
         DNx7okc4OAqVtUVj1SahPFpqyh46EZ88B1WuOnoorKncqyOmDSzAguJeFCO/XCUnH30b
         FrvQ4+43pzk1aXnyFfe9+gg3h+NFfRoaSi6CJ/gC0hfxURX/UkcFnqIpxj4l8N/YidWu
         znqNe5FEI2mB4Y+Np2L1iAYraVin/E+9iIkhpQ6PmUsoBGGJz527fzC5zhW5t1pLHu61
         /PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zReu5LZZqZ6XzLqTlsHxDdEsRb+VMY4CZOS8twEJM0=;
        b=xebvtLuMRsklObh1bX31ciW6+1TJvtC1S11dzZs3kBp89nrwqzZpsr1adA5b9/QYEd
         Q0/Jm8lUgyUB36ZoDZkD3NYVpB6juxD8ibirzx4hDmk20p2ZzjHPMxl1FlOPCOikwJbO
         TjSUHn8S8wH9ozAiDqRXCh6umwNPGTFzQf9y0sH5pIey5Vu8crHaLN+91363uh7CXxcK
         mPUBewq5q7lzTugzRGgpADzqA8e5fiJWvbXrPwKVpRdfVxVhXG9CTm8JYoCD4zFv0PnN
         Kdk5tqe1hYTSjYT/GAlxNljyd/mSaSgOpGWxL9Ym4z+62eudAdaWubjy/936JIELX4ZA
         5hbA==
X-Gm-Message-State: AOAM533TvNNXQH1P+E/aNrAj2koF/zcFNEhO2jgIhPNzJkvDmVzB2Nto
        37BEEqJoLt/iuXSi8XTwE/s=
X-Google-Smtp-Source: ABdhPJwZNecIduI3UOdXeLcXiNV7pEntiIhGWqrmD9Stf2FHeV1/7uirS2/+Y4Zc+QHsrTiSx0z7AQ==
X-Received: by 2002:a1c:2050:: with SMTP id g77mr5845733wmg.91.1634814670237;
        Thu, 21 Oct 2021 04:11:10 -0700 (PDT)
Received: from xws.localdomain (pd9e5a59c.dip0.t-ipconnect.de. [217.229.165.156])
        by smtp.gmail.com with ESMTPSA id k6sm4758930wri.83.2021.10.21.04.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:11:09 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: gpe: Add support for Surface Laptop Studio
Date:   Thu, 21 Oct 2021 13:10:53 +0200
Message-Id: <20211021111053.564133-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Surface Laptop Studio uses GPEs for lid events as well. Add an
entry for that so that the lid can be used to wake the device.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_gpe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index 86f6991b1215..c1775db29efb 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -26,6 +26,11 @@ static const struct property_entry lid_device_props_l17[] = {
 	{},
 };
 
+static const struct property_entry lid_device_props_l4B[] = {
+	PROPERTY_ENTRY_U32("gpe", 0x4B),
+	{},
+};
+
 static const struct property_entry lid_device_props_l4D[] = {
 	PROPERTY_ENTRY_U32("gpe", 0x4D),
 	{},
@@ -158,6 +163,14 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
 		},
 		.driver_data = (void *)lid_device_props_l4D,
 	},
+	{
+		.ident = "Surface Laptop Studio",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop Studio"),
+		},
+		.driver_data = (void *)lid_device_props_l4B,
+	},
 	{ }
 };
 
-- 
2.33.1

