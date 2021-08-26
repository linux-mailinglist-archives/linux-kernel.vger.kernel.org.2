Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF353F88FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbhHZNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbhHZNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:30:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FCC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:30:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q68so3063198pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrvpFTSxP6HC2hI5yw+6G74dP3xB/sdGF5ca/iz2uZg=;
        b=PSyPUMySQ272wCedf3L7LMw2fgz26+HTzsV4qnMo5wekkx9eLAXscV+7Es2Flz8jXR
         OunYwFk2d9oigiQPcky7fi5a1+wUo0PGiPnAvOjmOEaaCLczeYVviAIXI4ZBshCzx84L
         5dn+BJQE/FRSbCJ41f2ZxHvQNwOt2auQ/gXgvE4zlNCWs45TZhOrhuxLY5YKStswEcOG
         4+bnrw327o2hAZ1ypgLdnc/YYeQhQ23ERU89SuWuuNwj5bgTpPQT04EPTfQrmGFwRna7
         fsZuISZUcMC9Wj8tbebRgV8mfFU4QxQTvuvClgUSsHjWZQxJlx2F8MZdDWzx3GPXlQX2
         yfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wrvpFTSxP6HC2hI5yw+6G74dP3xB/sdGF5ca/iz2uZg=;
        b=eiLywPF1oyQOZnlfsNzKJEQmxDO8gVnIxK/ZYYt0taRns0NY63MirZ79veExG74AfD
         rKSV9+vFVcNavYDQ24h3WU9Egd6MhIbjfgpf/dB5enuRcS7gmVr1q6gijNV5kld+WN8c
         o9q3Jb8lqsstVWn5fFguuN7NrlUhfyYlUF1EkP35VWRbmD6Rc9vrrCR2wPgkSGCWI7Of
         xv3Ddd2ae7dP6+ER+6FGXDhidwWdgfKlGMwsfDzIrDUpgdD0yptJWF/yVF9QMveVzrkE
         9BSO5MfBbe71MyRLpYNvhjuHsUGYOW+M/hNt7ngdvVX0DwXlD6QfBmNCKWFB2UcFiC0e
         bErQ==
X-Gm-Message-State: AOAM530OFSgkAzuYfqIITdjzdi6XBQauqbRQ6iwtZQ4CwQsgQVgFyXQp
        pruYSnkwBN+DnLtwTpmxNwwplKUfxcE=
X-Google-Smtp-Source: ABdhPJyqR3mcchVS+Vw70cjzEDXYGU9iGVMMKeiGJel65hq2L74vF6ub7bnRf7BXcY9iAhFAwccZww==
X-Received: by 2002:aa7:86c3:0:b0:3eb:1857:8ae9 with SMTP id h3-20020aa786c3000000b003eb18578ae9mr3761399pfo.52.1629984600436;
        Thu, 26 Aug 2021 06:30:00 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id w186sm3359693pfw.78.2021.08.26.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:29:59 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] openrisc/litex: Add ethernet device
Date:   Thu, 26 Aug 2021 22:59:45 +0930
Message-Id: <20210826132946.3324593-3-joel@jms.id.au>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826132946.3324593-1-joel@jms.id.au>
References: <20210826132946.3324593-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the liteeth ethernet device.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/openrisc/boot/dts/or1klitex.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/openrisc/boot/dts/or1klitex.dts b/arch/openrisc/boot/dts/or1klitex.dts
index baba4f49fa6b..91c7173c50e6 100644
--- a/arch/openrisc/boot/dts/or1klitex.dts
+++ b/arch/openrisc/boot/dts/or1klitex.dts
@@ -52,4 +52,13 @@ soc_ctrl0: soc_controller@e0000000 {
 			reg = <0xe0000000 0xc>;
 			status = "okay";
 	};
+
+	ethernet@e0001000 {
+		compatible = "litex,liteeth";
+		reg = <0xe0001000 0x7c>,
+		      <0xe0001800 0x0a>,
+		      <0x80000000 0x2000>;
+		reg-names = "mac", "mdio", "buffer";
+		interrupts = <2>;
+	};
 };
-- 
2.33.0

