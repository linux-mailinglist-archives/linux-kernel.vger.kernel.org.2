Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6843BE21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhJZXvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhJZXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:51:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F1C061570;
        Tue, 26 Oct 2021 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=V6gYGPSmlZO2+IdapoJ3lT2mIVvRXAYGfe/XfmyiAJs=; b=a3USxLIdQD1loITMP9y1jCz4Lq
        3wo17dxEitP+ofnaJnPJnzHbPtf0/6nSS+jRls7BoQ6n4+AqhALYLt4oU1IQNRPpO4B3u8Yh1RJPV
        dla5b9Zs9PV2g13PAUryJDSMft9V9ujage5Q2uzb5ijJItZb5OPNR/fnHcMVF1Ts/SnQwvbajcyQL
        YSPMWLvPtfLR319S94f7Vrh7YyZ8L6jDevViR+HLMBP9hDylEMKxsoatWSSIz9TrStuq7R1ymIKIq
        xdEaZXH3egUNBWfEEUTW1CXg/47DM5cAxPDjupeJssDdp9gUP4+NI2mqagFa8SxPnJnY0AFr//sEM
        9sdckVcw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfWBk-003IBF-AO; Tue, 26 Oct 2021 23:49:04 +0000
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Trevor Woerner <twoerner@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
 <20211026144452.GA40651@localhost>
 <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
 <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
 <58650d3729a5b3a8bc86037757bccda5cc254e3f.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0976b45a-5cf8-450d-c651-96984fa340c9@infradead.org>
Date:   Tue, 26 Oct 2021 16:49:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <58650d3729a5b3a8bc86037757bccda5cc254e3f.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/21 8:27 AM, Joe Perches wrote:
> On Tue, 2021-10-26 at 08:18 -0700, Randy Dunlap wrote:
>> On 10/26/21 8:10 AM, Miguel Ojeda wrote:
>>> On Tue, Oct 26, 2021 at 4:44 PM Trevor Woerner <twoerner@gmail.com> wrote:
>>>>
>>>> get_maintainer.pl didn't add Andrew back then on my patch and still doesn't
>>>> even now. Maybe the MAINTAINERS file needs an update if Andrew is to be
>>>> included on trivial/documentation patches?
>>>
>>> I mentioned Andrew because he does the hard job of being a backup for
>>> everything and everyone, but normally you should try to put the actual
>>> maintainer first in the `To` field and/or trivial@kernel.org.
>>
>> I think that we decided to stop using trivial@kernel.org for new patches
>> a few months ago...
> 
> Dunno who the "we" is but then maybe this is appropriate:
> ---
>   MAINTAINERS | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 869e6cc6366bc..8c933736bb412 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19282,12 +19282,6 @@ W:	https://github.com/srcres258/linux-doc
>   T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>   F:	Documentation/translations/zh_TW/
>   
> -TRIVIAL PATCHES
> -M:	Jiri Kosina <trivial@kernel.org>
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
> -K:	^Subject:.*(?i)trivial
> -
>   TTY LAYER
>   M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   M:	Jiri Slaby <jirislaby@kernel.org>
> 

Jiri?

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy
