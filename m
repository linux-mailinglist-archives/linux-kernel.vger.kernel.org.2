Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC41B4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbhI1RLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbhI1RLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:11:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75FC061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dn26so8971922edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZK50rgSRHZQcRqY8tXdmJANbhQZl2eXtIuEyFm2xBo=;
        b=p0qI1ttJLpR80NCXOaI+kGOK+YMfIIB7tHLhbzpVu8ykE0BmvqCbQlt/mUcQ3hLCGu
         oiUjYZ5s6vU9PzXq4FyWfoo2ptDOI2DVDx4rXN2lJ2c9Ruj46HfbjbX2p3pdWronHYkn
         iZafES4mn56y8ChKaB55Ftz2IwlqGHHl0gN5WK79KF5iZNidez7LdO88weLGQFDPGJy4
         jhFk1v2TWEF0n76qRfjgXW9yWoQpe1g6iYOypx1hZHSgP1ZQ0P097XaLcVFbRipQIgjc
         GADrcMOtuz38SdRyz5/qBTjRLrEnVBT3pgsvXU0UMxfUwhRbiViPjERkvTCPiLDawH6C
         rBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZK50rgSRHZQcRqY8tXdmJANbhQZl2eXtIuEyFm2xBo=;
        b=EShHiTYHBwJeki9cEGqLopaJ0PRF7CWSBG4vNRk6fJH2STntN9HwyYUPudjVsdScNg
         Gq9c6XxYsebXXMu93NOpUmWjz7Mvgn0c3MwmXRdgPdcmNIfMblTBWNAzL0Bmm1u0J9+d
         iJ5eFAo801L99Bfn12abIARl6jGYnoOSTNcAwOrLt0M0Ik7W8zYGODw5acEwhNpvr/rG
         Kw2yO0/dzzR8D2fnFR87Vg5cCAhvKOs6H5CzHj2nMe8LwXffEOrFt/VF7hXMjjSzPPHJ
         59ZOec6rvoh5Vi2KzQ1vUEn5QUW22wOUpXl1HB5pngdMvprGbLMmbkt1t4jlZulMXEPQ
         jJdw==
X-Gm-Message-State: AOAM531dN4nnBAiGbnS7jolnRrylkSJVOXxYH31EXwxoYSe9XmHxT5Ra
        kRNEL+Qd2yq4B3JyoGi1Il8CpxhibimptA==
X-Google-Smtp-Source: ABdhPJymT3YOYPRu80o+Dk4PLwba8nkVBFvoSnZEq5bcWFN9vIm7CfRa2aF8CuYuYjay5M66WPnc3w==
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr7808803eji.177.1632848967075;
        Tue, 28 Sep 2021 10:09:27 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-231-cbl.xnet.hr. [94.253.144.231])
        by smtp.googlemail.com with ESMTPSA id bj21sm10806129ejb.42.2021.09.28.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:09:26 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 3/3] arm64: dts: marvell: espressobin-ultra: enable front USB3 port
Date:   Tue, 28 Sep 2021 19:09:19 +0200
Message-Id: <20210928170919.691845-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928170919.691845-1-robert.marko@sartura.hr>
References: <20210928170919.691845-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Espressobin Ultra has a front panel USB3.0 Type-A port which works
just fine so enable it.
I dont see a reason why it was disabled in the first place anyway.

Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Add Fixes tag
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 7c786d218f1b..070725b81be5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -108,7 +108,6 @@ rtc@51 {
 
 &usb3 {
 	usb-phy = <&usb3_phy>;
-	status = "disabled";
 };
 
 &mdio {
-- 
2.31.1

