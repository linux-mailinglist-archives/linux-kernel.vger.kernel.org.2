Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57387444182
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhKCMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231968AbhKCMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635942511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOigLsb/AiPO+lh5JvcCRxDIH+IjKx25qTIzyzSOo+o=;
        b=ah+zNPjfJDPtlzfL5aOoiAv+Wy3A7eYL5ekfOL6kdLBuvUcSsMkN4TYcn+JN6zy35cFXUW
        zN/beckYOni1sTA/j2f7OgNhKrscpWT2Oqn7in2bbeevtU9DlxvlUZB4DzpuoauW4KlzVV
        Sphgk/zOKdbVFDraOD3L4PZ0PYUmuvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-wW4GAJq9MkyJzoqbTY8ZXw-1; Wed, 03 Nov 2021 08:28:30 -0400
X-MC-Unique: wW4GAJq9MkyJzoqbTY8ZXw-1
Received: by mail-wm1-f69.google.com with SMTP id b133-20020a1c808b000000b0032cdd691994so2683869wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOigLsb/AiPO+lh5JvcCRxDIH+IjKx25qTIzyzSOo+o=;
        b=RLn/5PsNnfG5LpKMWkvVVVRplo3MaQ+9eZgYxGQ1U8E+LsP0m9WgBZv7OzxoG3tXFq
         GIzd3MV7Wu8MhvC7zhzuIizYttbzyyV9FlvbQcRta23PhHhdQZ6QBDUvk4dI8x0Q1UFH
         U6MX8oqOXyIsHlGFs0xyEZ4M1vOtZ0+GP28KwGV5Pow1VttEeaNXVOddjjtgg4MPsJu8
         4m3LwNkzXKlAqhrM1Ju46HGiMpi9aUv0Vs93u4rxwwg2HQmz4KxDxG6YSN/z227L1GNs
         CvLpYsCM8JhCwjU7PMcLrU4Tb6qwrHRW2K+umDEc2HkNDGc96iCX0FI/4k6p2PI4rCfu
         U7RA==
X-Gm-Message-State: AOAM533VZYFJT4hPYgPluKJKyn8TMfIdcEKEBBZpiZkFM2ZcOaSSm57b
        pOg0r3N6v1zAfmhImCyvf3LJsUTVX3HgTxL1lV8/ikBH8HsyM9z8G8K6ycjwK6aod10jSChJdAe
        6rgj6OznCTD6ozVDjNFicjYHqpT7oz+TtfojuxOTXhOC7BzulCj5q+sQRzMK1OcMuvIIuTgLcia
        w=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr47839173wrt.122.1635942509150;
        Wed, 03 Nov 2021 05:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvNRpXmZFEKhQpN3/OMoF+06zLZZouJw2euobrr6tiItTsNV1bIfdLVAHT+sRPk71He+cN7g==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr47839129wrt.122.1635942508901;
        Wed, 03 Nov 2021 05:28:28 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id w7sm1868400wru.51.2021.11.03.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:28:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [RESEND PATCH 1/5] drm/i915: Fix comment about modeset parameters
Date:   Wed,  3 Nov 2021 13:28:05 +0100
Message-Id: <20211103122809.1040754-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103122809.1040754-1-javierm@redhat.com>
References: <20211103122809.1040754-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment mentions that the KMS is enabled by default unless either the
i915.modeset module parameter or vga_text_mode_force boot option are used.

But the latter does not exist and instead the nomodeset option was meant.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/i915/i915_module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
index ab2295dd4500..c7507266aa83 100644
--- a/drivers/gpu/drm/i915/i915_module.c
+++ b/drivers/gpu/drm/i915/i915_module.c
@@ -24,8 +24,8 @@ static int i915_check_nomodeset(void)
 
 	/*
 	 * Enable KMS by default, unless explicitly overriden by
-	 * either the i915.modeset prarameter or by the
-	 * vga_text_mode_force boot option.
+	 * either the i915.modeset parameter or by the
+	 * nomodeset boot option.
 	 */
 
 	if (i915_modparams.modeset == 0)
-- 
2.33.1

