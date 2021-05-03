Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C237172D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhECOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:55:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57092 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229596AbhECOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:55:41 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 143EsaBc017067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 May 2021 10:54:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D763515C39C4; Mon,  3 May 2021 10:54:35 -0400 (EDT)
Date:   Mon, 3 May 2021 10:54:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <YJAOq9CD72EWaF8P@mit.edu>
References: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <alpine.DEB.2.21.2105020346520.2587@angie.orcam.me.uk>
 <YJAK1C1uLknYGYrH@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJAK1C1uLknYGYrH@mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 10:38:12AM -0400, Theodore Ts'o wrote:
> On Mon, May 03, 2021 at 03:03:31AM +0200, Maciej W. Rozycki wrote:
> > 
> > People went through great efforts to support shared libraries, sacrificed
> > performance for it even back then when the computing power was much lower
> > than nowadays.
> 
> That was because memory was *incredibly* restrictive in those days.
> My first Linux server had one gig of memory, and so shared libraries
> provided a huge performance boost --- because otherwise systems would
> be swapping or paging their brains out.

Correction.  My bad, my first Linux machine had 16 megs of memory....

	     	      	    	    	   - Ted

> 
> However, these days, many if not most developers aren't capable of the
> discpline needed to maintained the ABI stability needed for shared
> libraries to work well.  I can think several packages where if you
> used shared libraries, the major version number would need to be
> bumped at every releases, because people don't know how to spell ABI,
> never mind be able to *preserve* ABI.  Heck, it's the same reason that
> we don't promise kernel ABI compatibility for kernel modules!
> 
> https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst
> 
> And in the case of Debian, use of shared libraries means that every
> time you release a new version of, say, f2fs-tools, things can get
> stalled for months or in one case, over a year, due to the new package
> review process (a shared library version bump means a new binary
> package, and that in turn requires a full review of the entire source
> package for GPL compliance from scratch, and f2fs-tools has bumped
> their shared library major version *every* *single* *release*) ---
> during which time, security bug fixes were being held up due to the
> new package review tarpit.
> 
> If people could actually guarantee stable ABI's, then shared libraries
> might make sense.  E2fsprogs hasn't had a major version bump in shared
> libraries for over a decade (although some developers whine and
> complain about how I reject function signature changes in the
> libext2fs library to provide that ABI stability).  But how many
> userspace packages can make that claim?
> 
> 	  	       	    	 - Ted
