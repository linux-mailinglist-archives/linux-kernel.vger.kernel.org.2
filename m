Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3353E3E03
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhHICwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHICwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:52:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F4C061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 19:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VeEVmBRhzJwW70EXgz8gikTw4yYG1nvlogdYjeiVpsY=; b=YnLj9xWw2JGrkNfvnL7ajlkaWO
        OHfCYu/H3paOjWTTm3R9Q0TCUKc4/sJW1WLNiJsJU2Yjmqd99cewf3FtAWx9HaYethq0DtxYoImb/
        MH9PcVwK9EWewy+TqcYJjsicQzTDdswWnvcR2fXKUzKNd3Y58skkHlMi7eu+R332A+7Qy7oQ1dOiB
        Mztv7CK9aqmBuhrUoxVMMJ3Rq06r89SM8rRiI9TTF2a8lVflfX7Us0tz1O3klXf2P0eDTXSbMMtG8
        Q4Uc7Q5AgJRlJOHanwYxwAgZfPt5jfbzh+qtXC3WwRHRf9T0+A3aYGNAeoWCFrke4Ej9mIlAmDKgG
        u/vM7qSg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCvOb-00GxMm-Mr; Mon, 09 Aug 2021 02:52:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Wyatt Wood <wyatt.wood@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amd/display: use do-while-0 for DC_TRACE_LEVEL_MESSAGE()
Date:   Sun,  8 Aug 2021 19:52:08 -0700
Message-Id: <20210809025208.10182-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 complains about an empty 'else' statement, so use the
usual do-nothing-while-0 loop to quieten this warning.

../drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:113:53: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
  113 |                                 *state, retry_count);

Fixes: b30eda8d416c ("drm/amd/display: Add ETW log to dmub_psr_get_state")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210806.orig/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ linux-next-20210806/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -29,7 +29,7 @@
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
 
-#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define DC_TRACE_LEVEL_MESSAGE(...)	do {} while (0) /* do nothing */
 
 #define MAX_PIPES 6
 
