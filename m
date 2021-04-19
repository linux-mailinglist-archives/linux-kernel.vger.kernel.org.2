Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1A363E78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhDSJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhDSJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:27:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967CC061763;
        Mon, 19 Apr 2021 02:26:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so51836645ejr.5;
        Mon, 19 Apr 2021 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HmfVs+hiDRXJZWZEBHBQ3JAhFTKr+C9J2z3911ynMEw=;
        b=BDha9bfXAT8giuVCew3679cxC64+xg9PxhnDm/+mz8+W47wOpU9/W+8n18jhtEMoMh
         qY8QDyNfZINfycHz8ENrWkdBPFYkMid6s++vYfllnAPg82YcP5eeu9F2DrlFPIe70Lyx
         MZEXSVloX+iUWuzuCIniGL3h0MRmD4/U7jGMT130yiHU+MWmhoeYi4qtds9GnfkZUk53
         aQRwlRrqSTC4nMuu81C1qP7RDNaAihQwFBVlyQDSDbzsN+i1WazkLJfevOl1W7bQzV8R
         H4TCAij4yj5pLp0SMemIHKCOndc+IlqPu5lQXw3LucTLlqineqbRa/of2Icg24yy2e+i
         Nlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HmfVs+hiDRXJZWZEBHBQ3JAhFTKr+C9J2z3911ynMEw=;
        b=W37ju3dAagNV1q3B0vYwi400J0yyWXhtY6uYVA88dkrDJk7cVvBqEKfiySBiz1h+o/
         abno1Q5rmMoACm82nyxRNeZtUsWtH2eoSI2kTfXbNBlRT4y3s9GBZckdBNkptuQ8E4HK
         KTt0pe1NV4Rt5BCd9AUAtfuWmn5EY+2TMgCuYk6FO2edooe8MYH6BPkEHYsObHME22p7
         UhbFo5W6GI5aiG+n8gMMKrtyVZ7oeQZ1bnJpQroZRDIM1ayqil3gnsYmhsrznIkazDjc
         MU2EuxlQyJEYsgcmcP+J8owR0YLC4+gSnUl7x6Xy9SItce/gtdUi0xR9fUxS1sAgzRl2
         VRSg==
X-Gm-Message-State: AOAM532dfNceiCavCbNedTjaOgIW5siX+4++Ofnvhgte3+OKxPEc0atL
        3frdFKPapLo/whnjohSCj40=
X-Google-Smtp-Source: ABdhPJztvNS0sFK4JkfQ4EGlh9BsAWq5TFQ/tSjLqw/fAb309CW7p/9NoVmVOold+Em/ozwXu95KLQ==
X-Received: by 2002:a17:906:fb92:: with SMTP id lr18mr20590092ejb.511.1618824385070;
        Mon, 19 Apr 2021 02:26:25 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc6:900:a414:a08d:9e82:6738])
        by smtp.gmail.com with ESMTPSA id bh14sm9943706ejb.104.2021.04.19.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:26:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
Date:   Mon, 19 Apr 2021 11:26:09 +0200
Message-Id: <20210419092609.3692-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
References: <20210419092609.3692-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ed794057b052 ("drm/kmb: Build files for KeemBay Display driver")
refers to the non-existing file intel,kmb_display.yaml in
./Documentation/devicetree/bindings/display/.

Commit 5a76b1ed73b9 ("dt-bindings: display: Add support for Intel KeemBay
Display") originating from the same patch series however adds the file
intel,keembay-display.yaml in that directory instead.

So, refer to intel,keembay-display.yaml in the INTEL KEEM BAY DRM DRIVER
section instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f152717365c..421e24e43335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9268,7 +9268,7 @@ INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
 M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,kmb_display.yaml
+F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
 
 INTEL KEEM BAY OCS AES/SM4 CRYPTO DRIVER
-- 
2.17.1

