Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1502D3F97BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbhH0KBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhH0KBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+aJr1NTbvoxTLmIeJJqoJBHarMi/IcOrX6ArL1A6zIk=;
        b=frrQNKgad8Fq5XUaunOjjNmyImR5WgPf3VymQhdW7XfPQTid1PGUlN+gFyk4v9CJs5hsgk
        h9+Mg2w9Vfv8lCrpXlRFH7DsBbsTXxrzDa/5lchjoaWmWmKWJRxzdF5xPyA6+LMkUPw/f2
        tGBcTI4lkqtdLCzSp8+W5gPPVz02JJQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-oBFXZpRZOBiYX0XS2SKS3g-1; Fri, 27 Aug 2021 06:00:43 -0400
X-MC-Unique: oBFXZpRZOBiYX0XS2SKS3g-1
Received: by mail-wr1-f70.google.com with SMTP id o9-20020a5d6849000000b001574518a85aso1686999wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aJr1NTbvoxTLmIeJJqoJBHarMi/IcOrX6ArL1A6zIk=;
        b=R0NiL8fK0sxqRWdGlXv92es6J+jkKtSxs5+G2xQ+naZ9mvw6br6BdPKiY/nG64q9UY
         TnKYgLVwYKyuETgh9EaCZLP5oMIsWqjUJN9TDRPDarUqRi4uGpgYklsHaqFK5kGZ4pEf
         Dq6x5hIh0uvGqh3mwEZqrCsvtuHHHbUFtpBG7QLnoi6KAMNNkfI2G7CY2c70e5AitDkv
         yRtOnjfCWp4hd7ZzOjFGD8VE0YJiq1CNS8C8jmgnWwvZEf6f8gnSxpokKM2DNXozC5bg
         nJcefot044n8VW1gOZdfmPt1ixD3wDTQUzvQLkYltRFhIPR5jbwOT+MfqJzrSmtQH0fO
         6sOg==
X-Gm-Message-State: AOAM530SqXqHcSnwXacnRaTHA8O2wTDE2g1LWxHbYdPuVnGzbSrA0b3w
        GssUYukxVvuTWbVO5CXYyujztHHVwNFWH0PIXzUs90wMxX39G03LKeKU0/s0EvYi4/jCh3xCqFC
        8Q9qECRFlGZ+n17lTA09CVEMgM5QIxoFuGphIpB2CJmdrF357zqfCS4VwEN9ZyvQAq6ttAMatYs
        E=
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr18455124wmc.25.1630058441731;
        Fri, 27 Aug 2021 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD3l80v92gfAfOSZ8b1Ut69bemPoE/9nlRVQcrJ7xuf3wtFFgtxktW5NFZYCYctIfnyuFMVA==
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr18455078wmc.25.1630058441335;
        Fri, 27 Aug 2021 03:00:41 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z17sm1121267wrh.66.2021.08.27.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:00:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with CONFIG_FB disabled
Date:   Fri, 27 Aug 2021 12:00:23 +0200
Message-Id: <20210827100027.1577561-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still using fbcon with the DRM fbdev emulation layer.

The reason for doing this is that now with simpledrm we could just boot
with simpledrm -> real DRM driver, without needing any legacy fbdev driver
(e.g: efifb or simplefb) even for the early console.

We want to do that in the Fedora kernel, but currently need to keep option
CONFIG_FB enabled and all fbdev drivers explicitly disabled, which makes
the configuration harder to maintain.

It is a RFC because I'm not that familiar with the fbdev core, but I have
tested and works with CONFIG_DRM_FBDEV_EMULATION=y and CONFIG_FB disabled.
This config automatically disables all the fbdev drivers that is our goal.

Patch 1/4 is just a clean up, patch 2/4 moves a couple of functions out of
fbsysfs.o, that are not related to sysfs attributes creation and finally
patch 3/4 makes the fbdev split that is mentioned above.

Patch 4/4 makes the DRM fbdev emulation depend on the new FB_CORE symbol
instead of FB. This could be done as a follow-up but for completeness is
also included in this series.

Best regards,
Javier


Javier Martinez Canillas (4):
  fbdev: Rename fb_*_device() functions names to match what they do
  fbdev: Move framebuffer_{alloc,release}() functions to fbmem.c
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation depend on FB_CORE instead of FB

 arch/x86/Makefile                  |  2 +-
 arch/x86/video/Makefile            |  2 +-
 drivers/gpu/drm/Kconfig            |  2 +-
 drivers/video/console/Kconfig      |  2 +-
 drivers/video/fbdev/Kconfig        | 57 +++++++++++++---------
 drivers/video/fbdev/core/Makefile  | 13 +++--
 drivers/video/fbdev/core/fbmem.c   | 73 ++++++++++++++++++++++++++--
 drivers/video/fbdev/core/fbsysfs.c | 77 +-----------------------------
 include/linux/fb.h                 | 18 ++++++-
 9 files changed, 134 insertions(+), 112 deletions(-)

-- 
2.31.1

