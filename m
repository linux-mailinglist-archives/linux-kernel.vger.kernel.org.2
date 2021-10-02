Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4E41FA18
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJBGdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 02:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhJBGdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 02:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11CB4611EF;
        Sat,  2 Oct 2021 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633156311;
        bh=AJrsXzFUww//Sq2IUPcn/NGN5cBiVIJRCZ/GrLQZrJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuYbpeu41OUBA5UcXGjtCdDkwCNMsT0Lci0ph+udMCaMvcDtfbNLaFT7cLO5xJXqh
         ZMj3T5u69dbnbiicWI7d7hPj+4PbxP4en/6BArcdMEVhxQvLEigINJiZBcn9A0Icl8
         wxIN9bf0fpBih/0lp3GFoM4MjZS8/96h1tyKgRqw=
Date:   Sat, 2 Oct 2021 08:31:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
Message-ID: <YVf80rXg8Yd19Hmw@kroah.com>
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 12:05:25PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 30, 2021 at 4:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > While discussing how to format the addition of various function
> > attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> > close as possible to Linus's preferences for future reference.
> >
> > (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> > others that would prefer all attributes live on a separate leading line.)
> >
> > [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> While I appreciate you getting the ball across the finish line (having
> _any_ documentation to point to in future bikesheds), I can't help but
> shake the feeling that the chosen policy will harm the ability of
> existing automated code formatting tools from being able to automate
> code formatting on the kernel.

Why would documenting the expected format have an affect on tools not
being able to follow that exact expected format?  Are we defining a
format that is somehow impossible for them to use?

If anything I would think that now we have a format that the tools can
actually follow, while before it was semi-random as to what to pick as
the "one true way".

What am I missing here?

thanks,

greg k-h
