Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BE2349A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCYTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:37:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3929C06174A;
        Thu, 25 Mar 2021 12:37:32 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPVnN-0004kc-Vg; Thu, 25 Mar 2021 20:37:30 +0100
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1616181657.git.linux@leemhuis.info>
 <c8770353-3d0d-17af-115a-efa4a31fd97b@leemhuis.info>
 <87y2ebysy8.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 0/5] docs: reporting-issues: streamline process and
 solve a FIXME
Message-ID: <4bc573bf-3dc1-fb6b-e6d7-d51993725c29@leemhuis.info>
Date:   Thu, 25 Mar 2021 20:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87y2ebysy8.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616701053;a929d664;
X-HE-SMSGID: 1lPVnN-0004kc-Vg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.21 19:43, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> That's why I'd like to speed things up a little. But for that it would
>> be good to have something from you: a kind of "I like the direction
>> where this patch set is heading and I'm optimistic that we get it merged
>> for 5.13-rc1" message from you. With something like that I could move
>> ahead as outlined above already. Do you maybe have a minute for that?
> Honestly, I don't see any reason to delay this work any further, so I've
> just applied the set.

Ahh, great, many thx.

> Sorry for the slowness,

No worries, it's improvements to a docs text, not a crucial security
issue in core code. :-D

> it has been a rather harsh week.

I hope things will get better soon!

BTW, I wondered it it would make sense to add a entry to the MAINTAINERS
file for the text so I can keep and eye on things and help with fine
tuning. Let me known if you think that idea is overblown, otherwise I'll
likely add one with the patch that I'll send sooner or later to remove
the WIP box near the top.

Ciao (and make sure to take care of yourself!), Thorsten


