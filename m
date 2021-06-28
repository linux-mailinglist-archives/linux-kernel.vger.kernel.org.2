Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C829A3B58DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhF1GC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhF1GCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:02:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B7C061574;
        Sun, 27 Jun 2021 22:59:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot9so26839192ejb.8;
        Sun, 27 Jun 2021 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=scSC9FPsYN/R9j9GdoOTllx+3vsFm/mdFb9quS7rzYI=;
        b=CvkBdWJ4oRn3YEcWbcwFITff9TmL8QkVvNknoOvc+VIryWWpkukvvnRSeLaRxuRyRx
         xxTchDptzszJ0mWnMfZF2sOuZex6+/I+ZcJeFhHfsCGTCGTKwdDDTZ5lWzHSZZ4VQ2vV
         WgOisHH+PeWPSC/hH8st9jhLZ7atUtuyG4cTolspIR4wLQE6uIS4bFxgcMEdTPdmTeIu
         jioYCz245+TXgZrEGfvxhOFLZYIc3RMqjH6G5SBcTBPzLQTd5KNQBp4SUb1d52Fib7iZ
         YR/bHDrKSCfckCpA7nGIkVWw0Tu/Y9HfiAPRBjHQv9n/pFTItEkx89vPOh0eCnwEWldi
         KJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=scSC9FPsYN/R9j9GdoOTllx+3vsFm/mdFb9quS7rzYI=;
        b=i5arh1IC55kUbAFhbgoQTnNUI/IMtt6iL3w/b0us4ut0gKmd1yqTQqgn2uH3t3BLO0
         W2a+rmURzGZ5l5+hl+xlXwm/t2foHLOi59OC+J6DxByQ9/yHdQZ/6b2q9/883lOqIFaV
         8WEkcL0t3QfYtvBqnnMKdKmOPC0i281adWK7+TCVfwGlXvXPBdeE8MIx2YtGa3dEFU8u
         v1J/v/x0B62z/JoVnOo8zt6oXXUp38rkTQdlY4O8jEKw0i2YS59HsUnaKc7TTtnDjq2m
         +n/6VhVlQivelhxJvs56LG9JTiK7ketEAi/KOYFyii+5iuLh41yrP1fl/bK1tX9qo5fE
         i/Sw==
X-Gm-Message-State: AOAM531W/rRumb0UYCqzVTz/B1cyVIod+aQRFWdB5Py4862WmhXAoEZE
        hBtQdit/6AAsqMaEOfqU4zY=
X-Google-Smtp-Source: ABdhPJyrxn4mzQxG8eukm5nYIsde35AYVsofSIBJyVphFWkFl2j+jeThJ3JncoFe8AYj4eVgwD46AA==
X-Received: by 2002:a17:906:a38d:: with SMTP id k13mr23284181ejz.250.1624859996821;
        Sun, 27 Jun 2021 22:59:56 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dc2:cc00:2831:3317:971d:3f75])
        by smtp.gmail.com with ESMTPSA id e21sm6390506ejy.54.2021.06.27.22.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:59:55 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] pgo: rectify comment to proper kernel-doc syntax
Date:   Mon, 28 Jun 2021 07:59:47 +0200
Message-Id: <20210628055947.6948-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command ./scripts/kernel-doc -none kernel/pgo/pgo.h warns:

  kernel/pgo/pgo.h:112: warning: cannot understand function prototype: 'struct llvm_prf_value_node_data '

This is due to a slightly invalid use of kernel-doc syntax for the comment
of this struct, that must have probably just slipped through refactoring
and review before.

Rectify the comment to proper kernel-doc syntax.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Kees, please pick this quick minor fix into your pgo tree.

 kernel/pgo/pgo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
index ba3f8499254a..04fbf3bcde1e 100644
--- a/kernel/pgo/pgo.h
+++ b/kernel/pgo/pgo.h
@@ -103,7 +103,7 @@ struct llvm_prf_data {
 } __aligned(LLVM_INSTR_PROF_DATA_ALIGNMENT);
 
 /**
- * structure llvm_prf_value_node_data - represents the data part of the struct
+ * struct llvm_prf_value_node_data - represents the data part of the struct
  *   llvm_prf_value_node data structure.
  * @value: the value counters.
  * @count: the counters' count.
-- 
2.17.1

