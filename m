Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01293319176
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhBKRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBKRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:11:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0684C061574;
        Thu, 11 Feb 2021 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=12ShJGexWJHeRylc4GqOogvAYW9dhZ/QBiGrjPhnKqY=; b=THk0uMklMFUn0KisBUKcHxk5wg
        hOxImorDsS+myoLhIbhi0zQl3yhLjoMKyU+gV4L57Zmz3Re5EUrZVdw1gPXK+EnWEVNhucl581P/5
        nfoJs5lc6Z7ojzwGdjSu+EX6HvPceZlkwB/mjwcX/neJBWQT14u7/D7DA4sCOii71sNwzZC/lCYRB
        +00ew0ga+nOErERWl3+vJmUQ3Rjve+dBhzO8L+crN3N+fZYTBf1KzYWLaS6rJfEuakJqfLFiaim+Y
        TN9co8akvL4pCkStw+cyiUfCe2mSLxrKEv4N7PBzBbt/18JAEubebQD4r1sxGaoAw4IclcVd95ug5
        ChLyUDiQ==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFUI-00025H-0Y; Thu, 11 Feb 2021 17:10:42 +0000
Subject: Re: [PATCH] docs: kernel-hacking: Remove the word fuck,trying to be
 civil :)
To:     Jonathan Corbet <corbet@lwn.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, swboyd@chromium.org,
        tiwai@suse.de, nfraprado@protonmail.com, mchehab+huawei@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205115951.1276526-1-unixbhaskar@gmail.com>
 <87sg62pmd4.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca67086b-3b52-40b6-003e-9ac7796ad68d@infradead.org>
Date:   Thu, 11 Feb 2021 09:10:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <87sg62pmd4.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 9:04 AM, Jonathan Corbet wrote:
> Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:
> 
>> s/fuck//
>>
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/kernel-hacking/locking.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
>> index c3448929a824..ed1284c6f078 100644
>> --- a/Documentation/kernel-hacking/locking.rst
>> +++ b/Documentation/kernel-hacking/locking.rst
>> @@ -958,7 +958,7 @@ grabs a read lock, searches a list, fails to find what it wants, drops
>>  the read lock, grabs a write lock and inserts the object has a race
>>  condition.
>>
>> -If you don't see why, please stay the fuck away from my code.
>> +If you don't see why, please stay away from my code.
> 
> Sigh.
> 
> I've gotten a few variants of this patch over the years...I guess maybe
> the time has come to apply one, so I did.  If the word is too offensive
> to be in our docs, though, perhaps it shouldn't be in the changelog
> either, so I rewrote it:
> 
>     docs: kernel-hacking: be more civil
>     
>     Remove the f-bomb from locking.rst.  Let's have a moment of silence,
>     though, as we mark the passing of the last of Rusty's once plentiful
>     profanities in this venerable document.

I really like that tribute there, Jon. :)

-- 
~Randy

