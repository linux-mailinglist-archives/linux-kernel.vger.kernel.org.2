Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8833C520
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCOSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCOSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:02:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q5so8265020pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=gBtfslh/2+D3O3puVX9ZDAtC36eVV5PwPxp4XA9eUO/GkNl99kAxZv1qBOO/2d87Yx
         sFcrGY7n+SrJGaLIEjGKQGsysYRo98xeJYmZG2aDXDED15Pp4X+bQ6GQU6WNAgGp/IQ/
         RhvUNw3ubAilETtfi9v7RGV5r1E8XO5T7hEzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=MqAxpy44Dn9j7Ftlt1McQO0QWmFD4g1+7p8qCi1Iey3B+p4PHfcE/FIyUqIIj8JYRA
         LgOiPWWJGsW6GLOchG64skRjusGcZj+ZZXHUhBwUehyCaaXtKi7gbu7BwgqqOj9YoG1h
         +eZu86QXbILxVyv3nlp5Oa+FP1T5t8HyVRrnyBSj2W5gkwJuiz5uodzJzHEvJfrmY0vx
         Qbm9ggcuH/fZWTvneLA681x9GKzeuHTKgB6xejnNIIglF3yk4rkatMg3BU3W98RKVnTb
         lJhCVDD+BOIyav6yd9InLwurt+BfPsyxWHU+oPUJ6TSQtBCPE4lHAyAP5JjuK/R4pzlM
         vrUw==
X-Gm-Message-State: AOAM532OYX0yyGNEESIN829FKpXAOSH/n4EIi+KOLV3coPeQPXp4bZZr
        q79Pl808yewwdVyGsBTRl3hh+g==
X-Google-Smtp-Source: ABdhPJzy+LhxO21xjzht2PAIEQOU5u9oqRHSnG2QWsS3Nj8lpin4Qjvz+HiWe9beyIvHlwAcX0i4Dg==
X-Received: by 2002:a63:4848:: with SMTP id x8mr254310pgk.447.1615831356014;
        Mon, 15 Mar 2021 11:02:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm14381704pff.197.2021.03.15.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v6 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Mon, 15 Mar 2021 11:02:24 -0700
Message-Id: <20210315180229.1224655-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315180229.1224655-1-keescook@chromium.org>
References: <20210315180229.1224655-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBPoTMACgkQiXL039xtwCbQphAAsvI HVl+t3wcEix5iAa5u+qee6jeL17WvN180P0khg9fTok8jiq8396y7TgIDHQ4BLkF581ql/0Uauyhr jQizhGDD1GLMceM5ndhY01fkg4Bes5IUnUBBbQH/gV8/7E43otmDhSiLdCOLcmlhx8pZIW1Opu7Mo EonqOy1s/+mgshZZgq4XXV3xTkI2qNLfCBEycbzwgtvwOQdrqAyYpOD3JSL0Vqliq7v4pvwC/ahth B6O1wLb8+MxSHDSyFokf2rXR+PXobQLKT2scaaXOWKOPcwaW6ZaRZMSNYgzK6xyZNGJFGyg8lr49Z yu9kYJSs1E1xWtkma0+bkxYQkq6n2dfL3v43ra5hW2Rl1zX7QCd4nWXr2YiI+41CEFaIFluRW5YrM vFvNr5CqfzZYj5Oj+y9vNImxUnuA80IpmpY7uxON7BldV817mlOGhWGeU5CaFGBW5IEpAeyp8zu8c 554NsrIbaSfKHKxQbKaMRoOjRWJtBIT5z4HMFnddOfv89W6uxZgYkwVHqkB2Y1cF6scB6BOAmL10+ fIha/mB1NPydLtzcs8vPg0ebIwYZrbixhhUOsMRc+BXlvvhXI2XVZ1YT3PpV21DYNs3o9xVsoVph6 PuU67dc/pi4YlA/CLOvmj3L2E4Khw2Kb6zsAoyE1S7cc8QQsVy+W5ZFEq4uOIfRg=
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

