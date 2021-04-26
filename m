Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E236B27B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhDZLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhDZLrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:47:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCD6C061574;
        Mon, 26 Apr 2021 04:47:01 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z14so3125439ioc.12;
        Mon, 26 Apr 2021 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CWCSDgIxEP9nExMiQ8gtfxRiziS98W5A2zeK4MEZOs=;
        b=pVZIz4mrDyFn0QNuqWuNexCDE2SY1Rw0FX/KJdpqIqdOTY5W4Dup3WIh8WY0pXJc/k
         IRevNbLm4DPVXDu04hk/iaS/QFIj8Kya1syrimkagRU0VXHMGsm3hHbDQXWh1qJodik1
         Q32ZA/G1ATDYDg/f81Fb5uMBDQaOvmTsT4Ua9Q8VP4+KodhqtVOarxM6oGdfWez9R8uZ
         DBGQCqKK/IUhaBYqZEflDVtZv5dt0REsm6LxAXCW30dNBf17eSuIJxFXA+52tuWnlF9a
         LcNTp7957suwSeF51TKiwrGiQ/MA4FmYmSq4QJNyZBIILsXdYqyB9fC0FowkWNjn6XsU
         x2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CWCSDgIxEP9nExMiQ8gtfxRiziS98W5A2zeK4MEZOs=;
        b=E1LWki2XXvnkmZ5OUtO7N0pdgvqOM+GU9N2rpe8ptufz4YdYrthGkbnUJ5gLqqazXW
         i+tQ2Nxa2KtI75lR9Cbi8eEVHM6Q2QBI1yQmr9VrC0OMQS1FOZyU5aNXc3BUjMGGo+Em
         VCpN9PApBQOz9B0C4HIEiuUGjKiZBBwfvBdFL2lubLAe0moNi9hXeUU8vuyEBIAXNDpS
         lOHHMQfdmwToCiXV2QDG0qWN9B0oDFDuzXECxwSwE16xbx8Tq+1cLGkYkXt3tsHOsTrb
         /p2zqCJ1m4svMhW/eIA3nwsGj3RfIBFJcmXKjb0snIH9xSVOy3+UCTezTqtk/NGj2Lrt
         NW0g==
X-Gm-Message-State: AOAM5333tiLc0VCj9bWk4WevuXjNSvCUROVgCQH21C54VJHZmq4oyECH
        /N3fBLVGaVg3B8RbhyGECkI=
X-Google-Smtp-Source: ABdhPJxPkh2qqZZagWe0I5W6/yGxbOpR4Ir0nBSVpx85yhUqGmF97W9sxcamUQ+Ot1bMFhE7tpH1pQ==
X-Received: by 2002:a05:6638:443:: with SMTP id r3mr15578383jap.43.1619437620683;
        Mon, 26 Apr 2021 04:47:00 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id y19sm6969683ili.51.2021.04.26.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 04:47:00 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Pavel Machek <pavel@ucw.cz>, Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rename LED label for NanoPi R4S
Date:   Mon, 26 Apr 2021 19:46:52 +0800
Message-Id: <20210426114652.29542-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

However "sys" is not a valid function, and it is always on.
Let's keep existing functions.

Fixes: db792e9adbf85f ("rockchip: rk3399: Add support for FriendlyARM NanoPi R4S")

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fa5809887643..cef4d18b599d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -33,7 +33,7 @@
 
 		sys_led: led-sys {
 			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
-			label = "red:sys";
+			label = "red:power";
 			default-state = "on";
 		};
 
-- 
2.17.1

