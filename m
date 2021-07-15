Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB93C9615
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhGOC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 22:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhGOC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626317815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HtOhtY9A3lJk+S03M4q/MteJLZvObE+vhVxSQf8wa8=;
        b=SwFm+SU7AGT2zHIWj1fj4Hw4uBvgslUEp+OlZdsYVn7dYKkldaLE9+xj8A0E/iwMG9AeZ+
        hF3RdBgdxkd9a3ccOh/rY6rU7RijMRKoei89pjquUFFj20i8ahpWnhuSS/wAJsD7VB2Pla
        dYFFAxze+LrCNg6HtgvCwMuk7HVk03M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-MrutHEZ8O625yAa-5Ya7WQ-1; Wed, 14 Jul 2021 22:56:53 -0400
X-MC-Unique: MrutHEZ8O625yAa-5Ya7WQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54B5436254;
        Thu, 15 Jul 2021 02:56:52 +0000 (UTC)
Received: from dreyauc.ausil.us.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DCA91A872;
        Thu, 15 Jul 2021 02:56:49 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] arm64: dts: rockchip: helios64: set stdout-path
Date:   Wed, 14 Jul 2021 21:56:29 -0500
Message-Id: <20210715025635.70452-2-dgilmore@redhat.com>
In-Reply-To: <20210715025635.70452-1-dgilmore@redhat.com>
References: <20210715025635.70452-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

