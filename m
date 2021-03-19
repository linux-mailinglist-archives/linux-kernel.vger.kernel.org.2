Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480DE3424D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhCSShv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhCSShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:37:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1370C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:37:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k10so11298691ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh2DN7/MGtRQ9k5k62aw5CPTUbN8RSadqbP5EXHWoPc=;
        b=ajm14iGKKfGZB5OjaUwP3z7xkCq9R7jn0t2ychjiZuE0SrFECiLHqBnrY/XYJ7YegT
         e8k91zyGv+TQrH56h38T88S25prqiDXSgDvy4bQ5Ks7JT24bDpdokScNITIA08rSofMQ
         hIhAoMINTf2xd4Oh5F9CCRzhAioZwmYH6gk0VJpHiTzw72fD6r+BO/CeW1heVdADKjS3
         I3kisbkqMh7qRJdYcvhI1BERI7/nnUEoZLHahJf0WMyG5T0oQTQXogmTtX5TZTCS7Qcz
         uT9VH8IcA6jIAWsQp6+GiLq7fHo+TMTY5ZtbyZ4zorc2MINVWUjoabj29a0uBhgVmodh
         P6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nh2DN7/MGtRQ9k5k62aw5CPTUbN8RSadqbP5EXHWoPc=;
        b=AaHudNfwpI8SJoD/PunV2GhriiQRenHbu8rIgMirPXg5Ik5nA+iRW5uJpRecJX/H1/
         PiA/TN/8yKdTqO6Byi/LsKgEflEzqDLArrhk+og8fQ8M99bd5DsHKlvvXLK5ED8cjsZ/
         IromQeW8/gUYOjLvswdFetNzYnbVBBC/fMoUlOC0k5CFTGAu6JX0YYkvrphA8gIM+1lO
         JdG01FZFZS+F1wWgO+Mq9agSpcsiquJh8wXC9tb8nGJ083iG3OlOWd1bbhs1FtTrm7ij
         UXPQD8AT6sYf3K5lsabhFW22cd0Hm3nLJkbN6vDssp9Os+gIPJkiU8RMQ4Kx7wgKeI+0
         hW1w==
X-Gm-Message-State: AOAM533sp71VG//ksGr8ZHvDBA5+wsQrEM+e/76Ze4UFI56l8o1NL+7R
        eHOw+c4teB1BAFKiP/8XjhM=
X-Google-Smtp-Source: ABdhPJzr9huvzA6aK/1Sx1GlrzTDl5NqiHi6Fb2ff9xIcK03D56/rI4sVswS/06vE4+QdQrIK1j+zg==
X-Received: by 2002:a17:906:7384:: with SMTP id f4mr6046087ejl.196.1616179037629;
        Fri, 19 Mar 2021 11:37:17 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-79-34-220-97.business.telecomitalia.it. [79.34.220.97])
        by smtp.googlemail.com with ESMTPSA id c10sm4432936edt.64.2021.03.19.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:37:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] clang-format: Update ColumnLimit
Date:   Fri, 19 Mar 2021 19:37:14 +0100
Message-Id: <20210319183714.8463-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ColumnLimit value, changed from 80 to 100.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index c24b147cac01..3212542df113 100644
--- a/.clang-format
+++ b/.clang-format
@@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
 #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
 BreakAfterJavaFieldAnnotations: false
 BreakStringLiterals: false
-ColumnLimit: 80
+ColumnLimit: 100
 CommentPragmas: '^ IWYU pragma:'
 #CompactNamespaces: false # Unknown to clang-format-4.0
 ConstructorInitializerAllOnOneLineOrOnePerLine: false
-- 
2.30.2

