Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED98F3A71D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhFNWUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:20:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59279 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:20:11 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F174622236;
        Tue, 15 Jun 2021 00:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623709085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiA6WFJLQmDmGswf6HKqvP1ckPiqK+OvVCtTG11hdnk=;
        b=U59GsHIxEshtK/0fYXBs4asusQOMsX58iQ+aBfaU5b7uVgRiFi7EitsV9QhQ/gaSVWfP15
        hLwOuPVzaqiIakN6lykym9o/7aVrlFmaGP+b3BO99xHranQD6GMDW76uiWAI7bzz7duK32
        CgvmtHHjcRCqCzqYoniTVHsorytqfrI=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 1/2] drm/etnaviv: add HWDB entry for GC7000 r6202
Date:   Tue, 15 Jun 2021 00:17:51 +0200
Message-Id: <20210614221752.1251-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614221752.1251-1-michael@walle.cc>
References: <20210614221752.1251-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU is found on the NXP LS1028A SoC. The feature bits are taken from
the NXP downstream kernel driver 6.4.3.p1.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index dfc0f536b3b9..f2fc645c7956 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -37,6 +37,37 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 		.minor_features10 = 0x0,
 		.minor_features11 = 0x0,
 	},
+	{
+		.model = 0x7000,
+		.revision = 0x6202,
+		.product_id = 0x70003,
+		.customer_id = 0,
+		.eco_id = 0,
+		.stream_count = 8,
+		.register_max = 64,
+		.thread_count = 512,
+		.shader_core_count = 2,
+		.vertex_cache_size = 16,
+		.vertex_output_buffer_size = 1024,
+		.pixel_pipes = 1,
+		.instruction_count = 512,
+		.num_constants = 320,
+		.buffer_size = 0,
+		.varyings_count = 16,
+		.features = 0xe0287cad,
+		.minor_features0 = 0xc1489eff,
+		.minor_features1 = 0xfefbfad9,
+		.minor_features2 = 0xeb9d4fbf,
+		.minor_features3 = 0xedfffced,
+		.minor_features4 = 0xdb0dafc7,
+		.minor_features5 = 0x3b5ac333,
+		.minor_features6 = 0xfccee201,
+		.minor_features7 = 0x03fffa6f,
+		.minor_features8 = 0x00e10ef0,
+		.minor_features9 = 0x0088003c,
+		.minor_features10 = 0x00004040,
+		.minor_features11 = 0x00000024,
+	},
 	{
 		.model = 0x7000,
 		.revision = 0x6204,
-- 
2.20.1

