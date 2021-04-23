Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E7369A22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbhDWSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbhDWSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:45:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:44:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r5so1302441ilb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yVVz+E0c4ZzJNVeZ//Fi8gxwTLPS60gMt+sFzryfON8=;
        b=c6fY6309w2mHEHZ0CIVOC6wuR2L3pkUOdhLID/3oX5CAW25KoUWbCSz/B9vIkpS9YK
         uqNhExU07L9fIloLr+Ve8VdW+TmCEg3nu6HuY4LhZqRc9N/UTVG3O9vjRWbFOqvbSVBg
         JXy7k65yrbwolEQCr76WL8a9codOEcnptL+MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVVz+E0c4ZzJNVeZ//Fi8gxwTLPS60gMt+sFzryfON8=;
        b=jUQWxGW66/DtYHnmwiG/R9vWN176jVc4amGrj9SAZGQfDCDc2qoI7OnklYPtWPioWX
         CvyJriN1hGe/8XnkiPfGQhfYfmKwBA/nm4KIq7dArgyCQOTPCIsZXvBbutt/H2CrC5X4
         FTqxxVPS+5yXV81tBNKu9r64qi62uO3gmtaGwvgBmE62o0BfCiN4brHlBNj5Uyn0LDHZ
         Qzx/0+6g3dcQ4MBmgjCHzyfLYTYS8WKdBLSZNmAF8glM8k8NrQfkAu/0nnWXPmBsPIQ6
         4EqYv7MjLbSo0Ge/dbknkN7jn2JmvM22cJPmhsaylcJiD1Zj8qZeFGApuqfTi2xz99f5
         t1oA==
X-Gm-Message-State: AOAM533B5SRJUiGeQziOLxKfnKAADSkFyZwGJVXppyyzuWwv9SM0pTVp
        zLlIOnP6kdN239d5pBEfqw4vmQ==
X-Google-Smtp-Source: ABdhPJxKcbY7U2jxwXUwapSjuelGcph0KuuOUh7N4hqWX7jnbyzlHMmtUO7smvzoLbCJFou8VrPfNQ==
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr4166000ilv.142.1619203494383;
        Fri, 23 Apr 2021 11:44:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w10sm2800455ilm.38.2021.04.23.11.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 11:44:54 -0700 (PDT)
Subject: Re: [PATCH v3] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Junyong Sun <sunjy516@gmail.com>,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210414085406.1842-1-mail@anirudhrb.com>
 <20210414125540.GJ4332@42.do-not-panic.com>
 <1e12bb24-9bb8-dad7-d852-02173ce41b6a@linuxfoundation.org>
 <04b5bb2f-edf7-5b43-585a-3267d83bd8c3@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a31fc55f-1f61-19b6-dfaf-4454380f8f45@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 12:44:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <04b5bb2f-edf7-5b43-585a-3267d83bd8c3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 8:10 AM, Shuah Khan wrote:
> On 4/14/21 9:26 AM, Shuah Khan wrote:
>> On 4/14/21 6:55 AM, Luis Chamberlain wrote:
>>> Shuah, a question for you toward the end here.
>>>
>>> On Wed, Apr 14, 2021 at 02:24:05PM +0530, Anirudh Rayabharam wrote:
>>>> This use-after-free happens when a fw_priv object has been freed but
>>>> hasn't been removed from the pending list (pending_fw_head). The next
>>>> time fw_load_sysfs_fallback tries to insert into the list, it ends up
>>>> accessing the pending_list member of the previoiusly freed fw_priv.
>>>>
>>>> The root cause here is that all code paths that abort the fw load
>>>> don't delete it from the pending list. For example:
>>>>
>>>>     _request_firmware()
>>>>       -> fw_abort_batch_reqs()
>>>>           -> fw_state_aborted()
>>>>
>>>> To fix this, delete the fw_priv from the list in __fw_set_state() if
>>>> the new state is DONE or ABORTED. This way, all aborts will remove
>>>> the fw_priv from the list. Accordingly, remove calls to list_del_init
>>>> that were being made before calling fw_state_(aborted|done).
>>>>
>>>> Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
>>>> list if it is already aborted. Instead, just jump out and return early.
>>>>
>>>> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with 
>>>> fw_load_sysfs_fallback")
>>>> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
>>>> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
>>>> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> Modified the patch to incorporate suggestions by Luis Chamberlain in
>>>> order to fix the root cause instead of applying a "band-aid" kind of
>>>> fix.
>>>> https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/
>>>>
>>>> Changes in v2:
>>>> 1. Fixed 1 error and 1 warning (in the commit message) reported by
>>>> checkpatch.pl. The error was regarding the format for referring to
>>>> another commit "commit <sha> ("oneline")". The warning was for line
>>>> longer than 75 chars.
>>>>
>>>> ---
>>>>   drivers/base/firmware_loader/fallback.c | 8 ++++++--
>>>>   drivers/base/firmware_loader/firmware.h | 6 +++++-
>>>>   drivers/base/firmware_loader/main.c     | 2 ++
>>>>   3 files changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/base/firmware_loader/fallback.c 
>>>> b/drivers/base/firmware_loader/fallback.c
>>>> index 91899d185e31..73581b6998b4 100644
>>>> --- a/drivers/base/firmware_loader/fallback.c
>>>> +++ b/drivers/base/firmware_loader/fallback.c
>>>> @@ -94,7 +94,6 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
>>>>       if (fw_sysfs_done(fw_priv))
>>>>           return;
>>>> -    list_del_init(&fw_priv->pending_list);
>>>>       fw_state_aborted(fw_priv);
>>>>   }
>>>> @@ -280,7 +279,6 @@ static ssize_t firmware_loading_store(struct 
>>>> device *dev,
>>>>                * Same logic as fw_load_abort, only the DONE bit
>>>>                * is ignored and we set ABORT only on failure.
>>>>                */
>>>> -            list_del_init(&fw_priv->pending_list);
>>>>               if (rc) {
>>>>                   fw_state_aborted(fw_priv);
>>>>                   written = rc;
>>>> @@ -513,6 +511,11 @@ static int fw_load_sysfs_fallback(struct 
>>>> fw_sysfs *fw_sysfs, long timeout)
>>>>       }
>>>>       mutex_lock(&fw_lock);
>>>> +    if (fw_state_is_aborted(fw_priv)) {
>>>> +        mutex_unlock(&fw_lock);
>>>> +        retval = -EAGAIN;
>>>> +        goto out;
>>>> +    }
>>>
>>> Thanks for the quick follow up!
>>>
>>> This would regress commit 76098b36b5db1 ("firmware: send -EINTR on
>>> signal abort on fallback mechanism") which I had mentioned in my follow
>>> up email you posted a link to. It would regress it since the condition
>>> is just being met earlier and you nullify the effort. So essentially
>>> on Android you would make not being able to detect signal handlers
>>> like the SIGCHLD signal sent to init, if init was the same process
>>> dealing with the sysfs fallback firmware upload.
>>>
>>> The way I dealt with this in my patch was I decided to return -EINTR
>>> in the earlier case in the hunk you added, instead of -EAGAIN. In
>>> addition to this, later on fw_load_sysfs_fallback() when
>>> fw_sysfs_wait_timeout() is used that would also deal with checking
>>> for error codes on wait, and only then check if it was a signal
>>> that cancelled things (the check for -ERESTARTSYS). We therefore
>>> only send to userspace -EAGAIN when the wait really did hit the
>>> timeout.
>>>
>>> But also note that my change added a check for
>>> fw_state_is_aborted(fw_priv) inside fw_sysfs_wait_timeout(),
>>> as that was a recently intended goal.
>>>
>>> In either case I documented well *why* we do these error checks
>>> before sending a code to userspace on fw_sysfs_wait_timeout() since
>>> otherwise it would be easy to regress that code, so please also
>>> document that as I did.
>>>
>>> I'll re-iterate again also:
>>>
>>>     Shuah's commit 0542ad88fbdd81bb ("firmware loader: Fix
>>>     _request_firmware_load() return val for fw load abort") also 
>>> wanted to
>>>     distinguish the timeout vs -ENOMEM, but for some reason in the 
>>> timeout
>>>     case -EAGAIN was being sent back to userspace. I am no longer 
>>> sure if
>>>     that is a good idea, but since we started doing that at some point I
>>>     guess we want to keep that behaviour.
>>>
>>> Shuah, can you think of any reason to retain -EAGAIN other than you
>>> introduced it here? If there's no real good reason I think it can
>>> simplify the error handling here. But, we *would* change what we do
>>> to userspace... and for that reason we may have to live with it.
>>>
>>
>> As I recall the reason for this patch was to be able to differentiate
>> between timing out vs no memory case when driver was attempting to
>> load firmware. I wish I added why to the change log.
>>
>> The code seems to have changed a lot since my commit. I will take a look
>> at the closely and let you know if this is still necessary late on
>> today.
>>
> 
> Luis,
> 
> I did some digging and figured out why I added this timeout logic. Media
> drivers expect request_firmware() timeout or fail.
> 
> It turns out I have notes saved on this problem.
> 
> When drivers attempt to load firmware while ext_fs is going through
> recovery during boot or resume (after hibernate or suspend), 
> request_firmware() calls fail without this timeout handling leaving
> drivers and devices that need firmware loaded in failed state.
> 
> I added this timeout handling so drivers can retry loading the firmware.
> Several media drivers retry based on the timeoout return. This helps
> differentiate timeout and other failures.
> 
> We still need this logic or at least we can't delete without verifying
> that is indeed not needed.
> 

Doesn't look like this manded in your Inbox?

thanks,
-- Shuah
