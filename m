Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06096402D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbhIGQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbhIGQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:51:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0DC061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:49:56 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A8B1622175;
        Tue,  7 Sep 2021 18:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631033393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RBIaEU+QYRJFKSVBjVbUGUzxvaWbeZCnz5PKzm5X2GQ=;
        b=YhiJSkf6SgSXcXZhUZRVN1SrYWpTY2oGzLSHPG+7bLeaQBJ48I4LJgDj9XyIibCV/yBVyD
        4zQYOCiAXlEhq2I+39/qg3rVbo2tgZcUK2QWxKwfzomgXe70r0HDOoeY3VfmaAQ20HQmBl
        wb9hyz2JunKJnQupi/UPJwyYZ3Qe9Qk=
From:   Michael Walle <michael@walle.cc>
To:     Robin Murphy <robin.murphy@arm.com>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/3] drm/etnaviv: IOMMU related fixes
Date:   Tue,  7 Sep 2021 18:49:42 +0200
Message-Id: <20210907164945.2309815-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes usage of the etnaviv driver with GPUs behind a
IOMMU. It was tested on a NXP LS1028A SoC. Together with Lucas' MMU patches
[1] there are not more (GPU internal) MMU nor (system) IOMMU faults on the
LS1028A.

[1] https://lists.freedesktop.org/archives/etnaviv/2021-August/003682.html

changes since v1:
 - don't move the former dma_mask setup code around in patch 2/3. Will
   avoid any confusion.

Michael Walle (3):
  drm/etnaviv: use PLATFORM_DEVID_NONE
  drm/etnaviv: fix dma configuration of the virtual device
  drm/etnaviv: use a 32 bit mask as coherent DMA mask

 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 41 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.30.2

