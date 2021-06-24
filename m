Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7917C3B2F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFXNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhFXNCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:02:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A02BA61003;
        Thu, 24 Jun 2021 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624539588;
        bh=NrylstX705yNk/gBhk/kQsLmF1qJb5ZhvHEk4pQj6ic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qflNF5efbR1bsvxJDtWltJYXFHXia/rlBkrtnRDvntcxtztyNU3n1NBN9mFLmtbY5
         ICtG/5sy+28vA/HT11Cr0xqTTD2yRUBhRmyPmoLqs9su58Xh4l4Y2xPzxTt/U1fRIp
         NOr8CAvud2+PGzXgIXeuuuHUGKAzI00k/pPrWJdyI4YcCbxVqTYJS3qBQR94mqAbBP
         0P9Hms952dYNckojVQg+t6q8A27c88A6nbo0Delje0Aqp1q6NC7th3ZDd7jMCwBSvK
         O7pwxrsE/NB7TPAxbR7pYj80RC0Fq7JoYlijPNx7B0MM/BHQeAte9ikRjfqdSoEgiE
         DcxcLbbq14geQ==
Date:   Thu, 24 Jun 2021 14:59:43 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, "Wu X.C." <bobwxc@email.cn>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK
 ascii-art
Message-ID: <20210624145943.001f8115@coco.lan>
In-Reply-To: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 24 Jun 2021 21:06:59 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Subject: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
> 
> Hi all,
> 
> This is another attempt to improve translations' pdf output.
> I see there is a mismatch in the font choice for CJK documents, which
> causes poor-looking ascii-art where CJK characters and Latin letters
> are mixed used.
> 
> One of noticeable examples of such ascii-art can be found in
> Korean translation of memory-barriers.txt.
> 
> Hence the author of Korean translation of memory-barriers.txt is
> in the CC list.
> 
> At first, I thought the issue could be fixed by simply selecting
> "Noto Sans Mono CJK SC" as both of monofont and CJKmonofont.
> It fixed the mis-alignment in the Chinese translation, but failed
> in the Korean translation.
> 
> It turns out that Hangul characters in "Noto Sans Mono CJK SC"
> are slightly narrower than Chinese and Japanese counterparts.
> I have no idea why the so-called "mono" font has non-uniform
> character widths.
> 
> GNU Unifont is an alternative monospace font which covers
> almost all Unicode codepoints.
> However, due to its bitmap-font nature, the resulting document
> might not be acceptable to Korean readers, I guess.
> 
> As a compromise, Patch 2/3 enables Unifont only when it is available.
> 
> A comparison of some of ascii-art figures before and after this change
> can be found in the attached PDF.

Argh! Yeah, it sounds that those translations will always be
problematic.

Your patch series makes sense to me (although I didn't try to
test). Perhaps one way would be to split the translations into
one separate book per language, although I suspect that such
change would offer their own problems, as cross-references
will be broken[1].

[1] There is a sphinx extension that solves it:
	https://www.sphinx-doc.org/en/master/usage/extensions/intersphinx.html

But not sure how easy/hard would be to setup this one.

> 
> Patch 1/3 is a preparation of Patch 2/3.
> It converts font-availability check in python to LaTeX and make the
> resulting LaTeX code portable across systems with different sets of
> installed fonts.
> 
> Patch 3/3 is an independent white space fix (or a workaround of Sphinx
> mis-handling of tabs behind CJK characters) in Korean translation
> of memory-barriers.txt.
> 
> Any feedback is welcome!
> 
> Side note:
> 
> In Korean translation's PDF, I see there is another issue of missing
> white spaces between Hangul "phrase groups" in normal text.
> Looks like the pair of xelatex + xeCJK just ignores white spaces
> between CJK characters.
> 
> There is a package named "xetexko", which might (or might not) be
> a reasonable choice for Korean translation.
> 
> It should be possible to use a language-specific preamble once
> we figure out the way to load per-directory Sphinx configuration
> and move translation docs into per-language subdirectories.  
> 
> As I am not familiar with Korean LaTeX typesetting, I must defer to
> those who are well aware of such conventions.
> 
>         Thanks, Akira
> --
> Akira Yokosawa (3):
>   docs: pdfdocs: Refactor config for CJK document
>   docs: pdfdocs: Add font settings for CJK ascii-art
>   docs: ko_KR: Use white spaces behind CJK characters in ascii-art
> 
>  Documentation/conf.py                         | 26 +++++++++++--------
>  .../translations/ko_KR/memory-barriers.txt    | 14 +++++-----
>  2 files changed, 22 insertions(+), 18 deletions(-)
> 



Thanks,
Mauro
