Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B631F188
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBRVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBRVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 16:05:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA86C061756;
        Thu, 18 Feb 2021 13:05:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m1so5148579wml.2;
        Thu, 18 Feb 2021 13:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKu8nW+IhkI0fhmgVr8yPbUe1udaTjMcC5LDq4YsEcE=;
        b=osYveTfuj+Cgj+Q1WULftu2Kn47vghARQEgS0i9Loy7FKPxlxmhTAhKnU4Dav5dpKR
         rXA7kkmBlfWr1WWONlDA36mBUXfW/EmH/DnZW/h1YEOZqTAVZTHex4wiJUpj2p2mFdYc
         +qsp8R0Cm0v3Jqw6KPG5swda4T0mwXRIixpZFS1g39zlChp6QUzBGwhP393mI+Ir23xH
         sawVMk3U1+ZG3yi2uZDGj1T2z8+ax19TqAsLPIIE6e+A/U4a6YulifhiHGprNxmHdD2w
         WqU6GpwDT71sH5KILU5FpIql51tZGskGYifyQrSge3xZeBRpKSKTnjR0eHQnl2uIGzUQ
         OFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKu8nW+IhkI0fhmgVr8yPbUe1udaTjMcC5LDq4YsEcE=;
        b=aLxJT0T4irbz1voY6PqDExY181GIIaxI7VsLmGUQEhyLVZnmelxb1eNpbSSjHF6/VD
         89aSJXa4M3EKCCEk1LclV9dlYauupwb3kNtMl4dBgwsEJyqvGvKwnxb3Ohzu7NLW2KiB
         Io5jkp+gGCjS66ubEgKMEvq15l+mtdgCDTSEMVeYtczDRwkIjnOr8Cnoh2AxNX09la/8
         Tf6KgoO+ZleLNL3hmOgqr1E9LnmmoywOy5b0IoDA9s7ZJh/e0kUv0biKrSjoDf/aCJEH
         sUsPHgihWVfgNEVXrYOum7rqOBV9EOA2CXh2seNb3YBxuJoQ6xmeTdcjJsDo3NKW/WbY
         +3mw==
X-Gm-Message-State: AOAM531drzbpc09DeAL0GG6z/IKZRTreINnR/gM+AesVkaswcmhsFBCC
        KuxcSUGTAQt7kkLCNOVQ0x0=
X-Google-Smtp-Source: ABdhPJwBAIVnorgmOFhuQV+xAPUIp17Uton26DgC/TS7PQgpGmgxBZyThUYYDsaXuezZFuJUOintOQ==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr5246257wmq.2.1613682315921;
        Thu, 18 Feb 2021 13:05:15 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270040b01df6f3b9f578.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:40b0:1df6:f3b9:f578])
        by smtp.gmail.com with ESMTPSA id m2sm8450878wml.34.2021.02.18.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:05:15 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robert.foss@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        a.hajda@samsung.com, robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Thu, 18 Feb 2021 22:05:02 +0100
Message-Id: <20210218210504.375752-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch set adds the support of the Lontium lt8912 MIPI to HDMI
bridge in the kernel.

It's only support the video part, not the audio part yet
since I don't have the datasheet of this component.
I get the current i2c configuration from Digi and
Boundary drivers.
Developed using the DB_DSIHD board from BoundaryDevices.

Update in v2
  - Use standard data-lanes instead of a custom prop;
  - Use hdmi-connector node.

Update in v3
  - Fix indentation;
  - Implement missing bridge functions;
  - Add some comments.

Thanks,
Adrien Grassein

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912
  drm/bridge: Introduce LT8912 DSI to HDMI bridge

 .../display/bridge/lontium,lt8912.yaml        | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912.c       | 760 ++++++++++++++++++
 5 files changed, 883 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912.c

-- 
2.25.1

