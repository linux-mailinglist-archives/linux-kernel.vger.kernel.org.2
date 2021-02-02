Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D6D30CF36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhBBWlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhBBWky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:40:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E4C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:40:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id my11so2391373pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gf4kfOJqBjgZQut1Ak6RJ7CzZ9ml0GBOudh5JpYetVk=;
        b=KwZ3DQvt4qOvciz72hu3rLA7tmXhQvbIyfnorLGlYChzerwP9V4aUpspcj90Sas/N3
         yGyOWU25O++ZSY5U4cqbC3upIxlIfc8ULypDfsSw87sCEb1y5iHhfyQXFk5bN6yt6C2Q
         TzGY6d1DaQrCr/jV0We5TH9MYzCRpXcCK7Lhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gf4kfOJqBjgZQut1Ak6RJ7CzZ9ml0GBOudh5JpYetVk=;
        b=nXd5UxbR/bbEV9FJzjCOQufzZrjRKHXNTe9vnKQ7jEZ1tgMxxbiUmXkJEcOLpsdkoS
         7TIHdyegTToerZXyk0GDLczRIx8uJ+11HJiweuVFvgzIZpD8pP8tiK19vlbpvdTGcO4k
         /k4SGZtbEySOC58D3n+qU44hNe3eeo3qiG4MFcZPtYP9VlI7w+ZG+plNLWDt1kuodD12
         QSWuq/bj8AHqC6vMwxfQiDpj/1lI0JcNth/qZirG7PM4+BnWhsHCodmK4Sm95cCjoSeZ
         F2wjrUhAv0nF1hIsr1iVT+K1hPR61W1kURIx4capUvgw3Dpij3Pfj08Dp9FN7DDK9ZDu
         B1XA==
X-Gm-Message-State: AOAM533wQsHLQ64jkNS10NuOa4jx5/3fkkgbyJN0SB8oqbJKZhYvpwrx
        VAPX83Qu/f9ndX/UVAFjhdVnxr49Y5sLKg==
X-Google-Smtp-Source: ABdhPJzfxnjZDL694xQTMjC5qo/2mi9JhXjDMNILkyQLkUDdExhVNGk7FQPOEtlC1sn5YAx8dtutOg==
X-Received: by 2002:a17:90b:3751:: with SMTP id ne17mr44170pjb.174.1612305613177;
        Tue, 02 Feb 2021 14:40:13 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:b5ef:2e43:a515:f29c])
        by smtp.gmail.com with ESMTPSA id l3sm24424pgn.8.2021.02.02.14.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 14:40:12 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Decouple partner removal
Date:   Tue,  2 Feb 2021 14:40:01 -0800
Message-Id: <20210202224001.3810274-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we return if there is no partner present when
!PD_CTRL_RESP_ENABLED_CONNECTED, without proceeding further. This ties
partner removal to cable removal, whereas the two should be independent.

Update the check to remove a partner if one was registered, but continue
after that instead of returning.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e724a5eaef1c..91b8fc1fd7f3 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -638,9 +638,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 				 "Failed to register partner on port: %d\n",
 				 port_num);
 	} else {
-		if (!typec->ports[port_num]->partner)
-			return;
-		cros_typec_remove_partner(typec, port_num);
+		if (typec->ports[port_num]->partner)
+			cros_typec_remove_partner(typec, port_num);
 
 		if (typec->ports[port_num]->cable)
 			cros_typec_remove_cable(typec, port_num);
-- 
2.30.0.365.g02bc693789-goog

