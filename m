Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1540BB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhINWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhINWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:23:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so674208pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olUFE1LkbNQHA2J0IsYrjUSsRKYV3fY3xyKo2i+EIO0=;
        b=d4Nlcp3AxsX61DSSqBsy5I1yR4+xJGoAB8rLgVdarLocD4QILV9ODVh5DjouS84A1n
         LSBgmt18ogqXYDvcINlP+EwliSnzaYeexWtoE0BsnEm3sB+eKuh3E8XULgbnmbU91Qia
         +ehIKTG0CgwhDtW5/T8rHVtdhd26OwX4GXXB+bd+7x7oEe2Df9zAnlRtELw/nanrMwNU
         uoMnjpn4gf1Mpr3U7M/4P+3btM1G1wlTa3CvVwK4shNbllc4HiuKYGmqaBh3I19TqCYn
         WX5/g6k74XMQ35nxRaMhws4/a52UqJWwsW7IH+MwamPwyddWWPjTg52h0C/Ya9UI9RA0
         gH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olUFE1LkbNQHA2J0IsYrjUSsRKYV3fY3xyKo2i+EIO0=;
        b=dGkvvOiGEXcaOHQmXl2oF3UWdsJne6qbAqv3c68lpptDq8yeDk2xW4h2LKUEHtJ8HT
         wDfaai5xyjfmrVLLpMaaurkjbwRscXiEFWp8qIkTiKEoZ1tqto91WHZdY81ve67r7NtH
         qpuXe18YFyLHDuvfk16qtH01ENo/FQBwhuzoNmhV9opzCWDBvPjB3TneYrKcGchXD2ka
         5LCvspDWfVWpkAmhHTw7ppWsJEw1DZe9Dm3XpOZKpmDfLgVurZyWed+xaqWvV1b695dy
         gZDeXGAR85rptNdSGyJDMOVypV0SA047YF8VQogtiLnwmRrYb9JFDbcCjonTEV3akNJe
         9O3w==
X-Gm-Message-State: AOAM530gVYXuGQscRQXw965vW+keGVQyF6bOThwJSsIGhkDieno2voI0
        00EWUP68Y9FeGQEwRiWT/hvDq+Ly5WM=
X-Google-Smtp-Source: ABdhPJzMO63q7KwqYpgYuSsDq4SoCKOWK/OS5YPJEx56wd0bvz9BlAqk7i/tmudpujJDeouTjj8zLw==
X-Received: by 2002:a65:6648:: with SMTP id z8mr17512840pgv.418.1631658115501;
        Tue, 14 Sep 2021 15:21:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14sm2694951pjq.13.2021.09.14.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:21:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] soc: bcm: brcmstb: biuctrl: Tune MCP interface for 72113
Date:   Tue, 14 Sep 2021 15:21:44 -0700
Message-Id: <20210914222146.214115-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914222146.214115-1-f.fainelli@gmail.com>
References: <20210914222146.214115-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72113 uses a dual core Cortex-A72 CPU complex which requires tuning of
its bus interface unit the same way that the existing Cortex-A72 based
systems are tuned.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 7f8dc302ae6e..e6579fc82b9e 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -136,6 +136,7 @@ static int __init mcp_write_pairing_set(void)
 
 static const u32 a72_b53_mach_compat[] = {
 	0x7211,
+	0x72113,
 	0x7216,
 	0x72164,
 	0x72165,
-- 
2.25.1

