Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA39E3F86FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbhHZMLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242413AbhHZMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:11:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:10:15 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7165A22173;
        Thu, 26 Aug 2021 14:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629979812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H9RQiDxWvFG0IU5yJiqYwMEIyrB2lEpXizSuM9eNB9g=;
        b=VgkBCCO1Akw5Ckhvs4F7Frt26/4hxfGx88YzzZpjSd60JvrJbkrkIjwS/SEeEdpFdpyVUI
        UrcHCvvdk0GhuwFElitHyRoBF9KSAXLhEa+kvaDy5yIvgDr+FAEfrcWkHOVU0hxeXx9G99
        F4iQZyYOvfyR6Hr0K0xszVIQoWOtan4=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/3] drm/etnaviv: IOMMU related fixes
Date:   Thu, 26 Aug 2021 14:10:03 +0200
Message-Id: <20210826121006.685257-1-michael@walle.cc>
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

Michael Walle (3):
  drm/etnaviv: use PLATFORM_DEVID_NONE
  drm/etnaviv: fix dma configuration of the virtual device
  drm/etnaviv: use a 32 bit mask as coherent DMA mask

 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 41 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.30.2

