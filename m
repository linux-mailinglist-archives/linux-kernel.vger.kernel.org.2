Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA35235FA90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbhDNSOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B51C061344
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ba6so24832579edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaDqv6uPzP6qKRYwsvhGZokvdMBhemyYbul7hQEy7vM=;
        b=qrsUqyKwLxiLtTJIKW7zoZJmBwPpulz25SwG7ERZAZkWHwI6CKy4JTKhtvcgtwmYxi
         DNsRI9oXwnlFM8y1ZQxc5NxqbU2oenwpdvY0dI7NFAKSSY72yhkPKfYTsP+GoSmaRFun
         9LnnQ2uT/XyC5zUzBdzaivrAGo0yJfbDbmV4kfBwiXFUHCuFqdGRrS9n9ja+/6f6Wqen
         vF+5lUDtVuE/cxK/gcDTefDoPSsJPmXWFNHOzAZ2H1Mn32INVKNdqRs7hHCHcoQs4opK
         31g/wHsY1AJ7spPFjrWUHTvT3cyV4tzX1N7oEfwvnqqjii2eCm4WJvPbdC01CeZp0qfO
         lRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaDqv6uPzP6qKRYwsvhGZokvdMBhemyYbul7hQEy7vM=;
        b=XwS4WOo5DgmFC4DQZ1SoEFpSXZ5yEHZdoC/Ht9ztLzyreXMjNLI33DBlA9tBNcfa+d
         GGJzp9fIVkv3KNJ41OF5eAT6aQNu43CXQluFNC5ah0uV+60JRykSYBGr4eALt1qCeSCV
         yPfK6dha1B2zKqHonXitmaxKYtC2/YZ7WBkfcbZ4zot435DMvbkDRcMnWc5WDDG6APB6
         gLg2GVF5U5o4B3+DlZdTMovJR8ylXSV/xLyPitIUXhQ5c1YmIHA8qCGF1M+OiBmwULl9
         vfmXaAaGsH552QQgY5dRaW01UaKrbtEeP4CufxweN5B2hmOioWDBmSuIQNagxIfNmsIv
         Bvug==
X-Gm-Message-State: AOAM530e8HOYZOnNa/uKOKHCjTkN/G3MrKtVO3Myq9AVVmOzGQpcM7Qt
        TNbbHCMpV7mJN2QJ2rZxf7JxNg==
X-Google-Smtp-Source: ABdhPJyFKJ9t/SlxwgkNZtl1Er9EBURioW4mHm6fuoqesYXDLzxQET03VyRMKq1QMeHc3ipnNvmuYQ==
X-Received: by 2002:a05:6402:35cd:: with SMTP id z13mr179881edc.21.1618423934063;
        Wed, 14 Apr 2021 11:12:14 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 38/57] staging: fbtft: fb_ili9320: Remove unused variable 'ret'
Date:   Wed, 14 Apr 2021 19:11:10 +0100
Message-Id: <20210414181129.1628598-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/fbtft/fb_ili9320.c: In function ‘read_devicecode’:
 drivers/staging/fbtft/fb_ili9320.c:25:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/fbtft/fb_ili9320.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index f2e72d14431db..f0ebc40857b34 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -22,11 +22,10 @@
 
 static unsigned int read_devicecode(struct fbtft_par *par)
 {
-	int ret;
 	u8 rxbuf[8] = {0, };
 
 	write_reg(par, 0x0000);
-	ret = par->fbtftops.read(par, rxbuf, 4);
+	par->fbtftops.read(par, rxbuf, 4);
 	return (rxbuf[2] << 8) | rxbuf[3];
 }
 
-- 
2.27.0

