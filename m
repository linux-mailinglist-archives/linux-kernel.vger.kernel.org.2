Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE944470EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhKFXTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 19:19:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA2C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 16:16:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso960785wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKkLuJzLMfjAjIO6U9gJRFbpQv2dR5fK3LxeHiq7VAc=;
        b=qxQoKYOa/BqrirjFbhlkrCX7iOiLwwZu1kSj/QZmEdYdX1ERTyyLrc7aSP49+lnsAn
         LnqENw+FZLKKQh7rGsTweEuZzJ5aXLanTa++Qa93dpPUxfWOrnWwQV+arTAe8WGWWVhy
         rc4cwuiECHT69pf6ihgCGWorhCFNTQGbkpEt3ImNyCt7OF7qLK0goDvnVYCG0yCL03/3
         rkpsX9D4h3XdHXGlGZrjd2osoZQ2VI8hGlKcNY6akd9GitfwMNt1spD4KnOfT744kv5a
         eCgCtd0LdkTIjTq3hovdy79n+NCsjJoLZGpPNpOyYjcQPoXw6A1c+yBKvoxzI1lafA5I
         LoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKkLuJzLMfjAjIO6U9gJRFbpQv2dR5fK3LxeHiq7VAc=;
        b=pJfKVDnn6M5enHDkBPUYpIXfaAoFaRrwd1NBgPfBuEFCVRLZnE779XMCw3mXnRfCCI
         jaj+DhjP9ZX3kJO/D0LWL8omrgeihu/gExqzw5rgJqPExxxuKAfv2bC5G8gEhlNnOTPd
         17mfp9zHOkzCclsgPI3xTueZBAt1+IzhtmJfkoc//5r53hlCcdoeCR/v3/hP7yG3YGXp
         zkiiEYCaDAG2X/0mPYTCYwmWDQpduLvfnarfbEpnNKkQaSFS3hFs3c3qabm3Zdf/4tWa
         gBCoiTvxTiJkeIosIYd3xjQiRISu5sPRm8OopxAh9G9Y7CW3j/Pw2cTu5JWQBytmlvaM
         NRJA==
X-Gm-Message-State: AOAM5302PxMFJ27Ojesc9pZ8JbrA8KU8YFmnYUfKZ/FxSJIIYwIfM38e
        e7UkLgR566vbjwIg/nPjGDgTag==
X-Google-Smtp-Source: ABdhPJzz1pJrrBHH+HiKuqkUplOa8E5uHZTgDF9n11IB9OJ6Ly9NADYhx6cHlDpTQ5Aj/NLNG9VQDQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr43627925wmh.117.1636240597941;
        Sat, 06 Nov 2021 16:16:37 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id 4sm16320389wrz.90.2021.11.06.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 16:16:37 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 0/2] staging: r8188eu: MSG_88E cleanup series
Date:   Sat,  6 Nov 2021 23:16:34 +0000
Message-Id: <20211106231636.894-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series converts the last two callers of MSG_88E to
netdev_dbg, as the information may be of interest to users/developers so
I didn't just want to delete them outright. It also then removes the
MSG_88E macro from the drivers, as part of the ongoing macro cleanup.

Phillip Potter (2):
  staging: r8188eu: convert final two MSG_88E calls to netdev_dbg
  staging: r8188eu: remove MSG_88E macro

 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 +++--
 drivers/staging/r8188eu/include/rtw_debug.h     | 6 ------
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.31.1

