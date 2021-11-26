Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDD45F58A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhKZT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhKZTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:55:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA0C061371;
        Fri, 26 Nov 2021 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=psLVq64RUP+7Tz5j2QSMYFsAN2NCYT2oqqwwv4yFGa8=; b=VfCKO5SvBRfW6z1f1wJ7vMKSd7
        ub42if58+puXKPd3ggnFCSve48NX/X7QaV458OIvhvAnEDM1t5hFJWpLNpTz3jzsMvKTD2Gtd0y2V
        XZUNboUHa6Pjk32K7YYY6cj37J2oztxFbMADVOnQGDBym9xvX0O1dBqqt0qS9lqXCWc6GToEtLRbC
        HNCjZIdMmz/ENEPJJ51/Dwl6JPxugxsl7lZHXflHRmucLFHtZfiMLuoML6howhZGUgX6zhxAXzuXU
        9CwCjsy2MyLIbjd1U6ePKma92QpYjKU54S1/EYcFFsKoQI9hB4ou4udUtTK4N7eeSNjhPePhFUDLh
        i680ZcfQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqh1u-00BcSB-Il; Fri, 26 Nov 2021 19:37:06 +0000
Subject: Re: [PATCH] docs: conf.py: fix support for Readthedocs v 1.0.0
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <f0660b1d24bc9bc07b13fe9a25ccb69ca14e916d.1637923850.git.mchehab+huawei@kernel.org>
 <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59f64802-c3dc-74cd-8f35-878e3fac64e2@infradead.org>
Date:   Fri, 26 Nov 2021 11:37:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <13c40ed9-a51f-7496-7224-03b563bb6695@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 6:33 AM, Akira Yokosawa wrote:
> Hi Mauro,
> 
> On Fri, Nov 26, 2021 at 11:50:53AM +0100, Mauro Carvalho Chehab wrote:
>> As described at:
>> 	https://stackoverflow.com/questions/23211695/modifying-content-width-of-the-sphinx-theme-read-the-docs
>>
>> since Sphinx 1.8, the standard way to setup a custom theme is
>> to use html_css_files. While using html_context is OK with RTD
>> 0.5.2, it doesn't work with 1.0.0, causing the theme to not load,
>> producing a very weird html.
>>
>> Tested with:
>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 0.5.2
>> 	- Sphinx 2.4.4 + sphinx-rtd-theme 1.0.0
>> 	- Sphinx 4.3.0 + sphinx-rtd-theme 1.0.0
>>
>> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>   Documentation/conf.py | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> So I have an issue with this simple change.
> As I said to Jon in another thread [1], in which Jon didn't show any
> interest, this update changes the look of generated HTML pages
> (I should say) rather drastically, and it looks quite distracting
> for my eyes.  The style might be acceptable for API documentations,
> but kernel-doc has abundant natural language contents.

I agree 100% that the sans serif font is not desirable and not as
easy on the eyes as the serif font is.
Hopefully there is a way to change that.

> [1]: https://lkml.kernel.org/r/550fe790-b18d-f882-4c70-477b596facc7@gmail.com
> 
> I think there should be some knobs for customizing the styles.
> But I don't know much about css.
> 
> Can anybody restore the current look of kernel-doc HTML pages
> in a sphinx-rtd-theme-1.0.0-compatible way?
> 
> Sidenote:
> 
> The change (html_css_files) actually works with
>     - Sphinx 1.7.9 + sphinx-rtd-theme 1.0.0
> 
> This contradicts the Sphinx documentation saying that html_css_files
> was new to Sphinx 1.8.  This might be related to the changes in
> sphinx-rtd-theme side, but I have no evidence.
> 
> Any suggestion is welcome!

thanks.
-- 
~Randy
