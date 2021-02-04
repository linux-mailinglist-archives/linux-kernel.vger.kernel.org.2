Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4614530F359
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhBDMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhBDMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:44:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C3C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:44:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z6so3295598wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHsfvPu4rtpa1c+YtfjMmyJ7QoWs/xXcZLK6R6p5UYA=;
        b=GF8iVNy4Jyy1ZLM9SIJBS+TlyWkCv/KlrF7eDv9MxW8ST2wVUHXdKpdkQfeo1ki8m3
         RdX5gBUneFeIyUzmmsHdlDrLswvCeNNGLb9GFFwQbT2XaGnAc6wdhvtrbBBdAc0jO7QJ
         BDVadQvkpmT1cBIHRcBUDAB4yfoJ9ty3SqS755Pb1aGodppoi0OFvHbGRy1OMuNzWIuB
         RyoF5oZBJbb6lqA7ptZaSwo7GsVSw8Wg6Oee0RCAlT7sk/P6j07xsrS2BGWskhVduNqY
         HtliCyCnfKn3/U+Prhgw7hs/Dr5RuNBhdtjgbRvhWZN85r+F+U5gwnGi5NT1YVHdSmZY
         VqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHsfvPu4rtpa1c+YtfjMmyJ7QoWs/xXcZLK6R6p5UYA=;
        b=PlhYki7OP5d4dvx1tIMrHZslH42epuY/UUiqCL3t/EpBz/XcYf11KxDuQtrxlMzRSf
         jTyG71EBokebXKoJyNUuED8WRC+GXS6rvOGDNn/b6p8QG9YAvSkPV6YuYLuJCSqItPwH
         PSU2QLt12WMyJYkGpzPtnolfLxvC2K2wopW2FDmApwW+fK3FYuEgvfY42anE3Up97+Io
         1UGGuFcKMYGuGc6RNLVURigj4YSnk4AqPv553u5PuAvlGohlGKHlRaf1JKWfupCM79zC
         nH9ccmQY9mX54oCvKS0DUahCuov0jo1sedEnECT19/6ARqd1/NCH+BK/lXWg8mDzd0y7
         v6Ew==
X-Gm-Message-State: AOAM531zVn2aDW6/qMy6TcNlVxXeuV4vZE4f3JJLvS4BRsO+BxF5pbmp
        9eh9GAamk+EoVF4XvptACG1A+Q==
X-Google-Smtp-Source: ABdhPJziPrMStGFtcrowA1GTfEjzneGa8qCfa3ZE9xQPsFcJe8zLFY0maD0KuSiXexa5Leh21L3vgw==
X-Received: by 2002:adf:ebc2:: with SMTP id v2mr9203073wrn.88.1612442641986;
        Thu, 04 Feb 2021 04:44:01 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id z185sm6538248wmb.0.2021.02.04.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 04:44:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: uapi: use the preferred SPDX license identifier
Date:   Thu,  4 Feb 2021 13:43:57 +0100
Message-Id: <20210204124357.3817-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

GPL-2.0 license identifier is deprecated, let's use the preferred
identifier: GPL-2.0-only.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
Hi Kent, Greg,

I started working on making libgpiod licensing reuse-compliant and noticed
that the reuse-tool is telling me that the GPL-2.0 SPDX identifier in the
GPIO uapi header is deprecated. Since I'm required to copy the header
verbatim into libgpiod's repository, I think we need to fix that at source
first.

 include/uapi/linux/gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index e4eb0b8c5cf9..3e01ededbf36 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * <linux/gpio.h> - userspace ABI for the GPIO character devices
  *
-- 
2.29.1

