Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EA3343334
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhCUPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCUPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 11:39:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEC2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d10so7506763qve.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X8ygzOx9WKWx65WNAliSyrIPfjbfUTPnDnLRdoTlWY=;
        b=pmg0I30uPqhgzXbDwLZhm8U5Vzi67HhzPN4tWIQzDP0BxYcbSXwdsPIjF6PiEhxmr8
         IFVd2uQvX+pCNcO8UkMMrasfH6cu/2Ldr9XV4AXXnPpyWd/KFHZnBtws3V/dY4WYhfHL
         m994GbBQHoRhOeP/ejyZ65RaZAt/F8nNxN0E6QZ2i5m/hlNjO4JZK9mE+PEqcwhSlh4z
         iJLV47sMMqA9ltWHFLGlyGiAtTzgHpIInndQM1drPps4omK6WQJj8pZiaA8kIfSFD/tR
         fiSD0qMESSaFgAbN9c225jcmb2TsWUxWDtlncm8F34EdaZqtyKf3I0OA9ppaE8o+0B3q
         HGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X8ygzOx9WKWx65WNAliSyrIPfjbfUTPnDnLRdoTlWY=;
        b=e3fAkqrCP+v+O25PGV8NBuRwCBvZY6JK+KK0LNtzhrlZz+Fc5knOS4J6HHRWmSQxK0
         DN0312SvhH7gPbiDQLIFSaX5MdQy2HYs0EQhl9amXtGu8BPEMY225BklP3Yz3yH2b2L6
         JLwAGUBaYapVr/Y4vYMHRNUuW2ywwlS9W0ZzwonabL+gtokGk7F+O7l/kWBuqw+MFjtf
         cTd2If318nTXlJnAkNaVbjz8cBtvwh6JudhzfyFEfNwvPvIrfiiQ1AruWgxxvaf7ZpZo
         ASuIIIqBakx7S2wR1UXlHXtx0/ckKM1BMtIWsBE6QM0IKAbJdBGj9/I5pHXPeE0y2JeI
         5+EQ==
X-Gm-Message-State: AOAM532owhYIIzoFiwo7u2TyMXYeebbt0owAtd70LtnzRbFAyONZ8UiZ
        nw3uJyTknIVs9e5DQfKZwuA=
X-Google-Smtp-Source: ABdhPJw3ztG1UkVxmuLPpK6gzFcH8cTDa6W3nAykc9B9JtywQEHO/5nMZvZX6mjujE6gbFcdjTRD1Q==
X-Received: by 2002:a05:6214:1085:: with SMTP id o5mr17702351qvr.5.1616341139235;
        Sun, 21 Mar 2021 08:38:59 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id y19sm8976317qky.111.2021.03.21.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 08:38:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] ALSA: hdsp: don't disable if not enabled
Date:   Sun, 21 Mar 2021 11:38:38 -0400
Message-Id: <20210321153840.378226-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <s5htup4exbl.wl-tiwai@suse.de>
References: <s5htup4exbl.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdsp wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.758292] snd_hdsp 0000:00:03.0: disabling already-disabled device
[    1.758327] WARNING: CPU: 0 PID: 180 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.766985] Call Trace:
[    1.767121]  snd_hdsp_card_free+0x94/0xf0 [snd_hdsp]
[    1.767388]  release_card_device+0x4b/0x80 [snd]
[    1.767639]  device_release+0x3b/0xa0
[    1.767838]  kobject_put+0x94/0x1b0
[    1.768027]  put_device+0x13/0x20
[    1.768207]  snd_card_free+0x61/0x90 [snd]
[    1.768430]  snd_hdsp_probe+0x524/0x5e0 [snd_hdsp]

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/hdsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4cf879c42dc4..720297cbdf87 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5390,7 +5390,8 @@ static int snd_hdsp_free(struct hdsp *hdsp)
 	if (hdsp->port)
 		pci_release_regions(hdsp->pci);
 
-	pci_disable_device(hdsp->pci);
+	if (pci_is_enabled(hdsp->pci))
+		pci_disable_device(hdsp->pci);
 	return 0;
 }
 
-- 
2.25.1

