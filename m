Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700443AD32D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhFRTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhFRTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:53:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EDC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:51:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m21so18427192lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMVSNrHGcdt1vbOgCt0p2SZ9LSnvDYsg9SnZkED+C08=;
        b=OI+p8vNSYtg5dOKoFneDPR48HNRCn5+KtmQCC1iEiqeAkn90I7DNnoQ+1FM+nplYfP
         3G8Bcf6gj2Veo22h9O+8GD5/NmlqM8wVuLUEXuYSQW2TiFmCI9geu61KyyJITWbw4dD5
         RwtGyFY+nmPaVQBF6pZuo1fQ5EWDOIUpdiyQjvXGWoHvzaqaB4tHqISE3lOa0p8JVH16
         aKRi/LfxMyvI08TLkYOS1nt2K6i8a6wCsffNAMk+B9/AG43n4M7EhkqVyFlW4QlHAsA+
         CEvkfsnwzQ7BtnmuP9WaFc5g9E2fRp9jQnDGC/Ik0UMdQ36Z4YnZa6uPHeMXDgmvtEFc
         DvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMVSNrHGcdt1vbOgCt0p2SZ9LSnvDYsg9SnZkED+C08=;
        b=qQ5njZHK3Xni97L4QlFUw6OmQdkFx36MCElldyv7A4iP8jU37JQK5GUe3E4dPm8X3B
         SnGayuzAp6tzAy/MPeju+R3k0ieR0lXESa6HNPUBV5FGzh882BoHffVZZ1H7ZrhmVUho
         eJ6iC2E7H6tKJyvDwthpML8bEr/XCHpZ/CRc8NwflrBwBjfRbZOjQ+eNYD3MXvzB7XDB
         igXDYKa5u5HkgGa0gmBRpMVPjiLsD5L5ZQID/ZP+3wv3ldfHNRaH4zrpjOUqI7Xi+9go
         VpJm8CiyTkLKGTnbq8W3Kn0bfsaDiyM2Nlr5WKZdcCASgI+D7PyOlPM/EKKJggw013vn
         8I/w==
X-Gm-Message-State: AOAM533aoGyh7V4rqhkDjqZ/Xd4ZbUnsrO17PUPOkkpleeqjTTxr/QeF
        Ux5OztAxL/fcmBIKHXviuphKAQ==
X-Google-Smtp-Source: ABdhPJxTn9yUM//lgUINg3OMvXib0w3U1/wNLfUqdwLiM++zP7wiXYpSlpAY/I1XHz3rygGFqrs0KA==
X-Received: by 2002:a19:24c3:: with SMTP id k186mr4452699lfk.472.1624045867006;
        Fri, 18 Jun 2021 12:51:07 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id o7sm993221lfu.215.2021.06.18.12.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:51:06 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        grzegorz.jaszczyk@linaro.org,
        Michal Koziel <michal.koziel@emlogic.no>
Subject: [PATCH v2 2/2] watchdog: imx2_wdg: notify wdog core to stop ping worker on suspend
Date:   Fri, 18 Jun 2021 21:50:33 +0200
Message-Id: <20210618195033.3209598-3-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210618195033.3209598-1-grzegorz.jaszczyk@linaro.org>
References: <20210618195033.3209598-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend routine disables wdog clk. Nevertheless, the watchdog subsystem
is not aware of that and can still try to ping wdog through
watchdog_ping_work. In order to prevent such condition and therefore
prevent from system hang (caused by the wdog register access issued
while the wdog clock is disabled) notify watchdog core that the ping
worker should be canceled during watchdog core suspend and restored
during resume.

Signed-off-by: Michal Koziel <michal.koziel@emlogic.no>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v1->v2:
- Do not use watchdog_dev_suspend/resume directly, instead notify the
watchdog core that the ping worker should be canceled during watchdog
core suspend and restored during resume.
- Commit log was updated accordingly.
---
 drivers/watchdog/imx2_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index b84f80f7d342..3e8d9c3b6386 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -311,6 +311,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdog, nowayout);
 	watchdog_set_restart_priority(wdog, 128);
 	watchdog_init_timeout(wdog, timeout, dev);
+	watchdog_stop_ping_on_suspend(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
-- 
2.29.0

