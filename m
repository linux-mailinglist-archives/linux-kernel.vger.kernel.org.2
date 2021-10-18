Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378AD431259
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhJRIpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhJRIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:45:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8149C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:43:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n11so10724996plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/sIT4umqcrgezmo7NeKDo4pD3l7TGx1ShKleFi4zvMg=;
        b=lXrjdjy9g+sP6tVwh3R0LbFpvRMw0iCGBp/+3otwIDwVuLTV1rO74j9MnDfjuh5M3Q
         fNPJe3SkENcfuVJExXQfsOZwhFHvJvz4mbANfzRXJl2MpB3Kn3mzEIwEPrHXIPEazqXL
         Ex3O9KwPrnrWvwHVCa2PLdrQZaqLPXHKNs0Sbeq8DN3AXirhwYKRwU98oP0L1kKgoBAi
         pN7UJX4sdSu4a4iM/pMveiGmf2u/yxkYBhIBnFOvvatcBxvu53AVXtWkuMH085L0WA2g
         qiTDZ5WFGShMbsmqo+GPO98HKItWZexk9yIeyPi/lp2mVDVXIMk2M07vkTqTa4sb1TV7
         2fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/sIT4umqcrgezmo7NeKDo4pD3l7TGx1ShKleFi4zvMg=;
        b=w47Ojy1KeEEiB701u/feePiy/hdn7J8PZCa8PcpXN9q84+KdylT3zI1CNBHNwoD1rs
         fMwCDzIdYngfFfZoejgvbSslAZEITBJnaxygnjx1NcOCck6YRwCfur/IgMe40onjWvps
         DdlXOT2NOsS0D10+igjYCxhEQ/k+vMXgxIkG/myTlJw5lqxwsfCjCWBoMwyro4+i+4Xm
         w74A+2unxI94z5DPv2DQgrtOFSpZya4u4pEl3YnezrCKgUS1LY/OeGiPadVafchZ6kNT
         7PKlSpCv2oJz71Syg+jCQfnVg3+O5uNkCGOuxKtVbz3JHlV7Y54sjpqW2J9NF80b5pMc
         5urQ==
X-Gm-Message-State: AOAM530BM6s9olFH97Y4B0R95MkXBRympIE+XScgNNW//138siDubr/I
        5N8+EyJjQn5Y+QbmSLZqnhY=
X-Google-Smtp-Source: ABdhPJyXe3WVogvoDfLeXoKli08zF7MOl0pG+v3UNaG4cNfHsYezHxB8MJjkOAYchUOyIYllZuWSlQ==
X-Received: by 2002:a17:902:ed8c:b0:13f:136f:efb1 with SMTP id e12-20020a170902ed8c00b0013f136fefb1mr25827200plj.56.1634546617391;
        Mon, 18 Oct 2021 01:43:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s14sm12356974pfg.50.2021.10.18.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:43:36 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/display: Remove unused variable and its assignment.
Date:   Mon, 18 Oct 2021 08:43:31 +0000
Message-Id: <20211018084331.851975-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable is not used in functions, and its assignment is redundant too.
So it should be deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/i915/display/intel_dpll.c:1653:2 warning:
Value stored to 'bestm1' is never read.

drivers/gpu/drm/i915/display/intel_dpll.c:1651:2 warning:
Value stored to 'bestn' is never read.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/i915/display/intel_dpll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll.c b/drivers/gpu/drm/i915/display/intel_dpll.c
index b84ed4a..28b1616 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll.c
@@ -1644,13 +1644,11 @@ static void chv_prepare_pll(const struct intel_crtc_state *crtc_state)
 	enum pipe pipe = crtc->pipe;
 	enum dpio_channel port = vlv_pipe_to_channel(pipe);
 	u32 loopfilter, tribuf_calcntr;
-	u32 bestn, bestm1, bestm2, bestp1, bestp2, bestm2_frac;
+	u32 bestm2, bestp1, bestp2, bestm2_frac;
 	u32 dpio_val;
 	int vco;
 
-	bestn = crtc_state->dpll.n;
 	bestm2_frac = crtc_state->dpll.m2 & 0x3fffff;
-	bestm1 = crtc_state->dpll.m1;
 	bestm2 = crtc_state->dpll.m2 >> 22;
 	bestp1 = crtc_state->dpll.p1;
 	bestp2 = crtc_state->dpll.p2;
-- 
2.15.2

