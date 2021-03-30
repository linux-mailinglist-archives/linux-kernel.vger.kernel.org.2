Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90B34DED2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhC3CyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhC3CyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:54:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AD6C061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f10so10663338pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qI/3Hs2aK5j95IIJ6CXgbrMKhpGuwzEJEjubXc02oD4=;
        b=XVP5azCVkEZItoAwFhpabdgCE8YXvf2qCEpXn6Xgov2pwKSL15Y4UHoC05ptJsLGKx
         kEtelr+AEbMj7ivpuDloxY5vjyCH7q7CXiqDGjOvSdJnxhx1w41xPHavLLmnWDgXtNJB
         xf7gMchT4RbZOOtz0mslmlsxDTRC1wWZZ1otA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI/3Hs2aK5j95IIJ6CXgbrMKhpGuwzEJEjubXc02oD4=;
        b=AMq454Y4SIrJ0YdFvblyvT7/LA5KVthmi7OPkDVbpfYMy84yaXaMKbKaNi6pxUJBvj
         Z0ogyZJ9xSrdPHYd3j6wW3Q2PfQ1yX7e8oR3lUMaylGMB84PzOzPf9+3RPwN3iV8lCTm
         Me++RTm5jH6zPdR9fx8yqzZTZdWd5z7pICN4+bKXkFn/sxUDW202VnQL2KDOcrrZsfc5
         q339HXe6mQE7Dco7/qfkGvHc/RScRYdgH1igZ41iPF6um0N4hoilM1AxMcAJs3nDzexx
         vX1BvTTw8EAcAGMfSu5KZruWLNK/3VpcIn7CtH8MSPKyHbz9fwGFtJdqoiYSXUjjdTGs
         FFvw==
X-Gm-Message-State: AOAM530+clSFkS+/AxEjajRdxGcztbvFDLvlNddWq9zRK3/mViPKjxzH
        lwUFG3sge/DJH3RBZa++l4zuxg==
X-Google-Smtp-Source: ABdhPJyZiJrPuAbzqL8NKVXxk3Sum/s/UcvHx89hqsPS7SaR6LwBWLGagqLg79BtkIOOhi/X2lPw2Q==
X-Received: by 2002:a65:56cc:: with SMTP id w12mr26587564pgs.354.1617072842326;
        Mon, 29 Mar 2021 19:54:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f599:1ca7:742d:6b50])
        by smtp.gmail.com with ESMTPSA id t17sm19152706pgk.25.2021.03.29.19.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 19:54:02 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        robdclark@chromium.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] drm/bridge: Fix the stop condition of drm_bridge_chain_pre_enable()
Date:   Mon, 29 Mar 2021 19:53:32 -0700
Message-Id: <20210329195255.v2.1.If62a003f76a2bc4ccc6c53565becc05d2aad4430@changeid>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210330025345.3980086-1-dianders@chromium.org>
References: <20210330025345.3980086-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_bridge_chain_pre_enable() is not the proper opposite of
drm_bridge_chain_post_disable(). It continues along the chain to
_before_ the starting bridge. Let's fix that.

Fixes: 05193dc38197 ("drm/bridge: Make the bridge chain a double-linked list")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/drm_bridge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 64f0effb52ac..044acd07c153 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -522,6 +522,9 @@ void drm_bridge_chain_pre_enable(struct drm_bridge *bridge)
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->pre_enable)
 			iter->funcs->pre_enable(iter);
+
+		if (iter == bridge)
+			break;
 	}
 }
 EXPORT_SYMBOL(drm_bridge_chain_pre_enable);
-- 
2.31.0.291.g576ba9dcdaf-goog

