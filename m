Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B843896A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJXOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhJXOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 10:05:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5FC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:03:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w23so3171537lje.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/W/OsBp6xJzh/cYmtq7Inyjl9AOVVVrF3nxtQ0n7lDc=;
        b=PImFOx9H9ccHDD0utj/Y0sUbcV0Kq1Bi2LAbSgpZN2uCw6tTT7GhJnt3jArN7AXgMQ
         RUZfpZ8NEYm1xp49QexBcK4tpCJdoBiIV6r7Ktsm8fX37vbIGATWQSE9wcD/Y8GqBQIv
         piFiBfByjImqUg2o5XcX48Y5EqmJsUBTxWtB4Z17qZNTOucGlgAKKEz7sRw/cU97mmgE
         0hEqNifESwfmDlYwV0HHBLXkK0KPtkONLbG0Vm73VJRpKR+5EyE2zGkbgNrwcx9WRur/
         tFCLwD6iOaXiQSGD93sHT9oh+y52TFWn95Ce9JBu3zgCCpvRSfGBP6owi1VtIFlQ5esj
         sR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/W/OsBp6xJzh/cYmtq7Inyjl9AOVVVrF3nxtQ0n7lDc=;
        b=as7A8P6ZiM22bzxznBLCCUftDbMXARU1a9R2JAEzTjkRLiqaUB8TYvd4PReZKnhGUS
         INGDqf/yMlZvqBJqQT+z1iLlWvQQbJyhhAIKnU/f3r+th+PezCYLVK3nYJs1qWgaSZQg
         W69MPhEsiSLRmTcSv6AIVEGFtuu/62QBlQVvtM7OMmReYcgjdMxjZwnEpVroorhCaX+g
         gG8TOAgobU+UpnWtVlXRVStpvq4Q9kYlxTVdLHMJ757SJDAQomvgLXY8Bt0/wf5u3nwl
         YmtdNt84DvZUvZFyiKbZ/+XepYs4I9zpBLBefM+wRDRmDfQ2qbOlOhwpg90q0syEDfj1
         jXhQ==
X-Gm-Message-State: AOAM5326U9OYRwdorFZfMGoBJx9L/RtWSL/he22lwwdwuPtyQSV8v6ZY
        c7hX64gNb5R5SzI3+NQPfza2eS+W40g=
X-Google-Smtp-Source: ABdhPJxREqSAbVHKWxe7swgOwUQYV6FCh+IUORKGWGaHUrHdgywmAglXIA1GDeH6RvvyrkgoV8N6SA==
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr12713826ljj.125.1635084197876;
        Sun, 24 Oct 2021 07:03:17 -0700 (PDT)
Received: from localhost.localdomain ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id i28sm1452285ljn.122.2021.10.24.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 07:03:17 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        joe@perches.com, lars@metafoo.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com
Subject: [PATCH next] ALSA: mixer: fix deadlock in snd_mixer_oss_set_volume
Date:   Sun, 24 Oct 2021 17:03:15 +0300
Message-Id: <20211024140315.16704-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 411cef6adfb3 ("ALSA: mixer: oss: Fix racy access to slots")
added mutex protection in snd_mixer_oss_set_volume(). Second
mutex_lock() in same function looks like typo, fix it.

Reported-by: syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com
Fixes: 411cef6adfb3 ("ALSA: mixer: oss: Fix racy access to slots")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 sound/core/oss/mixer_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index d5ddc154a735..9620115cfdc0 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -313,7 +313,7 @@ static int snd_mixer_oss_set_volume(struct snd_mixer_oss_file *fmixer,
 	pslot->volume[1] = right;
 	result = (left & 0xff) | ((right & 0xff) << 8);
  unlock:
-	mutex_lock(&mixer->reg_mutex);
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
-- 
2.33.1

