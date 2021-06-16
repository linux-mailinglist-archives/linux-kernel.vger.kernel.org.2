Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDE3A9E59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhFPO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhFPO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:59:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:57:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d11so672704wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rvetSlkkqInISiQ3E1W6LW6br/lG3D9UNXnoAqlcJPY=;
        b=QkIFa+7O4pQtkpMjRtb+N5dtMfla8Hh4MXmvddTbpLjenVcRymif/6HkFXMok1fYCs
         9M9zJPTe00B9UcAK+ZRH9/2+1elrzmxhlypvhH5+xCnQN7tZGlEn13xOHXbqQLvYuzlJ
         Uucs+gPrjgj2oiG6okSGD6RZKjxA9k3uImem0WGq43vvPZ8bOReQl1oqsW+vXJK/zF97
         pdno9zuIM24yXb/ghEGaqC2pyhqWbvKLCPvDt2dj+j8cqC+SYUGHV2n0NrVgj1O3ZfMa
         hH47rvUML/FlLi0odzdncZGD5+O4CfNFCubCRQMBwarJpCC/13NLIIwKO5AcxwPtRyhO
         2FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvetSlkkqInISiQ3E1W6LW6br/lG3D9UNXnoAqlcJPY=;
        b=TrrCzfDNE6CaK1OSxciGbGWZir7e1Hw68QyWjmtNg27Gw8v/bcSXie7M6lyws8/wSw
         ffU1heZXOaDA6J+YTRiYSEpSTgGN5UCPrEhBop0aznpdeCozs7OKZIiVqZ2vIevk4aQj
         RJQiQ5Ss5sQxDkprTSrEZfqLySm1hb83n/rtPXnvTmzwz+dYHz4paHdLwlq8URTqYEZM
         U3ormuq8EqFQd5Ng9hObPnMKsVdzSglTfL27PTf7zRfAxrevVsn1X1/Devdik0VkVV35
         5k3uGYV2lLksYNM2Y5jMy4N9zONbf1QZdspNWUT8YPtT6UqKyyIarEO3v/2w/8qyXta0
         5RKg==
X-Gm-Message-State: AOAM531tyW9/o8gV2vUhKzhHNvS2Nv49biF8Q1fztLFtuEqnfZb+HUKj
        SqvTSYOINIvKJyUCWqBII7BpSYfoZGr+oP5G
X-Google-Smtp-Source: ABdhPJxUDjZqTxXovHGUu65GRbVwrAamIXJBmHs/kYqIvanORi4r9lzxCBxlvo1ZIOLHGKJpeQu59A==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr5893424wrv.322.1623855461550;
        Wed, 16 Jun 2021 07:57:41 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id c12sm2727125wrr.90.2021.06.16.07.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:57:41 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clocksource: Ingenic: Add SMP/SMT support for
 sysost driver.
To:     Paul Cercueil <paul@opendingux.net>,
        =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com
References: <1622824306-30987-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1622824306-30987-3-git-send-email-zhouyanjie@wanyeetech.com>
 <8ESHUQ.VB8PTX94HN193@crapouillou.net>
 <28c290db-d382-ac96-62c9-cf38fd367714@wanyeetech.com>
 <GPNJUQ.ZA1NJ09Y47YY2@opendingux.net>
 <20210612234243.69b68d7e@zhouyanjie-virtual-machine>
 <QEAPUQ.HGLUYKP0W4ZH@opendingux.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f1f6562d-d871-ffeb-e058-0891d6ab4ec8@linaro.org>
Date:   Wed, 16 Jun 2021 16:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <QEAPUQ.HGLUYKP0W4ZH@opendingux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 14/06/2021 18:42, Paul Cercueil wrote:
> Hi Zhou,
[ please trim ... ]

>>>  >> The DT documentation only mentions one memory resource. Here, you
>>>  >> map a second one, which is not used anywhere. I'm really confused
>>>  >> about what you're trying to do here.
>>>  >>
>>>  >
>>>  > X2000 and X2100 divide the OST into two parts. The global timer is
>>>  > the first part, which is still located at the address of 0x12000000,
>>>  > and the percpu timers are the second part, the starting address is
>>>  > 0x12100000, and each timer is offset by 0x100 (percpu timer0 is at
>>>  > 0x12100000, percpu timer1 is at 0x12100100, percpu timer2 is at
>>>  > 0x12100200, percpu timer3 is at 0x12100300). This one is used in
>>>  > line 593 of the code.
>>>
>>>  Then you need two different DT nodes, one at each start address.
>>>  Either use different drivers (since the register sets are different),
>>>  or *if* it can be implemented cleanly in ingenic-sysost.c, different
>>>  compatible strings - one for the global timer and one for the percpu
>>>  timers.
>>
>> Sorry, I did not describe it clearly. Although the global timer and
>> percpu timers are divided into two parts, they still belong to the same
>> hardware module. The base address of the entire module is 0x12000000,
>> but the control register of the global timer is not shifted. The percpu
>> timers are shifted by 0x100000 as a whole (the situation here is
>> similar to PDMA, which is also divided into two parts: the
>> channel-related registers are not shifted, while the system
>> control-related registers are shifted by 0x1000 as a whole). I think
>> maybe we can follow PDMA's approach and add corresponding instructions
>> in the DT documentation. This can avoid confusion caused by splitting
>> different parts of the same hardware module into two nodes, and at the
>> same time keep the code of the devicetree as simple and clear as
>> possible.
>>
>> What do you think about that?
> 
> Looking at the programming manual, these are not the same hardware
> module. They are on different addresses, are functionally independent,
> and are even described in different chapters of the PM; so I stick to
> what I said earlier.
> 
> Cheers,
> -Paul
> 
>> Thanks and best regards!
>>
>>>
>>>  -Paul

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
