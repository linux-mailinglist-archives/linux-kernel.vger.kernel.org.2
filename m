Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3596A460117
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbhK0TYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350814AbhK0TWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638040759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FmEONlRLRS7Q3m1/IGZ8/wAcZ9/vJrKLoCBv/npZi2U=;
        b=StJK0sWZkUyrUhLPuIkKwa9jN5cm4jGRWxu0ZKChCaEYu1AG8lwrdGmJxPs+nX+QeLyHAs
        9fH/1j/vDjBXtG/Pbe8YSnvK5X1sPiQy6a6NzAkCTLlgfWqKTVhXvnpNfaGwuc1J0p0dVW
        t7WaRwqLryR2S+7xobP3kUYBE4zVpYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-7VgOhMIQPEu76NxFWZZrHw-1; Sat, 27 Nov 2021 14:19:17 -0500
X-MC-Unique: 7VgOhMIQPEu76NxFWZZrHw-1
Received: by mail-wm1-f69.google.com with SMTP id c8-20020a7bc848000000b0033bf856f0easo9087650wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmEONlRLRS7Q3m1/IGZ8/wAcZ9/vJrKLoCBv/npZi2U=;
        b=agDPsqVVxT4jGpx4Q6VWOFLgqgu4mZSdWPzbOIkcXzrFZ9XTbvW5JuK/E0h8s0m50e
         lL0EqskgxwAkRPO5d/2c8fYQtOTIV9d1MRAetWoBo3oROxPRLgP8qZ/DAZ9pRRFGh6yN
         oYKRGPoSyX6v1PdtwB05C4l8mcDMzzxmkeMDaGJaXh5Md8kZojwSyv5QcNXf/TM9fbu6
         RUtuoBNuLO8ubk5NnzE95b2eRGeng6BqE06KOMwHsaKx3R2gdktpSL7iS2CYj4TPxpuQ
         XvjDX9zzArGSAH8FO+ZDKuQ7TiG7OlaWJ+Gm8IzculXrzXm3rW00KCfdK2XsH9kJCR0h
         M0Wg==
X-Gm-Message-State: AOAM533aEHdwyHFBU2npQKl3ih9S2aSu/xruQRivPAe4sx6R6F7fxQhf
        HlBKZBxM0F+t8dCu841/O+hj/b0cMHjk3IEtMoPZfujR6jFfDgEQEJn5MF6VDtpxtiabH5WFwF4
        2KkoVepzSdPhLqL554cVoUatrekmxWjurEHDeuSsCMd8wG2IdR+fWU0c8nbGGIk0+bGYyg1k2pt
        4=
X-Received: by 2002:adf:eac8:: with SMTP id o8mr22999004wrn.337.1638040756599;
        Sat, 27 Nov 2021 11:19:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxabUOTDhc5FjxR7ONoe8Du3sRBNo52FTEfP5Zf+UIg18HyEeIugSjNA5q9jOQ28IpzglwJhQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr22998975wrn.337.1638040756301;
        Sat, 27 Nov 2021 11:19:16 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i17sm11391314wmq.48.2021.11.27.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:19:15 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Fix build error caused by missing drm_nomodeset.o
Date:   Sat, 27 Nov 2021 20:19:10 +0100
Message-Id: <20211127191910.709356-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch for commit ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter
to the DRM subsystem") was generated with config 'diff.noprefix true'.

But later was applied using 'cat nomodeset.mbox | dim apply-branch' on a
machine with 'diff.noprefix false'. And command 'git am --scissors -3' as
used by the dim tool doesn't handle that case well, since the 3-way merge
wrongly resolves the path for new file drivers/gpu/drm/drm_nomodeset.c as
gpu/drm/drm_nomodeset.c instead.

It led to the following build error as reported by the kernel test robot:

  make[4]: *** No rule to make target 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.

Fixes: ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter to the DRM subsystem")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 {gpu => drivers/gpu}/drm/drm_nomodeset.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {gpu => drivers/gpu}/drm/drm_nomodeset.c (100%)

diff --git a/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
similarity index 100%
rename from gpu/drm/drm_nomodeset.c
rename to drivers/gpu/drm/drm_nomodeset.c
-- 
2.33.1

