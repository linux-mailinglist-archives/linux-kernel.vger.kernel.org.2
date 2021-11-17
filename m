Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B676545496B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhKQPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:02:06 -0500
Received: from marcansoft.com ([212.63.210.85]:57418 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhKQPCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:02:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6AC8841F28;
        Wed, 17 Nov 2021 14:59:03 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/3] drm/simpledrm: Apple M1 / DT platform support fixes
Date:   Wed, 17 Nov 2021 23:58:26 +0900
Message-Id: <20211117145829.204360-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi DRM folks,

This short series makes simpledrm work on Apple M1 (including Pro/Max)
platforms the way simplefb already does, by adding XRGB2101010 support
and making it bind to framebuffers in /chosen the same way simplefb
does.

This avoids breaking the bootloader-provided framebuffer console when
simpledrm is selected to replace simplefb, as these FBs always seem to
be 10-bit (at least when a real screen is attached).

Hector Martin (3):
  drm/simpledrm: Bind to OF framebuffers in /chosen
  drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_dstclip()
  drm/simpledrm: Enable XRGB2101010 format

 drivers/gpu/drm/drm_format_helper.c | 64 +++++++++++++++++++++++++++++
 drivers/gpu/drm/tiny/simpledrm.c    | 19 ++++++++-
 include/drm/drm_format_helper.h     |  4 ++
 3 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.33.0

