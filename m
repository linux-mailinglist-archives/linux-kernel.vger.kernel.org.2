Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC138408A18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhIML1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbhIML1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:46 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1009FC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:31 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so2550202wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jCMn+6PWYm/AH96CM8EJiUE6dV7GrC639I1pxBug/fo=;
        b=eEroU4oVN2heQHlxNbvxaYfKjjK4j0WrUk+DRUAHoiLJ7PHD/WGsgXFEFk2f/wzLJg
         SqZ6jWZ4lFj2qIY+JsT3eI7pM9dA50VSRexQe6w5ozloiZMl7FxSpycCzFl8sVLTJGYg
         fTJTaY+wvvdvIxWWmm6pQDvpRsVYRE8hcujHELJkIoebWgQ8Nb1v4+c7QsgigSJJ3HpO
         TJqu31JeWWteM/HjzOBnSKRerXZvPCt9CGl0gogOcnVAGFFIrKMbs8h+ignHfeF3VTv6
         JbJiosAcmcIfi6PnhXyiraPEuoc6RFK7e7fBDa/LWF/mM3/m9NhcHyI0g7IJHA1G9hN0
         yxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCMn+6PWYm/AH96CM8EJiUE6dV7GrC639I1pxBug/fo=;
        b=lcl7qm9Hc3DeKTCYIV6wx1+Vux8/mR5Qeblph7GN0p2HS6gYEpAficihAJLFhrbprs
         +aVIQkEgwpEDV+BKYul/o2SB48q8b+ySxZG7pzqMi2Uy1CGPQnEwmVsWWPOisfw2+2/U
         AHjPVjzCHtceBLOaTQpQKf2/Jv1VWTC9R2L+hSIuwHtXTVumYNLWROeCnUKZUGGLu1m1
         Duet3G1HB4ADjxfKexP2eLn8PUvxlQvuALkZ2KONmf6FidIpjeF7W3z7mSCEEBYJ30Sq
         bdWTfD+eKxkjJvUROa1dE7hXrrkJXmX5133Fw8T/6ml0qdy9FwskK8q9WsSf2jjTmkw3
         OyrA==
X-Gm-Message-State: AOAM532Gc6oor2myVER4tFgEeYrW9SNu6HuYaBDNxJVaAwwF2DEMb7WF
        yeZ5+a9zrG2SJhD++pli55RPt7Cdsg==
X-Google-Smtp-Source: ABdhPJwnccwL1pQ2aLBEviHvXVGI3QBXG8frezSWuniMCg1hwhbFkPmOVasOpj8typD1bkBIN3TYMGNvag==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1f19:d46:38c8:7e48])
 (user=elver job=sendgmr) by 2002:adf:e745:: with SMTP id c5mr11878126wrn.321.1631532389487;
 Mon, 13 Sep 2021 04:26:29 -0700 (PDT)
Date:   Mon, 13 Sep 2021 13:26:04 +0200
In-Reply-To: <20210913112609.2651084-1-elver@google.com>
Message-Id: <20210913112609.2651084-2-elver@google.com>
Mime-Version: 1.0
References: <20210913112609.2651084-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 1/6] lib/stackdepot: include gfp.h
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
2.33.0.309.g3052b89438-goog

