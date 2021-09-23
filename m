Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4841681F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbhIWWif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbhIWWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:38:34 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 15:37:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso10605840otb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e2SqU77jPNHr/sLnMpgcgNkrtlhtvE2vm31vygdVoNE=;
        b=ZicuvJrxv01uRKwuiZDzLe0E9z4T8yiO4f9zeZE3JesTw889LXjF3i+PCNCT32Cs86
         U0x2YsJWiHb18p1CVCdgVVAZyF052oBtvB53f1UzSxxv7/ecbEIEeJ2iBhExtyfEj/3w
         CS36WqnZeO4oVzSEMOzoURPSeAgVvjfxVhC04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e2SqU77jPNHr/sLnMpgcgNkrtlhtvE2vm31vygdVoNE=;
        b=XwELheZjT+dPQv4swR2vTBf+FGNrubsjqI1kvZOJvygKk0ywrgglJ73H5XMKBVY+i6
         bDv2uEaFEgPqFV7O9dduZVnm590JMQIf+CyQoZhWEmeR1tsjuJEZ7pr8iXzjE26Cng8U
         4MrIPoD7ZfzfwYFIcB252F4JT2v2mMEpLBvYO9fOlpdAuUcqKRYlx6rAi44sD9Lt2zHO
         bTQp2Mo01pdlys89VIpO6KaiGzeC+j7TtV8n8YSRABwLUsxBKFzs4vEGo3J7p892vxxa
         G/xNxweQgQsOfkMFgvaM8evHTck2Fov0Dx4nqQWoXmqYNg6Mgyg7lOaZSiqsxVIZnCea
         mIYQ==
X-Gm-Message-State: AOAM533DpLTRFZGinsVvxgXwETU7oyT3hopHmpmRmHjXDBR1uPuNoZYd
        mAtO1fuuCbKB5OiG38FwjInxdw==
X-Google-Smtp-Source: ABdhPJxX1Eamf4gQ8Ma1hMNm5G47PdgRLVvw+yLZamqxiJ47C9Q7b2DJpps12eFoLFvn90/EiVVe5Q==
X-Received: by 2002:a9d:7002:: with SMTP id k2mr1079485otj.206.1632436621662;
        Thu, 23 Sep 2021 15:37:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 12sm1381568otg.69.2021.09.23.15.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 15:37:01 -0700 (PDT)
Subject: Re: [PATCH] module: fix invalid ELF structure error to print error
 code
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210923001442.58278-1-skhan@linuxfoundation.org>
 <YUvtfUHb+8XjEtTf@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <93ef1a42-95e8-a8ec-a551-687fbd73570f@linuxfoundation.org>
Date:   Thu, 23 Sep 2021 16:37:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YUvtfUHb+8XjEtTf@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 8:59 PM, Luis Chamberlain wrote:
> On Wed, Sep 22, 2021 at 06:14:42PM -0600, Shuah Khan wrote:
>> When elf_validity_check() returns error, load_module() prints an
>> error message without error code. It is hard to determine why the
>> module ELF structure is invalid without this information. Fix the
>> error message to print the error code.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   kernel/module.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 40ec9a030eec..a0d412d396d6 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3941,7 +3941,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>   	 */
>>   	err = elf_validity_check(info);
>>   	if (err) {
>> -		pr_err("Module has invalid ELF structures\n");
>> +		pr_err("Module has invalid ELF structures:errno(%ld)\n", err);
>>   		goto free_copy;
> 
> The subject seems to indicate a fix is being made, and I think that the
> bots that pick up fixes through language might find that this is a
> candidate because of that. It is not, and so if you can change the
> subject to indicate that this is just expanding the error print message
> with the actual error code passed it would be better.
> 

I call this a fix because this message should have included the error code
to being with and is useless without it. Having bots pick up is one of the
reasons I called this it a fix. I am debugging a problem that a module is
failing to load, it would have been helpful to know the error code.

> Now, if you look at elf_validity_check() and how it can fail, it would
> seem tons of errors are due to -ENOEXEC. Even a function it calls,
> validate_section_offset() also uses that return code. So on failure,
> you likely won't still know exactly where this failed as you likely
> will juse see the -ENOEXEC value, but that won't tell you much I think.
> 

That is correct. This code path returns error without any indication
of what happened and needs fixing. I can do that.

> So, it would seem a bit more useful instead to add some pr_debug()s
> on the elf_validity_check() and friends so that dynamic debug could
> be used to debug and figure out where this did fail, when needed?
> Thoughts?
> 

I considered adding messages to elf_validity_check() error paths. I would
add them as pr_err() though so that it will be easier to debug. These are
errors that indicate module load failed and pr_err() is a better choice.

It doesn't look like we have access to .modinfo for determining the module
name. This information will be very useful.

thanks,
-- Shuah


