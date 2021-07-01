Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3083B8B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhGAAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238201AbhGAAn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625100059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HtOhtY9A3lJk+S03M4q/MteJLZvObE+vhVxSQf8wa8=;
        b=EMavO+x6c0NGnvzteguWCyFSUIZjj0E7Lsndapvjl/L1erN516t55NDe4I+eMfC6A8LgBG
        7w+v4pZWVa3ArM6R/OOJN49hH9gYiACWKf+DksX5kuJmxGElpdVVgw0ljqlPSBfwHwfHQj
        rzczw+ARbnRRuA/TT1keaSVzPpPiWdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-lksWBFYAM7-QN_dmwFYMUw-1; Wed, 30 Jun 2021 20:40:58 -0400
X-MC-Unique: lksWBFYAM7-QN_dmwFYMUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AA3800D62;
        Thu,  1 Jul 2021 00:40:57 +0000 (UTC)
Received: from dreyauc.ausil.us (ovpn-113-50.rdu2.redhat.com [10.10.113.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBD6A604CC;
        Thu,  1 Jul 2021 00:40:55 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] arm64: dts: rockchip: helios64: set stdout-path
Date:   Wed, 30 Jun 2021 19:40:37 -0500
Message-Id: <20210701004043.18585-2-dgilmore@redhat.com>
In-Reply-To: <20210701004043.18585-1-dgilmore@redhat.com>
References: <20210701004043.18585-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set the default output path to uart2

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index aeedf098f67c..bdcf6472664c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -43,6 +43,10 @@ avdd_1v8_s0: avdd-1v8-s0 {
 		vin-supply = <&vcc3v3_sys_s3>;
 	};
 
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
 	clkin_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
-- 
2.31.1

