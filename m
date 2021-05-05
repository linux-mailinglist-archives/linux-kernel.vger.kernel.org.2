Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3E373363
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhEEA7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:59:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34733 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231551AbhEEA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:59:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1450wB8b017268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 20:58:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D32EB15C3C43; Tue,  4 May 2021 20:58:11 -0400 (EDT)
Date:   Tue, 4 May 2021 20:58:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YJHto1KaPFey5irj@mit.edu>
References: <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
 <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost>
 <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
 <20210502175510.GB4522@localhost>
 <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
 <20210502214803.GA7951@localhost>
 <CANiq72=5766fGQjNoMoOxrywoJHQ+-i4U+Nb62MeEaRok4LCFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=5766fGQjNoMoOxrywoJHQ+-i4U+Nb62MeEaRok4LCFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:02:33AM +0200, Miguel Ojeda wrote:
> On Sun, May 2, 2021 at 11:48 PM Adrian Bunk <bunk@kernel.org> wrote:
> >
> > Library packages in ecosystems like Go or Rust are copies of the source
> > code, and when an application package is built with these "libraries"
> > (might even be using LTO) this is expected to be faster than using
> > shared libraries.
> 
> Rust libraries only need to include "copies" for generics; and only
> enough information to use them. Keeping the raw source code would be
> one way of doing that (like C++ header-only libraries), but it is not
> required.
> 
> However, it is true that Rust does not have a stable ABI, that the
> vast majority of Rust open source applications get built from source
> via Cargo and that Cargo does not share artifacts in its cache.

What does this mean for enterprise distributions, like RHEL, which
need to maintain a stable kernel ABI as part of their business model.
I assume it means that they will need to lock down on a specific Rust
compiler and Rust libraries?  How painful will it be for them to get
security updates (or have to do backports of security bug fixes) for
7-10 years?

					- Ted
