Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE534365E59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhDTRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhDTRQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:16:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68531C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y1so4381071plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6DmW3TpogHtwf05Mzz4gRFI9mozL7Twx+0WqjuCaWQ=;
        b=d5aRXR9grdGoscfdsmnCGO3EqpwppVHw/H7vXUKtgEugFtUUQmyl/XjhPuVsIkdrGZ
         +jtaZ+ZlUZ+mheP28N5LZQl6F43CLPeyJc7OlAYMeEF8RQ2XgvA4z6CcV7d2qsnqSUSY
         bZstMcHHhoJgRugPEBCFaunGu+nYCE9v9zHQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6DmW3TpogHtwf05Mzz4gRFI9mozL7Twx+0WqjuCaWQ=;
        b=LMIE089tSImszUIBlwniV7omG4HJkWxRPn35x6GeFIli1lw+4vcj54a6Ze4/dOc8rY
         IcmNXGsVtkitn7zG2jHCLy39xpkvljeRyopmNU5gI1MXZgrKKwMzdXVqFE/Q6PGYAit1
         2AFro+7Vy2IILtkECQi8QLWrAe7zH1fbtZhRZtHjVgxZ6Z6YXt0QxEk5J3BXWqCBryni
         HkA2u3IqazGD0cr5UvAyhXnrCLSCjyu29d0/6rar32CUVOAEiXFr/+J1SsnLzIH3rUjL
         4CIfV73XbSL+5dgp7sAOV7QhRZRRo+DtfnLQYLzCifTeRGeqS1aJkJC5WRA9ErEeYUhD
         8Jtw==
X-Gm-Message-State: AOAM530//18GwKGbZpgxE/PrIruBEpdAsx61ee/bJGbw44pg8XpS6FM3
        bVtqsKV5Ec39WQD8iI3UkcDKJGz5fv95Yw==
X-Google-Smtp-Source: ABdhPJzpBQvmisC9OIliXURa2dyI8c+yKtcag4eruYgRexoeHp1zN6Zzinu4OoHYh6hcfT4/cc/2jg==
X-Received: by 2002:a17:90a:1190:: with SMTP id e16mr6124673pja.110.1618938982810;
        Tue, 20 Apr 2021 10:16:22 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:ee88:6ec6:b8ee:20b9])
        by smtp.gmail.com with ESMTPSA id n48sm2260384pfv.130.2021.04.20.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:16:22 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Subject: [PATCH v3 1/2] platform/chrome: cros_ec: Add Type C hard reset
Date:   Tue, 20 Apr 2021 10:16:11 -0700
Message-Id: <20210420171617.3830902-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the EC command header to include the new event bit. This bit
is included in the latest version of the Chrome EC headers[1].

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3:
- Remove Change-Id tag and add Signed-off-by tag to the commit message.

v2 is the first version the patch was introduced.

 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 5ff8597ceabd..9156078c6fc6 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5678,6 +5678,7 @@ enum tcpc_cc_polarity {
 
 #define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
 #define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
+#define PD_STATUS_EVENT_HARD_RESET		BIT(2)
 
 struct ec_params_typec_status {
 	uint8_t port;
-- 
2.31.1.368.gbe11c130af-goog

