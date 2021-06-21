Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9A3AE373
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFUGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFUGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:47:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D157C061224
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:44:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w71so2844383pfd.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MByV6cpfz5xYL+DMP3l1hiWnj/Gzo6aYK3LpWdzWngw=;
        b=b29mzE46OF31Q0CDVIkCAi2dK/16TmoZc6FE32WuI0K0eE59eopnCwAo/XS+aCT4GD
         vB678ZVcP9xoXMVTsUk/OR0Mp4ts1fhMvmiktvVyUyAQTpBttVz8JcQwp4b1Tdconwgw
         8zZWW7a9Xn2iGmAREWcAEk1GMReMXDFhOUGuG5ciepZCDjsZIk+ArbLPLDhRJy9/mGdh
         zW0hRFKpx3RbUO24fU/jL3PEyRpQhlckS0HPgcphPygMzI+PY49rzRGCrpTxkecJs8q2
         zy/GFkZ04RTUajYooN0PEQZQKFt5xsLgIJa5cBfu8VOd3Gdtpi0WXSeUA6RDAdJVgT63
         yZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MByV6cpfz5xYL+DMP3l1hiWnj/Gzo6aYK3LpWdzWngw=;
        b=GGja3430S38ejTnRhkBabF6lOMU2gRQ49vhg08aJ/z/cfm6MsSUK5gL6QSTIXsm+ee
         wDfD8NEb+wOTKKmnI6ipd+m38EQhOfTuuwTYfj89NY8BSa3tP7NeK7j+5j92X3A56ywN
         BrI6C/txSo6KYdzhtED/gMAsbC8VX+19E5FNLfRoVOe/l2aU8dCYOFpMlxbaDpTsQYLg
         HFqvnEbyiH/0MVraeu2PNaGjV86YzCPstL7LRYwGWFCW/pxsmcwN8AelxkEIJdhA3Fzz
         ORuacH24ECpJPPk094WgTngJHWHxNSgE8wi9r55GpFacC2u66Evo244ex+dicqEs5E+k
         e7CQ==
X-Gm-Message-State: AOAM5331hC0nUoKlaTcfXNrXGr8vNDM1OXmPJ2IY8JjMFMhnBVaVkGu1
        7ubuLHIA7qOgqOESBSitJn7X9w==
X-Google-Smtp-Source: ABdhPJwH4/eLR8eUZGuKN8dGXC6akwtVCwhZ4Ipv8+e+H+PA4zXKM/he9uNlz8M414i8BGg/A2nyGQ==
X-Received: by 2002:a63:ed08:: with SMTP id d8mr22298931pgi.373.1624257888998;
        Sun, 20 Jun 2021 23:44:48 -0700 (PDT)
Received: from localhost.localdomain ([240b:10:c9a0:ca00:61b8:26ec:dc30:8823])
        by smtp.gmail.com with ESMTPSA id o34sm12744450pgm.6.2021.06.20.23.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 23:44:48 -0700 (PDT)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, Tomohito Esaki <etom@igel.co.jp>
Subject: [PATH 4/4] doc-rst: Add virtual DRM documentation
Date:   Mon, 21 Jun 2021 15:44:03 +0900
Message-Id: <20210621064403.26663-5-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621064403.26663-1-etom@igel.co.jp>
References: <20210621064403.26663-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
---
 Documentation/gpu/drivers.rst |  1 +
 Documentation/gpu/vdrm.rst    | 51 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/gpu/vdrm.rst

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index b4a0ed3ca961..bad0226de972 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -19,6 +19,7 @@ GPU Driver Documentation
    xen-front
    afbc
    komeda-kms
+   vdrm
 
 .. only::  subproject and html
 
diff --git a/Documentation/gpu/vdrm.rst b/Documentation/gpu/vdrm.rst
new file mode 100644
index 000000000000..2ab1699c2f42
--- /dev/null
+++ b/Documentation/gpu/vdrm.rst
@@ -0,0 +1,51 @@
+=============================
+ drm/vdrm virtual DRM driver
+=============================
+
+Virtual DRM splits the overlay planes of a display controller into multiple
+virtual devices to allow each plane to be accessed by each process.
+
+This makes it possible to overlay images output from multiple processes on a
+display. For example, one process displays the camera image without compositor
+while another process overlays the UI.
+
+The virtual DRM creates standalone virtual device and make DRM planes from a
+master device (e.g. card0) accessible via one or more virtual device. However,
+these plane are no longer accessible from the original device.
+Each virtual device (and plane) can be accessed via a separate device file.
+
+The virtual DRM driver doesn't directly control the display hardware and has
+no access to the physical bus. Instead, the virtual DRM driver issues requests
+to the standard DRM device driver ("master" driver) when the hardware needs to
+be controlled. The master driver is modified to notify the virtual DRM driver
+of interrupt events from the display hardware.
+
+Plane position and size
+=======================
+The initial position, size and z-position of the plane used in virtual DRM is
+specified in the device tree. The position and size of the planes are set as
+properties and can be updated. The name of each property is as
+follows:
+* vdrm_offset_x: x-coordinate of the left-top of the plane on the screen
+* vdrm_offset_y: y-coordinate of the left-top of the plane on the screen
+* vdrm_width: width of the plane
+* vdrm_height: height of the plane
+
+Virtual DRM Functions Reference
+===============================
+
+.. kernel-doc:: drivers/gpu/drm/vdrm/vdrm_api.h
+    :internal:
+
+.. kernel-doc:: drivers/gpu/drm/vdrm/vdrm_drv.c
+    :export:
+
+Driver limitations
+==================
+1. Each virtual DRM device only supports one plane per CRTC.
+
+2. Virtual DRM doesn't support hot plug connector.
+
+3. If virtual DRM has multiple CRTCs, the initial position and size of the
+   virtual DRM planes is the same for all planes, since they cannot be set
+   for each plane in the device tree.
-- 
2.25.1

