Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA138C65D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEUMVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhEUMVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF1F61132;
        Fri, 21 May 2021 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621599597;
        bh=Ge4IPmWEZZUCCXUNVa30jEpA3fN9ljQ4y981qrIQwyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CoeXlhYJr8Q+S/iSwelDVNeJwGEX4j9QfEfgqwv/ia8+Nh3a4coK4V/iNoo8bd6no
         lfaoBUHEE0K7m5mM+u+DFvpxc0pp09W1bmy4TH7f7dWQvo1B7xTZfX2411XWWHEolU
         V0c6lfdtn50po7EGFL4v51Swrcd+uegQeUwT3WufQ++ntM5y6xGVJwFCnHwXbkBMtE
         Uwd6uPQXV7Wbi2fqiLXUXUNK4IiM33A8oKUV1GE7bD4dEfbFWC/9IEUCzepV7dAbSW
         4nNgQZtejG/ZzhWoD1A0/6RVEgJdal7B3zSt8Zu3bWkwVuMFBCqxsTBP4nkjAuw8QA
         uvcuMFp6bqAJw==
Date:   Fri, 21 May 2021 14:19:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sphinx-pre-install: Reword warning on installing
 cjk font
Message-ID: <20210521141952.2c575cbe@coco.lan>
In-Reply-To: <0c33f48f-150d-caa9-d18b-f1267f679f26@gmail.com>
References: <c5652bb4-0bb0-9efa-2b80-a79793a8efa8@gmail.com>
        <20210521095442.33957ff3@coco.lan>
        <0c33f48f-150d-caa9-d18b-f1267f679f26@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 May 2021 18:00:00 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
> 
> On Fri, 21 May 2021 09:54:42 +0200, Mauro Carvalho Chehab wrote:
> > HI Akira,
> > 
> > Em Fri, 21 May 2021 16:14:19 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> Installing a ckj font as recommended by the warning message causes
> >> generated latex code to have:
> >>
> >> 	% This is needed for translations
> >> 	\usepackage{xeCJK}
> >> 	\setCJKmainfont{Noto Sans CJK SC}
> >>
> >> in its preamble even for an English document.  
> > 
> > Yes. The same LaTeX configuration is applied to all documents.
> > 
> > While the standard Sphinx logic allows just one conf.py, there's
> > a logic on Linux that allows a per-directory configuration.
> > Perhaps it would be possible to set the font just for translations.
> > 
> > Yet, this can't be easily done per-translation - Italian
> > translation for instance doesn't need CJK fonts.  
> 
> Yes, the Italian part looks ugly with xeCJK.
> 
> >   
> >> The package "xeCJK" changes wide characters' appearance including
> >> apostrophe (single quote) and double quotes, and it changes line-break
> >> behavior with regard to the boundary of narrow and wide characters.
> >>
> >> This greatly degrades readability of English PDFs typeset by xelatex.  
> > 
> > Hmm... could you give an example where it looks ugly?
> > 
> > At least on the documents I use to check the PDF output, I was unable
> > to see any big issue.  
> 
> Appended are screenshots from RCU.pdf built with and without xeCJK.
> 
> They are built on Ubuntu Bionic based container with sphinx 2.4.4.
> 
> I think you can see the difference of how apostrophes are rendered.
> Line-break points are also affected by the widths of apostrophes.
> 
> Can you spot the difference?

Ok, now I understand what you're meaning. We need to double check
what's wrong there, as it doesn't make much sense to have a
"`  " character instead of "`" on those places, nor to change
the word's hyphenation logic.

> 
> BTW, on current docs-next, wich the CJK font installed, "make pdfdocs"
> stops while building s390.pdf.

That's weird.

> I needed to manually run "make latexdocs", then run
> "latexmk -xelatex RCU.tex" under Documentation/output/latex/ to get
> RCU.pdf.

Well, you can pass some options to latexmk when building a
pdf via an environment var (LATEXMKOPTS), like (untested):

	LATEXMKOPTS="-interaction=nonstopmode" make pdfdocs.

or change it to interactive mode, in order to show what part
of the s390.tex is causing the issue.

Thanks,
Mauro
