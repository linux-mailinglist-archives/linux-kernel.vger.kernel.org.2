Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6439862C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhFBKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFBKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190DC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so1736125wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2U6dF+hH5gwzcoqkIhyeiAxmO4AyHDuMvjSLxOZWmU=;
        b=i5fH5Cf/5TlEl8yM0M75Pv5KaKc40eGR7Z7O4pPGlsTzewG+uV4TditU/mWxxLCfg/
         ri2gFrE2zZZ9hdZwK4ZM3EzybMarGmmonOe5u9PHg66NoG34MbN/tS+30FrRcBmIsgrh
         YB0pFRuLkDV6b6pkGB+93Zkj+wnWeGLwmv1WUOcpfoQbl5664IYp4+cO7Cr6Ncl57J+N
         IF6Tzd3suzO3rKdbnsqjQK/Pn4uY4QeyZPQyLIFssD6hhf5m9vNAfZ+RgUnvtuTlgiuK
         aoWjiBsYkVn/ktG1w/fl79TXaGzN3yT/dVKAgsJvDhWCh+z3JD8UJ/SNN7iASUV48GH1
         FJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2U6dF+hH5gwzcoqkIhyeiAxmO4AyHDuMvjSLxOZWmU=;
        b=ryTc4hwOnzoW+t5XKdfLFKgwMA5hM0klaJB0+G9J/J+EgYnP6Bi0apvPpp1Mwow3II
         bGdXmmvyvirs4ApxITDHaHMphUsNK3oX3u/40bGUhnfwIbCfFBCR1tWaeH+bgUMeME2z
         9BB/9sHpXsrFTAF1Py0ZS7kLr1dCHdcJlsQnJK6YnseUTgvPWjrqCBknINiLa+T7B0lm
         34dG94Z9lS46G+OkRbG9nL7i3I5Ow4lcw9SHY3x4GrBvgBU87ivlaV5zXLlm+mTz576W
         VGp0gBE+k6ftmb1DyRIM+AEa7k+MNEZPPT8aB1sjWIgAkR9CUR2DroeSDqbQHbgOJinX
         QPOg==
X-Gm-Message-State: AOAM531ZLrHIP2kjqeU0W0SDY0Kj1gmDcwUF5RSdBMH0zVKFHUhXfbqL
        l3pJtJqJ+l4kGxz5t1TX/JAD/A==
X-Google-Smtp-Source: ABdhPJwMO3wIYStENRGS/URkPemZcpjcLQZbT3eJrVPOcBZQB9pqIW/KfTzr7p0k0DOd5k/LO9jmFQ==
X-Received: by 2002:adf:e788:: with SMTP id n8mr19645605wrm.387.1622629058742;
        Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 05/21] ide: ide-proc: Strip out unused fops structure and accompanying call-back
Date:   Wed,  2 Jun 2021 11:17:06 +0100
Message-Id: <20210602101722.2276638-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/ide-proc.c:457:37: warning: ‘ide_media_proc_fops’ defined but not used [-Wunused-const-variable=]

Fixes: ec7d9c9ce897 ("ide: replace ->proc_fops with ->proc_show")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/ide-proc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3781ee9..34bed14f88c78 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -449,19 +449,6 @@ static int ide_media_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ide_media_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ide_media_proc_show, PDE_DATA(inode));
-}
-
-static const struct file_operations ide_media_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= ide_media_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	 ide_driver_proc_show	},
 	{ "identify",	S_IFREG|S_IRUSR,	 ide_identify_proc_show	},
-- 
2.31.1

