Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719EA3F6345
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhHXQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhHXQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:51:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F780C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:50:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so21179654ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wnJLmDQpwuCqmlXZqmbQNE5CdhWiVCeYL5fmov+jPQ=;
        b=Cq0fO4jvWCmNgiGilupCwBZ2tfiVRhKAEoiGtovZjenwmX9//DacVdrdYr70cOKjdt
         k+IEENvoo4egWQXg9ihuqGfNLtksAN/nL2E2ohO4U4tXsoppZINewj7UL2jGDIQiWf3G
         aRg439BxgGKzu2DKKGWnjSVYfB8d9d23KLXQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wnJLmDQpwuCqmlXZqmbQNE5CdhWiVCeYL5fmov+jPQ=;
        b=jkUyyqk4aCZXjK6h2RXKOUSNSmterINzDz+vxh3Ogsg3halowEv3lwKXKSG7XmPfp3
         rw50sIa9eSBuwcNjSQ0TfND/RxEdM4MeP1mb0YxyYsug4mRycx64P0lmZ0gaf7Z6OAZY
         DKx2UdgNshbkUsq09XbYSdKYbVQUxUir5NrQ8rkHFKdOF93YdX/61k/u9ZonQBKysNtl
         2rI2QNQ8cnNy+Y8kIpuKvGs0TUn4oCzj+TkSRhe3CoBQ6OoV64Yu49zSNlOmkf0yqmYT
         zXdiAzalGR5+5yF0Fv+6r8oRuE+/yGVQuKyjm0KaoM2Ja/wxCAZ5bKCbtGJXhAbFAZcr
         Zv8g==
X-Gm-Message-State: AOAM532gIRuHSc84WBqca4LrXkozZ11OuqD4Z2ebzCqoRXuDLnYq4Byx
        eITSk2ZG1/g3YVx0yMSjEKNb3Q==
X-Google-Smtp-Source: ABdhPJydHPCaEnl3IkA8mTycs0cxZYQP9Ymnmlz/K/UoonbCL0bLKLGni/gwJHR1eYvfFVZ2P0G6Og==
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr27240637ils.102.1629823824918;
        Tue, 24 Aug 2021 09:50:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c23sm10333329ioi.31.2021.08.24.09.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:50:24 -0700 (PDT)
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
 <20210824112129.2t6lzqyf2dxllw4a@senku>
 <20210824113619.a3gyxlerst7tumzn@wittgenstein>
 <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <15672b09-e4fc-78ec-7415-1ff7b777cc15@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 10:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 8:33 AM, Shuah Khan wrote:
> On 8/24/21 5:36 AM, Christian Brauner wrote:
>> On Tue, Aug 24, 2021 at 09:21:29PM +1000, Aleksa Sarai wrote:
>>> On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>> Hi Baolin,
>>>>
>>>> On 8/22/21 8:40 PM, Baolin Wang wrote:
>>>>> Hi Shuah,
>>>>>
>>>>> On 2021/7/28 20:32, Baolin Wang wrote:
>>>>>> Hi,
>>>>>>
>>>>>>> When running the openat2 test suite on ARM64 platform, we got below failure,
>>>>>>> since the definition of the O_LARGEFILE is different on ARM64. So we can
>>>>>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>>>>>
>>>>>> Sorry, I forgot to copy the failure log:
>>>>>>

Please send me v2 with failure log included in the commit log.

thanks,
-- Shuah

