Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC504089A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhIMLAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhIMLAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:00:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4AFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:59:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so6177473pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHMZuCBFOg4nU4Z2pc8C/3IHJsW+iWPKImwcSRTfnZo=;
        b=RvKi9adbGcBHGtXJLAmUL52Qmn/rv0u8eil2Hs6a8Q2wwVB+M3oGst76Kc8zRaDZ6E
         Z1Oa8+OH00xQUBVNkjv2q0FVaNiZl86Rds10kOvmlFShdSdTB4ZffDkqHnXfSlRaEC7c
         uQsksj+d2VFY+Q7giFt9zuZ83diH8zjhFlPEutnZUD6Da/z6BXCdrA+y/IWqWBYFc4aH
         bLHpvSoWQsm4MazmrnPrVnCB2Um8fKqkoQ4Vj855GnI/nzqMwetHXXW8KE1GhohidSI1
         fbCZrMqgMXQA1Xp9jSGdVxY4a/MB/sG8eyxRdxYIRrSjdFh+4vS23BnYiMVlyaSxoWff
         aHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHMZuCBFOg4nU4Z2pc8C/3IHJsW+iWPKImwcSRTfnZo=;
        b=kMKn6zKvwughEzUPyJ0E2iRhhNcnCcazwgVwychK/7ndMRAHNosSjLotwdBzJmi14R
         V+PVGLT4K3PdF5XKZk5e2jsk+JH/lk745ax9RKhPhjS9LjalT6zXx8blcVn3AmnXvWqp
         s9XvtMn7tKhmeTXCokVpn3/qCeeg11IPoN4xnPAKs4pwgnocMbm0lLFpbWdxCroqdv4X
         TtTw0tVNqB/8dWnRT8WTMYCJ/C0tS2g443J3dqpg5huSIn4t4wmsMJ0/ImM3odhAEq6u
         FSanwssbJ4XZZsv9nvl4bKGk/QiK4giIWdVkge5TdJB/wFe30aVsaYzNCheL1q6bNpvz
         C8LQ==
X-Gm-Message-State: AOAM532hobOVp91SqdAloPbvBy3qAtsm+0htwlKOxoJR7wfedx3h2jA2
        KuJdyleATTNTJfXdp6ufxDYlo4wQVSi15w==
X-Google-Smtp-Source: ABdhPJy1guPJn7N3DJdSqzNu26pConiFh+toPSDCQ7+vTWVEIGK7Jz82JveAXRkc6yq8T8V/EoXf+w==
X-Received: by 2002:a17:90b:224b:: with SMTP id hk11mr12381590pjb.76.1631530767693;
        Mon, 13 Sep 2021 03:59:27 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id l22sm8279641pgo.45.2021.09.13.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 03:59:27 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v5 0/5] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Mon, 13 Sep 2021 18:59:15 +0800
Message-Id: <20210913105920.3719525-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to v4, update init code and porch setting and revert DSI LS mode  in 
drm/panel: boe-tv101wum-nl6
 
-	.clock = 162383,
+	.clock = 166594,
 	.hdisplay = 1200,
 	.hsync_start = 1200 + 40,
 	.hsync_end = 1200 + 40 + 8,
 	.htotal = 1200 + 40 + 8 + 28,
 	.vdisplay = 2000,
 	.vsync_start = 2000 + 26,
-	.vsync_end = 2000 + 26 + 1,
-	.vtotal = 2000 + 26 + 1 + 94,
+	.vsync_end = 2000 + 26 + 2,
+	.vtotal = 2000 + 26 + 2 + 148,
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };

-	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-		      MIPI_DSI_MODE_LPM,
+	.mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO
+			| MIPI_DSI_MODE_VIDEO_HSE
+			| MIPI_DSI_CLOCK_NON_CONTINUOUS
+			| MIPI_DSI_MODE_VIDEO_BURST,
...
...
...

yangcong (5):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  drm/panel: support for BOE and INX video mode panel
  dt-bindings: boe, tv101wum-n16: Add compatible for boe tv110c9m-ll3
    and inx hj110iz-01a
  drm/panel: Update BOE and INX init code to support touch function

 .../display/panel/boe,tv101wum-nl6.yaml       |   7 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 745 +++++++++++++++++-
 2 files changed, 750 insertions(+), 2 deletions(-)

-- 
2.25.1

