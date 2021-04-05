Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4097353C36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhDEHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhDEHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:43:51 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B594C061756;
        Mon,  5 Apr 2021 00:43:46 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lTJtc-0005dk-6Y; Mon, 05 Apr 2021 09:43:40 +0200
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>
References: <cover.1617113469.git.linux@leemhuis.info>
 <49c674c2d304d87e6259063580fda05267e8c348.1617113469.git.linux@leemhuis.info>
 <YGM68Q0+aeNgjsdy@kroah.com> <87h7krksvu.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1 1/4] docs: make reporting-issues.rst official and
 delete reporting-bugs.rst
Message-ID: <ed386533-fde8-c9f0-38b4-9df40f9f90b3@leemhuis.info>
Date:   Mon, 5 Apr 2021 09:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87h7krksvu.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617608626;5db42ef1;
X-HE-SMSGID: 1lTJtc-0005dk-6Y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 21:47, Jonathan Corbet wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
>> On Tue, Mar 30, 2021 at 04:13:04PM +0200, Thorsten Leemhuis wrote:
>>> Removing Documentation/admin-guide/reporting-bugs.rst will break links
>>> in some of the translations. I was unsure if simply changing them to
>>> Documentation/admin-guide/reporting-issue.rst was wise, so I didn't
>>> touch anything for now and CCed the maintainers for the Chinese and
>>> Italian translation. I couldn't find one for the Japanse translation.
>>
>> Traditionally translations catch up much later on, you shouldn't have to
>> worry about them the authors will clean them up and submit patches for
>> them when they get the chance.
> 
> Agreed.  None of the broken references actually generate warnings
> (though perhaps some should) so we can let the translators catch up on
> their own time.

Ahh, good to know.

BTW to the translators in the CC: sorry for not giving you a heads up
earlier, things were supposed to get slower, but then had to be
accelerated.

> I've applied the set and stuck in this tweak:
> 
>> FWIW, this needs a
>>
>>  s!stable/>_`!stable/>`_!
>>
>> Sorry, this slipped through. :-/ Ciao, Thorsten
> 
> while I was at it.

Great, thx everyone, that what I had hoped for when I posted it.

BTW, can't see the patches in docs-next yet, but I just assume it's just
not pushed out yet for some reason. Whatever.

Side note, FWIW: I have no further patches for the text in my queue, but
I might sent one depending on how fast the new mailing list
linux-regressions will be created (will as for that later today).

Ciao, Thorsten


