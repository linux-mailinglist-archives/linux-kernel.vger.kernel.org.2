Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB838354F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbhEQPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbhEQPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:06:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2DC08EAE9;
        Mon, 17 May 2021 07:24:22 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso5670713ots.10;
        Mon, 17 May 2021 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wP0qVRRFLaqKdNsvIebHqzMAQA0sHv3p78V+XQan4IE=;
        b=SIIetbEYExbcUM1QfmpytUTa2IVHHxjrX5L6JO2j1xRF6GNf1rzKAyM40K3Hi5hYwf
         REzXM3GmnmYKtfOC3JTzd+8Q5wzYuan+AmqRuwrgoXOPPqC9S/ccK8CLcBCIZT7ro76q
         vdQ4N0tLO/zXJP4b5wg1VMck/JcqcLbL+m0YijN1z9Wy4KH1jVjVXeFNlbqjhBuEZpFL
         clyJPWEn6AwkURWyVxA9BsFa3GCFHCy/9/3s1au+ksMHEydPpvbnXHqdH34qXED252Fr
         3ipPzVpKQiT02tYGuDwi4Puho9+BjNndIhyvsV44R5iSoKNE4kJ2qajjZsijf8TctP+u
         qB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wP0qVRRFLaqKdNsvIebHqzMAQA0sHv3p78V+XQan4IE=;
        b=osMoT7u9T5fXUzO5HXAqTH1oLoA5zd5l+57LBKYBRAZOZY5Ph3o4owJ/0b/DQMa/zo
         J9cxcUmHpxFLryZEnhKC1elFv9BOcHOmAtoXI/7Trj54YSGtFdMnOfIsi6CBy5JJIHeo
         iIZEQCvxv2lLclDr9+siCCpmakBN6lVU6jWv67oqDHw7cESaGJEnNSDp5bbpvYWCH+N7
         duojR+cZN2zqlf2QBvueN5gzxxu5J6m0U5J9748S4ziAe/f4NWovf9/kuYXLBIRhNTl9
         5iYAhF5vo7PM2yBTWBEe1Vo38S9tgC/I8wYWC86gVyxeaNamolO/rgBw0/OdT7F/NpCY
         PH0w==
X-Gm-Message-State: AOAM533YJjx3Z8vU1/EKkOIuWoLCUx/2pxDNGvlyv8qt/FJqSMwtug0s
        q3aXOOMVgYxHHUCv3BJK9zY=
X-Google-Smtp-Source: ABdhPJxdOLV4H8+0nYsjoYe7S0t3PHTaJfdsTy6vFeUExppMn/WtX8UkSoPTI9j9rQzIApvCTHBZWA==
X-Received: by 2002:a9d:4e88:: with SMTP id v8mr28025140otk.110.1621261462130;
        Mon, 17 May 2021 07:24:22 -0700 (PDT)
Received: from [192.168.99.80] (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id 19sm2728380oiy.11.2021.05.17.07.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 07:24:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] usb: early: Avoid using DbC if already enabled
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Jann Horn <jannh@google.com>, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1620950220.git.connojdavis@gmail.com>
 <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
 <8ccce25a-e3ca-cb30-f6a3-f9243a85a49b@suse.com>
 <16400ee4-4406-8b26-10c0-a423b2b1fed0@gmail.com>
 <ddb58cbd-0a72-f680-80f4-ce09b13a2cee@suse.com>
From:   Connor Davis <connojdavis@gmail.com>
Message-ID: <55325db1-b086-fc81-9117-6560c4914a12@gmail.com>
Date:   Mon, 17 May 2021 08:24:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ddb58cbd-0a72-f680-80f4-ce09b13a2cee@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/21 8:13 AM, Jan Beulich wrote:
> On 17.05.2021 15:48, Connor Davis wrote:
>> On 5/17/21 3:32 AM, Jan Beulich wrote:
>>> On 14.05.2021 02:56, Connor Davis wrote:
>>>> Check if the debug capability is enabled in early_xdbc_parse_parameter,
>>>> and if it is, return with an error. This avoids collisions with whatever
>>>> enabled the DbC prior to linux starting.
>>> Doesn't this go too far and prevent use even if firmware (perhaps
>>> mistakenly) left it enabled?
>> Yes, but how is one supposed to distinguish the broken firmware and
>> non-broken
>>
>> firmware cases?
> Well, a first step might be to only check if running virtualized.
> And then if your running virtualized, there might be a way to
> inquire the hypervisor?

Right, but if it was enabled by something other than a hypervisor,

or you're not running virtualized, how do you distinguish then? IMO

the proper thing to do in any case is to simply not use the DbC in linux.

Thanks,

Connor

