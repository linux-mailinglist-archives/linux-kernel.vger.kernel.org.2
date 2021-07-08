Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9963BF2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGHAY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhGHAY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:24:27 -0400
X-Greylist: delayed 103804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jul 2021 17:21:47 PDT
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074B9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 17:21:46 -0700 (PDT)
Received: from usagi.middle.earth (ethbase.usagi.not.afront.org [IPv6:2620:137:e001:0:1897:4108:901b:c660])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 279144D0F3480;
        Wed,  7 Jul 2021 17:21:45 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Add check for common mailing list helper
 checks
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20210702223743.1240694-1-warthog9@eaglescrag.net>
 <b1592f359a7e68704c0faac77015b9b2aa8e4073.camel@perches.com>
 <506ec749-63dc-3a08-48e7-5179c3df9a42@eaglescrag.net>
 <5e5eaf6773a0dad42cd59e89f8e710666373f8f1.camel@perches.com>
From:   John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Openpgp: preference=signencrypt
Message-ID: <9fc96a1e-e079-229f-9f78-fa3d92b52116@eaglescrag.net>
Date:   Wed, 7 Jul 2021 17:21:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5e5eaf6773a0dad42cd59e89f8e710666373f8f1.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 07 Jul 2021 17:21:45 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 10:53 AM, Joe Perches wrote:
> On Tue, 2021-07-06 at 12:31 -0700, John 'Warthog9' Hawley wrote:
>> On 7/3/21 11:39 AM, Joe Perches wrote:
>>> On Fri, 2021-07-02 at 15:37 -0700, John 'Warthog9' Hawley (VMware)
>>> wrote:
>>>> From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
>>>>
>>>> Mailing lists in an attempt to try and avoid sending certain
>>>> administrative e-mails to the list, will check the first few lines
>>>> (usually ~10) looking for keywords.  If those key words are found it
>>>> shunts the e-mail to the list admin contact instead of potentially
>>>> passing it through to the list.
>>>
>>> Perhaps the below is a bit better, but I believe a few of the tests
>>> are going to be tripped a bit too often.
>>>
>>> Especially "cancel", "config" and maybe "subscribe" too.
>>>
>>> For instance:
>>>
>>> $ git log --grep='\bcancel\b' -P -i --pretty=oneline -10000 | wc -l
>>> 1693
>>>
>>> $ git log --grep='^config\b' -P -i --pretty=oneline -10000 | wc -l
>>> 890
>>>
>>> $ git log --grep='\bsubscribe\b' -P -i --pretty=oneline -10000 | wc -l
>>> 123
>>
>> A part of getting this into checkpatch.pl is getting some better
>> feedback mechanisms for why patches may not be passing through the list
>> correctly with regexes that have been in place for at least 14 years.
>> These, aren't tripped over often,
> 
> 3000+ commits with regex matches seem rather a lot to me.>
>> but have run into a instance at least
>> recently that triggered me trying to get at least some self check, and
>> notification, pieces in place.
> 
> No worries, but perhaps the message might be reworded to
> say something about possible mailing list moderation rather
> than imply rejection.
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>>> @@ -865,6 +865,37 @@ our $allowed_asm_includes = qr{(?x:
>>>  )};
>>>  # memory.h: ARM has a custom one
>>>
>>> +our $mailing_list_phrases = qr{(?xi:
>>> +	\bcancel\b |
> 
> Mere use of the word "cancel" in the commit description seems undesirable to me.>
>>> +# check if words in the commit message may trip up common mailing list helpers
>>> +# to redirect email to the admin contact
>>> +		if ($in_commit_log && $commit_log_lines < 10 &&
>>> +		    $line =~ /($mailing_list_phrases)/) {
>>> +			WARN("MAILING_LIST_HELPER",
>>> +			     "Line matches common mailing list helpers and may not be delivered correctly - consider rewording '$1'\n" . $herecurr);
> 
> Maybe FILTERS for phrases and helpers
> 
> Maybe something like:
> 
> "Use of '$1' in this patch's commit description might cause mailing list moderation or rejection\n"

"Use of '$1' in this patch's commit description, may cause the message
to be considered an administrative message and may be misdirected and
undelivered to the mailing list\n"

might be more overall accurate since the mailing list is likely push the
message into the admin queue as if it was a control message, and it may
not be easy to get it back into the main stream for delivery.

I'm not picky on the exact wording of the message though, just need to
convey that the commit_log may have something in it that may trip up the
mailing list, and the message may not make it through.
