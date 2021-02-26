Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB48326301
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZM71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:59:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68D3064E4D;
        Fri, 26 Feb 2021 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614344327;
        bh=weGnsnGiPqwfLIzMuRDLHgkEs6U6s1bW/ulqMKWlGeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyPcylKbJQ5rjgQpUE8mJtVcMvSJJcjYLp3k7oTJ1fLDuShfjQ8QZ73omWHS19Ael
         m9RS1vpcqs0fUs3z/WVjQVy2rCMIdSfumu/bQGDjgpVfQxBUZZ87MNHSAKpZBSaPtV
         zi6wXcVD/IIJ562im6ugrn3fFVBX1dyze+h9Amyk=
Date:   Fri, 26 Feb 2021 13:58:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: spdx spring cleaning
Message-ID: <YDjwhAIMvCWAPSUY@kroah.com>
References: <84ce357f-3400-2a4d-02e9-01e659829560@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ce357f-3400-2a4d-02e9-01e659829560@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 01:32:04PM +0100, Rasmus Villemoes wrote:
> Hi,
> 
> I was doing some 'git grep SPDX-License-Identifier' statistics, but
> noticed that I had to do a lot more normalization than expected (clearly
> handling different comment markers is needed).
> 
> How about running something like the below after -rc1? The end result is
> 
>  2558 files changed, 2558 insertions(+), 2558 deletions(-)
> 
> mostly from the last fixup, before that it's merely
> 
>  90 files changed, 90 insertions(+), 90 deletions(-)
> 
> Rasmus
> 
> #!/bin/sh
> 
> fixup() {
>     gp="$1"
>     cmd="$2"
> 
>     git grep --files-with-matches "SPDX-License-Identifier:$gp" | grep
> -v COPYING | \
>         xargs -r -P8 sed -E -s -i -e "1,3 { /SPDX-License-Identifier/ {
> $cmd } }"
>     git diff --stat | tail -n1
> }
> 
> # tab->space, the first string is "dot asterisk tab"
> fixup '.*	' 's/\t/ /g'
> 
> # trailing space
> fixup '.* $' 's/ *$//'
> 
> # collapse multiple spaces
> fixup '.*  ' 's/  */ /g'
> 
> # or -> OR
> fixup '.* or ' 's/ or / OR /g'
> 
> # Remove outer parenthesis - when that pair is the only set of
> # parenthesis. Only none or */ trailing comment marker is handled.
> fixup ' (' 's|Identifier: \(([^()]*)\)( \*/)?$|Identifier: \1\2|'

What exactly are you trying to "clean up" here?  What tool are you using
that can not properly parse the tags that we currently have?

confused,

greg k-h
