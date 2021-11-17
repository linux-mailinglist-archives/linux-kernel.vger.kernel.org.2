Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C22454E17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhKQToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhKQTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:43:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B34C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:40:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so3251455wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eviGgErY7pPh0bzKPKdHuETPpFqN8wg4N5k49MHMNNs=;
        b=P2yNXut7ch/+lScPwmeGhJyaNlx1rGJKta6n12XVWsSDpjas8YhblxtY+w2FZNb7yT
         I2os1yyuBc3hmVeuScPDadHkYNJhdAMWpRa0ytyiwQK6MdG4tHxrXCbnXzFYv7e29VLL
         RA8LRjLDOGJyEoRx5LPNCezKKt0YulW161AnkUpQ0q6WFQqhx371h6YdTehnbs3P5QLu
         CQoM0+b93gB60IZG9aknHYAs4foNFgrTc7MC29TO7HrD5wdXx4JLrxLfbF9uDcnJGrWz
         j2Uk2OaLVY2vGQtoJ4+SsKxL2OXOQX1PUYo251UjymvZum0yOUedeTn8rC/W8QbZD9g9
         eKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eviGgErY7pPh0bzKPKdHuETPpFqN8wg4N5k49MHMNNs=;
        b=ikX/YGBzmmLr5QC9Vca6Tg9VSQN6MntXJucH3MQI0dF6pciRD7bZJcdBIlUGqgOib8
         Q1QxeIZg/1cJnS1TvLodNFPgJG4YbKNnf2tq5sl8fNeHOM9YJN4IkahiWkvqxXf9Att0
         1YVVWkNuoLhICkp3Ubb3aLWhHDQu7QobwJpD2KRVIwcSHgp2Voa9fOpVotPj4S18nOzO
         NMGcLK9CoNdtqC6Ju1FODKbFO7szmD2EKXrs+opo0YWM2aKA53mZNpFdzGG4JJ4mYcnH
         hU2d6vR76mt2aQIS5Ria2ZbbnY8rkvP20cdQJaNktaPj4NDbwAyEaU1E9NC3ze9b6vrb
         Z5kA==
X-Gm-Message-State: AOAM533sbrwq9ljiwce9MhEIpnkXEsgyirX//Xy9+aQKWzzPzuQRS8VA
        q+Aqg4R3rafxA0jElgfXNXm3exbProcpw6/6JxmhNg==
X-Google-Smtp-Source: ABdhPJyOuG1r+4k+MRmsXN4ydZBp/p3PYvVFwDEc4BWrV9HnqSdTdLfXnsY4Pccly1quxK5m/zgPVJ0z4EqnSxiJTQU=
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr2688690wmk.92.1637178047437;
 Wed, 17 Nov 2021 11:40:47 -0800 (PST)
MIME-Version: 1.0
References: <202111180219.YkyoBMpf-lkp@intel.com> <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
In-Reply-To: <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 17 Nov 2021 11:40:35 -0800
Message-ID: <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:55 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > head:   d31c3c683ee668ba5d87c0730610442fd672525f
> > commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> > config: um-x86_64_defconfig (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
> >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> >         git fetch --no-tags tip x86/core
> >         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=um SUBARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> > >> arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
> >       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> >          |            ^~~~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> >
> >
>
> Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?

Perhaps something like the following ?

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5ec35626945b6db2f7f41c6d46d5e422810eac46..d419b9345d6dba2e924887671bc6f11c3e17ebd7
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -91,12 +91,23 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
                        : "memory");
                buff += 8;
        }
-       if (len & 7) {
-               unsigned int shift = (8 - (len & 7)) * 8;
+       len &= 7;
+       if (len) {
                unsigned long trail;
+#ifndef CONFIG_DCACHE_WORD_ACCESS
+               union {
+                       unsigned long   ulval;
+                       u8              bytes[sizeof(long)];
+               } v;

-               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
+               v.ulval = 0;
+               memcpy(v.bytes, buff, len);
+               trail = v.ulval;
+#else
+               unsigned int shift = (sizeof(long) - len) * BITS_PER_BYTE;

+               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
+#endif
                asm("addq %[trail],%[res]\n\t"
                    "adcq $0,%[res]"
                        : [res] "+r" (temp64)
