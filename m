Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7536893E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhDVXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhDVXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:09:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:08:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s2-20020a5b07420000b02904eb842efc40so21838984ybq.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RzzE9tvH5mrl8JKXh6xEbaGN7MzALSjf4iPNcVjH73E=;
        b=J4yBEElQnl4U/FTNqW8MWNpyEajp36rVUBeEVSMlLWgYOb7JNUmsVC6iGmoIvZIp6K
         ZB2In73E6bfv+IDK7FmPkMDNvQHIcMQ548PF0RnDFwdLSDbnH7fCZwgoGcjfnhfpJOH6
         FAEu4lgBnarHhVLiQcfHwYONdl/7gKDKv7hwXxNHAGHH56fmyXj6MKJbtd4oVA/GMHzQ
         ezO4b2h1WfD2tzM4xUkiae6ztmjPrxNqOIDwxczwm2yp78TRVemYamULNisD1a6ciFXv
         wA7SsnpCl5VzFhcbmz5s9i+tmvX48xdQI7RyHvw4VESQdXyfBOqBh4aHp1qbeZ/aWwd+
         3W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RzzE9tvH5mrl8JKXh6xEbaGN7MzALSjf4iPNcVjH73E=;
        b=WGp1nd5c60iazqzcap9kEfobjPSLqF/B0QGYlK2Us6Z5JOdBjn3bNLaXRwHndq/mSe
         P1ZdU2R5FVs+4JEW8EdXdjCsOgwgL9/g3KB6X1sjrDxU7iYxmT28hMjljC7f3E0Sl40i
         dP8DQJsG0IL25sijS5B6g30hhf1+NUv8XJNcc7I/jvFoEp3YY3ENKsT1gv3w+Oa6Rb2p
         7egAeEtgirmK29ijGr1m4hjQXsmaRNOtwNPREOH2fHHXm4xAtiggVVMCWQqWai8X1jrm
         etOPR95QJd7lrOwM2ihJijO/PSCNk1nwZgeJ00aYP0/GTA+WVg9dXAxQNEURwJc0Uukt
         OGvw==
X-Gm-Message-State: AOAM533qMyh8qn/HcuklqxfvGtRWjUGwACecOG1F5pCGGm9pImud5gHh
        umjpCG4EhyCn8crnT2bmfjf8pAT6AkfduFDIjjQ=
X-Google-Smtp-Source: ABdhPJwYoIo22k1Ze0677UKgw5Tr/HWOCYzC4aT3bM/vH/VGy7DUTxL6ImzSeNpyfDx6cGljb5NafpXY9lD5zUGi7m4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9317:2762:871:5f48])
 (user=ndesaulniers job=sendgmr) by 2002:a5b:5cf:: with SMTP id
 w15mr1520641ybp.490.1619132934932; Thu, 22 Apr 2021 16:08:54 -0700 (PDT)
Date:   Thu, 22 Apr 2021 16:08:37 -0700
Message-Id: <20210422230846.1756380-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] x86: signal: Don't do sas_ss_reset() until we are certain
 that sigframe won't be abandoned
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Currently we handle SS_AUTODISARM as soon as we have stored the
altstack settings into sigframe - that's the point when we have
set the things up for eventual sigreturn to restore the old settings.
And if we manage to set the sigframe up (we are not done with that
yet), everything's fine.  However, in case of failure we end up
with sigframe-to-be abandoned and SIGSEGV force-delivered.  And
in that case we end up with inconsistent rules - late failures
have altstack reset, early ones do not.

It's trivial to get consistent behaviour - just handle SS_AUTODISARM
once we have set the sigframe up and are committed to entering
the handler, i.e. in signal_delivered().

Link: https://lore.kernel.org/lkml/20200404170604.GN23230@ZenIV.linux.org.uk/
Link: https://github.com/ClangBuiltLinux/linux/issues/876
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compat.h |  2 --
 include/linux/signal.h |  2 --
 kernel/signal.c        | 14 ++++----------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..40ad060deb82 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -494,8 +494,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 			&__uss->ss_sp, label); \
 	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
 } while (0);
 
 /*
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 205526c4003a..20887ff4c27a 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -460,8 +460,6 @@ int __save_altstack(stack_t __user *, unsigned long);
 	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
 	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
 } while (0);
 
 #ifdef CONFIG_PROC_FS
diff --git a/kernel/signal.c b/kernel/signal.c
index f2718350bf4b..384030909daf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2815,6 +2815,8 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&blocked, ksig->sig);
 	set_current_blocked(&blocked);
+	if (current->sas_ss_flags & SS_AUTODISARM)
+		sas_ss_reset(current);
 	tracehook_signal_handler(stepping);
 }
 
@@ -4133,11 +4135,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 	int err = __put_user((void __user *)t->sas_ss_sp, &uss->ss_sp) |
 		__put_user(t->sas_ss_flags, &uss->ss_flags) |
 		__put_user(t->sas_ss_size, &uss->ss_size);
-	if (err)
-		return err;
-	if (t->sas_ss_flags & SS_AUTODISARM)
-		sas_ss_reset(t);
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
@@ -4192,11 +4190,7 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 			 &uss->ss_sp) |
 		__put_user(t->sas_ss_flags, &uss->ss_flags) |
 		__put_user(t->sas_ss_size, &uss->ss_size);
-	if (err)
-		return err;
-	if (t->sas_ss_flags & SS_AUTODISARM)
-		sas_ss_reset(t);
-	return 0;
+	return err;
 }
 #endif
 

base-commit: 16fc44d6387e260f4932e9248b985837324705d8
-- 
2.31.1.498.g6c1eba8ee3d-goog

