Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7933B267
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCOMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCOMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:20:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5268C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:20:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z5so15228517plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4v3KnBHklfIde26Ddd87TZYq1CLgjkOVL4RhzFqYaI=;
        b=sST1BG4mVJLI9Q6A3l6SceZgJNblzCuNjO7VCn9MGV09Gxp7lmxuMX5SLxLqfRIH0r
         B6xL63xIWjNRVk/LW3kIGanrDsvFmI8Ht08axttCAWG9+xw1j1E0TUQd3xyFvLcuFSyX
         Az40jQZ9gvsgQSOSTPA3N+phwSVpS+yhyy4zieG/6/yW89ApAvSOup2ybBeXdHtlMA4z
         gdVhuTxnC2spaESE3ebZK4xz2AX+ei3Yi6yZmD2/+OSf8eTD2yBCFr3OMm1DbO5IZMX0
         PBk8C8yKrc4A1aLuk1oW7/h+93JGbo7rpFFQajiYYn3GAdPD8Kb7qL3+eeOtF0dOY4wm
         1TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4v3KnBHklfIde26Ddd87TZYq1CLgjkOVL4RhzFqYaI=;
        b=oC/BeBMLNbyuAyZOphkEn0EGHJ+uffvE0cylFsHogVGO7QWj7hmsBcNMch4FXjxBT1
         wkQsy7TyCzk93HM5sZoxoobvfm9cjh/FY/cHga5ap2TZ6pxPs23zXakkNtc2YqWDeatd
         4bKKA2sqH9iC0Gufm1Ibp+RyP7SiJO19L9ZYkQI/znAMMYfN8hLt091dluRL6Wm4pi/D
         3qRvkIeFJ7kq1SXpLnuX+xN3WbW7IDRD2OHIJFJlKIpxu7t5KaX4B8RrJyaUgTNcsUi+
         pVRr4dx2dJ8kwMZRcZfnz3VQueiO5IVwJjyfdWZDuOATHgyS0XwoOk5cUwLHGoSF0Ofm
         yGfQ==
X-Gm-Message-State: AOAM530K1ZzsqhtWOKcEulStJmZ12Po4QLs+KBpbVbV9AMjDhoysIvaY
        ecjfgO8Eq9gP3FeY4mydVWZEpjqhZwE=
X-Google-Smtp-Source: ABdhPJzD1XCFaeWew+p4KFDNhHfFM9O1HZo9rITpbPKxW0KospLMPzEZWeTvEfr3KNrcsRdKJiwZGg==
X-Received: by 2002:a17:902:8a97:b029:e6:aa6b:92f1 with SMTP id p23-20020a1709028a97b02900e6aa6b92f1mr7268670plo.64.1615810825561;
        Mon, 15 Mar 2021 05:20:25 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id h15sm13648747pfo.20.2021.03.15.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:20:24 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 995A423603DE; Mon, 15 Mar 2021 21:20:21 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] tools:bootconfig: Fix a typo in scripts/xbc.sh
Date:   Mon, 15 Mar 2021 21:20:19 +0900
Message-Id: <20210315122019.1743393-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in tools/bootconfig/scripts/xbc.sh

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/bootconfig/scripts/xbc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/xbc.sh b/tools/bootconfig/scripts/xbc.sh
index b8c84e654556..808510f6c168 100644
--- a/tools/bootconfig/scripts/xbc.sh
+++ b/tools/bootconfig/scripts/xbc.sh
@@ -9,7 +9,7 @@ BOOTCONFIG=${BOOTCONFIG:=$XBC_BASEDIR/../bootconfig}
 if [ ! -x "$BOOTCONFIG" ]; then
 	BOOTCONFIG=`which bootconfig`
 	if [ -z "$BOOTCONFIG" ]; then
-		echo "Erorr: bootconfig command is not found" 1>&2
+		echo "Error: bootconfig command is not found" 1>&2
 		exit 1
 	fi
 fi
-- 
2.25.0

