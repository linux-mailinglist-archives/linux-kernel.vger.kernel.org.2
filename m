Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB24390AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhJYIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhJYIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635148689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0p9g1EJ/0qWdAEcRtSmulfYZr3WWmbZrrR9U8/IUCM=;
        b=Y8zkgJ2N10MLa4zur76pJdlJssPShXCrdKGqTWYmV+dL+uhRieFSiI6hOz+l0OoHj7M6Hb
        9Amv3oQiuAhjAMP2FnJmGuC3Sw6ffDxvtLsO5QBrAB8zeF2te/GthY0ckmcR2rVyvGuAEt
        X/0Sk2VYRQuDrTGWSr7zmiiWmyo3nSA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-bc0O12aXNcmDBTqB7Qs_iA-1; Mon, 25 Oct 2021 03:58:08 -0400
X-MC-Unique: bc0O12aXNcmDBTqB7Qs_iA-1
Received: by mail-wm1-f72.google.com with SMTP id c18-20020a1c9a12000000b0032caecbbe54so1412354wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0p9g1EJ/0qWdAEcRtSmulfYZr3WWmbZrrR9U8/IUCM=;
        b=rwIKyiIQAqCPmWyiUyrbenXXXbTlv+PB6lXn+5s6CqB6qOGHzzeVn/R4w2HUCoQBEN
         oOQq8SnWJI4IVAJJH5XRKp7aGuf0Ow/ldhHHr0qsSkruGaepvPo/l0S49pMCIuhl80++
         vA7rvKETTcsGFCwk3GY0zqNVgNw91lvMR6PYtq8Xl8htkuiVKJcVaGnnoa8sHFnGjO1J
         ViL0j2kUR+2VPjlgt3ZQJys84WZ7gXBqX3TRcX8YEc0SpbSR3OiV8taB04+zzoq7dZs9
         uGjs2Di1kj3Qm3/NN04r+TEZC2wtbhOvoYoASKfOOD7RKlUjPGfHan4CszUh/NqbOy+I
         Iz6A==
X-Gm-Message-State: AOAM533gep2jlN4YOoB0z1gVmmSkzqe5nh+3YGrbWoLAUkfQsXFob19z
        Mj8Aimmvk2G1uNonL5kQC5cEuKOGJMa5EYp2RJYKVtlfrLH9Q3q76SgJNDq8D0CUDPaAexiQn2G
        OUbOW/l6TxSvkF5kebfvrcTRMrxpo/Z+lDamxCzBM1sSIMA2MRLIZDuDN1gcZp0WfO1v73weyMH
        g=
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr5095641wmj.98.1635148686741;
        Mon, 25 Oct 2021 00:58:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeNzkCghAlbSOu9+pb40+e2jeuC0g3pAsuLw7y+ObmidA5Y7eKQIcaEQLbwjJtVjm7FZobuw==
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr5095606wmj.98.1635148686449;
        Mon, 25 Oct 2021 00:58:06 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d1sm15939502wrr.72.2021.10.25.00.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 00:58:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/aperture: Prevent conflicting framebuffers removal if option is set
Date:   Mon, 25 Oct 2021 09:57:56 +0200
Message-Id: <20211025075756.3479157-3-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025075756.3479157-1-javierm@redhat.com>
References: <20211025075756.3479157-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simpledrm driver allows to use the frame buffer that was set-up by the
firmware. This gives early video output before the platform DRM driver is
probed and takes over.

But it would be useful to have a way to disable this take over by native
DRM drivers. For example, there may be bugs in the DRM drivers that could
cause the display output to not work correctly.

For those cases, it would be good to keep the simpledrm driver instead and
at least get a working display as set-up by the firmware.

Let's add a drm.disable_native_drivers kernel command line parameter, that
when set to true it prevents the conflicting framebuffers to being removed.

Since the drivers call drm_aperture_remove_conflicting_framebuffers() very
early in their probe callback, this will cause the drivers' probe to fail.

Thanks to Neal Gompa for the suggestion and Thomas Zimmermann for the idea
on how this could be implemented.

Suggested-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Rename command line parameter to drm.disable_native_drivers.
- Return -EBUSY instead of -EINVAL when the function fails.
- Invert the parameter logic and make it false by default.

 drivers/gpu/drm/drm_aperture.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 1a8ed0c616d6..6ae20b6d6499 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -14,6 +14,11 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 
+static bool drm_disable_native_drivers;
+module_param_named(disable_native_drivers, drm_disable_native_drivers, bool, 0600);
+MODULE_PARM_DESC(disable_native_drivers,
+		 "Disable native DRM drivers probing [default=false]");
+
 /**
  * DOC: overview
  *
@@ -307,6 +312,9 @@ static int drm_aperture_remove_conflicting_fbdev_framebuffers(resource_size_t ba
  * This function removes graphics device drivers which use memory range described by
  * @base and @size.
  *
+ * The conflicting framebuffers removal does not happen when drm.disable_native_drivers=1 is
+ * set. When this option is enabled, the function will return an -EBUSY errno code instead.
+ *
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
@@ -315,6 +323,9 @@ int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_
 {
 	int ret;
 
+	if (drm_disable_native_drivers)
+		return -EBUSY;
+
 	ret = drm_aperture_remove_conflicting_fbdev_framebuffers(base, size, primary,
 								 req_driver);
 	if (ret)
@@ -335,6 +346,9 @@ EXPORT_SYMBOL(drm_aperture_remove_conflicting_framebuffers);
  * for any of @pdev's memory bars. The function assumes that PCI device with
  * shadowed ROM drives a primary display and so kicks out vga16fb.
  *
+ * The conflicting framebuffers removal does not happen when drm.disable_native_drivers=1 is
+ * set. When this option is enabled, the function will return an -EBUSY errno code instead.
+ *
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
@@ -344,6 +358,9 @@ int drm_aperture_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 	resource_size_t base, size;
 	int bar, ret = 0;
 
+	if (drm_disable_native_drivers)
+		return -EBUSY;
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
-- 
2.31.1

