Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52423885E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353262AbhESESX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhESESW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:18:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798DDC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:17:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v14so5797480pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xBAmlGmAhkNvMdsddqA/yKphvAVlxqJKNJ9NsTJMkQ=;
        b=htk8OOx/vusfyShmWu8F4zdFd56n888Iy1H+c5O0xWAcU9BiGsSIqilCcnrG+/tRGu
         8+hZdO77kAA4wAqGkUVdiNQQmjcm//lpUNgHoC5L9mqQgvEn3JwUAP33rtTmHrChMql+
         FQECDi9ohd/daGZqbq2Bq6rmOUdZRjmpYss2zdx86PMBcILnc74hWLhEui6P/lFmCXXi
         B/S6l0aAaBwi2MJwBpAk5onvpS9uQ9wB8nNZYaj0xoHRr4hodsIbw9uxR3zUpEGlR6l7
         TpXEoFWahreZavOJDnliGf6ZOtnBFxYrGLk79k+YnjXZ/qRv6ncwZpV3mc+Q4f9ucRfk
         Qh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xBAmlGmAhkNvMdsddqA/yKphvAVlxqJKNJ9NsTJMkQ=;
        b=J1XNtE+JWgaYK0ZXaMEZ3Cl+9btHNv7z6h7UjPt5IQNzVqbCE7tE7QcxD9zgIt7nQs
         XcWAvXXg7EaJfzyUBkAhWyhltEU032jeC0VnEd89+tM04NWyngvtbVAxX+7wyp2cfVwY
         P5E0LlvJP5hi3PC042QqKimNRU/jkoQrq/3zmwLF0/0cJDaHhggSiMV7VaoOXnDOHE8B
         ZS/B16pFXqDj2nEYEhYfpxEtBM9cKZogFW+RhrZ7RGD7TU6zQ+Jwy4wMYm88wYzVSJIO
         cVe9WBNSADFYHPQam10G/hh1vTATIJks3fu0Yv2Ay/23yijv240SGu8LGCK/iMKJ0PEd
         BnyQ==
X-Gm-Message-State: AOAM531UNSSkgdJjgNK2LXmW38ddUhaAXXtW71a3IcUcvaonuVZyzPGp
        gZvZ1twCzE9q+NpCSVvEzSs=
X-Google-Smtp-Source: ABdhPJyuQ3XeIA/Rnm+1ljTooR6LDM5UoElLgzIApmc6Q9q3m1pBZjg6RNlV0xP2PKY+k8qTWfp3Sw==
X-Received: by 2002:a65:668c:: with SMTP id b12mr8765066pgw.212.1621397823065;
        Tue, 18 May 2021 21:17:03 -0700 (PDT)
Received: from novachrono.domain.name ([106.214.255.120])
        by smtp.gmail.com with ESMTPSA id b1sm15231500pgf.84.2021.05.18.21.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:17:02 -0700 (PDT)
From:   Rajat Asthana <thisisrast7@gmail.com>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rajat Asthana <thisisrast7@gmail.com>
Subject: [PATCH] greybus: audio: Fix sparse warning.
Date:   Wed, 19 May 2021 09:46:24 +0530
Message-Id: <20210519041624.824757-1-thisisrast7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enforce int type on SNDRV_CTL_ELEM_IFACE_MIXER to fix sparse warning:
> warning: restricted snd_ctl_elem_iface_t degrades to integer

The iface field in the gb_audio_control struct is of type __u8, but the
values stored in it are of type int. So on conversion they are degraded.
Adding (__force int) will enforce them not to be degraded.

Signed-off-by: Rajat Asthana <thisisrast7@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 1fc7727ab7be..1e613d42d823 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -676,7 +676,7 @@ static int gbaudio_tplg_create_kcontrol(struct gbaudio_module_info *gb,
 	struct gbaudio_ctl_pvt *ctldata;
 
 	switch (ctl->iface) {
-	case SNDRV_CTL_ELEM_IFACE_MIXER:
+	case (__force int)SNDRV_CTL_ELEM_IFACE_MIXER:
 		switch (ctl->info.type) {
 		case GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED:
 			ret = gbaudio_tplg_create_enum_kctl(gb, kctl, ctl);
@@ -903,7 +903,7 @@ static int gbaudio_tplg_create_wcontrol(struct gbaudio_module_info *gb,
 	int ret;
 
 	switch (ctl->iface) {
-	case SNDRV_CTL_ELEM_IFACE_MIXER:
+	case (__force int)SNDRV_CTL_ELEM_IFACE_MIXER:
 		switch (ctl->info.type) {
 		case GB_AUDIO_CTL_ELEM_TYPE_ENUMERATED:
 			ret = gbaudio_tplg_create_enum_ctl(gb, kctl, ctl);
-- 
2.31.1

