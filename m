Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF3393FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhE1JP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhE1JPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:15:50 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85373C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:14:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so4151413wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDOJscwMhR8iji5F8vTyzpyDdL2c4rVCTLrFY76zsdo=;
        b=G45Fe2j5tJR8IhOVQgq6lJYIwNxx25/ft+H4yJZepoBdCbBfsWMNA6Xb3dDeSlaewI
         jDhuGHmx3uQe+iZE9P4NTkLaovkoy6gbp3atL6Yrxo7eR7szR9CUbUf1q9pDGnMPjL3z
         JpFYffLOMQof1UBuJk/bqgDvPiHf5u3bJH+1nRylaN7it/5uY4oAUBS6dn4IFGdZaLh5
         s+X0gS5M2zzIuapSd7xXbJBjp89nfWH5Uz+0z/fC7QM6iJ2XBmEn8j7L8SwZF4sU85b0
         vI1o/Kns6XsxIVtfOAlIx+wKkVojoaFarlI/9S6AOXmBQSJ6juun6AxCV+nDJ+23mlg4
         dZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDOJscwMhR8iji5F8vTyzpyDdL2c4rVCTLrFY76zsdo=;
        b=dXh2o6FBEvayHDGLrIKHGHGCseghEQEsyPaRyI8ViayarFrbwfkmRsOGLC42S52bzc
         nGgdsQLKmukGVmDZ80djexEh1CmO2AtTqXQ9BiJYldCcOUxUgfiLAuXzNPgLI5amk9fT
         pC7hsd6DnfXYNemUkFSxuG3W2rvOcw7Lg/divq+dt+pWL/qUIfLz9/B0nQynCkwy6Akl
         fkrJu68ScPI0X6gG8fAk6022V6YvTrgPu2zsU/RwFQ/D5SAXAW6erO2xFQ4QWaek5aoj
         0nrMcT4u6aZ4PG0jbdv7hCBfEhZzpFRRGU3J25/BVr4dCncPALDRo4Pqe6csJhEL6afV
         Bq2A==
X-Gm-Message-State: AOAM533znSmYr6/PPC1aSH+9rPUgHe1Xi7ufjc65EcLLVlKWlMoSJfFZ
        rgErTzQZiIjKWmEEivVgVAxDfQ==
X-Google-Smtp-Source: ABdhPJzziqNFHtrXPxF5dFvbCO1aXhH4+4X10jIWfi7UZwcGkDpHML/Jgu+b0Msy878Bm3TsP7vDpA==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr12329684wmh.32.1622193252133;
        Fri, 28 May 2021 02:14:12 -0700 (PDT)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id h13sm6329061wml.26.2021.05.28.02.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:14:11 -0700 (PDT)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH v2] usb: dwc2: Fix build in periphal-only mode
Date:   Fri, 28 May 2021 10:13:50 +0100
Message-Id: <20210528091349.2602410-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_suspended member of struct dwc2_hsotg is only present in builds
that support host-mode.

Fixes: 24d209dba5a3 ("usb: dwc2: Fix hibernation between host and device modes.")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/usb/dwc2/core_intr.c | 4 ++++
 1 file changed, 4 insertions(+)

v2: Correct commit hash used in the Fixes line.

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index a5ab03808da6..03d0c034cf57 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -725,7 +725,11 @@ static inline void dwc_handle_gpwrdn_disc_det(struct dwc2_hsotg *hsotg,
 	dwc2_writel(hsotg, gpwrdn_tmp, GPWRDN);
 
 	hsotg->hibernated = 0;
+
+#if IS_ENABLED(CONFIG_USB_DWC2_HOST) ||	\
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 	hsotg->bus_suspended = 0;
+#endif
 
 	if (gpwrdn & GPWRDN_IDSTS) {
 		hsotg->op_state = OTG_STATE_B_PERIPHERAL;
-- 
2.25.1

