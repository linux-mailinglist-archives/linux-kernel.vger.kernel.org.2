Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03834362B42
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhDPWlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhDPWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C29C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so20148943pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XvcTL0RsbG+N8ibrkzli2K1A+rE+ZrcYjKP9wz2z40I=;
        b=AufOpWxiDS8cPPrP7xzjOHsIoN36eKpOCxEXl12PAo2J/qdSsF4bqxhnWAoHrmPdgi
         jdSwBdRJc9Q5vDcJV0vvreL74oFh6+Anm/o8pvPb8DW+i5Aelp9ZDP1HNTZ0Rp2OrdyZ
         XPBg766uOfY2dHhRsLvb38FAjAcOn8oh7WNLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XvcTL0RsbG+N8ibrkzli2K1A+rE+ZrcYjKP9wz2z40I=;
        b=PLPR3tyHPTVtvDOiblXFGH/M4XbhS8MbCPsR36CFbtc5XMgaqoSamSNxF8Mq7vtDg+
         WkO29giM6hQjzyM3UdYVH6vnA86ReszXotB1QgpZvX9BCZK6QhmRCAnGdOswc+L+hZ6t
         dKgWXNvr5W/33HM/o2MtF+1vxsurU5TON3iDvn5nEfUhqxpa/bHxJN8uTnmlKklhyNu5
         3NMqnAgn/+qymdYE6j4+qKue/neQCHYG5iSaPJA3dbeo/DddOLaBmNIVh+2HM30CtJhZ
         xU2W9Y2ZPTkswjN9l5+nSto3cU84TxoROqQDibWfNn0cM8XDGdp8YGJfTCQqm7hLU7a8
         4cDA==
X-Gm-Message-State: AOAM530/G7sZ8xv9nnCytqq35u+KUxrxjQe05QMQ1NKoFRXhzgmRIz0t
        63dkHwj/4/fFqcd8pM0pofqSbg==
X-Google-Smtp-Source: ABdhPJzNUiYzRYYbvZn//8wjS/CeqlBImBF5oNQlkkD5V/lJHOiw3ppDJgVHdWGhvCqC6g4Hpy9jag==
X-Received: by 2002:aa7:9791:0:b029:25c:38de:aa6b with SMTP id o17-20020aa797910000b029025c38deaa6bmr522788pfp.19.1618612856582;
        Fri, 16 Apr 2021 15:40:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:40:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/27] drm/bridge: ti-sn65dsi86: Remove incorrectly tagged kerneldoc comment
Date:   Fri, 16 Apr 2021 15:39:26 -0700
Message-Id: <20210416153909.v4.3.I167766eeaf4c4646a3934c4dd5332decbab6bd68@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A random comment inside a function had "/**" in front of it. That
doesn't make sense. Remove.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v1)

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 96fe8f2c0ea9..76f43af6735d 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -788,7 +788,7 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	/* set dsi clk frequency value */
 	ti_sn_bridge_set_dsi_rate(pdata);
 
-	/**
+	/*
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
 	 * this method is enabled by default. An eDP panel must support this
 	 * authentication method. We need to enable this method in the eDP panel
-- 
2.31.1.368.gbe11c130af-goog

