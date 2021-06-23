Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7B3B23DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhFWXKQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Jun 2021 19:10:16 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50671 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230234AbhFWXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:09:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-_x1M5uONPgmc64xROrd67w-1; Wed, 23 Jun 2021 19:07:31 -0400
X-MC-Unique: _x1M5uONPgmc64xROrd67w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5154B1084F54;
        Wed, 23 Jun 2021 23:07:30 +0000 (UTC)
Received: from dreyauc.ausil.us.com (ovpn-112-58.phx2.redhat.com [10.3.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2B2060CCC;
        Wed, 23 Jun 2021 23:07:28 +0000 (UTC)
From:   Dennis Gilmore <dennis@ausil.us>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dennis Gilmore <dgilmore@redhat.com>
Subject: [PATCH] dts: arm: helios4, set aliases for spi and i2c, and enable spi
Date:   Wed, 23 Jun 2021 18:07:26 -0500
Message-Id: <20210623230726.366706-1-dennis@ausil.us>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dennis@ausil.us
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: ausil.us
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Gilmore <dgilmore@redhat.com>

set aliases for spi1, i2c0, and i2c1
set status to okay for spi

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 arch/arm/boot/dts/armada-388-helios4.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-helios4.dts b/arch/arm/boot/dts/armada-388-helios4.dts
index ec134e22bae3..ec9388c3d7c8 100644
--- a/arch/arm/boot/dts/armada-388-helios4.dts
+++ b/arch/arm/boot/dts/armada-388-helios4.dts
@@ -22,8 +22,11 @@ memory {
 	};
 
 	aliases {
-		/* So that mvebu u-boot can update the MAC addresses */
+		/* So that mvebu u-boot can update the MAC address */
 		ethernet1 = &eth0;
+		spi1 = &spi1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
 	};
 
 	chosen {
@@ -322,3 +325,11 @@ microsom_spi1_cs_pins: spi1-cs-pins {
 		};
 	};
 };
+
+&w25q32 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
-- 
2.31.1

