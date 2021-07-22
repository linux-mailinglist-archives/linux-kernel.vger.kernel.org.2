Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8310E3D2759
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhGVPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGVPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:31:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405DC061575;
        Thu, 22 Jul 2021 09:12:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f9so6499270wrq.11;
        Thu, 22 Jul 2021 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bqMHX1s5ON0P7G769ywkrdppi3QjEs9pnjlyttXWnc=;
        b=RXwkYkexQEKkLCXsqRryuyPidSJ+VOWO/PGQdljrghi5ZDOAFYv2W3wQtJH5zpT+AX
         4QPeETEkT0omWmfD5GAIL4bUm5HPaTtlgJ4vdOZ69mKKiKiBhto9ZDaCNHv31qRuvLCq
         27g0cGUHOjIfjINu7EfhLPBkegXxlIaBcZoPyGIyJKf4AhFmcI6SlgQ4RXUFOtdMzNJK
         NcG85ptmXPoQwyQMDBhsgpgId6+LsqlO2IRf9SvocG+QzSPepLBP/RixTDFWD9/8j+4J
         VqxKO3XAYHPr6OBKnMAnwwsGbsVSo/dKceOilV2R+MisanFecvHKQzqKnfbP3qNmkwkL
         kjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bqMHX1s5ON0P7G769ywkrdppi3QjEs9pnjlyttXWnc=;
        b=EPUUmrekETbMM4A2erCKNg/4rrVXnbXNDZLGZW8LveT/QjlVWT28pnA3ScV1iOMcTD
         5SI8HcO7SUevj9Hxx4ayfhiq8HWz+X5a2BsrsGYk23Bbvi3lDrbwJJyVF+5KUQ/uKTt8
         fbU83uyyLiBj9RGu1fqi8uKS4fVw5NLEWNcGdEMXAXdR9qmereAtzUvbnNK74N6APdmy
         KnAv5CXrLj+mbzbxoZNPnjNYNYeVqibZJbpBprbQ9zmqfwUopWEQs+DeNEwtyRoKDfzY
         lS6VYkrh56l2dMrNYT2Mbrh7I1/gfldRNxyORRzimC8ao18hbNOZH7M89BwDUMwKieRD
         mpaw==
X-Gm-Message-State: AOAM530kIuvi4ZhJZdcK4npBF7Kfxc7VjGEXNGd8LsTgRcVNaLX66iLb
        W/NJiy2L69OHCARHuOXByXhF/mLlVoiKZKrC
X-Google-Smtp-Source: ABdhPJzdIlGt7hRUSmmIIGbdzgB8uOb7SBIsZVTfRdyRalx7H7ANG9HEXZMzxgR29SzoxNaiLfp8Yg==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr768096wrp.142.1626970349607;
        Thu, 22 Jul 2021 09:12:29 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id z6sm3585363wmp.1.2021.07.22.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:12:29 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Date:   Thu, 22 Jul 2021 18:12:20 +0200
Message-Id: <20210722161220.51181-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722161220.51181-1-jernej.skrabec@gmail.com>
References: <20210722161220.51181-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has 32 GiB eMMC. Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index cf9721ca6370..8f2a80f128de 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -98,6 +98,16 @@ &mmc0 {
 	status = "okay";
 };
 
+&mmc2 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
-- 
2.32.0

