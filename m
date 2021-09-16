Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2D40E5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbhIPRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:15:23 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59424
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345135AbhIPRIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:08:47 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 198DA402D8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811938;
        bh=dlCoWNlSGazTh8Qcc02M/YkZ2Um4v8y/vWjZioKN8vA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dyB1IO8Ocwm7eTlrg5OPsz+iv4abacJUohmQPIyjEum8MR2yLYu+XvwzYzT2ljk/K
         P4RP1xXykSanVQy1nK6KNpdz/ZcOnuX7mdtbvrxTYVGWIS3S2MZo6bh8KK3wTy0vdn
         cAVm8xTLWX5/6u3u8X+Pqz1X8WKQEHFEhihrnkC8ItItvacyJwQU9OTcOMWzJflSIQ
         HjoHSGLVKvKtDHGbCvQDRttfRN2NuXZOvbN0kKAz0sEPaKixLEjcZ09sJZg4j1ZLDk
         /SHGKwUvh7LYYtARmRFPlyoHaVferJCjPo/8b9x2BeqdAj9ML4YXSZHGJXCRaQ4VpJ
         xBzWcP6bDT3UQ==
Received: by mail-wm1-f71.google.com with SMTP id j16-20020a1c2310000000b0030b3dce20e1so583682wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlCoWNlSGazTh8Qcc02M/YkZ2Um4v8y/vWjZioKN8vA=;
        b=Gdk9jhJ4Nu9AUK/4b0sVvwdNReyq/VMfjfEMxOvJEB2zcfnbwFtzVS5n3KgPRbXKrt
         5ukOFTlrDiD9Q1iVdBI0D2WNpXktkt8UYgk8vmmmt+YsLDm0LOczPawAWRILQqnEBWzX
         QFvFNDv170QsUjt6QhAhzqZQmW/CzYV7VOGgRYAZX00MdG0MqLuvbI9femIrZdemYQhd
         j/5zJjPm8cdxb2v641SPSaQZhRSsoIoS8efPuqvwmJE0jla9XLPxcR/izPsi6O1Y5L7Q
         vflcA8NvZ/nysPjNKZqlRjklPu0SL1L2FJEr3EImxnyKeGfV9JLSjEQOAL9Oz/0s5V09
         wkzw==
X-Gm-Message-State: AOAM531xiOf3X1AztMP+iyd+r85vKT8onnaF+w05Ii5lGaS/z+uOrCcT
        SvleIEIAFcqxsQ/zwzTHBfWz8IXtHZdZ5gumhhHrI8xVZH1/vGmzQymDzj8VW5p+l2RXXb3fzmn
        S2UiE689LpOz+iom69qorCV9XwRFoPet1LbJJraI0PQ==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr7475983wrw.14.1631811937409;
        Thu, 16 Sep 2021 10:05:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfjjaXZKWySs09tvYZERIX2axhpXqImUmYwsH4UD10db/ect7dwo/3Q45CynCQtVVBhWd8HQ==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr7475972wrw.14.1631811937292;
        Thu, 16 Sep 2021 10:05:37 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d70sm3836799wmd.3.2021.09.16.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] mfd: cros_ec: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:34 +0200
Message-Id: <20210916170534.138395-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias.  Having another
MODULE_ALIAS causes the alias to be duplicated:

  $ modinfo cros_ec_dev.ko

  alias:          platform:cros-ec-dev
  srcversion:     F84A69D2156719A4F717A76
  alias:          platform:cros-ec-dev

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/cros_ec_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8c08d1c55726..81cee1a5daa6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -326,7 +326,6 @@ static void __exit cros_ec_dev_exit(void)
 module_init(cros_ec_dev_init);
 module_exit(cros_ec_dev_exit);
 
-MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
 MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
 MODULE_VERSION("1.0");
-- 
2.30.2

