Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F2422434
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhJELCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhJELBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:01:49 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F97C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:59:58 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id d12-20020a1c730c000000b0030b4e0ecf5dso916892wmb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8oN1Tye/sfpVxOoza0f1n5GzdtTeuegmg43uvYtdPIg=;
        b=JR+7ySSAMEpVVTM6D2YKngKa55UUG1VVZQnyRxXIyzXpzoQNrVnKws9O6c14cXxPwd
         INzUT4hbmUIZKpi/WwWkbvlBLP3f6RJ5sb4NKLOjGuW/HYy6T641SHN9h1zbgCuD7oYE
         80xrasUK/KIw88sVd48bY+UtIi0HACEexOxFhdW/QYxL0sgz51eAxG1F6rhB2duP2kS3
         AyXSGkUVQuwNUtXc6OB0F8lOBPqeTTAtqSv/bg6+JyxEHwfmQuUrZAwiS73926J4xrGP
         m/QvobQGvrhCojz9NZ4rux+arbUnUXzgp3RSeNgCjKRaFJWFGXvb0zMeuxHLqpfYZOsX
         tA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8oN1Tye/sfpVxOoza0f1n5GzdtTeuegmg43uvYtdPIg=;
        b=3pm7B2ckFdfUPWI4aLYhEmbWOFW9U492HCyEkMErm1ZMTTANJsv/C0bRuYYIZVlArJ
         ROVFKQkPd3JmvCZ4W//MzsWazMz9AeBP93KzuNYp8/+0iDJ9SnEQzbM3Ckp5r4qUiV5a
         xjREaZnjwePpLHDGg2lUWv5P3k6YoqMCF2xHIiiGOhaHFXC2Y1qx9dnIM836y/LBClTJ
         knVLO4IEEV1MOP5aYce2Qk4HAdUTwwliGfBl4CfqkWuOgf+MYJrThA754PyntSwiMw6A
         AbKYNyShFIJZPqzFLxyCNvrQMWcsJsiTJ20UZDsm+1JUhGnF0vZI5jYOevVF4deIxUnE
         wuRg==
X-Gm-Message-State: AOAM533x+UW2kCNGDx3hbspo6WkHBPnfB7XcNI9UiEVlRAVK7WQYRTHI
        QiHPoY+0MggH9HQNpJ8/x9S6Y3UVvg==
X-Google-Smtp-Source: ABdhPJy7sDB39VOxOxsRAKuuX8CFXz7P4SVeWe0jzLrvHE/6h7oC9R7eAIwMkt4fHa1OL+Wfu4H07SBgjw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:600c:3b26:: with SMTP id
 m38mr553969wms.0.1633431596812; Tue, 05 Oct 2021 03:59:56 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:48 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-7-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 06/23] kcsan, kbuild: Add option for barrier
 instrumentation only
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source files that disable KCSAN via KCSAN_SANITIZE := n, remove all
instrumentation, including explicit barrier instrumentation. With
instrumentation for memory barriers, in few places it is required to
enable just the explicit instrumentation for memory barriers to avoid
false positives.

Providing the Makefile variable KCSAN_INSTRUMENT_BARRIERS_obj.o or
KCSAN_INSTRUMENT_BARRIERS (for all files) set to 'y' only enables the
explicit barrier instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.lib | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 54582673fc1a..2118f63b2bc5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -182,6 +182,11 @@ ifeq ($(CONFIG_KCSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
 	$(CFLAGS_KCSAN))
+# Some uninstrumented files provide implied barriers required to avoid false
+# positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_INSTRUMENT_BARRIERS_$(basetarget).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
+	-D__KCSAN_INSTRUMENT_BARRIERS__)
 endif
 
 # $(srctree)/$(src) for including checkin headers from generated source files
-- 
2.33.0.800.g4c38ced690-goog

