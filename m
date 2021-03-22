Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C1343A06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCVGxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhCVGwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:52:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F18C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:52:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u7so11559666qtq.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MfLI22hOdGeLXd7irJ3H+09OKZv1yFGIXM4YPOW914=;
        b=QKYfiNvQEl4mlvz3ABlho8BSp575p8EYzJ1RcLIWZUy1iftQOIJ45s5GdHRUCPZnXq
         EZ2XtNvRt3HSaY5g3erfFNHop9An5EXfQZzCUOzGxBuGCxieD1A4izSImk0hI05PAAH9
         shusNvW+rfZUFZSQ1lkmF1oV5YFyH+M+pwslgaq5tFLHLcZ65qJoMsSsG35lQMY6d6kW
         a7+4xBxJdwagRLESTQeMFp4vbokqxjXEg08cSojhzbEYQKINjBFqv+6jUn/YWK6FV/Ri
         VyKrcGXwGHioytry29qOpQxzfG5/rL955XhxBopFBnpHxGh3Z8yKPr1nlH611Rnpc/kf
         GurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MfLI22hOdGeLXd7irJ3H+09OKZv1yFGIXM4YPOW914=;
        b=MKXMEg3pgLJXX5BLGzP4oFFVy0Yj5dUGJsQBsMeC0nJnEscxHGlc3+TkgEfKjDCbJ1
         AUADslTl+e8QPeYgFGIuhUjBeld0XoFVRXZzQDLjrQqzCgUi9Vi3hzj5x0XZM/OPjktD
         h+uSdqajtzMUhihjPxduqn3961XDY7TormNw8gMYlIyIzmDtmuEM49lXienIGGmMYryx
         9RPA9Zex6fUF8SJMhdd56cjtuPGNvCmh9VIU1he+NNksGqGCTPyi6aHzFRMXOmrngZSH
         OCnxVJV0O7idh8cM+jgSC8gMMh6vioebML5IWALi5ZOYcUqUCtgNj3CB/vGLktC9jrIc
         mk/Q==
X-Gm-Message-State: AOAM530CCvvqFsKc3V9vUA1uvcYS8A7w7u6deIBBS05v32baJHRZS2Pf
        3yQYOU8/4K77s9Q+r/BPPic=
X-Google-Smtp-Source: ABdhPJz8KIcTr1yNdJJQxPortLSfqnfzcoUFqHDL72IsmuUsSgfiDMpHaV/NV9Ze1e+gbQ69JXaS5w==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr8704538qtp.176.1616395971724;
        Sun, 21 Mar 2021 23:52:51 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id e3sm10482682qkn.39.2021.03.21.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:52:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        unixbhaskar@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ASoC: Intel: Fix a typo
Date:   Mon, 22 Mar 2021 12:22:38 +0530
Message-Id: <20210322065238.151920-1-unixbhaskar@gmail.com>
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
index 102b0e7eafb0..8d9e29b16e57 100644
--- a/sound/soc/intel/atom/sst-mfld-dsp.h
+++ b/sound/soc/intel/atom/sst-mfld-dsp.h
@@ -256,7 +256,7 @@ struct snd_sst_tstamp {
 	u32 channel_peak[8];
 } __packed;

-/* Stream type params struture for Alloc stream */
+/* Stream type params structure for Alloc stream */
 struct snd_sst_str_type {
 	u8 codec_type;		/* Codec type */
 	u8 str_type;		/* 1 = voice 2 = music */
--
2.31.0

