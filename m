Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1516C333229
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhCJADz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:03:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56444 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhCJADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:03:44 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12A03ckb041003;
        Wed, 10 Mar 2021 09:03:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Wed, 10 Mar 2021 09:03:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12A03c8u040996
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Mar 2021 09:03:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
 <30a1afb2-d5a4-40b2-385d-24a2bf110e92@linuxfoundation.org>
 <7b9465aa-213e-a513-d033-12c048df15d6@i-love.sakura.ne.jp>
 <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
Date:   Wed, 10 Mar 2021 09:03:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/10 8:52, Shuah Khan wrote:
> On 3/9/21 4:40 PM, Tetsuo Handa wrote:
>> On 2021/03/10 4:50, Shuah Khan wrote:
>>> On 3/9/21 4:04 AM, Tetsuo Handa wrote:
>>>> On 2021/03/09 1:27, Shuah Khan wrote:
>>>>> Yes. We might need synchronization between events, threads, and shutdown
>>>>> in usbip_host side and in connection polling and threads in vhci.
>>>>>
>>>>> I am also looking at the shutdown sequences closely as well since the
>>>>> local state is referenced without usbip_device lock in these paths.
>>>>>
>>>>> I am approaching these problems as peeling the onion an expression so
>>>>> we can limit the changes and take a spot fix approach. We have the
>>>>> goal to address these crashes and not introduce regressions.
>>>>
>>>> I think my [PATCH v4 01/12]-[PATCH v4 06/12] simplify your further changes
>>>> without introducing regressions. While ud->lock is held when checking ud->status,
>>>> current attach/detach code is racy about read/update of ud->status . I think we
>>>> can close race in attach/detach code via a simple usbip_event_mutex serialization.
>>>>
>>>
>>> Do you mean patches 1,2,3,3,4,5,6?
>>
>> Yes, my 1,2,3,4,5,6.
>>
>> Since you think that usbip_prepare_threads() does not worth introducing, I'm fine with
>> replacing my 7,8,9,10,11,12 with your "[PATCH 0/6] usbip fixes to crashes found by syzbot".
>>
> 
> Using event lock isn't the right approach to solve the race. It is a
> large grain lock. I am not looking to replace patches.

It is not a large grain lock. Since event_handler() is exclusively executed, this lock
does _NOT_ block event_handler() unless attach/detach operations run concurrently.

> 
> I still haven't seen any response from you about if you were able to
> verify the fixes I sent in fix the problem you are seeing.

I won't be able to verify your fixes, for it is syzbot who is seeing the problem.
But I can see that your patch description is wrong because you are ignoring what I'm commenting.

Global serialization had better come first. Your patch description depends on global serialization.
