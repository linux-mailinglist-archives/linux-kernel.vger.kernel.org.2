Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C1375BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhEFTie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhEFTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:38:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:37:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so3626563wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSVx5CbmWpab/75galcw5Pa/8ztDkRzEwSLi+NS3A7k=;
        b=Jq2A15Gz5PE1cEoVvf0sDubiqJqFMFK1Idrcb8LiXvxbiF7g9qdu4b2DTZIpuwsCA4
         7kcPp02VsRxagEFt1RVqfekjFehEp6ICoafkCw8cbWIqBP3CZqaafvVvEvuZyUZGfM/s
         V1WbatqTjV79mgM7+vsoyWZLGqpg5FoNAFIjiHkDQVuCuT5P3chbe2JgMjrF2wY8pRGr
         o++JaSYLmLu+ZM1w2dcjZJzQr0JVlv6bms2AW/trkQ4VAkcEcdwTIb8dXOdiTSfqvKHP
         DnMWGlASHCJnFHOOMlnWpu4B5sl5y8LstISSF2v8t94qqORqvb71QB5d5aDZFURsm5lE
         1osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSVx5CbmWpab/75galcw5Pa/8ztDkRzEwSLi+NS3A7k=;
        b=ZRIiZVCSgOi4WXiAUtNi7YDdtd0ckTEPMt4jyBO/oF8AOCnW18yusWvzEQWwwR9wbs
         ntD9IZ11/PZHMcyRu5yiKEwWczPHpse8McV9iiAeBUsE7kNyKaCs6prNdXMrQWg1bIxI
         mHS6fOjGbcf4RJY86rkGrS2sV5RTYCTaYHR8dGOkidTQlaq2Oz1sBmNmDmU4FJ3vK0qq
         GeobJAk3/PaZk2QRtO0X9AvqaM7xxD8FR1aTjalTSPF5BcNqS7LxkdUJ3F99+yGcePMy
         gg4QrbsmN2UbDv0AXyC6PBL8NTEkUfw4guSWyZp7Wv2vD4Zw9tDpU+oZYBGDGQCqM1TE
         hldw==
X-Gm-Message-State: AOAM530UY1g4GzjDXiSineqPjX+h8Du/ZCTCpaSpwAyWLjXBOlttATQ4
        HEwpvYQeG38drZBnrrQOUXM=
X-Google-Smtp-Source: ABdhPJy5jsXtFyy/sHf+QZgYXkSQMnZ7gDvCAWROoFB5N9TjGqn/i7Wet2KcmDxh0hawVoc2QW5+LQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr16948157wmq.41.1620329849249;
        Thu, 06 May 2021 12:37:29 -0700 (PDT)
Received: from luca020400-laptop-arch.lan ([2001:b07:5d33:19f:ea1f:2342:ea78:219a])
        by smtp.googlemail.com with ESMTPSA id 61sm6564402wrm.52.2021.05.06.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 12:37:28 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] binder: Return EFAULT if we fail BINDER_ENABLE_ONEWAY_SPAM_DETECTION
Date:   Thu,  6 May 2021 21:37:25 +0200
Message-Id: <20210506193726.45118-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the other ioctl paths return EFAULT in case the
copy_from_user/copy_to_user call fails, make oneway spam detection
follow the same paradigm.

Fixes: a7dc1e6f99df ("binder: tell userspace to dump current backtrace
when detected oneway spamming")
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 61d34e1dc59c..bcec598b89f2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4918,7 +4918,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		uint32_t enable;
 
 		if (copy_from_user(&enable, ubuf, sizeof(enable))) {
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto err;
 		}
 		binder_inner_proc_lock(proc);
-- 
2.31.1

