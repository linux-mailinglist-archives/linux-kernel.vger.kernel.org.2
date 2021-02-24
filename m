Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9154A32441C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhBXSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhBXSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:54:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4505FC061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:53:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x16so2664977wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSDwhm/B1nWo0YlDilnMA2vAdsLISNow4izMT6iWvdo=;
        b=bXx0TC7khU2YQJiIWSJUaY2tY0YZ5qs8ZG9rBMaTJxeKvS6l97yBFfz8pleY5CAcVC
         H5Fxn8Y8HMrm+2rRZLfJms1r3QInfziKa+KPiKiaaKabaQA3I3aVdqykgooY4fGlumVL
         9L/XTaiD9FjyxChT0oO6Ma/hoKVefEgxFub3oh+zFXpg59Clw9nOZT52liTsyR2zQWQ2
         y6bBPHcFSKhOoIczxbJj368qklPgMxRauYVdSiEX2fBuA8ILdTRHbJlEkmaPJG15wQ9x
         vP2TJs4BiPnw3N2bn4MDWGycjpV/JEdOcYBurfDnV37bmL7yLv6eCrRDddQti8OU0tLg
         EpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSDwhm/B1nWo0YlDilnMA2vAdsLISNow4izMT6iWvdo=;
        b=gipzKG4j2FrzgvyxVGI47bCeTfzFDWojNGEWjv8/HGIGs7BJbFNDZgIl3WJsfdXVFh
         dPVHSIWaCXMXgSiUQxbz6BZ4scSvInFdLqHYYZxOI96ctc3OWCoMCTTq5mMsricVYfUx
         C5kswTRwNcggpR2iFCmt/33HqEhQL8ViT54bUGauCWAsy5NF8EbXig7mKwVoZPc0MGyS
         8q5aIwZGFIzzHTKEjtNHVZI9fM8JcHxqar2zXp30TCv7ZKoINlYZfCr5eBqTj9WSyJIK
         ejvYPGcQ90SBXrLpp4pT1p1LFKMtde9Gm20/M/lzgw9VjQqMpj7dDll2GPFYuvXUOgMI
         X9Rg==
X-Gm-Message-State: AOAM533L1XJw4amewjmjuBSlkdHek4lAbQXJ/J9yftRwb3eBQSrMD7qo
        w9s2qEeXhTXLUn4QIV6SJ0sXTQ==
X-Google-Smtp-Source: ABdhPJwf1WSX8JSwkGLulrchv8DPoj7L6b+WpKbVRfmXKpvRS9bB1jvM2fJE3Wk8hjBrvP4Zqy4Iag==
X-Received: by 2002:a1c:e402:: with SMTP id b2mr4941472wmh.103.1614192801807;
        Wed, 24 Feb 2021 10:53:21 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id s11sm4568791wme.22.2021.02.24.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:53:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] selftests: gpio: update .gitignore
Date:   Wed, 24 Feb 2021 19:53:16 +0100
Message-Id: <20210224185316.17942-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The executable that we build for GPIO selftests was renamed to
gpio-mockup-cdev. Let's update .gitignore so that we don't show it
as an untracked file.

Fixes: 8bc395a6a2e2 ("selftests: gpio: rework and simplify test implementation")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/testing/selftests/gpio/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index 4c69408f3e84..a4969f7ee020 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-gpio-mockup-chardev
+gpio-mockup-cdev
-- 
2.29.1

