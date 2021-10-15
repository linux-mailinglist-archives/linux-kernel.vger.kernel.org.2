Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AF42EC67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhJOId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhJOId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:33:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A71C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:31:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so38617697lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2yH0WUF2Pmt960W3aCgwkvdWRG1Ggjks7I2oXQbVY4=;
        b=QXWKBnKK6e8V8aXcmho7JQ6yA8xKBVmpxSMLi4JMZKu4Shydu7mtmZG0rtfIEuLnAH
         9MNqLQoANuUdoTDEcTeK1PgEMs/9mGdOMo5DdsKISo8dt+OENMeooIX9RVijjTIv601V
         VRaGVfPoEgtI2xFBcu4+O/y+PBjFckIHVeuKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2yH0WUF2Pmt960W3aCgwkvdWRG1Ggjks7I2oXQbVY4=;
        b=1h7aGudspuqdv7N631EosRLB+THKZiy87ygUVW4gmM/mf2GyFra4QJSlr/A6Nl7Fvh
         xiQf8/kVHoy8NEfHp1odwN0NjVpXMo65LDNOGfKFqy2YjAJMC7xSZj9DueQSravwJSK2
         QFcMYaR7XL6n7YWmvj4l9rhorcVkzbjuUyd7BRrafizr7+hS0YYxaqA7uWMLrLZY6vhx
         5Tfyrut6GDd6BVgRa8oNkVthY4eDGpU3P7ukgSh6tAzt3gt7JZEcxB8noj251xtMfif2
         +aKysWW7CjquAPMo6s1gTE0Lam1e6Qeg+L6UOi/iVOpdCp3XKgQxNR2qZdZZHJcnklPz
         G7vw==
X-Gm-Message-State: AOAM5332BUUq1gq5eWMRFoq5m+cscejbyaYxZ7KLDPHeHQ25QQvIrMZT
        YJOWzTiqPo0wDlgJQFsaXW8s6Q==
X-Google-Smtp-Source: ABdhPJwy1zRmFEYVkuE38OBulWR112kqasl9wLX+HfJ+YjjRoGLl0twLQy/ZoHTCx1URgscQq2POUA==
X-Received: by 2002:a05:6512:2307:: with SMTP id o7mr9754896lfu.595.1634286708625;
        Fri, 15 Oct 2021 01:31:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bj38sm486219ljb.138.2021.10.15.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:31:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] tools: compiler.h: remove duplicate #ifndef noinline block
Date:   Fri, 15 Oct 2021 10:31:44 +0200
Message-Id: <20211015083144.2767725-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same three lines also appear a bit earlier in the same file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/include/linux/compiler.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index ff872dc2637c..90ba44a99199 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -102,10 +102,6 @@
 # define __init
 #endif
 
-#ifndef noinline
-# define noinline
-#endif
-
 #include <linux/types.h>
 
 /*
-- 
2.31.1

