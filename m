Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9857440153
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhJ2Rg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhJ2Rg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:36:26 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69461C061570;
        Fri, 29 Oct 2021 10:33:57 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bi29so10065901qkb.5;
        Fri, 29 Oct 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PYz8amIMiCGzOswnVMPnWhcArdnBZe4XYPwWVEAP4g=;
        b=Z1yHRiySw6moWokSrZHTRWzRgu/4VWnZNY9KU/855rM3/Rm4l42cjTLdgJrrskDhBj
         F0HldJwKCkO0xurugoXJysqVrc9DZi/Dg3Q/bFHblpeY11XegTEr6xvO+PZLhQl/68kU
         DOLsgj1IIqEVcRxGuMHlukP1FoK03Jdk8Ill8vFXXnw9AtdznydE5maA4JnHogV+vzBW
         7stXp/8k0nTzDNbBeOfBzzqYH8gdQ+PuUEL7T5Q1JO3/FC5FjGufiLqZiZnIdahzNXIG
         PYKvSfAhTe+owz4mW4kfYQqN+UitGt35XrPoZx3y2FMiE6W6ZGas0ByDqY0AtmGMQtET
         IlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PYz8amIMiCGzOswnVMPnWhcArdnBZe4XYPwWVEAP4g=;
        b=wOhHj1XBfdMXfwObnADTojVFOfHlRbn46gnJ58+0/wj+Hi8HrGUACcDjupI/nRc0O7
         m3/cc2trMm9nN7kB9hoCBJENUZvXNRpiu2rLvimb6ju3DhTj+xSA10OQG5zTvf6aCEwG
         /FalO9xSepN9LjaFs6kDCgoE5G8DrEZOyy7UaoeRnR7UvYFsR/pLKmgwIuc6Fiby9Kx8
         q9vlCKwjg1PIjZaujETv0WYYwbsAQMWWIGvswUnoAw35A7M5Echv+spEhUP3ZReAtkAJ
         NQCJWeNw04INRSBun1aAslA7qYyKjsmcXh7G7D5oaRS1TNsjJOg182+vejP/DsHDw1e1
         o6UA==
X-Gm-Message-State: AOAM531VliCJTKF+rMAnewpuNUmYItG9RcPuL61vfo5Oq4UHKFkiHu+0
        jIv0PdsiJdHZ9n3jb/a/0OE=
X-Google-Smtp-Source: ABdhPJyu8n7mNnL1HaMwMHht/b6Jv+f1W6V1QFZG6Mq9QcDhDwFjl+1/N7YJDJ4zrVgnRmkvu0Qy4g==
X-Received: by 2002:a05:620a:1707:: with SMTP id az7mr10204906qkb.276.1635528836639;
        Fri, 29 Oct 2021 10:33:56 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id d23sm4405736qtm.11.2021.10.29.10.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 10:33:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: unittest: fix dts for interrupt-map provider
 build warning
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211029005802.2047081-1-frowand.list@gmail.com>
 <CAL_JsqJujq0K9tF+m3qQ5GhC-yo7-vj9HRhF69UmrWA7tZv7DA@mail.gmail.com>
 <e353b41d-48f9-5349-8b89-bafe9ab5101e@gmail.com>
 <CAL_JsqJi8h+DnnZCb-S2apDfMGF6PimQC+ViXB+X0oa4fWPcJg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <de51f09d-1a63-c798-b434-a610b68e592b@gmail.com>
Date:   Fri, 29 Oct 2021 12:33:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJi8h+DnnZCb-S2apDfMGF6PimQC+ViXB+X0oa4fWPcJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 8:16 AM, Rob Herring wrote:
> On Thu, Oct 28, 2021 at 10:07 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/28/21 9:07 PM, Rob Herring wrote:
>>> On Thu, Oct 28, 2021 at 7:58 PM <frowand.list@gmail.com> wrote:
>>>>
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Fix kernel build warning:
>>>> drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
>>>>
>>>> A recently implemented dtc compiler warning reported the dts problem.
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>  drivers/of/unittest-data/tests-interrupts.dtsi | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
>>>> index 9b60a549f502..8c2b91b998aa 100644
>>>> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
>>>> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
>>>> @@ -31,6 +31,7 @@ test_intmap0: intmap0 {
>>>>
>>>>                         test_intmap1: intmap1 {
>>>>                                 #interrupt-cells = <2>;
>>>> +                               #address-cells = <1>;
>>>
>>> Notice that we have 2 nodes with interrupt-map here. One has
>>> '#address-cells' and one doesn't. Why? Because we need to test that
>>> the code can handle both cases.>
>>> The dtc warnings are more what should 'new' users do. I don't know
>>> what DTs don't have #address-cells, but my guess is ancient ones.
>>>
>>> Rob
>>>
>>
>> I had hoped to build all of the .dts files in the Linux tree, with the
>> new dtc, but did not get to that today.  That should flush out any
>> cases that would result in build fail from the new approach of treating
>> all warnings as errors.  I may get to that tomorrow.
> 
> They are still just warnings. You mean the requirement to be warning
> free? That's not new for dts files.
> 
>> If there any any existing .dts files that will trigger the interrupt
>> map warning, will we require that they be fixed so that the build will
>> not fail?
> 
> I already submitted patches for them.

OK, I'll drop this patchk, and instead create a patch that documents
why the unittest .dts is missing #address-cells.

-Frank

> 
> Rob
> 

