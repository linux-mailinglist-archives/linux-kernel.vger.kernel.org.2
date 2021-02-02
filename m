Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33D30C623
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhBBQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbhBBQg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:36:29 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D5C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:33:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so15239429pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAEmX4T0SFhCX900Vx4u0Ymo1oePmn//2Jt6pbrxJRM=;
        b=P4NrsAe6VNaTkp+kWO5WECdGg5XEKewsuFO7JZUNV6F7jEkq0C/9vP23BBB57HoGAx
         vbB6CjOlwF3ataZYUKLSpnvjkLD/+6VtqdoOK+nlXrbOLVNvLXUhECvB90dBJBO//Z2b
         h3MYWqBXNHbMBnWqnPLAvPbUJW7dq4N6KPS9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAEmX4T0SFhCX900Vx4u0Ymo1oePmn//2Jt6pbrxJRM=;
        b=eyvL+mF6ZPEHEMR2UbREoASH7nupmZ6jIDwPObRYuEZ4tmHJKjSoGqFxqNCESvEH7d
         tvWzCnCrJ5vPdGOXsHKAyVN59j2WxgD5MTzbbfphQKUMO5gLzU0WMuB/aFz/eOSdZYKe
         0w9/hyBoY3/7kP2Ixa/QwBFB5ikQeCiSbW0P2BSgY6IuAP5za6ZhYlCfgJ58GwFWN5cb
         +6tamZlAKw/Bwvde9xk7citxv1FEGe+5SuW2ZhFv/X2ys385j1Q897s4I7dHT4K0t49J
         YvisoWj+HG55Vk7ayQwV5heUHGwj5K/T4EXHynzRf814mC+S90JLUMwJrCEftsVMj0WJ
         I+NQ==
X-Gm-Message-State: AOAM533m65SmCC7/rM8ak2y4adrjWKy24RZrEsmZd9dkZmYmyRzT9Hgo
        +qmuHoSNB55FaxAIbJEny7XuOg==
X-Google-Smtp-Source: ABdhPJx7beim7GgN+Jw1TKGiM6BGWFthksNDqUSEVQjVdn+wX6KKt4N6o+LMbQF8+5fuM+xj+r0yJQ==
X-Received: by 2002:a63:5b43:: with SMTP id l3mr22400040pgm.369.1612283586702;
        Tue, 02 Feb 2021 08:33:06 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id i7sm22362511pfc.50.2021.02.02.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:33:05 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kyletso@google.com, bleung@google.com, bleung@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision
Date:   Tue,  2 Feb 2021 08:32:48 -0800
Message-Id: <20210202163248.3981555-1-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_partner_set_pd_revision returns void now.

Fixes: cefc011f8daf platform/chrome: cros_ec_typec: Set Partner PD revision from status
Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a7778258d0a0..7b93dfd02999 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -842,11 +842,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		goto disc_exit;
 	}
 
-	ret = typec_partner_set_pd_revision(port->partner, pd_revision);
-	if (ret < 0) {
-		dev_err(typec->dev, "Failed to update partner PD revision, port: %d\n", port_num);
-		goto disc_exit;
-	}
+	typec_partner_set_pd_revision(port->partner, pd_revision);
 
 	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
-- 
2.30.0.365.g02bc693789-goog

