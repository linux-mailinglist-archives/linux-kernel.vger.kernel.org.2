Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1D402A87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhIGOP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbhIGOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:15:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730EC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:14:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so12725068qtx.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0HnGqpsoRrU1QmVhpHGIABru/4TEzN09iOx6pzAlIgs=;
        b=FIdzWcWCyYBHcYo+lYxCb/BdxuxeVQKjDQ/8C68Uldd4DOqqkqMqCwIeQM1k4P9tWX
         R8aeVxljaZLDg34Q6E0a+AE+8FDZ5CAIJZfmaaUIM5L+OoC9twTp3x3PzXdn2TJ6cSvL
         XDZEbf54+JNvayl39VYEvwRDh10ike0Oej78UbMSwLihb8i2K1nBW+KMycZFTvB1Yvz1
         FUQbNIxlvJ9BNM9ojDKkE3Bm+q3a4FAGDZmG3LyjlHhNUkK+5lfAqWCsw8Jc2t3f54+k
         jO5osWRFtwTDJ2aVCPkmi4fHVbaq+hWV2RasAXtJt2+02uOHHuDlDnNjAesNHtBmUVg/
         rn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0HnGqpsoRrU1QmVhpHGIABru/4TEzN09iOx6pzAlIgs=;
        b=C7aNg2rwoPTVvlV5Id40/tx3OjxvTX14A7tbBC+ux+z+mxJDJ2hkq3tE8WJZZkqgf5
         f6W1GpWBqHIVzG2MN6P0l8e/b+zkJqII3L8JXU1Tn9HJ7m7W6cqC8wzjCvcWAVUrl4Hm
         hJKts7Olfq0y6iXjagUBWzq2SNqu2hGVX2Fax7bfEcMU53xT0nGCjt6Ojwm+316UrsjV
         Vsv8Wh5wcUz2ZXcgmbXHGM5k1j4wifgxv8Gmz4K9LbDZ8uyE7XOPOuv4BElPI6Y7MIwk
         jXaBZq/gIRO7kTqLNrJ2zjHh8SOqXNcgmw4hd9FJzTR9jHZwG2B9XPWCxHnGjEaWJQw+
         KsEg==
X-Gm-Message-State: AOAM5319gi6rQCEMJgRVNUdrR7CNAIynoRgWS1l4hMusUtkSmTNAzFPM
        w9lYlOZAzU2HZ0ZjJ2fPyKopK1ayBw==
X-Google-Smtp-Source: ABdhPJwPd2W6LAa6evsW67Ve6ymtbHJ7iRdwBWR2WoZEZcz4Wcc4dovrJsftmGoxoLGs6bjyJoqRVo+WTw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6800:c1ea:4271:5898])
 (user=elver job=sendgmr) by 2002:a0c:e1cf:: with SMTP id v15mr17153429qvl.50.1631024043569;
 Tue, 07 Sep 2021 07:14:03 -0700 (PDT)
Date:   Tue,  7 Sep 2021 16:13:02 +0200
In-Reply-To: <20210907141307.1437816-1-elver@google.com>
Message-Id: <20210907141307.1437816-2-elver@google.com>
Mime-Version: 1.0
References: <20210907141307.1437816-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 1/6] lib/stackdepot: include gfp.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/stackdepot.h> refers to gfp_t, but doesn't include gfp.h.

Fix it by including <linux/gfp.h>.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/stackdepot.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 6bb4bc1a5f54..97b36dc53301 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -11,6 +11,8 @@
 #ifndef _LINUX_STACKDEPOT_H
 #define _LINUX_STACKDEPOT_H
 
+#include <linux/gfp.h>
+
 typedef u32 depot_stack_handle_t;
 
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
-- 
2.33.0.153.gba50c8fa24-goog

