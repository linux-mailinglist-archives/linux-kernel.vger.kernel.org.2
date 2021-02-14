Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77A31B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 00:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhBNXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 18:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhBNXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 18:30:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11EC061574;
        Sun, 14 Feb 2021 15:29:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o24so6348721wmh.5;
        Sun, 14 Feb 2021 15:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evlyv8cW4AaH5I2gOc3PmwqIiElKj0kJaTfG3XXnM1U=;
        b=ecDlWsOnQELKqf0jvx4yn2aud0nXYXVZmT3PWOMXEZinickGNSRou3xYFv+YvI/9g4
         AwFipmpoybrdtvzINATFrILSiCrPHXAbnHwQPYpWK7ou39NQPczu00tkqH3+QZ75vHat
         yBwWXqwuqElsDi6nGrdKjKUXdVN/iMg79xtNcNT8RqypWSOZVlZOYzmaTbLMbQFnhnoQ
         D3hYRBqMFrtdEKsskoa+n3x4tJpwyoKWAsixTcNEjynI7Z417krJ17JeGkS6Qc8t+2SZ
         25fFodTOfnAMGzZLkLsT6EQO/f+dgL/ZdkF57+DTWEs+nEC4ysGt5vfbcJTA+Y3qtZZ4
         4oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evlyv8cW4AaH5I2gOc3PmwqIiElKj0kJaTfG3XXnM1U=;
        b=l/pHXeN3F+JtML7tDW5uxMVlV7bHFhEUnXdDa2M5aWxd3ZSYgWUsOvOap0tc27PaVb
         y5Hgpzqx6wO8flNdu8WDs5q884n6h4b1JEuY/sLBVQkFbPmXeYUt0a7mKBKignSg+SfY
         p+rSeO7z65ft6W8N8aCTPTSboiqdgtwZCimMnVsx47zn88RMmLJqQJS7cDep66OunZ2Y
         R8NuS50ah5GN4if225ulHAkbvEF7Kxj/xbk5V5fekgHXTdFci08iomV0WtXIYmR4z4Rh
         jemjmqKjbNagSxkHV0PeEiKOwPSU26RFg6NQYcYUphKisfnmnuCR82fjo4yJoznwzsMm
         3nlg==
X-Gm-Message-State: AOAM532XftkE9wL0HkgjUvfuhaRUJJ6GgtqAYH9Vr9G0T0KPOidh0FqZ
        GE9sMXpz4BY+mBIaEND6Qts=
X-Google-Smtp-Source: ABdhPJzUE8PaFQc9mUFNlvbSd5ayCBji/He2N37077krd9VhHiU9FPE0Pb3yXOkXJW165LSDI9k/dQ==
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr852143wmq.127.1613345377556;
        Sun, 14 Feb 2021 15:29:37 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700341b9a8437bdab47.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:341b:9a84:37bd:ab47])
        by smtp.gmail.com with ESMTPSA id l1sm19522478wmq.17.2021.02.14.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 15:29:37 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, a.hajda@samsung.com,
        robh+dt@kernel.org, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 0/2] Add support of Lontium lt8912 MIPI to HDMI bridge
Date:   Mon, 15 Feb 2021 00:29:02 +0100
Message-Id: <20210214232904.1142706-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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

Thanks,
Adrien Grassein

Adrien Grassein (2):
  dt-bindings: display: bridge: Add documentation for LT8912
  drm/bridge: Introduce LT8912 DSI to HDMI bridge

 .../display/bridge/lontium,lt8912.yaml        | 102 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/bridge/Kconfig                |  14 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt8912.c       | 719 ++++++++++++++++++
 5 files changed, 842 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912.c

-- 
2.25.1

