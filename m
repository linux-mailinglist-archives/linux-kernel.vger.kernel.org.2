Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14F138F14A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhEXQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbhEXQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:13:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A6C06137B
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:03:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n10so28353408ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y+makYrcDuSPhSPuZ0EEqqg1sVn6shp16zXhBJ/Rew8=;
        b=KBH5hQvPEtCEhGv14dpfsszi8kpfMILLt21IvA/YTxgWvqJ1BJ7UCADVHaxOicwK1r
         6zXNbCVVcaHut1bq7qQYIcmzBZC2Gz46gPp5hMsPV3V1/pJaDzbYhW9BraZYH7ZFN366
         H0GgdNrliVLJ+zE2eapoZ2HTSZWttEcPKgZyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+makYrcDuSPhSPuZ0EEqqg1sVn6shp16zXhBJ/Rew8=;
        b=C2q1PDGrwRkrOP+H2jmZZarDZ1Ndw0PlBuu15+YyGTSet0xmB3ItXxQB1AOrGOOa4Z
         4mv0nAvToI8cI/rUohyvWO5AFCVQ6QUplcoI+2ANGlFRl6zq8oRUH5zWpReMQwXgVXJQ
         +STgDXiE0XlXB+XhY/yp+E7R6SfWFoEacnPCwt+nE5d1gJiF42waaInOGfKzQ0B1o2RF
         AW9ri0scBTrcOdObK4UdGPltUEnDjKY01bo89wEwJgKE/U0fPVfE5gK9N5SU2Ysk41GL
         X1mxZ3CGVmZY3mmfuxtLYFWQgBfKtZlfXRA3DK9mUa89INXfbvc0Qu6qUSMuNZrxLqLR
         BNJw==
X-Gm-Message-State: AOAM532gks/9jWVkORuhFtV4yYuJngJtLsgOAWR/bjvkUaNWJ6n3rvMX
        JVPG9NXwrdbKBucxJxosPvDXSw==
X-Google-Smtp-Source: ABdhPJz5MJ70Nkg/qkrgOLmpw9nbJ2fJBmUNkV513TIUQLJJY6P35O662hMDlfPmboL6i9jb3xIZXg==
X-Received: by 2002:a05:6602:1695:: with SMTP id s21mr13947732iow.29.1621872218516;
        Mon, 24 May 2021 09:03:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j15sm11444495ilc.53.2021.05.24.09.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 09:03:38 -0700 (PDT)
Subject: Re: [PATCH v2] kbuild: replace LANG=C with LC_ALL=C
To:     Masahiro Yamada <masahiroy@kernel.org>,
        patchwork-bot+linux-kselftest@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210430015627.65738-1-masahiroy@kernel.org>
 <162162208791.14477.6963689219198766644.git-patchwork-notify@kernel.org>
 <CAK7LNAST-2CDycoAsKEmVw-56um7HHs07smaWemsOsL8eo+F6w@mail.gmail.com>
 <CAK7LNATWFLTKYBg6OOc5JQeb5mZXjUXqo0GNU3vAqVrwfcqDew@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <80462279-ac70-719e-6bbd-80b6bb0d9340@linuxfoundation.org>
Date:   Mon, 24 May 2021 10:03:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATWFLTKYBg6OOc5JQeb5mZXjUXqo0GNU3vAqVrwfcqDew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 8:22 PM, Masahiro Yamada wrote:
> On Sat, May 22, 2021 at 11:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> On Sat, May 22, 2021 at 3:34 AM
>> <patchwork-bot+linux-kselftest@kernel.org> wrote:
>>>
>>> Hello:
>>>
>>> This patch was applied to shuah/linux-kselftest.git (refs/heads/next):
>>>
>>> On Fri, 30 Apr 2021 10:56:27 +0900 you wrote:
>>>> LANG gives a weak default to each LC_* in case it is not explicitly
>>>> defined. LC_ALL, if set, overrides all other LC_* variables.
>>>>
>>>>    LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL
>>>>
>>>> This is why documentation such as [1] suggests to set LC_ALL in build
>>>> scripts to get the deterministic result.
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>    - [v2] kbuild: replace LANG=C with LC_ALL=C
>>>      https://git.kernel.org/shuah/linux-kselftest/c/77a88274dc1a
>>>
>>> You are awesome, thank you!
>>> --
>>
>>
>> Huh?
>>
>> This patch exists in Linus' tree.
>>
>> Why is this going to the kselftest tree
>> in the first place?
> 
> 
> Sorry, I misunderstood it.
> 
> I think this notification was unneeded
> because the commit was not actually
> applied to kselftest tree.
> 

When I rebase kselftest tree, patchwork-bot generates this unnecessary
notification. I have been procrastinating looking into how to disable
this. This confusion is a good enough reason to get to it asap. :)

thanks,
-- Shuah

