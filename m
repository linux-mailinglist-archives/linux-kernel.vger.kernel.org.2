Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6632CB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhCDDoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhCDDn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:43:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F2C0613E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:42:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i14so5655877pjz.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=krHS8jj2QXNypospcYRERtT0+swfUgztdkYoHNFA4VXLWuLUzq1MJ2lTyCbONQ9lm3
         SW3+pEdHNibO6/v+AT+N1GXAJ3vlyfPvJBuznRg8PgvdmrSRvXHM1bbvOrgxmVS5NFTB
         fsk65ZMoYfpHFyxr+mc6JuuJoVsUtoeBzr4GpksP3Esx/CZGRBiGwBID782USqdyJ15n
         SqDOhFLlS4h7sR6YIdE+UcuCjTzzbET6pA1nFw+OzZp8yejsYPff5nNC4DloJ5AXxa9+
         SyP2ksaKSvomzTQB22fRNsD3Qqy3qjWN90i7tG0rDH1dBA9CYj4+3a1nAU5Z5VRw5NV4
         4SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5evIgUHLH3iE2TL4J3188f+WN89LXupcPiWpSn3upRg=;
        b=kKbS++57upUZ6LHHuPRD0f3C6sKhC67p6cxPthNPj67tghp2oYESH2y0ZcJzS57xhD
         AXd35MGFpHLdCSWHEyKico0cjmWGxWMd6tYQLYRzX2eSzPkClvEHrswhuFErTLRSIXav
         HV2P5UfZuKs7AlZ6CmqAm6owOLB8mJDthbKyVz1aqYNGIQKOnQqAdUF06x2i//zigTIV
         bJX2Y9EfRM8eNeoeSoughvOeB0DealA0MqtIY6vrYYXPBzD9jpMOnJ/GhXcTFq8Z0Q7x
         Nw3OXKVmpNHQbSVjSt0g0jSE9bpDgkEKJC4AXMBbLKE2sfX+X1oJaqJ/E9ITbbEvs2wV
         upcQ==
X-Gm-Message-State: AOAM532+rl7jg0dNM4hCZ0u7po/a7PNgNAVL9pFe8O8q+VN8L0SbAevp
        Vled57eq2ByrT2OoM0a2NhO5Rg==
X-Google-Smtp-Source: ABdhPJyE5bFbeBfYEWSJ+gwpOI0+z1XD9msbhoODqnXnZy8LX7goajm/FKghGMdptdJQWuIweGqeRA==
X-Received: by 2002:a17:903:2491:b029:e4:16d6:e0a4 with SMTP id p17-20020a1709032491b02900e416d6e0a4mr2197194plw.64.1614829349158;
        Wed, 03 Mar 2021 19:42:29 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:28 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] spidev: Add Pensando CPLD compatible
Date:   Wed,  3 Mar 2021 19:41:37 -0800
Message-Id: <20210304034141.7062-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pensando Elba SoC platforms have a SPI connected CPLD
for platform management.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8cb4d923aeaa..8b285852ce82 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -683,6 +683,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
 	{ .compatible = "cisco,spi-petra" },
+	{ .compatible = "pensando,cpld" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.17.1

