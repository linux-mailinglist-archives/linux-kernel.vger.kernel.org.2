Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBB238AF31
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbhETMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbhETMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ABBC069171
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y14so15343754wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0/XZlqctoRA+W/yxYEd7xa8yl2COhSxb4iD7dHyTbU=;
        b=gdEELgIn5WGMPb0rRxm40zN+OrZoncCnQ4pmM46Xlr/HgI5zzEKAk/e2t3gjBuNHJW
         +okD+rNV1/jJHjxPSivi4YA+E6VaesPgsM+llLNR4xHsGYQug6R6hlIR7qyGSbAKuKe3
         2Jkhr/OLPQGqbcVuzSFe4+Y/vBVH9vwVqfbCPvtDM+yQgl0i3Vl99fureCkX68vdSfMF
         AuhFi3gqJuOS8js30yDlV6OJrh0QiPKZ4K3VvCPKVSCgihJiZEG+/zT3KQssHGnVZrB2
         /7id7aG0XuREBj6nTiKtyfhHJuM9E3JoDQiNo5k6dW4yrFIEYRldpvsWD8hZfW/VzxBm
         e0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0/XZlqctoRA+W/yxYEd7xa8yl2COhSxb4iD7dHyTbU=;
        b=BD7IfZS8pRbeDbG16uPluzmy1MU5c5/cL2UUczBtF7Mx3G6Wu7ScREyvLzpdQdriBy
         7B+8GAR7oRTwCoVjiB/NjEgySpvTT1VQlT2kMJW00iBS8wo9ghr7gBs1UZ6TSCupL1Q+
         4+OHWlRildfnkrSMJPLh1eosKIxjROnaRu8nRwUcSjF+jNoS4/u/G8VXi0bZ9PzSEYG9
         Ye1k+tafSS29+ZzglWwztjqMforEogsSXZ6j5skz13qDn5sWkXEbWgNIiYsgRrKfw5Tp
         i+7Wkp6wQ4sPaKGECtHCnnBEQ9icDbYC+GRHjz9gZHTZAbQiQixfc4iqfNjx0HWTdlie
         VYHg==
X-Gm-Message-State: AOAM531WPemfeF0o1ln5X1xNOjzklZ9RLSGoGJNgYdTpgGL40p74EnCB
        1M8udwr8ufle9zLh9TxiOsm10g==
X-Google-Smtp-Source: ABdhPJzEruPLEsIhgwfabvZvgpG9By0+5hWm+pl+ggNSIZP+M3GbKGJ7V3jEmX35W2021EzSOTcOUA==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr3944250wrx.320.1621512851719;
        Thu, 20 May 2021 05:14:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: [PATCH 13/16] char: agp: generic: Place braces around optimised out function in if()
Date:   Thu, 20 May 2021 13:13:44 +0100
Message-Id: <20210520121347.3467794-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/agp/generic.c: In function ‘agp_generic_destroy_page’:
 drivers/char/agp/generic.c:1265:28: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/agp/generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 3ffbb1c80c5c7..37a07676da6ff 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1261,8 +1261,9 @@ void agp_generic_destroy_page(struct page *page, int flags)
 	if (page == NULL)
 		return;
 
-	if (flags & AGP_PAGE_DESTROY_UNMAP)
+	if (flags & AGP_PAGE_DESTROY_UNMAP) {
 		unmap_page_from_agp(page);
+	}
 
 	if (flags & AGP_PAGE_DESTROY_FREE) {
 		put_page(page);
-- 
2.31.1

