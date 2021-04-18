Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80A0363463
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhDRJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 05:12:16 -0400
Received: from mout01.posteo.de ([185.67.36.65]:58889 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhDRJMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 05:12:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 695F7240026
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 11:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618737105; bh=WKRW0XXKC2fipPBs9zdITrBVtmnVHuSd55wYWDnZwxo=;
        h=Date:From:To:Cc:Subject:From;
        b=WM3XWGKtXKYrHGYNzvnlhUgABC6QSkTTOkdOaAAAymeby4Tgdzla/05eFd/B++32z
         ZQkt6y4BCX2Vb3532nCFSlbZXw7PDoICdateI+jSzWSDDdKoK2FUoKWgDyKV6HBDVC
         vL6wCanPDGodKMnJPRKTmV3wEl3SNQ7j9zaYC1a/WZzNoQ7hDwC+A6ZtiFB7efXIKm
         NVf7Ij4aTN5w5gsupjHjfv2+XLr4paJxKwN0iNjqOxVl9px2EUMMXgrLqZHoSwhbdb
         ptnSB2q14J8X/u0pftHINFBhv9gfizl13IQ1A+9w9uZhHfYS6VNAcokrOmEnWNgI9Y
         lqo0e6DJIk+PQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNPMh1d41z6tmG;
        Sun, 18 Apr 2021 11:11:44 +0200 (CEST)
Date:   Sun, 18 Apr 2021 09:11:43 +0000
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
Message-ID: <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
 <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joe,

On 18.04.2021 00:09, Joe Perches wrote:
>On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
>> Remove a redundant space to improve the quality of the comment.
>
>I think this patch is not useful.
>
>It's not redundant.

Thank you, I actually found this pattern a few more times but I wanted
to check first if this is a mistake or chosen consciously.

Sorry for the noise.

>
>Two spaces after a period is commonly used to separate sentences.
>It's especially common when used with fixed pitch fonts.
>
>A trivial grep seems to show it's used about 50K times in comments.
>Though single space after period may be used about twice as often.
>
>$ git grep '^\s*\*.*\.  [A-Z]' | wc -l
>54439
>$ git grep '^\s*\*.*\. [A-Z]' | wc -l
>110003
>
>For drivers/base/power/runtime.c, that 2 space after period style is used
>dozens of times and changing a single instance of it isn't very useful.

True and if I understand you correctly you would rather keep it as is
right?

Greetings,
Sebastian

>
>> ---
>> Side-note:
>> I found this while reading the code, I don't believe it is important but
>> I thought it doesn't hurt to fix it.
>> ---
>>  drivers/base/power/runtime.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 18b82427d0cb..499434b84171 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -786,7 +786,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>>  	}
>>  
>>
>>  	/*
>> -	 * See if we can skip waking up the parent.  This is safe only if
>> +	 * See if we can skip waking up the parent. This is safe only if
>>  	 * power.no_callbacks is set, because otherwise we don't know whether
>>  	 * the resume will actually succeed.
>>  	 */
>
>
