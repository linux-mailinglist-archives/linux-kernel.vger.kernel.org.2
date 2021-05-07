Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA9376B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhEGUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhEGUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:21:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 13:20:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a22so9232809qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=IBj/oZGsokAaKHrJmMkspt5KMjTgwL9D5Zw2L25XmNk=;
        b=Hg1rtZXFeW6k0VRLwuyxYAG198xLkQPyq0rq2h1n9KGeAISifksU5Jqqfcuf5OEE37
         46cb7gU2WIcCR6fPIba4AOAB/ebM3SAwW3qwcUNcKIQei8juISKEqcVJPflc1ZQ9o7yd
         5u7tPIdp5UB0K4AfMUgXdauaUtlJhLIQn9Ut9pT/jEIFUiz5tkNXY7NBKmd8gXQdGd3/
         Ihhbjhx1BOn5rtrw6cchNsqmopDheG9DVRvbAP/IyZcVd5nI5CDj1U2zxTUIUIG6Oce+
         ueDV+oM5bTPNH3ARStg4Bqzw82+ddJ6rMpopg9J+9kQEUc9rQ50ZehwVqIrIMv53ulrE
         IrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=IBj/oZGsokAaKHrJmMkspt5KMjTgwL9D5Zw2L25XmNk=;
        b=PoUzj6vAMCl81pdCGbYLPzylT2aIRat1uPR3v8574l6A3TIbJUQiMj2PRiq/NJ0vDh
         g1uyVvgODPi4PUeyAUJ0RcGln62X1/Ye/QTm3OgY3WcJ+5gSi7IO/xzBAz6fZTfWWjGn
         VV0tsPrmDSNAoD81vsjOSdY13YjmdGSvUpveU8qqUazenkSPoF/THbOw2nYhwSvTB3ZM
         7hrjWfyBfKOZudYh0GIfUavCI7Gqb5tI8LSzEqayilpYJQmBcKHI7sGs9NIZk0pCYemZ
         yOUsVRJssElUXy0HmLo9fSO2g3jJTarAQYguyvkms+QC8rgzcsOofXEhHUrYCBdLjgOg
         KIRA==
X-Gm-Message-State: AOAM533V7Iycpb0lh98/z+VKQ5IFTMz+fdW9qDRWO75wLDtunvSkt/Zm
        880kO9swW1zD7bMvUsFQ6nyJtgJ1KHqGpOe3
X-Google-Smtp-Source: ABdhPJwus0Ph9xG7MvqxFxPk9LK37uTs096ZLwxIn0l0Ix59WRUCyLGpRDMDo618OkJJVrzzFytLjg==
X-Received: by 2002:a37:8906:: with SMTP id l6mr12145662qkd.198.1620418837280;
        Fri, 07 May 2021 13:20:37 -0700 (PDT)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id g13sm5320343qtp.31.2021.05.07.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:20:36 -0700 (PDT)
Date:   Fri, 7 May 2021 16:20:36 -0400 (EDT)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
cc:     Dien Pham <dien.pham.ry@renesas.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: add clock management to the SCMI power
 domain
Message-ID: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks requiring non-atomic contexts are supported by the generic clock
PM layer since commit 0bfa0820c274 ("PM: clk: make PM clock layer
compatible with clocks that must sleep"). That means we can have
SCMI-based clocks be managed by the SCMI power domain now.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Tested-by: Dien Pham <dien.pham.ry@renesas.com>
Reviewed-by: Gaku Inami <gaku.inami.xh@renesas.com>

diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 9d36d5c062..4371fdcd5a 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/scmi_protocol.h>
 
@@ -52,6 +53,27 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
 	return scmi_pd_power(domain, false);
 }
 
+static int scmi_pd_attach_dev(struct generic_pm_domain *pd, struct device *dev)
+{
+	int ret;
+
+	ret = pm_clk_create(dev);
+	if (ret)
+		return ret;
+
+	ret = of_pm_clk_add_clks(dev);
+	if (ret >= 0)
+		return 0;
+
+	pm_clk_destroy(dev);
+	return ret;
+}
+
+static void scmi_pd_detach_dev(struct generic_pm_domain *pd, struct device *dev)
+{
+	pm_clk_destroy(dev);
+}
+
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
 {
 	int num_domains, i;
@@ -102,6 +124,10 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
+		scmi_pd->genpd.attach_dev = scmi_pd_attach_dev;
+		scmi_pd->genpd.detach_dev = scmi_pd_detach_dev;
+		scmi_pd->genpd.flags = GENPD_FLAG_PM_CLK |
+				       GENPD_FLAG_ACTIVE_WAKEUP;
 
 		pm_genpd_init(&scmi_pd->genpd, NULL,
 			      state == SCMI_POWER_STATE_GENERIC_OFF);
