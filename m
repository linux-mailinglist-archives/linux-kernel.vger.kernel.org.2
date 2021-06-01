Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B309D396F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhFAIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhFAIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:55:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0FC061574;
        Tue,  1 Jun 2021 01:53:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 29so10167426pgu.11;
        Tue, 01 Jun 2021 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCbm1eO6NljASmXQV6rZLOGqrFmq6s5+C7dsgtFpv+g=;
        b=KDohyLRpFufwz/3nAD2UD2ukR7EqlrJULj20zX4Ek2VrDStJA8EC2boeHBH0fAk4qA
         ORrvDPWoCs/jHbrwfHt9krMavts9f6N0Rb0wKy0e7yztEa7c3MizdOi7ak8PNXzyCwnL
         Wcd2IbC7Ulj59/bUOi3PlHuikiM4ExV7dQjujZm218EA293NQtRyUB8gUoRtF0wgLZ9t
         Df3/VrDc8kx6PkO+RJINgMRcBm652jZFGkTRpQrbqs5IQQLmghdZbtlazYPgoGeqOsHn
         2GZjwNbwWzghICEAYilR2rufVxh1lwH7AtL+mIZ24qhHa9FHC8vQjvixCUAhjXQ65oKB
         nShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCbm1eO6NljASmXQV6rZLOGqrFmq6s5+C7dsgtFpv+g=;
        b=SLGB3QMRjctzEpZUFMCNkWNvUFnHSWJQCg/kz2/LcSRHeIxwZvqqOMIEXyT744N+yZ
         ze/qkrY0d17JRHWtpC+q2oSDhkKakfP2OaIPCWW7kyyAwXCVke8rHpt444Xobou/HKId
         ognb2JlI+IUyx1LVZDd1S/CAlsOpLq9grxVDP3UtNTDT4TgmmUi9yWPZKuCWzEdbT0wR
         TFDL5OAQlQsSrn6mo77PZZBS/9bnbdRGK/eykVlGaZF1Wfi6GABXt4RwpNuGiWq9ihZO
         N7O9TSW9clngB0+CMO+6/h9ZIOjNq291xXumj1gW/iMn/3+JMPM0niOZRnGJSWVwy7Wv
         Ly7w==
X-Gm-Message-State: AOAM533lvKxcs5M+uyuaTWKNH1JG5iu+M3lCHttWttFzw9ues/R8uzRe
        DnR+Go4qG1TDQtve4npA0WQ=
X-Google-Smtp-Source: ABdhPJxw96WKM3bN7DHnJcNBori4Vq1y4Pz4SQVPRrghtuqjgFC7wHM2H1E48tSbV5sb9OWAGTxEUA==
X-Received: by 2002:a63:2cd4:: with SMTP id s203mr14383682pgs.417.1622537614813;
        Tue, 01 Jun 2021 01:53:34 -0700 (PDT)
Received: from Ubuntu.localdomain ([103.127.241.252])
        by smtp.gmail.com with ESMTPSA id v3sm12639919pfb.203.2021.06.01.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:53:34 -0700 (PDT)
From:   Gao Mingfei <g199209@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Gao Mingfei <g199209@gmail.com>
Subject: [PATCH] docs: block: fix stat.rst document error
Date:   Tue,  1 Jun 2021 08:51:45 +0000
Message-Id: <20210601085145.3273-1-g199209@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 17 decimal vaules, not 11.

Previous committers forgot to change this number when adding
new fields.

Signed-off-by: Gao Mingfei <g199209@gmail.com>
---
 Documentation/block/stat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/stat.rst b/Documentation/block/stat.rst
index 77311335c08b..a1cd9db2058f 100644
--- a/Documentation/block/stat.rst
+++ b/Documentation/block/stat.rst
@@ -18,7 +18,7 @@ A.
    each, it would be impossible to guarantee that a set of readings
    represent a single point in time.
 
-The stat file consists of a single line of text containing 11 decimal
+The stat file consists of a single line of text containing 17 decimal
 values separated by whitespace.  The fields are summarized in the
 following table, and described in more detail below.
 
-- 
2.25.1

