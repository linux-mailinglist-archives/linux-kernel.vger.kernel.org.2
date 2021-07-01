Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385263B8B56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhGAAnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237629AbhGAAnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625100054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+v6WPT/5taggbNgs2bz+98+dN0UiYk4moHB5213+Nl0=;
        b=RjqZmhPNaBokWwbzr3G6G3bHQwbyHULf9djeQMraRASpcFly3PI6HdaL5Rn7dqg1nlaWVk
        GWELTyaq8zGcAZAmE124uzEG4cci+tC81gawitiP8z8njYFu0ro6lE7ApXseMGSCHvFuF8
        MUN3nUfjDgwn6epcLDmqvjg2vHy7+CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-KFxkK4w2MwyP4Kgvkz9bkA-1; Wed, 30 Jun 2021 20:40:53 -0400
X-MC-Unique: KFxkK4w2MwyP4Kgvkz9bkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0135074C;
        Thu,  1 Jul 2021 00:40:51 +0000 (UTC)
Received: from dreyauc.ausil.us (ovpn-113-50.rdu2.redhat.com [10.10.113.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB3F0604CC;
        Thu,  1 Jul 2021 00:40:49 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
Date:   Wed, 30 Jun 2021 19:40:36 -0500
Message-Id: <20210701004043.18585-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the usbdrd_dwc3_1 node defined u-boot will throw an error and
reset the system. All other rk3399 systems use this format

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index 738cfd21df3e..aeedf098f67c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -490,9 +490,9 @@ &uart2 {
 
 &usbdrd3_1 {
 	status = "okay";
+};
 
-	usb@fe900000 {
-		dr_mode = "host";
-		status = "okay";
-	};
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
 };
-- 
2.31.1

