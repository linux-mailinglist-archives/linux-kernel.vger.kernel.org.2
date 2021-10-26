Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48743B780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhJZQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhJZQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:47:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C41BC061745;
        Tue, 26 Oct 2021 09:45:20 -0700 (PDT)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mfPZb-0008Q8-6Q; Tue, 26 Oct 2021 18:45:15 +0200
Message-ID: <390b1b40-6798-5215-914c-d75a9cf20dae@leemhuis.info>
Date:   Tue, 26 Oct 2021 18:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1635152553.git.linux@leemhuis.info>
 <27105768dc19b395e7c8e7a80d056d1ff9c570d0.1635152553.git.linux@leemhuis.info>
 <20211025210536.hlmkpjwf3nll6mlm@meerkat.local> <87wnlzeqgr.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/1] docs: submitting-patches: make section about the
 Link: tag more explicit
In-Reply-To: <87wnlzeqgr.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1635266720;25ed95c4;
X-HE-SMSGID: 1mfPZb-0008Q8-6Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.21 17:49, Jonathan Corbet wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
>> On Mon, Oct 25, 2021 at 11:06:35AM +0200, Thorsten Leemhuis wrote:
>>> +If related discussions or any other background information behind the change
>>> +can be found on the web, add 'Link:' tags pointing to it. In case your patch
>>> +for example fixes a bug, add a tag with a URL referencing the report in the
>>> +mailing list archives or a bug tracker; if the patch is a result of some
>>> +earlier mailing list discussion or something documented on the web, point to
>>> +it.
>>
>> The "for example" is splitting the sentence awkwardly, so I would move it to
>> the beginning of the sentence:
>>
>> "For example, in case your patch fixes a bug, add ..." etc
>>
>> Otherwise,
>>
>> Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

BTW: thx, Konstantin, good idea.

> I tweaked things along these lines and applied the patch, thanks.

Great, many thx Jon!

Ciao, Thorsten
