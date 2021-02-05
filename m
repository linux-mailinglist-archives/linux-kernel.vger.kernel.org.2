Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9462310B39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBEMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhBEMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:38:01 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B70C06178B;
        Fri,  5 Feb 2021 04:37:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so6659330qkh.3;
        Fri, 05 Feb 2021 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P//4NsTzgdVvgNpoG0rL3BUt1lW6VkCnGY/CD9Nmt9U=;
        b=cma7FhwM++XEoZhbabUkCXjz6SJsR+hhT5F4ophOX2sl4ZL2abcmgJv+gOQP36KxI6
         SDTmJpuJ0wYv0Rz0OqZW6RBOAmb687Q6/LV8tbKy5c/qGjWRsZuVdU5kit6G0qMYblSh
         7lVj358poJfT2Xze9hvNbZ+YUNMLa8AIE9f7VaDD+m+0w9gngk6bWFI42OQ4Ld+gGM9Y
         oJs1noz1m7A4ShgAeFY3PAapFtWcdQoxMo8UHSTUlEp4aCSyGz2OTzRp1KHy9oYkYaTC
         fZ7XMmdYgItrqcXmuqzOTu8Kyw37LZ6E+EjxAzY/C1MZKYr5zOKce1QW3b7yrIRpUQCx
         funw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P//4NsTzgdVvgNpoG0rL3BUt1lW6VkCnGY/CD9Nmt9U=;
        b=Aii1BMr4zKlJz0ZghalZ2bT9rc4dSBZnMgKNfUL+wJRZVSbiHcdsIT6ThpFrBvsPSM
         o9zxxoxUsgTIZWjkXfSiu4/jKN1tz4CUb981oxKd+1E2jar9YuYALxoKGTgsZDiF2Ch5
         6VrwTK8j0AN9MCzRQqufc0P6+0vKWrXeA6V0959g21xArf/EPTMNqW3kxdU2Uaq3YQJe
         grOqkCuM/aLlF/76kbhv5w3I2MjSmEDJLIIYNoYXBGWLqqz8FBN1mOTNb2HpKqC26FZl
         MHnaJLWztLCtq0IBA8muzoRkbNu3U5Pl7KPeu3+Ex8fPzQ9Wmq7AJlCMEMliYsXdrPiE
         saLg==
X-Gm-Message-State: AOAM530e2phX7FavAEq656ixDMa63TDAz5v0mxiyiDy/o70kNxCWOpd3
        pRnLXhZMxVO0xjTuSObhf5o=
X-Google-Smtp-Source: ABdhPJyRWVNKDoTPM4TQIKHB6RyFzf5Ar26jCLPXxTwMDArR3BL4YA3poNjcyHELjoh/L3MO78RRSw==
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr3867775qky.327.1612528639469;
        Fri, 05 Feb 2021 04:37:19 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id v19sm8688002qkj.48.2021.02.05.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:37:17 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: ide: Fixed a word by replacing a word in the file cmd640.c
Date:   Fri,  5 Feb 2021 18:07:06 +0530
Message-Id: <20210205123706.1375902-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/fucked/spoils/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/ide/cmd640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
index f48decb9fac4..ac926653b826 100644
--- a/drivers/ide/cmd640.c
+++ b/drivers/ide/cmd640.c
@@ -12,7 +12,7 @@
  *  This file provides support for the advanced features and bugs
  *  of IDE interfaces using the CMD Technologies 0640 IDE interface chip.
  *
- *  These chips are basically fucked by design, and getting this driver
+ *  These chips are basically spoils by design, and getting this driver
  *  to work on every motherboard design that uses this screwed chip seems
  *  bloody well impossible.  However, we're still trying.
  *
--
2.30.0

