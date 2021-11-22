Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B5459518
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhKVSxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhKVSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:53:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC7C061574;
        Mon, 22 Nov 2021 10:50:37 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mpEOh-00013s-U6; Mon, 22 Nov 2021 19:50:35 +0100
Message-ID: <aa158444-4319-a019-1031-095a69105447@leemhuis.info>
Date:   Mon, 22 Nov 2021 19:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211122112916.498810bb@gandalf.local.home>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
In-Reply-To: <20211122112916.498810bb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1637607038;5814353c;
X-HE-SMSGID: 1mpEOh-00013s-U6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.21 17:29, Steven Rostedt wrote:
> On Mon, 22 Nov 2021 08:33:42 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
>> Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
>> as the latter is overloaded and hence doesn't indicate what the provided
>> URL is about. Documenting these also provides clarity, as a few
>> developers have used 'References:' to point to problem reports;
>> nevertheless 'Reported:' was chosen for this purpose, as it perfectly
>> matches up with the 'Reported-by:' tag commonly used already and needed
>> in this situation already.
> 
> I like the differences between "Reorted:" and "Reviewed:", although I may
> keep the "Link" instead of Reviewed because my automate scripts just give
> the link of the patch, and there's seldom a review attached to it :-/

/me wonders if "Merge Request:" would be a better tag, but at least for
now settles on 'it's nice, as it's close to what people are used from
git forges, but OTOH it somehow feels wrong'

> That said, I would like a way to have versions show a link to the last
> version that was reviewed.
> 
> v1: has no tags
> 
> v2: has a Reviewed: tag to v1.
> 
> v3: has a Reviewed: tag to v2
> 
> [...]
> 
> Then the final commit could have a "Link" or "Reviewed" tag to v3, even
> though there may not be any reviews to v3, but v3 has the link to v2, and
> v2 has the link to v1, etc.

Is that really worth it? Isn't it sufficient if the commit links to the
last public review posting, as that already should link to all earlier
review postings. Sure, not everybody is doing this right now, but maybe
just educating people to do so is better than creating something new.

Ciao, Thorsten
