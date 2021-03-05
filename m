Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28632E334
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEHuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 02:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCEHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 02:50:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4052C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 23:50:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n22so568004wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=34MO9BuNF7F2D8p7lT8uAN48AKZC5qU22L/kUK0Cseg=;
        b=UCpKUlDdbkld20jWtwrwVCl7fvEY6WPGRRsN1CB24w6SrACDyLQeF+0KpUwSufp3YT
         9WoPwpgISjPcPWvxBrM/6ytz9usiqT9m9TNExzwzd6nr1L8djRj9A7nx/xwhgRxHUru8
         331l6SF/BAAoZipJvjb+HiJvAmf8BUOFFu8FdLH9S4vq75xt3FJh1LvDvMgj+bceMpgA
         gZLSQwAgLZxUkwNupmgyOLrkiLglh9Mb+8Ldgtu2hHlagbXcSUfZ4gPam78CQmA5ew33
         LiUS8oIvQkdFjSBhOGONOwzlROvD6aHu0UPCI9Oe1EgN9t7irTEu7mzMmB4xrVjNqFbK
         H9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=34MO9BuNF7F2D8p7lT8uAN48AKZC5qU22L/kUK0Cseg=;
        b=rfrgFSlW5NY+GHGI5vvAgS5+uWZg+CfdaR1IX3+uGu/g8+V0QljDOurOTiyzATVD4L
         RYr21v9LqnbQ8ursuSN9mlH9i3yGNW9xLaGk6WXWxn54ZkCLu8f1ivimxQLEoCDm2Ene
         3JP+64Qc3ADpo+mIChJJJke0J6G1jQvewx/erZFaU9U4YTAV8oLsv885HOzJsirl3xTu
         JMKNEH/cNRLaxFoQcgybgaCKsTi22KWHR6N9bGSnZlfEUyyJlAmU0XVNU1P2qtWQRP1H
         XoLdJ7aDhqCgw6LlluN6AGIXwwmJ+CG4nlMglrZaLYR9Gowfk+WxMt0DkFW8/2YVM4Ic
         U4mg==
X-Gm-Message-State: AOAM532j8j3vekNGQeGAqV6e/ZNbxmt3e/5P6ZIjmPmPdx7NnUNp4mM8
        hPq1U98GzRT+JzAWfQ/t1KfBcA==
X-Google-Smtp-Source: ABdhPJyPb8+35mv6yBH4gRG7/7g7KebfRs2DVmGhcMB86J4Quui2MrYV40cVB5G7wkw/KCGpk5iRFA==
X-Received: by 2002:a1c:195:: with SMTP id 143mr7514538wmb.147.1614930609184;
        Thu, 04 Mar 2021 23:50:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:adef:40fb:49ed:5ab6])
        by smtp.gmail.com with ESMTPSA id j26sm3009633wrh.57.2021.03.04.23.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 23:50:08 -0800 (PST)
Date:   Fri, 5 Mar 2021 08:50:03 +0100
From:   Marco Elver <elver@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
Message-ID: <YEHiq1ALdPn2crvP@elver.google.com>
References: <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu>
 <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu>
 <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
 <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu>
 <YEDXJ5JNkgvDFehc@elver.google.com>
 <874khqry78.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874khqry78.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:01PM +1100, Michael Ellerman wrote:
> Marco Elver <elver@google.com> writes:
> > On Thu, Mar 04, 2021 at 12:48PM +0100, Christophe Leroy wrote:
> >> Le 04/03/2021 à 12:31, Marco Elver a écrit :
> >> > On Thu, 4 Mar 2021 at 12:23, Christophe Leroy
> >> > <christophe.leroy@csgroup.eu> wrote:
> >> > > Le 03/03/2021 à 11:56, Marco Elver a écrit :
> >> > > > 
> >> > > > Somewhat tangentially, I also note that e.g. show_regs(regs) (which
> >> > > > was printed along the KFENCE report above) didn't include the top
> >> > > > frame in the "Call Trace", so this assumption is definitely not
> >> > > > isolated to KFENCE.
> >> > > > 
> >> > > 
> >> > > Now, I have tested PPC64 (with the patch I sent yesterday to modify save_stack_trace_regs()
> >> > > applied), and I get many failures. Any idea ?
> >> > > 
> >> > > [   17.653751][   T58] ==================================================================
> >> > > [   17.654379][   T58] BUG: KFENCE: invalid free in .kfence_guarded_free+0x2e4/0x530
> >> > > [   17.654379][   T58]
> >> > > [   17.654831][   T58] Invalid free of 0xc00000003c9c0000 (in kfence-#77):
> >> > > [   17.655358][   T58]  .kfence_guarded_free+0x2e4/0x530
> >> > > [   17.655775][   T58]  .__slab_free+0x320/0x5a0
> >> > > [   17.656039][   T58]  .test_double_free+0xe0/0x198
> >> > > [   17.656308][   T58]  .kunit_try_run_case+0x80/0x110
> >> > > [   17.656523][   T58]  .kunit_generic_run_threadfn_adapter+0x38/0x50
> >> > > [   17.657161][   T58]  .kthread+0x18c/0x1a0
> >> > > [   17.659148][   T58]  .ret_from_kernel_thread+0x58/0x70
> >> > > [   17.659869][   T58]
> > [...]
> >> > 
> >> > Looks like something is prepending '.' to function names. We expect
> >> > the function name to appear as-is, e.g. "kfence_guarded_free",
> >> > "test_double_free", etc.
> >> > 
> >> > Is there something special on ppc64, where the '.' is some convention?
> >> > 
> >> 
> >> I think so, see https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#FUNC-DES
> >> 
> >> Also see commit https://github.com/linuxppc/linux/commit/02424d896
> >
> > Thanks -- could you try the below patch? You'll need to define
> > ARCH_FUNC_PREFIX accordingly.
> >
> > We think, since there are only very few architectures that add a prefix,
> > requiring <asm/kfence.h> to define something like ARCH_FUNC_PREFIX is
> > the simplest option. Let me know if this works for you.
> >
> > There an alternative option, which is to dynamically figure out the
> > prefix, but if this simpler option is fine with you, we'd prefer it.
> 
> We have rediscovered this problem in basically every tracing / debugging
> feature added in the last 20 years :)
> 
> I think the simplest solution is the one tools/perf/util/symbol.c uses,
> which is to just skip a leading '.'.
> 
> Does that work?
> 
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index ab83d5a59bb1..67b49dc54b38 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -67,6 +67,9 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>  	for (skipnr = 0; skipnr < num_entries; skipnr++) {
>  		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
>  
> +		if (buf[0] == '.')
> +			buf++;
> +

Unfortunately this does not work, since buf is an array. We'd need an
offset, and it should be determined outside the loop. I had a solution
like this, but it turned out quite complex (see below). And since most
architectures do not require this, decided that the safest option is to
use the macro approach with ARCH_FUNC_PREFIX, for which Christophe
already prepared a patch and tested:
https://lore.kernel.org/linux-mm/20210304144000.1148590-1-elver@google.com/
https://lkml.kernel.org/r/afaec81a551ef15345cb7d7563b3fac3d7041c3a.1614868445.git.christophe.leroy@csgroup.eu

Since KFENCE requires <asm/kfence.h> anyway, we'd prefer this approach
(vs.  dynamically detecting).

Thanks,
-- Marco

------ >8 ------

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 519f037720f5..b0590199b039 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -43,8 +43,8 @@ static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
 static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
 			    const enum kfence_error_type *type)
 {
+	int skipnr, fallback = 0, fprefix_chars = 0;
 	char buf[64];
-	int skipnr, fallback = 0;
 
 	if (type) {
 		/* Depending on error type, find different stack entries. */
@@ -64,11 +64,24 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 		}
 	}
 
+	if (scnprintf(buf, sizeof(buf), "%ps", (void *)kfree)) {
+		/*
+		 * Some architectures (e.g. ppc64) add a constant prefix to
+		 * function names. Determine if such a prefix exists.
+		 */
+		const char *str = strstr(buf, "kfree");
+
+		if (str)
+			fprefix_chars = str - buf;
+	}
+
 	for (skipnr = 0; skipnr < num_entries; skipnr++) {
-		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
+		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]) -
+			  fprefix_chars;
 
-		if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
-		    !strncmp(buf, "__slab_free", len)) {
+		if (str_has_prefix(buf + fprefix_chars, "kfence_") ||
+		    str_has_prefix(buf + fprefix_chars, "__kfence_") ||
+		    !strncmp(buf + fprefix_chars, "__slab_free", len)) {
 			/*
 			 * In case of tail calls from any of the below
 			 * to any of the above.
@@ -77,10 +90,10 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
 		}
 
 		/* Also the *_bulk() variants by only checking prefixes. */
-		if (str_has_prefix(buf, "kfree") ||
-		    str_has_prefix(buf, "kmem_cache_free") ||
-		    str_has_prefix(buf, "__kmalloc") ||
-		    str_has_prefix(buf, "kmem_cache_alloc"))
+		if (str_has_prefix(buf + fprefix_chars, "kfree") ||
+		    str_has_prefix(buf + fprefix_chars, "kmem_cache_free") ||
+		    str_has_prefix(buf + fprefix_chars, "__kmalloc") ||
+		    str_has_prefix(buf + fprefix_chars, "kmem_cache_alloc"))
 			goto found;
 	}
 	if (fallback < num_entries)
