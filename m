Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393FE3B8B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 02:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbhGAAnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 20:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238231AbhGAAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 20:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625100075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVBk4SHqyOlcbF1ifNVSq0kIYoC+2bJkL0n2RJO/CS0=;
        b=V0cebv26JFf24ZLSXE9kLGoQwK/qbTFU7zkhNd9ncMMlTT4UCAZwxNkep2l1HiMtTiTNEa
        4724rzxrLtHFtf9hzK7QwworfG3dpinSiv489oKcrSUCMkQjrAAeVCuo7sNTKP3fIoWvHh
        J+vFqSBY8eODm32T1g60mwoC3uBMaTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-D-aFng4MPgu6eM9_N0gOLw-1; Wed, 30 Jun 2021 20:41:12 -0400
X-MC-Unique: D-aFng4MPgu6eM9_N0gOLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416B8800D62;
        Thu,  1 Jul 2021 00:41:10 +0000 (UTC)
Received: from dreyauc.ausil.us (ovpn-113-50.rdu2.redhat.com [10.10.113.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EEA604CC;
        Thu,  1 Jul 2021 00:41:09 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] arm64: dts: rockchip: helios64: enable tsadc on helios64
Date:   Wed, 30 Jun 2021 19:40:39 -0500
Message-Id: <20210701004043.18585-4-dgilmore@redhat.com>
In-Reply-To: <20210701004043.18585-1-dgilmore@redhat.com>
References: <20210701004043.18585-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the tsadc thermal controller on the helios64

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index 09c5a6fa11ff..b44e54571c31 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -502,6 +502,14 @@ &tcphy1 {
 	status = "okay";
 };
 
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 
-- 
2.31.1

