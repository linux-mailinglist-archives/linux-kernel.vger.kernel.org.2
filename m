Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2223ACA90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhFRMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFRMGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:06:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:04:45 -0700 (PDT)
Received: from mwalle01.kontron.local (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7D5DA2224A;
        Fri, 18 Jun 2021 14:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1624017883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Cup0WYTz8qyPQdVfnKBH0xN0Z3VBg7xVZOWY2enN54=;
        b=JcFkWaEbXa1aiX5rRfaEf+xdcq8mFodOnYH0x8e8YYfoGuNcuMsyTngV67pcfL9Cn3rhCo
        jO6IZCSdjlOZunQ955pIefJ7mKlumAjCSnT6UrDr34Xj1Nn7Lnv0gzYyFqWHD6IevqX7Pb
        bF5UaJc/StzAqFEuTsUEEOqDrl60cXA=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lukas F . Hartmann" <lukas@mntre.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/2] drm/etnaviv: add GC7000 r6202 support
Date:   Fri, 18 Jun 2021 14:04:31 +0200
Message-Id: <20210618120433.14746-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first step to bring GPU support to the NXP LS1028A SoC. It
features a Mali DP500, a Vivante GC7000 and has one DisplayPort output
which is driven by a Cadence MHDP controller and PHY.

This was briefly tested with glmark2, a patched mesa kmsro driver [1]
to support the mali DP500/GC7000 duo, fixes from mesa merge request
9255 [2] and using ETNA_MESA_DEBUG=no_supertile,no_ts.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/11419
[2] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/9255

Michael Walle (2):
  drm/etnaviv: add HWDB entry for GC7000 r6202
  drm/etnaviv: add clock gating workaround for GC7000 r6202

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  |  6 +++++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.20.1

