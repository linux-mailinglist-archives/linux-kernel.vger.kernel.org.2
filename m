Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6C460004
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 17:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbhK0QEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 11:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbhK0QC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 11:02:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27274C061756;
        Sat, 27 Nov 2021 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=4XZtF6UQJJOpieuhcFmh9pyuWGB6MbG7X7vb66bbCK0=; b=XWOCT2nIplInYp0oxQPVnCccLr
        FmQ8M13ARK7QXswrL/bZsTQW2ALUttNXdIwv+bCuljXoh5rW+V42RCP5kV8P28qJfedKjYOQY8vEg
        a3SqNQp+31QsfuumhHRnTThbq8CkiUCrzeXltdeSek1DHkSBqxvfxSy5YkaVoFdxGUTOW9z8cUzoK
        Z+d8UC19xFiq+2b9wCGC8xV+5u4bAqfTrbTgTuIv2dbJ1dKxYh9DCrrBeUqeC+gOAfAD2W/LjK8jf
        m49yAX0KOlw0PdMPNkQ4+XjoULixsO4R6HWzVXn5jP0QViMOJApQ/EnbOb+IstM4G/GM7X9PSNaW1
        NHZdbfYA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mr06b-00DxWi-Rw; Sat, 27 Nov 2021 15:59:13 +0000
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
 <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
 <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
 <87sfvik21z.fsf@intel.com> <20211127102518.6e715036@coco.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c6fe1f6-1a81-1181-f23a-df3f1b538cdf@infradead.org>
Date:   Sat, 27 Nov 2021 07:59:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211127102518.6e715036@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/21 1:25 AM, Mauro Carvalho Chehab wrote:
> Em Sat, 27 Nov 2021 00:03:04 +0200
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> 
>> On Fri, 26 Nov 2021, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 11/26/21 6:33 AM, Akira Yokosawa wrote:
>>>> Hi Mauro,
>>>>
>>>> On Fri, Nov 26, 2021 at 11:50:53AM +0100, Mauro Carvalho Chehab wrote:
>>>>> As described at:
>>>>> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
>>>>>
>>>>> since Sphinx 1.8, the standard way to setup a custom theme is
>>>>> to use html_css_files. While using html_context is OK with RTD
>>>>> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
>>>>> producing a very weird html.
>>>>>
>>>>> Tested with:
>>>>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
>>>>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
>>>>> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
>>>>>
>>>>> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>>> ---
>>>>>    Documentation/conf.py | 13 +++++++++----
>>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> So I have an issue with this simple change.
>>>> As I said to Jon in another thread [1], in which Jon didn't show any
>>>> interest, this update changes the look of generated HTML pages
>>>> (I should say) rather drastically, and it looks quite distracting
>>>> for my eyes.  The style might be acceptable for API documentations,
>>>> but kernel-doc has abundant natural language contents.
>>>
>>> I agree 100% that the sans serif font is not desirable and not as
>>> easy on the eyes as the serif font is.
>>> Hopefully there is a way to change that.
> 
> That's actually a bug on my past patch. When html_css_files is used,
> it should *not* contain "_static/" at the path. So, it should simply
> be:
> 
> 	html_css_files = [
> 		'theme_overrides.css',
> 	]
> 
> Just sent a v2 fixing such issue.
> 

Oh, thanks.

>>
>> Taking a step back, choosing the sphinx-rtd-theme to begin with was
>> purely arbitrary, I didn't put much effort into checking the
>> alternatives, and as far as I recall, neither did Jon. There were more
>> pressing issues at the time to get the documentation generation ball
>> rolling at all.
>>
>> Obviously anyone can change the theme for themselves, and I guess the
>> question is rather what the default is, and, subsequently, what gets
>> used at [1].
>>
>> I haven't followed the development on this closely, but I am somewhat
>> surprised at the amount of theme overrides having been added, and it
>> begs the question whether there'd perhaps be a readily available stock
>> theme that would be better suited than sphinx-rtd-theme?
> 
> I doubt we'll find one that everybody agrees on, but it sounds worth
> discussing it.
> 
> One of the things with themes (and with supporting different Sphinx
> versions) is that the look-and-feel changes over time, depending on the
> specific versions that are used. I mean, newer versions of Sphinx come
> with newer css classes, which sometimes replace the output of existing
> tags.
> 
> So, except if either:
> 
> 1. We stick with just a single Sphinx and theme version; or
> 
> 2. someone has enough time to keep tracking on mapping each tag's output
>     to their css classes and ensure that the look-and-feel will remain
>     the same with all valid version combinations (I don't)
> 
> the output will differ depending on the changes at the theme and due
> to Sphinx version-dependent output.
> 
> Btw, if we look at RTD change log:
> 
> 	https://sphinx-rtd-theme.readthedocs.io/en/stable/changelog.html
> 
> version 1.0.0 basically upgraded the theme to support:
> 	- Sphinx 4.x
> 	- Docutils 0.17
> 
> It also dropped support for Sphinx version < 1.6.
> 
> On other words, by sticking with a non-builtin theme, we may end
> needing to apply version-dependent fixes from time to time - mostly
> via css override stuff.
> 
> -
> 
> Perhaps one alternative to help with themes maintenance would be to
> select one of the builtin themes from:
> 
> 	https://sphinx-themes.org/

Looks to me like those are external to sphinx-doc.org. It says that
they are maintained by @pradyunsg and @shirou. (don't know who they are)
There are over 40 themes shown there.

OTOH, there is https://www.sphinx-doc.org/en/master/usage/theming.html#builtin-themes,
which shows about 12 builtin themes to choose from. Pretty much like the
list the you show just below here...

> 
> if they're good enough and are present at the minimal Sphinx version
> supported by Kernel documentation. The ones available on 1.7.9 are:
> 
> 	$ ls sphinx_1.7.9/lib/python3.10/site-packages/sphinx/themes
> 	agogo  bizstyle  default  haiku   nonav    scrolls    traditional
> 	basic  classic   epub     nature  pyramid  sphinxdoc
> 
> They all are also the same themes available at the latest version.
> 
> If we're willing to do so, I did a quick test here. Those seems to
> produce a reasonable output:
> 
> 	- bizstyle
> 	- nature
> 	- classic

Thanks for checking.

> If something would still be needed to change, the css override file could
> still be used, but keeping it minimal helps to avoid the need of too
> drastic changes.

I'll take a look...


-- 
~Randy
