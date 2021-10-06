Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43354243FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhJFRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:24:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFBC061746;
        Wed,  6 Oct 2021 10:22:45 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mYAct-00042Y-Vc; Wed, 06 Oct 2021 19:22:44 +0200
Message-ID: <a890b043-9142-514f-28e0-1b98790c70dc@leemhuis.info>
Date:   Wed, 6 Oct 2021 19:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-BS
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7dff33afec555fed0bf033c910ca59f9f19f22f1.1633537634.git.linux@leemhuis.info>
 <20211006170025.qw3glxvocczfuhar@meerkat.local>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: submitting-patches: make section on linking more
 explicit
In-Reply-To: <20211006170025.qw3glxvocczfuhar@meerkat.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1633540965;cec6a928;
X-HE-SMSGID: 1mYAct-00042Y-Vc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 19:00, Konstantin Ryabitsev wrote:
> On Wed, Oct 06, 2021 at 06:37:38PM +0200, Thorsten Leemhuis wrote:
>> +Add 'Link:' tags with URLs pointing to related discussions and rationale
>> +behind the change whenever that makes sense. If your patch for example
>> +fixes a bug, add a tag with a URL referencing the report in the mailing
>> +list archives or a bug tracker; if the patch follows from a mailing list
>> +discussion, point to it. When linking to mailing list archives, use the
>> +https://lkml.kernel.org/r/ redirector with a ``Message-Id``, to ensure
> 
> We shouldn't be using "lkml.kernel.org" because that domain name can create
> confusion that this is only valid for messages sent to "the LKML"
> (linux-kernel@vger.kernel.org). The convention has been to use
> https://lore.kernel.org/r/msgid for this reason. I would also reword that a
> bit:
> 
>     ... or a bug tracker; if the patch was discussed on a mailing list, you
>     may point to it using the lore.kernel.org message archiver service. To
>     create the link URL, use the contents of the ``Message-Id`` header of the
>     patch message without the surrounding angle brackets. For example::
> 
>     Link: https://lore.kernel.org/r/git-send-email.555-1234@example.org
> 
>     Please check the link to make sure that it is actually working and points
>     to the relevant message.

Thx, feedback like this was exactly why I CCed you. So I'll do what I
outlined in my earlier mail already: prepare a patch that first does a
s!lkml.kernel.org!lore.kernel.org! in everywhere in Documentation/ where
it makes sense.

Ciao, Thorsten
