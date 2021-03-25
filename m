Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD8348675
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhCYBh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhCYBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:37:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF52C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:37:17 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q12so399760qvc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBfD39CaynpQgCKTDXt+Ey2bhdeDPIw8xNayuX1gvNI=;
        b=tkSJEzz4MdthtO/noCz+GYoWMideoK2fIU7YBK3anLLtJ/rpbOLJPjJEweevsQxCMb
         LwIbVceEzsAoc1Wc5MfZ4vaGx81nvmTopixzcE3n4IcrAjS0aCJd31mlka04iFdHiKHs
         bxc7JSxlVxe0W0bKwvfQEqwV4sI6hmALLa/giFWRAnM2VPcI9/+ukByqwiQexQcivAmP
         Hb2hRHzZ4QqhBetmS65B2AmAERiE2PmcnsclTFOm9SJbB0qZKAgiqEDEnJf4+8Kg9qxs
         ShLyapNXngIRKV91014YJb+W2tiozU7Jwzf2M6xjvRraxsYYCG4eNoR52mOaQN4hA8fz
         wGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CBfD39CaynpQgCKTDXt+Ey2bhdeDPIw8xNayuX1gvNI=;
        b=qZaeDts0M3RoDVVIv9oV5FC7anYFI4vrScWZxWxOu786ngF1yvjSHoyQvdHkfkGtWV
         rbTBaKxuuK38pNd/FsWmhvRd1wsfD0LvbpDfFawo0uWkzCiPSUFIz9o/LplMVT82gnC4
         iwJniVDeGXioRemKbVe7Qwlr/Sp3Nnzugv/bYZZOisObM6hWp0+IFuRMl+VlCJkA+xYN
         m624dTrGnHRryLOWTSZHd4BCxn3WVOmPasKfgmgKFvStB3TCtCEGTT2qa3I09kMRF8gU
         mjXM4Hqdz5aU7OHq638LNycEqaE1uOk4b2RuNah2ivVyY6vNHLSCg0l+G3gIda3PoAbm
         XQmQ==
X-Gm-Message-State: AOAM533DOsOL/t+xAtEkSBWYvL4en7ZbUB7t0XBNfFtX0kjw0Zv0Td55
        JbiL0jaQRjm5vXGRDgXwlBY=
X-Google-Smtp-Source: ABdhPJw2N5ddoYsi+u9n9JbiYQFBrWepnSG67mIipZoIz9Zt6KWWa1TPEBml4tthPj4GgRuP8Dj3fA==
X-Received: by 2002:a0c:fa0d:: with SMTP id q13mr6007931qvn.15.1616636237025;
        Wed, 24 Mar 2021 18:37:17 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id q24sm3005165qki.120.2021.03.24.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:37:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, huawei@kernel.org, joe@perches.com,
        viro@zeniv.linux.org.uk, gustavoars@kernel.org,
        unixbhaskar@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] ALSA: pcm: Fix couple of typos
Date:   Thu, 25 Mar 2021 07:06:31 +0530
Message-Id: <20210325013631.3935-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/unconditonally/unconditionally/
s/succesful/successful/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Randy's finding incorporated ,plus the subject line adjusted.

 sound/core/pcm_native.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 17a85f4815d5..afb670d7fd53 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1425,7 +1425,7 @@ static int snd_pcm_do_stop(struct snd_pcm_substream *substream,
 		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_STOP);
 		substream->runtime->stop_operating = true;
 	}
-	return 0; /* unconditonally stop all substreams */
+	return 0; /* unconditionally stop all substreams */
 }

 static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
@@ -1469,7 +1469,7 @@ EXPORT_SYMBOL(snd_pcm_stop);
  * After stopping, the state is changed to SETUP.
  * Unlike snd_pcm_stop(), this affects only the given stream.
  *
- * Return: Zero if succesful, or a negative error code.
+ * Return: Zero if successful, or a negative error code.
--
2.30.1

