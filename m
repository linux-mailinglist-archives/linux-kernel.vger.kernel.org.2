Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC59745FD99
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353300AbhK0Jam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhK0J2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:28:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CAC061574;
        Sat, 27 Nov 2021 01:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB13B81112;
        Sat, 27 Nov 2021 09:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B6C53FAD;
        Sat, 27 Nov 2021 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638005125;
        bh=Y0PZrrq8/TxtF57LdECreGUYHt34NfNPXyOPWQv/hO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U8lkgE+Q+EtvmdHGRIlaSfRP26EltAjQSiEVaDxa1sS5A8DRzXu+cxZOHZM9HwSh1
         FumbRpEeYYgUoah0ay77OsvExOdSiQAfpBD1k5XLUX7Ov8YMZ+CLMAlm2/j6fCeE9L
         tMw+ZoBqsRsRHCPKeHLzUPx1UzZtugkcXUg21gJK5g3ZtOw4TpkYRW8+SgRznk0DY7
         A2bznWe1SIv6qC5CFJEg5W17ypiqL13j/XyL9ZCAa+mNi7riiQoEcWzVIbzcr81N6l
         WQoWOVqst3CXeydJlzuEt06qsPPztObwkWNWMSXReh9YNpLwk9WOcXxXNWLWlUX4EB
         M+nxhcw4+M/zw==
Date:   Sat, 27 Nov 2021 10:25:18 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
Message-ID: <20211127102518.6e715036@coco.lan>
In-Reply-To: <87sfvik21z.fsf@intel.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
        <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
        <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
        <87sfvik21z.fsf@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 27 Nov 2021 00:03:04 +0200
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Fri, 26 Nov 2021, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/26/21 6:33 AM, Akira Yokosawa wrote:  
> >> Hi Mauro,
> >> 
> >> On Fri, Nov 26, 2021 at 11:50:53AM +0100, Mauro Carvalho Chehab wrote:  
> >>> As described at:
> >>> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
> >>>
> >>> since Sphinx 1.8, the standard way to setup a custom theme is
> >>> to use html_css_files. While using html_context is OK with RTD
> >>> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
> >>> producing a very weird html.
> >>>
> >>> Tested with:
> >>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
> >>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
> >>> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
> >>>
> >>> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> ---
> >>>   Documentation/conf.py | 13 +++++++++----
> >>>   1 file changed, 9 insertions(+), 4 deletions(-)  
> >> 
> >> So I have an issue with this simple change.
> >> As I said to Jon in another thread [1], in which Jon didn't show any
> >> interest, this update changes the look of generated HTML pages
> >> (I should say) rather drastically, and it looks quite distracting
> >> for my eyes.  The style might be acceptable for API documentations,
> >> but kernel-doc has abundant natural language contents.  
> >
> > I agree 100% that the sans serif font is not desirable and not as
> > easy on the eyes as the serif font is.
> > Hopefully there is a way to change that.  

That's actually a bug on my past patch. When html_css_files is used,
it should *not* contain "_static/" at the path. So, it should simply
be:

	html_css_files = [
		'theme_overrides.css',
	]

Just sent a v2 fixing such issue.

> 
> Taking a step back, choosing the sphinx-rtd-theme to begin with was
> purely arbitrary, I didn't put much effort into checking the
> alternatives, and as far as I recall, neither did Jon. There were more
> pressing issues at the time to get the documentation generation ball
> rolling at all.
> 
> Obviously anyone can change the theme for themselves, and I guess the
> question is rather what the default is, and, subsequently, what gets
> used at [1].
> 
> I haven't followed the development on this closely, but I am somewhat
> surprised at the amount of theme overrides having been added, and it
> begs the question whether there'd perhaps be a readily available stock
> theme that would be better suited than sphinx-rtd-theme?

I doubt we'll find one that everybody agrees on, but it sounds worth
discussing it.

One of the things with themes (and with supporting different Sphinx 
versions) is that the look-and-feel changes over time, depending on the 
specific versions that are used. I mean, newer versions of Sphinx come 
with newer css classes, which sometimes replace the output of existing 
tags. 

So, except if either:

1. We stick with just a single Sphinx and theme version; or

2. someone has enough time to keep tracking on mapping each tag's output
   to their css classes and ensure that the look-and-feel will remain 
   the same with all valid version combinations (I don't)

the output will differ depending on the changes at the theme and due
to Sphinx version-dependent output.

Btw, if we look at RTD change log:

	https://sphinx-rtd-theme.readthedocs.io/en/stable/changelog.html

version 1.0.0 basically upgraded the theme to support:
	- Sphinx 4.x
	- Docutils 0.17

It also dropped support for Sphinx version < 1.6.

On other words, by sticking with a non-builtin theme, we may end
needing to apply version-dependent fixes from time to time - mostly
via css override stuff.

-

Perhaps one alternative to help with themes maintenance would be to
select one of the builtin themes from:

	https://sphinx-themes.org/

if they're good enough and are present at the minimal Sphinx version 
supported by Kernel documentation. The ones available on 1.7.9 are:

	$ ls sphinx_1.7.9/lib/python3.10/site-packages/sphinx/themes
	agogo  bizstyle  default  haiku   nonav    scrolls    traditional
	basic  classic   epub     nature  pyramid  sphinxdoc

They all are also the same themes available at the latest version.

If we're willing to do so, I did a quick test here. Those seems to
produce a reasonable output:

	- bizstyle
	- nature
	- classic

If something would still be needed to change, the css override file could
still be used, but keeping it minimal helps to avoid the need of too 
drastic changes.

Thanks,
Mauro
