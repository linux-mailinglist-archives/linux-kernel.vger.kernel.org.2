Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16E31B24A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhBNTmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 14:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBNTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 14:41:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC175C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t2so2627710pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEU9K8O8lr+3rHXwRQA55P8y6nBOsd6z61f8CIpxwRw=;
        b=F0Qgyf6v2tiZz7YJnxvZ8eJHpLZZL5anVhqVpyWbyWbL0II9dBc6u/HvOM2jr5iVe6
         72nvcuVeFokurb2dJiyhOkaW/kZ/Hz2ZMBlVZ5MY5Vn9AELfyVaA3bXomHFZdVTCZjEF
         hnwLFmiIHcOEXarki46T+SdiRs3IcxQXk2ILA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEU9K8O8lr+3rHXwRQA55P8y6nBOsd6z61f8CIpxwRw=;
        b=j4fY94/qNS6nko13YQeZFfeCc42kIRnbv81yfenAy8gz6ooeWTr1nraMDxuB1N7xtC
         TAI25VfO7JdPRx0ch+YtKrPNr3lXvjfBwSulUhw/NNb/Oxmhh0OM08oPIf1AxLc2otIU
         xKrftnNrImtUw++y5otPH12o1vasbVK5W0+G4t3jBhWplVhTVnxVpsn4THf3LhWIpgVN
         dJOkHHQ6THyShOSKhgglluf4dJill67pHei38N+xIUBUMnnfxbdvTUgjoZQdyIxHm+U2
         0jZw9dRmJEIADch8eUwPGcbwZf5hJC7L8ijCGHGqMj3tXAc8quySeM2oKdHnTIVhmgRI
         Nwgg==
X-Gm-Message-State: AOAM533+qxIwmd3Ur0okmXDBUAaZgk/vdxFnmtkV15bylGduX4AQaTOW
        +eZz51QNcVONm3MfFeg943yNzA==
X-Google-Smtp-Source: ABdhPJzuRDJWAxPCuSeDZkNIGM/J3GwrRrwVFw+NjiOftQtrJh5oLckq92dQmblysU6ylnUPSswJKA==
X-Received: by 2002:a17:90a:dc82:: with SMTP id j2mr1522625pjv.99.1613331678340;
        Sun, 14 Feb 2021 11:41:18 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([45.249.78.214])
        by smtp.gmail.com with ESMTPSA id 125sm15129247pfu.7.2021.02.14.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 11:41:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/7] drm: sun4i: dsi: Convert drm bridge
Date:   Mon, 15 Feb 2021 01:10:55 +0530
Message-Id: <20210214194102.126146-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert Allwinner DSI controller to full functional 
drm bridge driver for supporting slave panel, bridges.

Here, are the previous version changes[1].

The key concern about these changes is about kms hotplug which 
indeed not compatible with bridge conversion.  However, I did 
try several ways to support hotplug with the bridge but it's 
resulting in a deadlock where bind never attach bridge until 
bridge pointer found and bridge pointer cannot found until bind 
finishes. Any inputs on this would be appreciated.

[1] https://lwn.net/Articles/783127/

Any inputs?
Jagan.

Jagan Teki (7):
  drm: sun4i: dsi: Use drm_of_find_panel_or_bridge
  drm: sun4i: dsi: Add bridge support
  drm: sun4i: dsi: Convert to bridge driver
  drm: sun4i: dsi: Separate code for bridge pre_enable
  drm: bridge: Queue the bridge chain instead of stacking
  drm: sun4i: dsi: Use drm_panel_bridge, connector API
  [DO NOT MERGE] ARM: dts: sun8i: bananapi-m2m: Enable S070WV20-CT16 panel

 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts |  85 ++++++++++++
 drivers/gpu/drm/drm_bridge.c                 |   4 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c       | 128 +++++++++----------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h       |  11 +-
 4 files changed, 150 insertions(+), 78 deletions(-)

-- 
2.25.1

