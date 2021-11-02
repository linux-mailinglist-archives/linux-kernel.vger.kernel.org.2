Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F25442B50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:07:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC04C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 03:04:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r4so73333457edi.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+t+3tBvZ55KmjFJAzPVh7PkIiV/wiSXOJElNmqRWcA=;
        b=vY2STts06FZ60Ai8F4v458MeLyNssicvxtTXqeZyary7pXATu6moH8Z6oNoItXFd1K
         do0ecGZJcKW8qxAcguJ6E9yflvb6YkhuyoUZBdI+Ad9632jFt3Iak3QfZfGDHgEu2vOf
         kIhaX8r3x3B3N6g8gLT8x4U9VvbmXedif/6C5vew9rX+dSqIY0++CAt0snzPpuqf53S/
         4p9F4YKpjyIfUjqQq9zjTzrpHfVOfdg3sauat/fGGlF/+PdrkY7VOcs8UZAYjxYguvBt
         cCetI+Aj+I6JDyogCQaippbVsNrmeVkJ7BpSFTc9wTzw6ij8CFaAyux73bsNYSyV7y2F
         BQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+t+3tBvZ55KmjFJAzPVh7PkIiV/wiSXOJElNmqRWcA=;
        b=SbnsJRqvT5mFFzHJhFdqJly3eBdUtnFV0gCxpHbf7KeF9BBTd90bEA6vluRImE4k0R
         DX/kdKh/Eft4lt+ap47T0VcmmiAecWziUk44zk1o/Ren83LsEumDa4Svhx+bM6nACFqZ
         3BnTqAQTbXf5dZR9QDvcwv3lBNCIaQi0ZAzC8JBCnZlMKBjexw2fUcfvIQsLg6jEB6ys
         L4Vsg9zMwxENrATybeY7jzRgvpCDvG5FNWT01EM6jbU+q2Fm5oEJzDpcNysaBIvmjoQy
         zGM4LWbY/xAvH1VD06cU0DwCqZbprOeTuGrlIqEW5mPrgEEwaVhtRQfvzdwJwsfQ3Ln3
         rlUw==
X-Gm-Message-State: AOAM531KJpUOgxxomvec8BNneEIfU8g1xSKkIXJQWHFjw70lc9SRsfgL
        Jklv78CJGjiftrmNXwY+nTKshHiHUuIXWQ==
X-Google-Smtp-Source: ABdhPJzPPOlmw+56IrpuffgY8cuBqnbuQC7FWqs5RhZpbye0kVsz8iOJTbEaWXGfb5gw7ph3/UURbQ==
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr49021718edu.314.1635847466394;
        Tue, 02 Nov 2021 03:04:26 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-144-183-cbl.xnet.hr. [94.253.144.183])
        by smtp.googlemail.com with ESMTPSA id j15sm10534090edl.34.2021.11.02.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 03:04:26 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lee.jones@linaro.org, michael@walle.cc,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] mfd: simple-mfd-i2c: Select MFD_CORE to fix build error
Date:   Tue,  2 Nov 2021 11:04:20 +0100
Message-Id: <20211102100420.112215-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD_SIMPLE_MFD_I2C should select the MFD_CORE to a prevent build error:

aarch64-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
drivers/mfd/simple-mfd-i2c.c:55: undefined reference to `devm_mfd_add_devices'

Fixes: 3abee4579484 ("mfd: Add simple regmap based I2C driver")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 61992edf6a4d..2de69892b631 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1204,6 +1204,7 @@ config MFD_SI476X_CORE
 config MFD_SIMPLE_MFD_I2C
 	tristate
 	depends on I2C
+	select MFD_CORE
 	select REGMAP_I2C
 	help
 	  This driver creates a single register map with the intention for it
-- 
2.33.1

