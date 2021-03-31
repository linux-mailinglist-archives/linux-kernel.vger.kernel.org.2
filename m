Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20513350896
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhCaUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCaUzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:55:06 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q10so174549pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=WPzOZI/7h/nIlJykeZPJIx0pP8kh07MzAyzEZatHRuIhHB97Us6jbJeY/UYOlmqOhI
         I0ecVNwtacYNG9lms+cBmhaFNl0rIzXFYDD0LRCOvReTo3zRWs7cC3oUH7692A+ZDVVi
         2gGuQxNlOLAX8UFE9I1BxL/Nh/X2RmBxs4Bxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=BRCdSYUKOy85iT1EN6jmcsnAkQRt4vaNQTKo7qjCLg9EgGC85T2qXSizprW0M26U2J
         P6BZs4aOuTkRit1CiYg/1EVyJjw2LYxYuGrAiaXaTTunevPYnoYmjekM0HjVEzgm1Vfn
         p4A1ToQ0vgGNYlk18mES6VLQg5kViKtlJpX2bmEB/4yCUnijazNBZ5XMpeUSS8vIXj9I
         4Va6rqKPlc8M2JzBu+d9U0CxbYdhIpSug/Df2T5PPXJM5ORNpxyt7tgHm02r1AXQhEQB
         HNFBV0EnIEzL6x/+/EsFuk++iQIkHpYWu8dlOcHqoQh3uVwq/z+wDC0IceWmuTXIsY37
         JZyQ==
X-Gm-Message-State: AOAM530XN3OuLD3HaIcedWd8BYV4teWGtVYleW8kWalnDLmvZKECW2V3
        m41de27NKRRAg5SMpuQd+iKX1w==
X-Google-Smtp-Source: ABdhPJwjc+yR/F1HFGbsO3JvcN74Eaz7ocQ4vidQqR9lLlweYVUpN1FMKcKww5c8xRtm5T99yzj42g==
X-Received: by 2002:a63:4f56:: with SMTP id p22mr4811122pgl.224.1617224106052;
        Wed, 31 Mar 2021 13:55:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp22sm3040786pjb.15.2021.03.31.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Wed, 31 Mar 2021 13:54:53 -0700
Message-Id: <20210331205458.1871746-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331205458.1871746-1-keescook@chromium.org>
References: <20210331205458.1871746-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBk4aEACgkQiXL039xtwCaqhg/+KwH hAw/wsPS1SeVqGJmKPfdQr82hCM0Ml7SVm9J6WipR0nxoHNTRoTq5fJgQ/HAKX35mqAAL3tYGqBi0 2+4WfT2O7DCmcfB4kxHIAZPP1QJPHiUWqb+fNCgutJ9rorMb8tWzDisghAXGGA5mLJTb+e3za84Mg Tz11kRO6uL8orQe4PDGMbtu4ZCR98bQV+/s0SJ2edzBC6JEfXsZGQR+aVB8IXsP7SLf4m7cqs+xko 0HsCJcGnkdPob7OY3xJ5xX638TmezTLmrLymvZQF/3nSqc6H9sGuaiM3d+AM23zJ3MCY6ZlyJXvV8 GzbL/fy12rUa+H/CHYoxEjJJDyopHQQOf677UExOEVO+E4cujeCRzdKv5dGhmFIcpDsFb7FlVCloU ORxvUCgvTSBkWF3qpl9OVmYHU6SKzdG4TU/awDvK6NojCgqhZpoIKjFDsImZzpta59PWF0iJQY7XJ jEq3UVi32y1V10znVqFCRaTTsYnknmSRGohaJqK9aIN29Ua/iBZooygQSNVS0ae3NR3YEQRHRoEZV kgil7zpFlzwuBxrLHrYvvKq3r0q0H4hsoDpFHgHGDZaTXKU4EXWsZ66xrOPJi0r6R9a8pYf+QDjxC cqQfU25fy65WH6DRJBFFXm3eRu/MP8OcVb83DQXHPhdKGC0lf0O4/2ELWKbU5SbM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As shown in jump_label.h[1], choosing the initial state of static
branches changes the assembly layout. If the condition is expected to
be likely it's inline, and if unlikely it is out of line via a jump. A
few places in the kernel use (or could be using) a CONFIG to choose the
default state, which would give a small performance benefit to their
compile-time declared default. Provide the infrastructure to do this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/jump_label.h?h=v5.11#n398

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200324220641.GT2452@worktop.programming.kicks-ass.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d92691262f51..05f5554d860f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
-- 
2.25.1

