Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2D30BEF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBBNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhBBNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:00:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F46C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 04:59:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c6so22811752ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y6qPLnNOrfshI5dIE0ugviOMMakt3G7MlcOBivCgLvU=;
        b=lBiqFTBvGs+YNbwRlb8fwxRZnZhIQNN8U3K/scvMU+7RxQmAvMlCQCsRw5DFZDgYEO
         AdSeRO1M5uwTHwLKf9+R7uOBCH6RnATxWQwJkKK77v81ieEj1lys0hBkrw8xW3dErvRI
         L+Rnq0HvW2bYWvjoT773MlLyNNv3zRtc2+1jzRlsgTusrcJjCmjqrLDSqEV1ildzChWE
         nIMOYxRNaObMV74fVdGZoDzpYpzrOYsZr1dsW307PPwwax/Rur0fqy4cAF1INj5HW5Cg
         MXh4OcwVuiB/tuWWEdAMMYAtnX9KNOiGWpxs4yfEM4pKugN76JWvScuN1S4BxlvFNsQf
         eQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Y6qPLnNOrfshI5dIE0ugviOMMakt3G7MlcOBivCgLvU=;
        b=G9iBezQQLHA31Paka37AEQu6QQxeJ2tR1tDVlUsyAAVnmxT076cEWRqdpUonfkOqS2
         W6rsTmfTyjjbyGpgtLGEraTE8hlq6Oo9me2w0WyzByWJSwlOmvpgtUYQ97wFpYiLxxk9
         n8ljMMyS3IzK318sALDqqPUqw22FOYrXtXZw1YUSWsTL7TdEYr5MOtS6Sjz3cchE5+JH
         fivpXbxfsjA+GDngT9QxuLAzt+Yw/B9zlG349RBV9vVdeMnvE7/3G4ikuuUwIVqw2zpm
         E3sUXJsUcS6DazhhNcZr5WJa7f6SxJio6mIfewwOHE1NAnDhnsE3iT+t7IYAxWhvv9nO
         AR7g==
X-Gm-Message-State: AOAM532H+XPlCtkGNsq6TMJSDpwJ9V7BI8kKYfkklmOjQt6UPSSW2ONk
        0ZMGsviD6dkQ/6RW2D/sCtozuzSPDps=
X-Google-Smtp-Source: ABdhPJynD+V3bqDmobELwzDEzya0fVgz4tQv8SHjCnl8tF6SPWIgrFY7d6AZp0Tf9zb67QcSN2wzeQ==
X-Received: by 2002:a05:6402:d0a:: with SMTP id eb10mr23515860edb.249.1612270788565;
        Tue, 02 Feb 2021 04:59:48 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id r7sm9419361ejo.20.2021.02.02.04.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 04:59:48 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] list: add more extensive double add check
To:     NeilBrown <neilb@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     mojha@codeaurora.org, jkosina@suse.cz, cezary.rojewski@intel.com,
        neilb@suse.com, b00073877@aus.edu, linux-kernel@vger.kernel.org
References: <20210201135251.1884-1-christian.koenig@amd.com>
 <YBgnY8FXpHJdoDos@smile.fi.intel.com>
 <8735yffn85.fsf@notabene.neil.brown.name>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7d40b266-ce1a-cb11-da85-ff7746b3dd96@gmail.com>
Date:   Tue, 2 Feb 2021 13:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8735yffn85.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.02.21 um 23:16 schrieb NeilBrown:
> On Mon, Feb 01 2021, Andy Shevchenko wrote:
>
>> On Mon, Feb 01, 2021 at 02:52:51PM +0100, Christian König wrote:
>>> Adding the same element to a linked list multiple times
>>> seems to be a rather common programming mistake. To debug
>>> those I've more than once written some code to check a
>>> linked list for duplicates.
>>>
>>> Since re-inventing the wheel over and over again is a bad
>>> idea this patch tries to add some common code which allows
>>> to check linked lists for duplicates while adding new
>>> elements.
>>>
>>> When list debugging is enabled we currently already check
>>> the previous and next element if they are identical to the
>>> new one. This patch now adds a configuration option to
>>> check N elements before and after the desired position.
>>>
>>> By default we still only test one item since testing more
>>> means quite a large CPU overhead. This can be overwritten
>>> on a per C file bases by defining DEBUG_LIST_DOUBLE_ADD
>>> before including list.h.
>> I'm not sure it is a good idea. Currently the implementation is *generic*.
>> You are customizing it w/o letting caller know.
>>
>> Create a derivative implementation and name it exlist (exclusive list) and use
>> whenever it makes sense.
>>
>> And I think if you are still pushing to modify generic one the default must be
>> 0 in order not altering current behaviour.
> I don't understand your complaint.
> The extra checks are also completely *generic*.  It can never make sense
> to add sometime to a list if it is already on the list.  All lists are
> exclusive lists.
> The code ALREADY tests if the inserted object is already present either
> side of the insert side of the insertion point.  This patch just extends
> it somewhat.

Correct, we are just checking for obvious bugs. The bigger problem is 
the usability and potentially performance impact.

In other words when you set this value to high the list_add() function 
will use so much time that the kernel thinks that the CPU is stuck. I've 
was already able to trigger this.

Would it be more acceptable if I drop the config option and only allow 
to override the check on a per C file basis?

> I myself have never had, or heard of, a bug due to double insertion so
> I'm no strongly in favour of this patch for that reason.
> But I *am* in favour of making the platform more resilient in general,
> and if others have experienced this sort of bug, then I'm in favour of
> make that easier to detect in future.

I have seen plenty of those. Especially when you implement state 
machines when a certain object needs to move from state to state 
triggered by external events.

For example it seems to be a common mistake to do a list_del_init, drop 
a lock and then assume a list_add should do it when you re-aquired the 
lock. In reality you have a very small window where a device interrupt 
could have already added the item to the list again between the locks.

Thanks,
Christian.

>
> NeilBrown
>
>
>>> A new kunit test is also added to the existing list tests
>>> which intentionally triggers the debug functionality.
>> -- 
>> With Best Regards,
>> Andy Shevchenko

