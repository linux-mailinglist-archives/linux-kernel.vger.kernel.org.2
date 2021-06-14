Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD33A71D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFNWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:20:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36901 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhFNWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:20:11 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9B00222235;
        Tue, 15 Jun 2021 00:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623709084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NMazRWFUklqY5eKDwZP4pOG/B4qTZtlOrNAqqXg85KM=;
        b=WIlbTbIMoEMwgAeIBTZqL45CA8FFfQ0Dr5KF7/eIx42VylMacCCVZbbv1CQsApJ9evwaKw
        AWZl927+zd9UzC57FvyONCA+Sfs/pum2ch2Fa8gOH8xp8WFuKgoZI0PpW9Wq41Nk9T3Vl+
        Jhm4qiaciaigpXAnrnahACKcFRkyo2w=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 0/2] drm/etnaviv: add GC7000 r6202 support
Date:   Tue, 15 Jun 2021 00:17:50 +0200
Message-Id: <20210614221752.1251-1-michael@walle.cc>
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

This was briefly tested with glmark2, a patched mesa kmsro driver to
support the mali DP500/GC7000 duo an using
ETNA_MESA_DEBUG=no_supertile,no_ts.

Michael Walle (2):
  drm/etnaviv: add HWDB entry for GC7000 r6202
  drm/etnaviv: add clock gating workaround for GC7000 r6202

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c  |  6 +++++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.20.1

