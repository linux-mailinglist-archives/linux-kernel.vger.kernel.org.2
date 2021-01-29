Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B9308C07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhA2R7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:59:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53534 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhA2R7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:59:32 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l5Y2k-0001zZ-KZ
        for linux-kernel@vger.kernel.org; Fri, 29 Jan 2021 17:58:50 +0000
Received: by mail-il1-f200.google.com with SMTP id v16so8307448iln.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W7+v3EIXQwPpU91C+7QLiBi/RQzHX1PG0vPOAEJlptw=;
        b=uHzdrltIaLvJ3laCqpiG5OxjqXXp/86AogO9qDT1/Vo4x8234WPOUPO7W0PRFf3JK6
         JLqLBBimCs4i8wrMhMSOGGDpXB1mdddxmkiGYOVnFVVtRPv4a42QFpkIuRp/87tvMB7z
         ucOs/72AUyBpVpgLyhYeLZbnRjZdkSdkAnbTkFULUYOg9TsN6kbINg3w3858bqJ5UExG
         NYn+S6ubTlRxb/r17BNILri+h0/fF/n1CUqGfZgWg638dT3fwM6Lgug5mOVoh02JX9od
         /zU8Tn4AxbSe8WJhalrPMszSjJPc9XQfRndagS+8CruFmZJruEjeJXwijmcLL42X5dGi
         rZhg==
X-Gm-Message-State: AOAM530NCFFQcI/asJgdXI227BwqDqlfz0kAXlyTAY1YCiMjSVBIjzo8
        rwZXw45gefNmWVTWypQ0skNwYr4ettpXzbizOwCeVYpat2B3fqCSJdNDDeOgyDY+DhJmRt9Xl2J
        4bJYWLFIMOZNZ4UAuGG+7OBWHtX5Omcy9kwowfmSA6A==
X-Received: by 2002:a92:49cf:: with SMTP id k76mr4145336ilg.52.1611943129685;
        Fri, 29 Jan 2021 09:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/Td61xl1vDf0n17YvYEAb79RziMkHiG3Nhi2YWFr8FADiwttrxNxSPk+FZxZNP89jEZBHig==
X-Received: by 2002:a92:49cf:: with SMTP id k76mr4145321ilg.52.1611943129486;
        Fri, 29 Jan 2021 09:58:49 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:8c40:72aa:4521:f281])
        by smtp.gmail.com with ESMTPSA id d13sm4386964ioy.26.2021.01.29.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:58:48 -0800 (PST)
Date:   Fri, 29 Jan 2021 11:58:47 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>, x86@kernel.org,
        Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86: Disable CET instrumentation in the kernel
Message-ID: <YBRM181kNGBVKU4V@ubuntu-x1>
References: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
 <20210128165014.xc77qtun6fl2qfun@treble>
 <20210128215219.6kct3h2eiustncws@treble>
 <20210129102105.GA27841@zn.tnic>
 <20210129151034.iba4eaa2fuxsipqa@treble>
 <20210129163048.GD27841@zn.tnic>
 <20210129164932.qt7hhmb7x4ehomfr@treble>
 <fd874f37-5842-93ab-6b6b-872f028f2583@suse.com>
 <20210129170331.akmpnaqlwtfy4y6o@treble>
 <20210129170755.GF27841@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210129170755.GF27841@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 06:07:55PM +0100, Borislav Petkov wrote:
> On Fri, Jan 29, 2021 at 11:03:31AM -0600, Josh Poimboeuf wrote:
> > On Fri, Jan 29, 2021 at 06:54:08PM +0200, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 29.01.21 г. 18:49 ч., Josh Poimboeuf wrote:
> > > > Agreed, stable is a good idea.   I think Nikolay saw it with GCC 9.
> > > 
> > > 
> > > Yes I did, with the default Ubuntu compiler as well as the default gcc-10 compiler: 
> > > 
> > > # gcc -v -Q -O2 --help=target | grep protection
> > > 
> > > gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
> > > COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
> > >  /usr/lib/gcc/x86_64-linux-gnu/9/cc1 -v -imultiarch x86_64-linux-gnu help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -fasynchronous-unwind-tables -fstack-protector-strong -Wformat -Wformat-security -fstack-clash-protection -fcf-protection -o /tmp/ccSecttk.s
> > > GNU C17 (Ubuntu 9.3.0-17ubuntu1~20.04) version 9.3.0 (x86_64-linux-gnu)
> > > 	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP
> > > 
> > > 
> > > It has -fcf-protection turned on by default it seems. 
> > 
> > Yup, explains why I didn't see it:
> > 
> > gcc version 10.2.1 20201125 (Red Hat 10.2.1-9) (GCC)
> > COLLECT_GCC_OPTIONS='-v' '-Q' '-O2' '--help=target' '-mtune=generic' '-march=x86-64'
> >  /usr/libexec/gcc/x86_64-redhat-linux/10/cc1 -v help-dummy -dumpbase help-dummy -mtune=generic -march=x86-64 -auxbase help-dummy -O2 -version --help=target -o /tmp/cclBz55H.s
> 
> The fact that you triggered it with an Ubuntu gcc explains why the
> original patch adding that switch:
> 
> 29be86d7f9cb ("kbuild: add -fcf-protection=none when using retpoline flags")
> 
> came from a Canonical.
> 
> Adding the author to Cc for FYI.
> 
> Seth, you can find this thread starting here:
> 
> https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@treble

Thanks for the heads up. This still works fine for our needs.

Acked-by: Seth Forshee <seth.forshee@canonical.com>
