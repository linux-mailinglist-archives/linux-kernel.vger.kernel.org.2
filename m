Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F845F6BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbhKZWIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:08:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:21578 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244366AbhKZWGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:06:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="216428648"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="216428648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 14:03:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="498579817"
Received: from iaoflynx-mobl3.amr.corp.intel.com (HELO localhost) ([10.252.10.246])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 14:03:07 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
In-Reply-To: <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
 <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
 <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
Date:   Sat, 27 Nov 2021 00:03:04 +0200
Message-ID: <87sfvik21z.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/26/21 6:33 AM, Akira Yokosawa wrote:
>> Hi Mauro,
>> 
>> On Fri, Nov 26, 2021 at 11:50:53AM +0100, Mauro Carvalho Chehab wrote:
>>> As described at:
>>> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
>>>
>>> since Sphinx 1.8, the standard way to setup a custom theme is
>>> to use html_css_files. While using html_context is OK with RTD
>>> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
>>> producing a very weird html.
>>>
>>> Tested with:
>>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
>>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
>>> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
>>>
>>> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> ---
>>>   Documentation/conf.py | 13 +++++++++----
>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> So I have an issue with this simple change.
>> As I said to Jon in another thread [1], in which Jon didn't show any
>> interest, this update changes the look of generated HTML pages
>> (I should say) rather drastically, and it looks quite distracting
>> for my eyes.  The style might be acceptable for API documentations,
>> but kernel-doc has abundant natural language contents.
>
> I agree 100% that the sans serif font is not desirable and not as
> easy on the eyes as the serif font is.
> Hopefully there is a way to change that.

Taking a step back, choosing the sphinx-rtd-theme to begin with was
purely arbitrary, I didn't put much effort into checking the
alternatives, and as far as I recall, neither did Jon. There were more
pressing issues at the time to get the documentation generation ball
rolling at all.

Obviously anyone can change the theme for themselves, and I guess the
question is rather what the default is, and, subsequently, what gets
used at [1].

I haven't followed the development on this closely, but I am somewhat
surprised at the amount of theme overrides having been added, and it
begs the question whether there'd perhaps be a readily available stock
theme that would be better suited than sphinx-rtd-theme?


BR,
Jani.


[1] https://www.kernel.org/doc/html/latest/



>
>> [1]: https://lkml.kernel.org/r/550fe790-b18d-f882-4c70-477b596facc7@gmail.com
>> 
>> I think there should be some knobs for customizing the styles.
>> But I don't know much about css.
>> 
>> Can anybody restore the current look of kernel-doc HTML pages
>> in a sphinx-rtd-theme-1.0.0-compatible way?
>> 
>> Sidenote:
>> 
>> The change (html_css_files) actually works with
>>     - Sphinx 1.7.9 + sphinx-rtd-theme 1.0.0
>> 
>> This contradicts the Sphinx documentation saying that html_css_files
>> was new to Sphinx 1.8.  This might be related to the changes in
>> sphinx-rtd-theme side, but I have no evidence.
>> 
>> Any suggestion is welcome!
>
> thanks.

-- 
Jani Nikula, Intel Open Source Graphics Center
