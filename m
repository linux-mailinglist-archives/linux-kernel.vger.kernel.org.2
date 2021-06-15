Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2F3A8260
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFOORj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:17:39 -0400
Received: from srv6.fidu.org ([159.69.62.71]:47968 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhFOOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:16:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id AD27DC800A7;
        Tue, 15 Jun 2021 16:14:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Fnry7ItCZ1uv; Tue, 15 Jun 2021 16:14:35 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F3949009F7CF2Abd5Da2787.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:9f7c:f2ab:d5da:2787])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 01154C80095;
        Tue, 15 Jun 2021 16:14:34 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v3 00/14] New uAPI drm properties for color management
Date:   Tue, 15 Jun 2021 16:14:11 +0200
Message-Id: <20210615141426.6001-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I started work on my proposal for better color handling in Linux display
drivers: https://lkml.org/lkml/2021/5/12/764

In this 3rd revision everything except the generalised Broadcast RGB
implementation is included. I did however not yet include everything suggested
in the feedback for v1 and v2.

I rebased the patch series on drm-tip to have the latest changes in i915's
YCbCr420 handling and to make the intel-gfx ci not fail on merge anymore.

The read only properties are now correctly marked as immutable.

Some questions I already have:

I think Broadcast RGB is really no good name for the property as, at least in
theory, YCbCr can also be "Limited" or "Full". Should the new implementation
have a different name and make "Broadcast RGB" an alias for it? I propose
"preferred color range" as the new name.

I have not tested dp mst (both on AMD and Intel) as i have no adapter for it at
hand. If one can test it, please let me know if things break or not.

I found the DRM_MODE_PROP_ATOMIC flag and from the documentation it sounds like
"max bpc" (and "preferred color format" and "Broadcast RGB") should have it. Is
there a reason it doesn't?

I have not yet looked into dsc and dithering behaviour.

I have already submitted the first two patches separately to the lkml as they fix
potential bugs and don't introduce new uAPI.

