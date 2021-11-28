Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98402460646
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357531AbhK1Mz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbhK1Mxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:53:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F818C06174A;
        Sun, 28 Nov 2021 04:50:39 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p23so17469249iod.7;
        Sun, 28 Nov 2021 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1VqIbvXbfTKkfvr8bA9EiHuiz25WgDuXsZ91LcbZA0=;
        b=FGwu3bLcFDDjMr5SjkoW8jG1Gv8aqRZ+o7V50sSibyYpt7aknoVfOtvqZ/Ah4Lw83z
         /OYQUSltlkM+ymSRQhTXwrVmwug55PZVABjrZdED2nfzG1k7i6yScz0+7jLaf/aYj8ft
         yIsJpvkMojeLNgnUiVJ1ni7EmWAugSCj4407dblKhVjA9Ij3+E+ysgxzXUQm2NxPSaOH
         RFnviXNalgPUxqFmZgkPW2XCJ4o9CaJLId9HPwWBAM9ZBtCcTu17+ydNMfLQpRvoYuJS
         ALRShOO2Ha2qNcMC/HfhGZ5V2RC/DaSj3jvg5paLusaC6N7/up44B4EaRTQY/i1J0txr
         iCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1VqIbvXbfTKkfvr8bA9EiHuiz25WgDuXsZ91LcbZA0=;
        b=6etQ82GvcQz/nujQv83wdqEyniJA4/CxMScm0h9nF36ebrX5khpyO7VMCl7neUuCq4
         dJaDDjps3T6bWT1ZPgLJLUuXUK5vd0wNlOBEPTFEWibMeSpKKqmnFoveyfGKFQCEHZSJ
         /QG3VajMyTwm3bvI9jLB/ieaLXNbnS4x4XXtqNjyD5SH2/aX9J9ndgaF+eO3B/ZlpD5Q
         KTifDbrbo/NwVvtklb1pW7fOVngF8GVcWIJ1+xym/Stf8hwH/CSnWRz6+5TKNid7+pCb
         5I8jVT0yd2N2jsn5VA/VvX9wUPdvxcK857gbTa252rYmIMr5JamLzvaxgzFyu+gXjhlX
         2HKQ==
X-Gm-Message-State: AOAM533i9pRCG1YBxhv1NTR67lJVYYn9o6Pf+VyohsRRTmKss5wo/2Xb
        hnPtRoC4xXdyJhO+1QbsRgQ=
X-Google-Smtp-Source: ABdhPJzm3jlXpOxi+qKFMRXOWTCXNW0Lz/N5ZBIjHN9M7x3rQGBgA2A42gmbI1c4fXuRwU/ww3wfLw==
X-Received: by 2002:a6b:7c46:: with SMTP id b6mr54543418ioq.129.1638103838468;
        Sun, 28 Nov 2021 04:50:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id j21sm6545240ila.6.2021.11.28.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:50:38 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] arm64: defconfig: Enable VIDEO_IMX_MEDIA
Date:   Sun, 28 Nov 2021 06:50:09 -0600
Message-Id: <20211128125011.12817-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use a camera, the CSIS and CSI drivers need to be enabled with
VIDEO_IMX_MEDIA.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
V2:  No Change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0da6a944d5cd..8df432182275 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -959,6 +959,7 @@ CONFIG_MFD_CROS_EC_DEV=y
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_HANTRO=m
+CONFIG_VIDEO_IMX_MEDIA=m
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
-- 
2.32.0

