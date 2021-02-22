Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE00321CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhBVQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhBVQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:18:33 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD01C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:17:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id n10so10499538pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZQ81zn5KjPnayIv7F7//pJHAsLKWR/BMQUUmYbIJXA=;
        b=Dt24BpX1YnqNTOhs8U7CREV4Lwj8nxBU4uXPfqBHHTPVIQFF6zSRkdvkLhOspr4LAI
         YbdJ3riCVg59tdKSVZ9jnsxpX8Q7fnxLlwckZiwMrI6B79ElGHQOqjSBap+koQ5kyS4V
         MCIf4ozDHEckAzJIYfG9nn11cEux0MSu78mUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZQ81zn5KjPnayIv7F7//pJHAsLKWR/BMQUUmYbIJXA=;
        b=snct41soqxI8TPXiLta6zd/Yo3enUBZx4LJii3XzMyHJYJwA3c6+hbEMvX4W/LPlZl
         6MBYlSqXycldyJW1rNrfTrhzL7CDt22x93DAZZl9HeI9raEWt6MUb9HwnJixqu5cpK+i
         CWMn+twzWva80+NdETlNIJHOLrblDgcJU4jvUsHD0JgGTrLKdtXqk4lpAudyzHN0Jl/A
         3yp7sWf2IqlNcn7ptOkLbuz/RxxArg66xENy3LVqQTs2XdK+2er5qyehGlHYXJCWuoFW
         59ESOZp+x6GPe11dTB5tf7RHeh/+XXQZuWx2wqEM2DZzG9xlr6/iEy01hVdPT7otFoBQ
         sgrw==
X-Gm-Message-State: AOAM532tffh2z24RuXCb1mDkdC6IqIenD68xsTLAPKaOx+2OkralZShk
        3IYQa0vvfkFG6xIn7EVb2b7X+J/dGnFryBrM
X-Google-Smtp-Source: ABdhPJyScZsUsiOdGNQAF4qiKt7TO6n7/fuJpM8ctVZsirjyQNhhtutqAA4teSOba+e4apFfpB4uFQ==
X-Received: by 2002:a63:4405:: with SMTP id r5mr20209002pga.168.1614010670456;
        Mon, 22 Feb 2021 08:17:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:fd5d:7c23:34f:c618])
        by smtp.gmail.com with ESMTPSA id v4sm21101036pjc.0.2021.02.22.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:17:50 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel: simple: Set enable delay for BOE NV110WTM-N61
Date:   Mon, 22 Feb 2021 08:17:24 -0800
Message-Id: <20210222081716.1.I1a45aece5d2ac6a2e73bbec50da2086e43e0862b@changeid>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panel power sequence says timing T8 (time from link idle to turn on
the backlight) should be at least 50 ms.  This is what the .enable
delay in simple-panel is for, so set it.  NOTE: this overlaps with the
80 ms .prepare_to_enable delay on purpose.  The data sheet says that
at least 80 ms needs to pass between HPD going high and turning on the
backlight and that at least 50 ms needs to pass between the link idle
and the backlight going on.  Thus it works like this on the system in
front of me:
* In bridge chip pre_enable call drm_panel_prepare()
* drm_panel_prepare() -> panel_simple_prepare()
* Wait for HPD GPIO to go high.
* Start counting for 80 ms (store in prepared_time)
* In bridge chip enable, train link then call drm_panel_enable()
* drm_panel_enable() -> panel_simple_enable()
* panel_simple_enable() does hardcoded 50 ms delay then enforces 80 ms
  from HPD going high (in case the bridge took less than 30 ms to
  enable / link train).
* drm_panel_enable() -> backlight_enable().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9858079f9e14..9d36b74357ae 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1445,6 +1445,7 @@ static const struct panel_desc boe_nv110wtm_n61 = {
 	.delay = {
 		.hpd_absent_delay = 200,
 		.prepare_to_enable = 80,
+		.enable = 50,
 		.unprepare = 500,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
-- 
2.30.0.617.g56c4b15f3c-goog

