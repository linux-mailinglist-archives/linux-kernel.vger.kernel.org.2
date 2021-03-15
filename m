Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE433C7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhCOUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:38:54 -0400
Received: from audible.transient.net ([24.143.126.66]:49682 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229979AbhCOUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:38:47 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 16:38:46 EDT
Received: (qmail 28239 invoked from network); 15 Mar 2021 20:32:04 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 15 Mar 2021 20:32:04 -0000
Received: (nullmailer pid 478863 invoked by uid 1000);
        Mon, 15 Mar 2021 20:32:04 -0000
Date:   Mon, 15 Mar 2021 20:32:04 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: [PATCH] gcov: fail build on gcov_info size
 mismatch
Message-ID: <YE/ERLHBdjJ19TYT@audible.transient.net>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210311130328.2859337-1-oberpar@linux.ibm.com>
 <202103120329.VU4uJ0yZ-lkp@intel.com>
 <CAHk-=whmwEJ-4tGamqOCw4BDJ-yjYrLRYxaFq5YurVc-XXO+hg@mail.gmail.com>
 <db88186a-d6af-33c9-f1fb-10b673b8fdd6@intel.com>
 <CAHk-=wji=we4HQ2m6Z=fnUSM4UW8+X0eTnb9YPGYdcTqpVAL2Q@mail.gmail.com>
 <09373c3d-73e8-933a-24ad-5c4ba4fdc615@intel.com>
 <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0DY=cE-6Tjp_Dt32UC6XtMZBa0Rr2GqkK=Sh9HE=5kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, Mar 14, 2021 at 7:32 PM Rong Chen <rong.a.chen@intel.com> wrote:
> >
> > It can be reproduced with '-a' option in dash:
> 
> Oh, ok. That kind of explains it.
> 
> 'dash' is trash. Please somebody make a bug report.
> 
> >      $ a="!"
> >      $ [ "$a" = ".size" ]
> >      $ [ "$a" = ".size" -a "$b" = ".LPBX0," ]
> >      sh: 2: [: =: unexpected operator
> 
> This is 100% a dash bug. There is no question what-so-ever about it.
> This is not some kind of "POSIX is ambiguous", or "the handling of
> '-a' is complicated".
> 
> It's simply just that dash is buggy.
> 
> >  While dash supports most uses of the -a and -o options, they have
> > very confusing semantics even in bash and are best avoided.
> 
> No, they have perfectly sane semantics in bash, and in POSIX.
> 
> See
> 
>      https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html
> 
> and there is absolutely zero question that bash does this correctly,
> and dash does not.
> 
> But yes, it seems to be easy to work around, but still - could some
> Ubuntu person please open a bug report on dash?

fwiw, https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=850202
