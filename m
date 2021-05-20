Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5316438AF21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbhETMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbhETMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F7C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so15342997wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6I+wunMsoLIB/cRlgPdzMyehQFKmAMGoaVYDN7OOL/w=;
        b=ebN4M5vfUFw9rSaoblExk0ITZuO5yTGXFxP8vLXLO0KhZEMnpflf/jxXWldW7fnEHz
         ruMHx1X/S1GRw4ln+Ca0jtySQBl4VT3kjrBNJeJbe9seiRweQmMB9+uzRkdMtUDZyufu
         uYd42OnG06O2YvRmc244QCZaylqX2aPKoNpvpr8xjLFugYdxx6CLTkx2Lkv4mi+QdS1t
         cWkmkcO+UJ9FacHkiyYYP7KONPn/neDqneXPaGzAzJpCvh2+ds/C0vBEqqMOHbL+Xw1l
         E9tmCe0Lc/l3myDFCKovzEMn9y74MT/NEyI9dUxmScQJJZEue6k2wLl/mScX+pOAkJoZ
         Xk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6I+wunMsoLIB/cRlgPdzMyehQFKmAMGoaVYDN7OOL/w=;
        b=Qh1GV15ChhMOWclEymPiIb6u34dWVkxCQBtScasS12Eoz3rtoxJU7C9ShP+PpArGTB
         h8wUMCBCeQ0YCeowRJQVEAyB2vCiYtoUEu253vELPWItD3klb3qB6hu7tDh1LWslsosT
         GKRbaLzysjvzxzReqf6QSmFPgKFFdIR0KVDPgbgQ2KgHwWgMII6Ya+CNQN0SgWZQNu4a
         ndgv+deIVxBo5UNqsMX2nKZ+lax6a1B2fKKYz/a1RuDf/ct+4o9JKU5GH8z+r0iIUrGS
         XvoS9Tf0rW4EHOTUr1xRh+yS4YkyEejhL2L/j1LcHbYyyjs3jodfCVEyDxcmADkAHc0O
         kkmg==
X-Gm-Message-State: AOAM533up1DnbYpr0T+vYzXXJmgCzmui9Vs8+MLXQnhVeZY8C4fxeYvo
        oKlKdQ1TVPj31R+wA/j43eyJgQ==
X-Google-Smtp-Source: ABdhPJyKQiDxddxgK5eg8/pcbYuVPnQb6wmifZ4n+0+V0QQ04OUvgPsxdxsTi9QZblU6k3NO/THNSQ==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr3913668wrv.354.1621512838976;
        Thu, 20 May 2021 05:13:58 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:13:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matt Mackall <mpm@selenic.com>
Subject: [PATCH 03/16] char: random: Include header containing our prototypes
Date:   Thu, 20 May 2021 13:13:34 +0100
Message-Id: <20210520121347.3467794-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/random.c:2283:6: warning: no previous prototype for ‘add_hwgenerator_randomness’ [-Wmissing-prototypes]

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Matt Mackall <mpm@selenic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/random.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f965..852e765aea62c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -317,6 +317,7 @@
 #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/hw_random.h>
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-- 
2.31.1

