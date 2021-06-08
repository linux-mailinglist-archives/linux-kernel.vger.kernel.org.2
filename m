Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C2739F331
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFHKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:09:49 -0400
Received: from router.aksignal.cz ([62.44.4.214]:60734 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhFHKJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:09:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 6F964423F0;
        Tue,  8 Jun 2021 12:07:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id NB2YPxqvotri; Tue,  8 Jun 2021 12:07:53 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id E0439423EE;
        Tue,  8 Jun 2021 12:07:52 +0200 (CEST)
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
 <YL4S2/hlfRwRM+Ug@kroah.com>
 <56f088fe-8db2-54d4-bef3-72e5f893a414@aksignal.cz>
 <YL8ybqOfgOqjlpoX@kroah.com>
 <b1c0eab3-8d07-5c52-300e-45974f7fea9c@aksignal.cz>
 <YL8+NOdz+ue3MTGg@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <e32ad2d9-f2b3-f5de-54e5-fe43cd5403a9@aksignal.cz>
Date:   Tue, 8 Jun 2021 12:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL8+NOdz+ue3MTGg@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08. 06. 21 11:53, Greg Kroah-Hartman wrote:
>>>> Prints as little endian, is that OK?
>>>
>>> You tell me!  What tool is going to be reading this?  What do they
>>> expect it to look like?
>>
>> sh, php in my usecase as unique id.
> 
> I am sorry, I do not understand.

In my use case: shell and php.

> 
>> So endianess does not matter to me too much. The question is what is usual
>> (like mac address, uuid...?).
> 
> What does the device export?  Why not just export it as:
> 	0123456789ABCDEF
> if it is 8 bytes long?

Yes, device contains 0123456789ABCDEF.

> 
>>> And it's a byte array, why would there be endian issues?
>>
>> Now is printed as one big number. Not real issue. Just human readability?
>> Should I turn back it to space separated bytes?
> 
> It's up to you, what do you want to do with it and what does a tool want
> it to look like?

Right now I export it as bytes separated by space. But no problem to 
change it.
Just asking: for generic users what would be better or is there "best 
practice"?

> 
> thanks,
> 
> greg k-h
> 
