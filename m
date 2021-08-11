Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAAF3E97ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhHKStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhHKStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:49:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8775C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:48:52 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so1782115otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vnWMVNHKYEEeZ37C83kTGsgTXsBJBBrZvQ8KfTHY4Zs=;
        b=gz+0atFneoycooO1m9dLELLImmYCE2ILiC9wwR6svjAcqs7Ap3v+BXwTxDV/CRCt3m
         CQgsMLbSook3vXEQeOPMPSdcl73w1GB6E505eLf/FaWHeKXp7CPMoCROq7vDHlfdnbO8
         m7BLmdDqyjVwTYh2gvPOjJqHxMf3HgNP49rWUd/kJXh+ZWyHaVSx8rc2lP6a3f2NwPkq
         om8mjdHlbCpFUKVzj5OG/jWFbBbZdHE4v2L8VBAF3PhRPVdtHMlecZX8XdPTURPwVOdq
         6JxYu4FkQ9Ngizgp7/vG1xRk4UnAYnBjLM48bXZY0mwpKBDrN9mEokELEid5939bB60e
         24aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vnWMVNHKYEEeZ37C83kTGsgTXsBJBBrZvQ8KfTHY4Zs=;
        b=TAGM94lKwaUcK2F+EBavxSlI2AkHmjcp0cdxqSOUadFZhErf0FDVozUR734jrbyXcQ
         uwOrtNeebR7d7Pk2LGTeWcc66gOsq0/yz7HiP+lMQlHPJHOYfk+96XbycQEkGkR0a8gU
         uJdCSuJQcALoJ7jhf3P2OhJHDPqcCRwLxag0UvS+CLwd8UuArAcOhbLIky+ukVG7+1HI
         OEx94MTYqvCfeS7gBZYaL3Pfm+Hg1I478sXpp9GlJZH2ryqSyWqfIjLK3TnC7lVdS+wi
         RL60OgpTyGzlbWjD1KvP/xz53w0qJR214JFx9QEkevzGcCRaKszxG2TmtaKHwjFJA48r
         Y6OA==
X-Gm-Message-State: AOAM530uMANs51fBQ8SjlfIXOXtaZPP6hBqBodyFC3giklliufTvXLki
        fzS70YNSkqMTuhzGCDgVQKZr2DTbOGvDQw==
X-Google-Smtp-Source: ABdhPJyOR5e7XHLhqPPGLNslcO5qqQqeQg9c1mVjiCQUOSkcjKzI+JYT2891DDy/kvZ0R6QN6vmz3A==
X-Received: by 2002:a05:6830:30ac:: with SMTP id g12mr284072ots.209.1628707732117;
        Wed, 11 Aug 2021 11:48:52 -0700 (PDT)
Received: from [192.168.68.112] (192-241-58-140.ip.ctc.biz. [192.241.58.140])
        by smtp.gmail.com with ESMTPSA id d26sm1539553oos.41.2021.08.11.11.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:48:51 -0700 (PDT)
Subject: Re: [PATCH] seccomp: Fix setting number of loaded filters
To:     Kees Cook <keescook@chromium.org>,
        Wiktor Garbacz <wiktorg@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
References: <20210810125158.329849-1-wiktorg@google.com>
 <202108111144.3519134B5@keescook>
From:   Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Message-ID: <96d45778-6011-81e2-2fec-3f07ee8b6e15@gmail.com>
Date:   Wed, 11 Aug 2021 13:48:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108111144.3519134B5@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I was just trying to understand how seccomp works by code reading and 
spotted this bug.


On 8/11/21 1:46 PM, Kees Cook wrote:
> On Tue, Aug 10, 2021 at 02:51:58PM +0200, Wiktor Garbacz wrote:
>> The value is only reported through procfs so this
>> is purely cosmetic.
> Hi,
>
> Thanks for the patch! I thought this had already been fixed, but I see I
> dropped the ball. :( Sorry!
>
> I'll get the original fix landed[1], and add you as a reporter.
>
> Out of curiosity, how did you (or Hsuan-Chi Kuo) find this? Broken
> behavior, code reading, static analysis?
>
> Thanks!
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20210304233708.420597-1-hsuanchikuo@gmail.com/
>
>> Signed-off-by: Wiktor Garbacz <wiktorg@google.com>
>> ---
>>   kernel/seccomp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 057e17f3215d..6469eca8078c 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -602,7 +602,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
>>   		smp_store_release(&thread->seccomp.filter,
>>   				  caller->seccomp.filter);
>>   		atomic_set(&thread->seccomp.filter_count,
>> -			   atomic_read(&thread->seccomp.filter_count));
>> +			   atomic_read(&caller->seccomp.filter_count));
>>   
>>   		/*
>>   		 * Don't let an unprivileged task work around
>> -- 
>> 2.32.0.605.g8dce9f2422-goog
>>
