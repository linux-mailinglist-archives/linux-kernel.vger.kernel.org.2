Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F93730D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhEDTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhEDTgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA24C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so10635094wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfKwDo8azWN0Gbc7/pIjGO8T4exsCKBX4Y2Y1QqmWes=;
        b=05o7ReA7rAKHmkd0VqX0nWa4Encxngxhb46pr43kojkbSgBP0EaRdX+231RbnE7zwV
         s4y9y+xh22lXXGpOg43Ruv9YkwYPEsdd2QJWzd2BjIAk4Bz1rvU6vJG0Rzi5t4iHdgZl
         oP1ALyF3di75NUU8tOAsdX0b8BlG+etuwHXMISnRlIUis5NNI5YPGRp3YYHM+vq2tMoa
         q8mWAOCNZ737fuPJY73g+re2opNW22UsDdP341L8hgxvL3UQWhWIpjwQp6HzQcvjPOr6
         0TBNYVrTFUr4iXI80KvYUV4zDsnoZ4ba5hOHpo+PABpIVXlej1HeH/SxnF8u7zxP1Qyh
         V8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfKwDo8azWN0Gbc7/pIjGO8T4exsCKBX4Y2Y1QqmWes=;
        b=WXW5VUVWDIfQtIKj7iSbLUbS6ewmO78WuEJb7lJv4R7omlaIXlmayYaXoQuMov151S
         rfOPWwmDVqqmZb2SGgKMqsqF14vQLX4g08mHQ5jG09z2I8SoJCFdo0YHjHEG12U5zXbk
         R8q+wGPogC7NIpak9qe8pW/3ZTictLgtQ9KYW8DCHt8NazhTTdY0N0w3ScCpCm7Jn3q8
         RhgzZBFZUPLALak6gaC/GvnnVc8dgVOe8rNyrva6ceM5hpdgc7AHtYQUF3bsmyXQCQqO
         zb1iLQcWyXcXSMP8CWMs1qr58W/ies7YUFUXNFezRcO5uJ+1djH7xyzI/dzJKu1uWiQM
         LDDA==
X-Gm-Message-State: AOAM531D1YT5PKCcnz+6L8O54WCblQbQJsOw8EfKHAST+lSC5OOGHa31
        eWGZZfyINnVq5Fi2lzOiFP5W5g==
X-Google-Smtp-Source: ABdhPJxWg+HSorQvF2RrlLM+c8v0lSWRGO+IpTTDPUTnfP8IIx/z6CvDhSGW889Qo1o4XqTfgq0yNA==
X-Received: by 2002:adf:ef90:: with SMTP id d16mr34040195wro.359.1620156904727;
        Tue, 04 May 2021 12:35:04 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:04 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/5] ARM: ixp4xx_defconfig: add CONFIG_SERIAL_OF_PLATFORM
Date:   Tue,  4 May 2021 19:34:53 +0000
Message-Id: <20210504193457.4008384-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504193457.4008384-1-clabbe@baylibre.com>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My ixp42x-welltech-epbx100 does not print anything on console without
CONFIG_SERIAL_OF_PLATFORM.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/configs/ixp4xx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 0d6edeb27659..e3bcf2bed25c 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -152,6 +152,7 @@ CONFIG_INPUT_IXP4XX_BEEPER=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_SENSORS_W83781D=y
-- 
2.26.3

