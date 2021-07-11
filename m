Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD03C3B36
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhGKIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:53:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F4CC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:50:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y4so13190979pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiuAO62+7h7s9nSyvEm63tvLNu0SfPaEdE1IBzqVth0=;
        b=TDmSZmVie/dyu8SHyYbkDDM+qqdCjrqdgh5/P5Hm03vkA6wgJzgwajW7tog8kSSpig
         JKTaeAxeKkcttBLAnqQZWJS0d5CsYOKWDuAAg/8fFGkamr6eOq/W8HaNKtP/D+fHtmsG
         M1c5DAEIB73uC4YQyTPC2I0QuUes1UFHd/WawvXXwCsXn44x8z+FI049X38q/+piG3ll
         RaLiGcV0AbhRnbOJsjFpK6fNvm0t+pku8J9wPQlFc7rTdaH9pkqeYR4+rAUSE3ksRFfw
         WeeKDTe6g4r/ip3f4+o6Lp4UVBR5/YCbvr9mQUAbg3ASKD8+HbSb6sHFJIcNgyh/syQS
         XKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiuAO62+7h7s9nSyvEm63tvLNu0SfPaEdE1IBzqVth0=;
        b=cW+qoq4dEtxsv8MTmfupMucUlScX21dyGpnS6SjBUq+sFZh0aHVs9NZVlFk9hn/xrm
         lgaaFu5+P4lj/+hj3/yvlMbcUN7DSlNSAsFd+VBZs0uufSh9YUBCRZL+bXPEo1XJpPgF
         ryZR8dqWD+WeOearBbdSzIxMdRihLt9obOafQ+U/ynLa2XrRqvY+5Z7J1cz5TnZjOzpe
         81aenaJArvSr4TmnDUfrIgM9xRgiknTycxntsTpuJmKXs0pKq7DNH10xQC4wSYfw3DC2
         hfzTQW09K4b5bYxd7XM5I21/8m+xLin43vtoJhLe0oIFyayTRdPJLWWic82YaP6ns9sY
         kHQA==
X-Gm-Message-State: AOAM533HVymw8tet0Fq3yyCxDfXqK78qJ4Yycfrur8ZuSZWBkpK9/p52
        +xCYBOcCHHTegAzn9SaPzA4=
X-Google-Smtp-Source: ABdhPJwsO8DE8Sk8noo2PuY6bWKqC6vmA6roIRoJ1kzEdEgol51DnfQmTBeze8YwXxwirGqEd53ToQ==
X-Received: by 2002:a63:1661:: with SMTP id 33mr5901358pgw.443.1625993447486;
        Sun, 11 Jul 2021 01:50:47 -0700 (PDT)
Received: from localhost.localdomain ([49.37.51.242])
        by smtp.gmail.com with ESMTPSA id f19sm959714pjj.22.2021.07.11.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 01:50:47 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     lukas.bulwahn@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] drivers:gpu:drm:selftests: cleanup __FUNCTION__ usage
Date:   Sun, 11 Jul 2021 14:20:30 +0530
Message-Id: <20210711085030.95725-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__FUNCTION__ exists only for backwards compatibility reasons
with old gcc versions. Replace it with __func__.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 drivers/gpu/drm/selftests/test-drm_modeset_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
index cfb51d8da2bc..a4e9d9bacc89 100644
--- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
+++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
@@ -9,7 +9,7 @@
 #define FAIL(test, msg, ...) \
 	do { \
 		if (test) { \
-			pr_err("%s/%u: " msg, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
+			pr_err("%s/%u: " msg, __func__, __LINE__, ##__VA_ARGS__); \
 			return -EINVAL; \
 		} \
 	} while (0)
-- 
2.28.0

