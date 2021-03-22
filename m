Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8D3439F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCVGtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhCVGtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:49:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:49:23 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 94so11610496qtc.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxDMqFUouE20qsvNflnewD1IIh7nduTTtj8Eq1UkFGs=;
        b=nD1TzUdyCyfaTUFBhzqKBYtbu/HzeBjY4HUm9oyJb6LTq1pjhqZOZDIG6sWIlHqJyQ
         smL0WrI/0MNwpTvn3C5e/bhBJ3OSUc3/ke/8ivPK/CGtevyqH3zpqIb0sJ9LnXR6YnkY
         cH6KIjBUlWoYQG3vi8p1Rc2c/2gBPWkHQPOCIbwwILh2eaLmzkObeeMXWbjB/QS3D+/B
         tEtfkzg5w42+VFN3oWtJfexvOaMMXgidUc9ROa7Jm6P55tLtWM4SCOll66F7IDj1+bnQ
         4DVkJwPdKCB0msjVtBInSHc4RcvC8IBnOFt+VvZiS0x+m8twRjRIyBUEYAb62TqIAGcm
         +/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxDMqFUouE20qsvNflnewD1IIh7nduTTtj8Eq1UkFGs=;
        b=dMXwDRLDEoCrtBqgUVjBNf1HKu74lcywa6euWPlZnP4TDth8HiXDtieptBa6fbqPO6
         d/YZJFuz3U8qEoR4McCjkzIYW1c0+EvRaFZJSwoSYcjkohADbP1SCW/6TMm0z2PuPKNV
         5Gm4+Qybtww6na6qGe2CAwTC7FSa79UQbzyhvldCrn3WqIkFUvgh75jFTm6wjkqq/CG/
         tbhZffGFTOcBjXW1/QYgYFPOsM3WU6XPoSYkxCq0aUCk1ovkl/ZHr2Vw4j0Vrmnjz/2+
         JXIC5ExlTc6VTPDjp3fxmjglGvQTCf6yOYzHSYdHbTEKfCOJigZ/r+xtTPcVxLwgTO9K
         IgjQ==
X-Gm-Message-State: AOAM532T4EIJTe47KUfiJvQOnN4H5xSFpxqNCyv4NZfGNhFMa2hNzsY7
        Ir0vA9r64GBjdYk00hWV6uY=
X-Google-Smtp-Source: ABdhPJzBEXyQpF8NUqXKaZybJXOeP6riyABLtFcaEJFm2opVzlsQiH7AjwT6Fl4+hP6mnnsK/jZ0UA==
X-Received: by 2002:ac8:7d09:: with SMTP id g9mr8345828qtb.288.1616395762629;
        Sun, 21 Mar 2021 23:49:22 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id x14sm10156149qkx.112.2021.03.21.23.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:49:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        unixbhaskar@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date:   Mon, 22 Mar 2021 12:19:09 +0530
Message-Id: <20210322064909.4189290-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-dsp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-dsp.h b/sound/soc/intel/atom/sst-mfld-dsp.h
index 5795f98e04d4..102b0e7eafb0 100644
--- a/sound/soc/intel/atom/sst-mfld-dsp.h
+++ b/sound/soc/intel/atom/sst-mfld-dsp.h
@@ -358,7 +358,7 @@ struct snd_wma_params {
 	u8 reserved;	/* reserved */
 } __packed;

-/* Codec params struture */
+/* Codec params structure */
 union  snd_sst_codec_params {
 	struct snd_pcm_params pcm_params;
 	struct snd_mp3_params mp3_params;
--
2.31.0

