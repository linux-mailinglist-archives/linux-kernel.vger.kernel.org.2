Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D137A4163D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhIWRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbhIWRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:09:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E53C061574;
        Thu, 23 Sep 2021 10:08:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so19217698wrb.3;
        Thu, 23 Sep 2021 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=DaUjSqDwLae/vY8ch/tHiryo0g1rXA9ht28tFsDeGiKU7uYJbgg5DtZsyNAxEuCTsU
         nRPVPxq0x86rO1UUleyF5+qD7gkrRKMPDowp3DWHo+cIstXwg7XmN13mBUaOgKsD+Bq1
         XQAdgzRmCnSC7S0nvSICFj7eXLTPsgtg6qx47hjyJQ8atvvTiLGLvBWW1ahwTohFNI0s
         8N8ey3sVFKbh3IrHiK23wYn8CPSwP1PLeekEw6Ce8KJgDJyHv0Q9HhVcUa13KLSjto57
         DneOvWf054Rr/lUisVSu5mueZJuau2wl3TFy3qLEG92unPSIoFJsJEMSc4s8px4DhUYl
         R2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSna1bEaXtn8m7SSEUg3SHS/YUvgM9x34Z5EWR+22QI=;
        b=uxv2rZ132axFvqnd14Fuvj1XSuSTZBbp+RIfrOAzWAcKZEp8y7yPvPRjn5aN02dBOh
         +iVTe5YOhVNTzcgrkAZAVxaYhXqh6WljXNPHBPXuvkdU1Ub2yYtoxrbxBZgj/uNYUNvi
         0YTKwALYykDF0VDVoRoFNeeLHfkNOAvstiqKuLpcqxSPrxMet1+WBC/XUbR0d5oAylVa
         uBVspFJOhO2qAE93j7oNSwzUd3HXVBH7bMjr+lmYImiuKYBAZRraV6ZSXVagFoi/2+5a
         kS3Mpxbb14YxOYea+yK7pU4sdr+9vVNU391pGfJakxzjRJy2rtW1mvk9pEjSLYti8HBv
         ZABQ==
X-Gm-Message-State: AOAM532a27HRrbHAGReSIzozIGA6sX9vyukaQZwEW4Tq3sglnDNjxB9A
        Q48p/8btDgL0EjuvvUIdZ8+Y+2XzrWA=
X-Google-Smtp-Source: ABdhPJwc5rZge2VddobYbUqB+xzRpzBaufb/ijUFot1OzKeSNJ9ItO+XUojkLEEOQXL+p5H3CzWPEA==
X-Received: by 2002:adf:fb89:: with SMTP id a9mr6475050wrr.164.1632416881495;
        Thu, 23 Sep 2021 10:08:01 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id 25sm11219573wmo.9.2021.09.23.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:08:01 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: mstar: Mark timer with arm,cpu-registers-not-fw-configured
Date:   Thu, 23 Sep 2021 19:07:45 +0200
Message-Id: <20210923170747.5786-2-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923170747.5786-1-romain.perier@gmail.com>
References: <20210923170747.5786-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor u-boot does not configure the arch timer correctly on
MStar, let Linux do it.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 2273295e140f..982dba9d28eb 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -39,6 +39,7 @@ arch_timer {
 		 * u-boot is broken
 		 */
 		clock-frequency = <6000000>;
+		arm,cpu-registers-not-fw-configured;
 	};
 
 	pmu: pmu {
-- 
2.33.0

