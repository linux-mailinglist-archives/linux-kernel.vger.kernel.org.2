Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86204343337
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCUPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCUPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:39:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a11so10585333qto.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRW9PE4PemHN72A5ymHlcDFWXespNNcujE5EyueWS1k=;
        b=MW7M/frksjY68Z6hpZ1XKQm1soDl0ROTOrzcboTIYi7FXWRONGkTl39yZgcXoYWN60
         NjY1+yS88ZN5QGacqwT6pOsmVFn3b1E5PagRClGs7ZJTRItxPvIb8mFPIALP46u9Yavn
         QBS7YxKKGxLjzMOo+TkEtRzKR0QPDocLUzSfrxruVBIvIdp/th3/BZwrqvaIWE6LkCRO
         /mxJjnEMT0M5N6dz0Kh6grvvLHGLY/ZhYwHnDn16s1dNZE5d1vHThaIe0Ay7TF5o9nAt
         AX91QRtWBHHyefmveaWQco9k4g8+B8UihXlj9z6j9PGy0auW5E+5zGKU5b2VNc3uGwyL
         l0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRW9PE4PemHN72A5ymHlcDFWXespNNcujE5EyueWS1k=;
        b=X6KX2wubyp4B6eadd8/QOl1m1oi3/pqwsRwvPx/7j1B/M1wgeuzeDt8RehsOVTlweZ
         Ywhpt190fOA4MArC6l8s9rbpQ5Mb+6ObQPwnLJdP0IlIsCTge5cPv+U8pXLpLYjbOJY0
         7G+ISkzU0DT44+k9ZLq9Id+mNzykbKSTCXfgxTrYkf62Zikb/bUe6ls0Tt5eJnr3lzsl
         JguaCFZXbtE4/pMdz5GUY1xToMZI1NM3WZFQgxLFRIR5eTiwNrZNBfX8cXC3tDVxXgVy
         gtEJQaCIcFM6A9b86CJYpEhI9Pe2qbKgbE8cc7syXpYpiSdwcQXErB9a9gio9h58xcT3
         JpQw==
X-Gm-Message-State: AOAM533INZy0xn3SuP6mOpiYSVRnqbhM/gJwbZMQK2DU4L1yXH4YkfDk
        AqH1h+W07qtdd55XGqI2zGA=
X-Google-Smtp-Source: ABdhPJx/FaxehlsgcmepHvvf0n9MUE0QFGhKRNoO+mNkK2Tvb8q+G43gvlzfNlT4hbQ3hQY9eDWCfw==
X-Received: by 2002:a05:622a:8a:: with SMTP id o10mr6164651qtw.50.1616341145901;
        Sun, 21 Mar 2021 08:39:05 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id y19sm8976317qky.111.2021.03.21.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:39:05 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Cc:     Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 3/3] ALSA: rme9652: don't disable if not enabled
Date:   Sun, 21 Mar 2021 11:38:40 -0400
Message-Id: <20210321153840.378226-4-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <s5htup4exbl.wl-tiwai@suse.de>
References: <s5htup4exbl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rme9652 wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.751595] snd_rme9652 0000:00:03.0: disabling already-disabled device
[    1.751605] WARNING: CPU: 0 PID: 174 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.759968] Call Trace:
[    1.760145]  snd_rme9652_card_free+0x76/0xa0 [snd_rme9652]
[    1.760434]  release_card_device+0x4b/0x80 [snd]
[    1.760679]  device_release+0x3b/0xa0
[    1.760874]  kobject_put+0x94/0x1b0
[    1.761059]  put_device+0x13/0x20
[    1.761235]  snd_card_free+0x61/0x90 [snd]
[    1.761454]  snd_rme9652_probe+0x3be/0x700 [snd_rme9652]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/rme9652.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 4df992e846f2..f407a95fc81f 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1731,7 +1731,8 @@ static int snd_rme9652_free(struct snd_rme9652 *rme9652)
 	if (rme9652->port)
 		pci_release_regions(rme9652->pci);
 
-	pci_disable_device(rme9652->pci);
+	if (pci_is_enabled(rme9652->pci))
+		pci_disable_device(rme9652->pci);
 	return 0;
 }
 
-- 
2.25.1

