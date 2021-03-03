Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8DA32BE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573882AbhCCRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383293AbhCCNqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63497C0611C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d15so8498050wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=NJfqDB9NHKQ/wGFMa43GPx+ixK4Rx/iRwTH9xXN65p2FK/n8vZ3ebEhihmL73C5coI
         DguDr3o/fpfTpc2qnQydLiHkjZ4bxu4aWvn3pP1QXvssbFa5mh5/bCtluGHYYaEXnsrj
         ao7HNvCYertCxSwgtEEfj3yBD9hLNIReP6NupahkoGPbgNJmX+ZF3+ZvWQCwXs79H8y8
         yYs+F2bbN16FlLS9tu585Ll/UW2o+l4lQ9Bf04G3MHgnC4aF3ccqBI3fY3jejXQORchb
         Y0UfUNF+Eys+Rvl8q/L8zHzCYI7N8r0yk+FqbwNRd4XUHrLtP2m6uihF8mfgfWK71x20
         ++Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3BFodeOPTMMoMJFhYQYaXV3COFge4hJ56ydgoQMcn0=;
        b=hjDD2JDi/t2rmzsI2hevkPv1nusMtihLRVQuTQFo9ASWDYlViA1kMfczFvgO32xhsI
         x+UAyBl5vhw6pzwgjSTyMULwLa4IQ13NruE0isy54OpG3RO9yaph3d+ViYLEwjpTC9au
         np7I/F6MlUS/mVXZLXi0Nr+HNOSAdn5emnloj+1B1jRMN3HIkZtpC8tsrYhxgiJuQPUq
         pPJIUChBwy0mz73WMFm3SIuFaBhoHBw8UITzRrOXbvt3OHA3L2zIE0hd3jlVKoT2Lsn1
         ANFKd9xLrqpfXYZUACX+mr1f/k4mBuFWLiBfsElDXtX+lYYYCSbfA5laq41vseDXLGBp
         /vLA==
X-Gm-Message-State: AOAM533iO4XDGcqzfXndBStrkH7mxC4ocojoo/vo5yMpYaGuWwcEiUq4
        HgOnPNvBcvwf/F18FC1zPeYGIg==
X-Google-Smtp-Source: ABdhPJwg0qVs5es0CXhmCcvkodgXHaVs99pEF1zW+Kj/W6VZdZEtiqPdehQYYsFnLOx42FLMZcCbKw==
X-Received: by 2002:adf:f2c3:: with SMTP id d3mr27870193wrp.380.1614779026168;
        Wed, 03 Mar 2021 05:43:46 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 15/53] drm/nouveau/dispnv04/crtc: Demote non-conforming kernel-doc headers
Date:   Wed,  3 Mar 2021 13:42:41 +0000
Message-Id: <20210303134319.3160762-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:462: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set_regs'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'crtc' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'adjusted_mode' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'x' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'y' not described in 'nv_crtc_mode_set'
 drivers/gpu/drm/nouveau/dispnv04/crtc.c:640: warning: Function parameter or member 'old_fb' not described in 'nv_crtc_mode_set'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f9e962fd94d0d..f9a276ea5a9e0 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct drm_display_mode *mode)
 	regp->Attribute[NV_CIO_AR_CSEL_INDEX] = 0x00;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
@@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
 	return ret;
 }
 
-/**
+/*
  * Sets up registers for the given mode/adjusted_mode pair.
  *
  * The clocks, CRTCs and outputs attached to this CRTC must be off.
-- 
2.27.0

