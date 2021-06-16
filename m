Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F393A9458
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhFPHsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFPHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:48:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35122C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:46:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd37so2313233ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4TyHLQ4LR5S/LBt8eudzX9kDvJUMoDca5KcxWhDSDw=;
        b=rXiAp2jrc8fLpZsvaJgKpeHWxK/bdE8E3vIakHtTH15E8oMWr3+muv3c0kR8rpPcm0
         f3yHBzI2qJxygQT5UqkDMJZ9vXYjDWRZcg60v1Wu2rZCRCzwcFxF96YIGfF8r6OUdnuY
         6QnAf/pGbJgKO21PvnY7n3rP5QUZsHX61pEc0Z0dO56JRTQD4QJr011Qxa4+bqCLMzuZ
         pfDmLyk20vl5dv3G6R3N6eS3OpX2trEoGWMRwgv2xsJfYgba/aBP6/qCcrqKR03h34sM
         yzBTcAycRY6AiCrKvir05a28F6k9ggr6IyOypPupW97WWFI7ekfbk9syalk3D9DS74On
         rbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M4TyHLQ4LR5S/LBt8eudzX9kDvJUMoDca5KcxWhDSDw=;
        b=ARj6fS+4SpNo1wdLFmqOVO35UOr8KXRXVGyqnGcdyXcj5qDAG5xpA+HXRmnBvKxotU
         hPOd9EEDqTF3LosBbvouxZ4t/bf408StzHlXWmLjPRz4bTzbUHH2USdaMjKQ0clqU1kL
         hakhX4KQi20FFkQtUchlXqEH32I9rsFUyTAmVxyfChrIyGwFmdFFQpuH8u3Jau5c4W8n
         bp2lK3jSYexbFRv85rPKDNKDR59qP7+NjYdYtCw2vDmZc+RjHHR4UPM2t6a54NpE+O6J
         4vBXx0d5tRm+XD+KYp4uu7LarmnbEDBR9eVLzTXvay7OvgjQpa/xL7q5RIVzPhhFMWxP
         NILw==
X-Gm-Message-State: AOAM5335zoJxHVuE84S0in5u6QNEoOSL3dTP9E/12q56fY0PF5IZzIMl
        ZmlpXjd1x14tBYxWOeczj6sNYleqy/0=
X-Google-Smtp-Source: ABdhPJyDQIZawhe/akfwnLVWsVWGjrvpS8PWc8rMTPN141zsfQEsVebK5UtEPzZZuPN9Oe+k4lECYw==
X-Received: by 2002:a17:906:48c8:: with SMTP id d8mr3974133ejt.176.1623829587813;
        Wed, 16 Jun 2021 00:46:27 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id yd25sm657840ejb.114.2021.06.16.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:46:27 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 1/2] riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
Date:   Wed, 16 Jun 2021 15:46:44 +0800
Message-Id: <20210616074645.429578-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Per HiFive Unleashed schematics, the card detect signal of the
micro SD card is connected to gpio pin #11, which should be
reflected in the DT via the <gpios> property, as described in
Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.

[1] https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e88ae4b..22f971e97161 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -80,6 +80,7 @@ mmc@0 {
 		spi-max-frequency = <20000000>;
 		voltage-ranges = <3300 3300>;
 		disable-wp;
+		gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.25.1

