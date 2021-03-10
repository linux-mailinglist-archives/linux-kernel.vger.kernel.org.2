Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3324C333254
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCJA3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCJA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:29:04 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9517C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 16:29:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id t16so14707901ott.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YCFqenVwgnCmAUoeefLo2iVv6XxOeskoCaYYAzv0TRA=;
        b=gIkwjcO/KoP+cwZtxXlX5WIlpIpsCBmYJyT7yi+Wk58xdUnKN9E/uYybEjSsdRVOiS
         30YeghMqtLpBhy0Ni52K/+iabei4ZEzECEGl4UHJ2NkwPcA7q3XGe3yUTMIoZxEWckef
         79fCtCVcDZYjkSH4nHWfocrayc5VSJDCu7SHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCFqenVwgnCmAUoeefLo2iVv6XxOeskoCaYYAzv0TRA=;
        b=lVvHXRDj90AxS+MBzPVk+tLRZ0xVBCnbsuHInGgY/JNNZFSSHqgM7bYx8Cw1h5g3w9
         6ZBciQtELK6OuBADc9hIZV2tQa2GFliQM8JiTjg5VRu6rFCf1IwJSyAVyQLmXo8TeKDZ
         JOfSZ+WgE4LX4czMGNqRRWhQhbE63QTYXOxJc9kPQ8aUImb1CLORlH/d2rtYZ3gPYdHh
         LZ0R+RJDSRIrca9UyT8EYPB/TtgTIjMx0Us9BsSOxZ4agXTiUCaksGK9MDjSn2L6h5fG
         JQcvazEd2RGZAIdLI5hHNLCi+lDmsApP0ScsyMYdZ1cKpbcTMBGsCCpFc1yoB0Q/EPjV
         J3vg==
X-Gm-Message-State: AOAM5326kSHvVkM5raCB67zfx6CiVuLlJaUF78RJ86yjaN2i5uSZ4SlA
        IuZBCBlIBFR5Kr0WhaorFsPWWw==
X-Google-Smtp-Source: ABdhPJw7TybX5+FL0pbTYdm39ZmmBuRtKJBvI5JnKZpZOuJeir3SGXJKLHPRdCGCKsjetEDFFQBC1Q==
X-Received: by 2002:a9d:640b:: with SMTP id h11mr614458otl.224.1615336144055;
        Tue, 09 Mar 2021 16:29:04 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s21sm3319980oos.5.2021.03.09.16.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 16:29:03 -0800 (PST)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
 <30a1afb2-d5a4-40b2-385d-24a2bf110e92@linuxfoundation.org>
 <7b9465aa-213e-a513-d033-12c048df15d6@i-love.sakura.ne.jp>
 <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
 <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1edb9542-59c9-bbf6-9f16-99614605a800@linuxfoundation.org>
Date:   Tue, 9 Mar 2021 17:29:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 5:03 PM, Tetsuo Handa wrote:
> On 2021/03/10 8:52, Shuah Khan wrote:
>> On 3/9/21 4:40 PM, Tetsuo Handa wrote:
>>> On 2021/03/10 4:50, Shuah Khan wrote:
>>>> On 3/9/21 4:04 AM, Tetsuo Handa wrote:
>>>>> On 2021/03/09 1:27, Shuah Khan wrote:
>>>>>> Yes. We might need synchronization between events, threads, and shutdown
>>>>>> in usbip_host side and in connection polling and threads in vhci.
>>>>>>
>>>>>> I am also looking at the shutdown sequences closely as well since the
>>>>>> local state is referenced without usbip_device lock in these paths.
>>>>>>
>>>>>> I am approaching these problems as peeling the onion an expression so
>>>>>> we can limit the changes and take a spot fix approach. We have the
>>>>>> goal to address these crashes and not introduce regressions.
>>>>>
>>>>> I think my [PATCH v4 01/12]-[PATCH v4 06/12] simplify your further changes
>>>>> without introducing regressions. While ud->lock is held when checking ud->status,
>>>>> current attach/detach code is racy about read/update of ud->status . I think we
>>>>> can close race in attach/detach code via a simple usbip_event_mutex serialization.
>>>>>
>>>>
>>>> Do you mean patches 1,2,3,3,4,5,6?
>>>
>>> Yes, my 1,2,3,4,5,6.
>>>
>>> Since you think that usbip_prepare_threads() does not worth introducing, I'm fine with
>>> replacing my 7,8,9,10,11,12 with your "[PATCH 0/6] usbip fixes to crashes found by syzbot".
>>>
>>
>> Using event lock isn't the right approach to solve the race. It is a
>> large grain lock. I am not looking to replace patches.
> 
> It is not a large grain lock. Since event_handler() is exclusively executed, this lock
> does _NOT_ block event_handler() unless attach/detach operations run concurrently.
> 
>>

event handler queues the events. It shouldn't be blocked by attach
and detach. The events could originate for various reasons during
the host and vhci operations. I don't like using this lock for
attach and detach.

>> I still haven't seen any response from you about if you were able to
>> verify the fixes I sent in fix the problem you are seeing.
>  > I won't be able to verify your fixes, for it is syzbot who is seeing 
the problem.

Thank you for letting me know.

thanks,
-- Shuah

