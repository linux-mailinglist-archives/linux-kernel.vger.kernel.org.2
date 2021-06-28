Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCD3B5796
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhF1DEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhF1DES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:04:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC92C061766
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:01:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u19so2395259plc.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9eGVF5ZNz8nQeXOqwWeAB+AFal3aZItv05+YuTQaR4=;
        b=nAi3a2vSS3U0bc4SPlN0MeGoGJ5skB8/jiP0cUp7hL7SVubHtY0acuBzgh/hj9z3uU
         cBJzakJJmH437/QKg1eTECVq4uu30q9cAHBd0v37R4y2iIvH5som7IPkonShv1mim7Ey
         vjntw4HJEJ9Qcd9e42fdycxQoRLLQkKcimV1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A9eGVF5ZNz8nQeXOqwWeAB+AFal3aZItv05+YuTQaR4=;
        b=lBauFUqtb0jLQGLDsiuvewG6Ht685YJ5JLAbfdfqCLsxlLXq0+qpYq/mTU3o28shE0
         CFoVM6Q+ALDZsSmKJ5WuQ1jm5BjH3tTk6C8RyGEPK/G+kP9Wi6rdKJvaGorGsSYl0x3H
         B0dN2tkHs5tLsef6G76qcCajMv4Ilmv0Z/nLi7ydnlo+GslRGC7t37i4FHjhj20QvNK3
         kHtPhZm56Mtat75XtHwEt8/MJmkGQo2erQyfSRk8q8rC3SelIJA43N//UCS7zZaCX5uG
         8cvcNpl4iY1qAa1DwlhBLua6q58CT/hoIAaVBziGjE+/dxJbH7AEarQ2C5vgRiDu8UbB
         Mq2g==
X-Gm-Message-State: AOAM530ZxuxLCiWpvFCljS4lpEkgIUgR8llkm/MHjoZ8X8xQ9eZ0SnDw
        Wt3vOttXoLtLRYezhLZKuRPK3g==
X-Google-Smtp-Source: ABdhPJx2xtmUqV+tD6KqHckTPhUWLlJQEovBbaSe6z2oXTu5eswEQZDx1Ix82ra3LV0hiqRc52DNQQ==
X-Received: by 2002:a17:902:ab8e:b029:125:e6a0:fea2 with SMTP id f14-20020a170902ab8eb0290125e6a0fea2mr14269615plr.41.1624849312526;
        Sun, 27 Jun 2021 20:01:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6882:938a:8fcb:25e1])
        by smtp.gmail.com with ESMTPSA id c5sm12513720pfi.81.2021.06.27.20.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 20:01:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH/RESEND] soc: qcom: socinfo: Don't print anything if nothing found
Date:   Sun, 27 Jun 2021 20:01:50 -0700
Message-Id: <20210628030150.2627905-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's skip printing anything if there's nothing to see. This makes it so
the file length is 0 instead of 1, for the newline, and helps scripts
figure out if there's anything to see in these files.

Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/socinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index f6cfb79338f0..152f3e0e3c6c 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -373,8 +373,8 @@ QCOM_OPEN(chip_id, qcom_show_chip_id);
 static int show_image_##type(struct seq_file *seq, void *p)		  \
 {								  \
 	struct smem_image_version *image_version = seq->private;  \
-	seq_puts(seq, image_version->type);			  \
-	seq_putc(seq, '\n');					  \
+	if (image_version->type[0] != '\0')			  \
+		seq_printf(seq, "%s\n", image_version->type);	  \
 	return 0;						  \
 }								  \
 static int open_image_##type(struct inode *inode, struct file *file)	  \
-- 
https://chromeos.dev

