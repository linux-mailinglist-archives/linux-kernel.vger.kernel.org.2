Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DF43902A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhEYNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbhEYNlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:41:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D2D361413;
        Tue, 25 May 2021 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621949980;
        bh=bpJhqhzyJIOpwvCBoK22zd+vKa7WuZzfK//AHfWxpno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mucVuTK3eLjiks/flDd2+/QxoDER4LrVL8aBuTPNcBE9D8zLF8LnItnvdvf8Nrmaj
         NwJiZBF/y2aZCbxn6mVE+PPsjheaTweqUVqKDIe73ws4x8Pc/Fp96HBqhn7QNN6+9p
         fScSqrhdQN9oig0TLnD9psM7FSPxDFJOdj3gB+VfCA6mPjJ7rrF+9NZX+UbkGRuAKn
         1rn1mqRyswpKzi47MtRe/Sj3tXBaMRlUPaXz7EmDn/RuGQWOJPjKhcfUOI8BSQUK0m
         duFZ9bS868bYx2lDVJB31Vwdby3kkslzZXa1lKVhhVYVM1e1N6XdyFEoQgfdbfHIMr
         EJsAUtMb3kF2g==
Date:   Tue, 25 May 2021 15:39:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Wu X.C." <bobwxc@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Activate exCJK only in CJK chapters
Message-ID: <20210525153935.7fd9f445@coco.lan>
In-Reply-To: <97234fd1-66b8-5591-1259-6e995f91835f@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
        <0229bc4d-b391-41b9-e900-b88089c493df@gmail.com>
        <20210525123012.GA16810@bobwxc.top>
        <97234fd1-66b8-5591-1259-6e995f91835f@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 25 May 2021 21:55:53 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Tue, 25 May 2021 20:30:12 +0800, Wu X.C. wrote:
> > On Tue, May 25, 2021 at 08:17:26PM +0900, Akira Yokosawa wrote:  
> >> Activating xeCJK in English and Italian-translation documents
> >> results in sub-optimal typesetting with wide-looking apostrophes
> >> and quotation marks.
> >>
> >> The xeCJK package provides macros for enabling and disabling its
> >> effect in the middle of a document, namely \makexeCJKactive and
> >> \makexeCJKinactive.
> >>
> >> So the goal of this change is to activate xeCJK in the relevant
> >> chapters in translations.
> >>
> >> To do this:
> >>
> >>     o Define custom macros in the preamble depending on the
> >>       availability of the "Noto Sans CJK" font so that those
> >>       macros can be used regardless of the use of xeCJK package.
> >>
> >>     o Patch \sphinxtableofcontents so that xeCJK is inactivated
> >>       after table of contents.
> >>
> >>     o Embed those custom macros in each language's index.rst file
> >>       as a ".. raw:: latex" construct.
> >>
> >> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
> >> heading, while a non-CJK chapter should have \kerneldocCJKoff
> >> below its chapter heading.
> >>
> >> This is to make sure the CJK font is available to CJK chapter's
> >> heading and ending page's footer.
> >>
> >> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>  
> > 
> > Test it, worked well.
> > 
> > Tested-by: Wu XiangCheng <bobwxc@email.cn>  
> 
> Thanks!
> 
> > 
> > And one warning when am patch:
> > 
> >     .git/rebase-apply/patch:62: trailing whitespace.
> > 	    \kerneldocCJKoff  
> 
> Oops, will fix and post v3 soon, with your Tested-by: appended

You can also add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

(but see below)


> 
> > 
> >   
> >> I think per-directory conf.py can be tried as a follow-up
> >> change after this patch is applied.  
> > 
> > Agree, I think it's enough for this problem.
> > If we need more complex customization, per-directory conf.py then worth. 

Well, this change seems good enough to me and it avoids the
need of adding a separate conf.py.

The only thing that concerns me is if this logic works with
all Sphinx versions. I guess it should, but there were some
changes in the past with the LaTeX output module which
broke on newer versions, as different versions of Sphinx use
different .

So, this patch needs to be tested against the minimal version recommended
for PDF output (2.4.4) and against the latest one, to be 100% sure that
it won't cause any breakages.

You can test it with something like:

	$ /usr/bin/python3 -m venv sphinx_foo
	$ . sphinx_foo/bin/activate
	$ pip install docutils Sphinx==2.4.4 sphinx_rtd_theme
	$ make pdfdocs
...
	# Should install Latest version, e. g. currently, Sphinx 4.0.2
	$ pip uninstall Sphinx
	$ pip install docutils Sphinx sphinx_rtd_theme
	$ make pdfdocs

(That's said, I didn't test version 4.0 yet... not sure if
everything would work fine, even without this change)

Regards,
Mauro

> >   
> >> --- a/Documentation/translations/index.rst
> >> +++ b/Documentation/translations/index.rst
> >> @@ -18,6 +18,10 @@ Translations
> >>  Disclaimer
> >>  ----------
> >>  
> >> +.. raw:: latex
> >> +
> >> +	\kerneldocCJKoff	
> >> +
> >>  Translation's purpose is to ease reading and understanding in languages other
> >>  than English. Its aim is to help people who do not understand English or have
> >>  doubts about its interpretation. Additionally, some people prefer to read
> >> diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
> >> index bb8fa7346939..e80a3097aa57 100644
> >> --- a/Documentation/translations/it_IT/index.rst
> >> +++ b/Documentation/translations/it_IT/index.rst
> >> @@ -4,6 +4,10 @@
> >>  Traduzione italiana
> >>  ===================
> >>  
> >> +.. raw:: latex
> >> +
> >> +	\kerneldocCJKoff
> >> +
> >>  :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
> >>  
> >>  .. _it_disclaimer:  
> > 
> > And for above two, maybe better to put "raw:: latex" block above the
> > title, more beautiful, and CJKoff will be done before enter "Italiana"
> > chapter.  
> 
> These two are placed there intentionally.
> 
> As mentioned in the change log:
> 
> >> Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
> >> heading, while a non-CJK chapter should have \kerneldocCJKoff
> >> below its chapter heading.
> >>
> >> This is to make sure the CJK font is available to CJK chapter's
> >> heading and ending page's footer.  
> 
> If they are put above chapter titles in the .rst files,
> Chinese translation's final page's footer won't be rendered properly.
> 
>         Thanks, Akira
> 
> > 
> > Thanks,
> > 	Wu X.C.
> >   



Thanks,
Mauro
