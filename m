Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28501310026
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBDWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBDWiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:38:50 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E429C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:38:10 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e18so5363643lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkAztRmVaPsle95l7/AFoawcR7HppSv89SvojHQudyk=;
        b=APV/rndjEVUBlvaTfspUBHnt+2+NUsobTWX8govHTKtLq3Yoh0k63vbB5KbiRp346M
         owCvUcGNG+xuKyfSIgvn/2MQn4e150ceN6ifmiE02UzllS3H8KZkBXe5plmiI3N5EfHo
         Sm83QTDvkJJsvCmdfUzNE9/1BFQ3iPI+IX075kidHhKNXtI+1B76m1zPICP8nxOzFH9U
         VESeOqjVIy0AVpeWdi/fcCmIwul7ydSQDSoOs6VBGuMOtsrB+o4qUm86RpbtvOWIZK/l
         GCcEqOvmhzezMAA0cfgETkh/Xf9tc4WqtvOF/WO8jigk0b2+VipixuFh66JjkArfF9GV
         fEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkAztRmVaPsle95l7/AFoawcR7HppSv89SvojHQudyk=;
        b=jP8MDbxelGbVDHeJrnP+W/WswVe9MurUi6jM4Oz92hQDhn672s+a33TBFbeoBlxe6V
         HKs7vmJiSmiD0Dc51UseP9BAEUpm60i2cLyIAwRRLVlrxJomwR2I9A1/GIFg7aSkI0yX
         JMHt4yNP9k7I93iegsZheZjrHvVR1YbCC6P4BIAqOmBbozsD0a1kwmYUeNGHmAU6rO+e
         nd0bIFIAvTl4pmbRruIZcqCsflf5JE1B3b3xagj5lIsZOX8abuhAtxbodfgqev0MEopD
         30qE819vkiWqh8ooY8tnXYORotchpNBkHeLJ1PULQIJJaNe+G+ZbgSgdcOgOMTcjP5OJ
         ZcHg==
X-Gm-Message-State: AOAM53342yFzqwnysRhACzXzfTptvMS66+lQBIRvMpAdyJgjRDto7/+D
        K5h78UipFJi5VJJfCOZIsds=
X-Google-Smtp-Source: ABdhPJw8gXzJd8KxGlPvtxWZV5iPRiXSAbSJNBBZp1ELWozRh7FhhI3lOOKVll1LaALLF05qio0ZOg==
X-Received: by 2002:a05:651c:103c:: with SMTP id w28mr916094ljm.186.1612478288805;
        Thu, 04 Feb 2021 14:38:08 -0800 (PST)
Received: from localhost.localdomain (109-252-130-105.dynamic.spd-mgts.ru. [109.252.130.105])
        by smtp.gmail.com with ESMTPSA id b1sm809732lji.129.2021.02.04.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:38:08 -0800 (PST)
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: [PATCH] MAINTAINERS: Update Andrey Ryabinin's email address
Date:   Fri,  5 Feb 2021 01:39:04 +0300
Message-Id: <20210204223904.3824-1-ryabinin.a.a@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email, @virtuozzo.com will stop working shortly.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 632700cee55c..b325d3c79725 100644
--- a/.mailmap
+++ b/.mailmap
@@ -40,6 +40,7 @@ Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
 Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
 Andrew Vasquez <andrew.vasquez@qlogic.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
+Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..f3126e88669d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9559,7 +9559,7 @@ F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
 KASAN
-M:	Andrey Ryabinin <aryabinin@virtuozzo.com>
+M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 R:	Alexander Potapenko <glider@google.com>
 R:	Dmitry Vyukov <dvyukov@google.com>
 L:	kasan-dev@googlegroups.com
-- 
2.26.2

