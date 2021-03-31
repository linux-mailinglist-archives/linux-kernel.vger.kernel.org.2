Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB334F732
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhCaDGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhCaDGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:06:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA78C061574;
        Tue, 30 Mar 2021 20:06:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a12so4645854pfc.7;
        Tue, 30 Mar 2021 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IZPrYnPkidjfkwOd95npa8XUYpnaw/oHRnVzmbq1aY=;
        b=F+f6y0/3BlkhyuHDYfJfPdxpx/7rP5+f7mEribYnja+kgWL8OfuZ7zaafwnBW9N2fm
         l2ju4kj9Xb22kIYf0uM0iNefKb/SMxTLiBXu/gknw46mV4oZpTUNeA/DZlgXxva4jc5f
         T9WISUDA4DyZHpKZib+K3RSXNVX+R1km5cgTJJrhDQEKQRCsu/O6PXZNAMm9G+bBDghp
         vs48gbPQvRy91fdBkfGLcWdDot7dQ0C4VOeIGtVlFfv9kqZqwZ1g8XA9L2+kwyFVueWN
         4dClyMpFrGR4TFnN2KWnB/frjta8Dzy7f5Ka0Ihid6yoF8PC83NDnxa0bzma+l7Ox4nH
         Ov4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IZPrYnPkidjfkwOd95npa8XUYpnaw/oHRnVzmbq1aY=;
        b=c4SP9IfBZJXb8dhXL6iWNKvcqyPH1OKic8Afpus4yOIzyNYDwuwDiu+L9PiJQ/P2Ql
         FwQ2lYvq3d4a1QMykjfukwLfD7Y0ZMm0ind7//8PIHzw1LyG8DrtwczY+7FQPMEWvuf/
         brpE87I/jSot8EBG89EdxgG1rIFHgPTqUCKmIzo/UNnKFUGjpLLEQg4X/fj/Ri5l9RWJ
         0EM9EDULyX6ZV8F0IwFoeCFybbOoomFvTR4l2V4+1hY2Z5XmD1GER+sPM+Q7ZxX2msTU
         ihMcDuq/C0pdR1PDFEDYCb2sk5UoH+v0CM1yqQzPH5Sw+iGOYTEscTAgsnNdH7TLUvzT
         fyww==
X-Gm-Message-State: AOAM532AHAZkEV+0y1dXfvLCfFUo2/0BGl1dDxFBhGOkQFG78ol2oJQB
        5zANOe0wnypcwbTBI64Ai/0=
X-Google-Smtp-Source: ABdhPJzR3p/VuEwkIaS7e9O0f5ShH/3oUMeC6mvL9qRrkJ7j6anwyFNzHSLGiSPd5JZc9f3552HU8A==
X-Received: by 2002:a63:f014:: with SMTP id k20mr1127406pgh.323.1617159963467;
        Tue, 30 Mar 2021 20:06:03 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k21sm375376pfi.28.2021.03.30.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:06:02 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, zhangxuezhi1@yulong.com,
        robh+dt@kernel.org
Cc:     sam@ravnborg.org, kraxel@redhat.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] add support for Waveshare 2inch LCD module
Date:   Wed, 31 Mar 2021 03:05:48 +0000
Message-Id: <20210331030550.119493-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@yulong.com>

This patch add support for Waveshare 2inch LCD module.

Xuezhi Zhang (2):
  drm/tiny: add support for Waveshare 2inch LCD module
  dt-bindings: display: sitronix,st7789v-dbi: Add Waveshare 2inch LCD
    module

 .../display/sitronix,st7789v-dbi.yaml         |  72 +++++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/tiny/Kconfig                  |  14 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/st7789v.c                | 269 ++++++++++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
 create mode 100644 drivers/gpu/drm/tiny/st7789v.c

-- 
2.25.1

