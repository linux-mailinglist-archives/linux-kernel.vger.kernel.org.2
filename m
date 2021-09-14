Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C529140BB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhINWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhINWXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:23:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A68C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so689957pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olUFE1LkbNQHA2J0IsYrjUSsRKYV3fY3xyKo2i+EIO0=;
        b=pQUWdsmfXNCRz4/tj19jQ2wEPfGmoSG9qt1uFqUKwC10tSvYFbiRyS55syYOj18NBM
         FMlJ1SkifGZ8STw1ifGZRoJFPV9mH2MzqlOhzQ+gCpiXwplGjO02xuMKK+MyF1/8hIfU
         aiY4Fg1e/M/uSQ9+5qn7Lh01mFfO19wm8uisG8fG3TviG0YrgdO2iakd45kiAKv2NCUT
         KNbkJBa/jnSxI+a7GFwWQM/4USoIHGl6+EonPcLloKnoVCBCWEIiRoVQIcvkGiMjYPtv
         3uFZQpjy393eGypG4qwik2SK+0StLrbpMB5m464IOSEY2uTsgfa7JCe54suO0XjZUFdU
         ac8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olUFE1LkbNQHA2J0IsYrjUSsRKYV3fY3xyKo2i+EIO0=;
        b=kGx0IALkBePF+IHo73TDzVtadmTKUKG9VvKFZfS1/Za+Dc/M8bScJssg0XTFvcfNnb
         IxFXPRWAMNHemazi2FRMU1fToToip5higrjqPiGgYqujJX/3Ky2zwyUyk6uQLXhTfKMA
         Gcnu2mEzgAH+e55YJpgm7xiayrS/jstC2X0AHwEiP5MHHbrKbq0j1LM98HhCdoI2a5i/
         GgVyZGPIZ6v45MrtY9rL40uvJmtsyt6isDu3YhVKpZvvffpQM8t6g46k3YhnjVnxkerf
         nyNRqstqrylG6dZG2HPZLh8gBSKbjrhtKnsM/bOtsr4O6NI/sVWUUXi5lXSPLa/PbVum
         8Zxg==
X-Gm-Message-State: AOAM533iFA1Nqj14r1yedStRzHfi2fJInEEauwb+sx7yipFRvJ/xJIYv
        ThTtfjx0NsRhlrHNbDAx/TM=
X-Google-Smtp-Source: ABdhPJzU8gcHNdoKRqQi7HVBFi8kJ21au8eNvFbw3BdOenk2sk02n8TLPp8zRpaFl4etj2jFfMz4aA==
X-Received: by 2002:a05:6a00:2188:b0:412:444e:f603 with SMTP id h8-20020a056a00218800b00412444ef603mr7015445pfi.86.1631658116783;
        Tue, 14 Sep 2021 15:21:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14sm2694951pjq.13.2021.09.14.15.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:21:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72113
Date:   Tue, 14 Sep 2021 15:21:45 -0700
Message-Id: <20210914222146.214115-3-f.fainelli@gmail.com>
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

