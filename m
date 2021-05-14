Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57F38140A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhENXCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhENXCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:02:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:01:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so681507wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DLT6T+7ahT3h2bp+/MpRlemcgEcaSpw+T8SFb1iKTRY=;
        b=ME8G7Ttrwp2hl1pEO1Hq+favoCo0/xyhpVNX+BYpqqCc67I2rPhNyXZW7jCZqSBEqY
         y3jw82fAevRLebeQQuqbp1m/t53C2WS3FTwp6d9HyXmRO5bnyy8Hap2AlJazF97a1WN8
         Cd12gpu997Np6kgChJQ80J8I/jBwYnCNZ0w05RDgbg1djGucLrz9M7wb6VWaVEvvVfDH
         XyFPYNc04E+EFHMqlF2wnrIOETkDCckyxE0eOB8KlR2fH8O5jmqb7ZSK0lorLljL0xY5
         ryvCv9l0OVoo6Ryn5VsY0SYZr4PqXSnT7cYAVcy0vrO26Wjf3prPvN1V18KRtFvdQ0sq
         8BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLT6T+7ahT3h2bp+/MpRlemcgEcaSpw+T8SFb1iKTRY=;
        b=mFu76vXzseWyQv6D29028T8gEmiVNBaFVNS4lfj9cusprrjhsyDC4OvnFHaOw1QPvk
         62g1qBJzku+is5YgfK/jQS/7b7V6O83hfUFaDru3WmHM5QeBGgOTXbFBe5nxt6nHDcmy
         3xvcQugDvHlc3aK/Qx4w4VBMmFdGSXh5TlsN3U/F71F364uqvHZnuV9gFD+6yVTjzAbm
         5ZpU2VvPKdaAyAsIv3Hb/sSMgjatm5YYforDkmegyQyAI4HTWFTo1JMolh7nZbBQg2p+
         GSJdC7RCR39triOwz27WtKB1Y5XnlgPPGzsxKxGbEZPlYEMl5CMeuElsB09DH1yeLP+A
         5KaA==
X-Gm-Message-State: AOAM532DJwqO2n56vVPk9l4rIGdHJkdAPS+9drCxmkFH338pCbhV30ZQ
        RzahGQ8it1EAqMiQa+2ejUn53Q==
X-Google-Smtp-Source: ABdhPJxdod0nC7XsXp6cAVXd5UCUxr2L/44kajcNFxWWrw3+2Af1X+NAzqRSq0dV6msara9IOFbydg==
X-Received: by 2002:a5d:4886:: with SMTP id g6mr49446327wrq.225.1621033297714;
        Fri, 14 May 2021 16:01:37 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:9bfa:6490:ea29:a5dc])
        by smtp.gmail.com with ESMTPSA id h9sm6323784wmb.35.2021.05.14.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 16:01:36 -0700 (PDT)
Date:   Sat, 15 May 2021 01:01:31 +0200
From:   Marco Elver <elver@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
Message-ID: <YJ8BS9fs5qrtQIzg@elver.google.com>
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
 <20210514201808.GO975577@paulmck-ThinkPad-P17-Gen-1>
 <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3O=DPgsXZpBxz+cPEHAzGaW+64GBDM4BMzAZQ+5w6Dow@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:16PM +0200, Arnd Bergmann wrote:
> On Fri, May 14, 2021 at 10:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Fri, May 14, 2021 at 01:11:05PM -0700, Nathan Chancellor wrote:
> 
> > > You can see my response to Marco here:
> > >
> > > https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/
> > >
> > > Maybe some improved wording might look like
> > >
> > > clang with CONFIG_LTO_CLANG points out that an initcall function should
> > > return an 'int' due to the changes made to the initcall macros in commit
> > > 3578ad11f3fb ("init: lto: fix PREL32 relocations"):
> >
> > OK, so the naive reading was correct, thank you!
> >
> > > ...
> > >
> > > Arnd, do you have any objections?
> >
> > In the meantime, here is what I have.  Please let me know of any needed
> > updates.
> >
> 
> Looks good to me, thanks for the improvements!

FWIW, this prompted me to see if I can convince the compiler to complain
in all configs. The below is what I came up with and will send once the
fix here has landed. Need to check a few other config+arch combinations
(allyesconfig with gcc on x86_64 is good).

Thanks,
-- Marco

------ >8 ------

From 96c1c4e9902e96485268909d5ea8f91b9595e187 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Fri, 14 May 2021 21:08:50 +0200
Subject: [PATCH] init: verify that function is initcall_t at compile-time

In the spirit of making it hard to misuse an interface, add a
compile-time assertion in the CONFIG_HAVE_ARCH_PREL32_RELOCATIONS case
to verify the initcall function matches initcall_t, because the inline
asm bypasses any type-checking the compiler would otherwise do. This
will help developers catch incorrect API use in all configurations.

A recent example of this is:
https://lkml.kernel.org/r/20210514140015.2944744-1-arnd@kernel.org

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
---
 include/linux/init.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 045ad1650ed1..d82b4b2e1d25 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -242,7 +242,8 @@ extern bool initcall_debug;
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
 	    __stringify(__name) ":			\n"	\
 	    ".long	" __stringify(__stub) " - .	\n"	\
-	    ".previous					\n");
+	    ".previous					\n");	\
+	static_assert(__same_type(initcall_t, &fn));
 #else
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
-- 
2.31.1.751.gd2f1c929bd-goog

