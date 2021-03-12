Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84271338ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhCLK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhCLKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC6C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso15512658wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTDdaTycGYlNA/lyonpjEoSlsLiRrWvU/OfIN0f1xg4=;
        b=ERbKKB4/+jTtG9cxQCI6ys1C2lW4tUaNJdMui+/oWeXE0HsW6DNJRDpnpLOoJZqG0c
         q/pOK+PWJGTFd8jFRLH9zGHgjPEFavi2IYR4k4+Idhx6YPwn/rp+WCdB0OGFv2TQQ6QC
         r4O3cad/oKkNIC/0CFfazs3nN/6O3Geh/pOdj9I5in5kIzD6IyLwgDdn7B1b13yE5KJA
         RmAKA8Qas52QlZP1QXMSDfm9vPfp0l0i/LCI5PgJb4IsLPDiT/goCdDhzArJVbXqjMGc
         f7juz1rKAoMY+aUOBma/t299ym1GFGKBUu0ra3mWr0vJi5mlw7J63BC9Aziq6waqvas2
         p9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTDdaTycGYlNA/lyonpjEoSlsLiRrWvU/OfIN0f1xg4=;
        b=FSomz2qbCHfxVmbgUgLauTfpuEzI4NObCiebuDtt4O1ybsidevQH4aJO4x2oDYJk8Y
         GO+vMusmDJxLQip0RhiyTA6objpyCocxjors9FWogLrMZ7g7E3HIjbNjuHh14qJ3nqTG
         di1ZDJTSxdR3aciWhHqk2WqweuHRLRJLu8KKzrdcI5+VdQhmIS7HKqyh+p2GPgwoedoz
         eYUdiJtr7n1HSIYpGGx/bR/sqU36gaTyST+w7l8FMM5DWppgE+MD4B0E0M3eZt/AOsCJ
         pU4rbiFrUJzpb0wxsaBg2nFyJpqrGop7fM5reG6QE8Kl2W3YawXuPxgbivOlYuIeR/dz
         zepA==
X-Gm-Message-State: AOAM531TQNilKmaPqc4V4wTLHy1ACCPZVygu7rGH+j3fScTiBHqQNb6c
        lnnvK0TBLmz/eozkkGtPQQMi4A==
X-Google-Smtp-Source: ABdhPJyBSWReAMX3zAKD9jX8PV62DEBUVoL14DbaG+qxxdzW1KCswtemO46FdCsHks6M611re71JtA==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr12256371wmi.159.1615546538048;
        Fri, 12 Mar 2021 02:55:38 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 03/11] block: mtip32xx: mtip32xx: Mark debugging variable 'start' as __maybe_unused
Date:   Fri, 12 Mar 2021 10:55:22 +0000
Message-Id: <20210312105530.2219008-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/mtip32xx/mtip32xx.c: In function ‘mtip_standby_immediate’:
 drivers/block/mtip32xx/mtip32xx.c:1216:16: warning: variable ‘start’ set but not used [-Wunused-but-set-variable]

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3be0dbc674bd0..bc485f1623361 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1213,7 +1213,7 @@ static int mtip_standby_immediate(struct mtip_port *port)
 {
 	int rv;
 	struct host_to_dev_fis	fis;
-	unsigned long start;
+	unsigned long __maybe_unused start;
 	unsigned int timeout;
 
 	/* Build the FIS. */
-- 
2.27.0

