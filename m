Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30040BF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhIOF4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbhIOFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1502C0613E3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=rbwUWma8B1g9oTXxJCVoQqeUm06Xy2UnlZlesTTDLsI=; b=QDa92s4U4eRnInRnhAnkcOThUg
        6sBiPAJ5mn1lLiA4R7FGbMTC/saHq8Qr1FVswQVhgQ0sT1QH7qJkmVLMO59oJPBEkVc0/Xtd/KdBV
        9ZVnG+Ivgp2r9gCpC2ooKgHuEQ46IJDbc9fmDcw2JIGr4U0fjShAivIbAKYrjcSLHbEREgPp6Cd2t
        gGzH1WbOa2g4pkxX5tXXaTIqmQlgEUa+RMOnftcaEkJJbwq5+9CLB7OlLzdaeYW8nNg/kdfBlOrhH
        +dWM7hHkCdb4cP4ngyK9pc+U4J/CItQVcvDs6yefKGOm1R/9r6oo3BJfQRmfqk0EiAV+jmwC8bqrG
        ralWX3VQ==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQNsN-0087sN-RB; Wed, 15 Sep 2021 05:54:31 +0000
Subject: Re: [PATCH misc] misc: Add Renesas Synchronization Management Unit
 (SMU) support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
 <YUBmIWU6HwIjjeXa@kroah.com>
 <OS3PR01MB6593057EA6257006C7228542BADA9@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <YUGG8iPWMLx5vJ1f@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b78ebf7b-ea01-757b-39c4-0dc36e126af0@infradead.org>
Date:   Tue, 14 Sep 2021 22:54:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUGG8iPWMLx5vJ1f@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 10:38 PM, Greg KH wrote:
> On Tue, Sep 14, 2021 at 08:43:44PM +0000, Min Li wrote:
>> Hi Greg
>>
>> Thanks for the review
>>
>>>>   drivers/misc/Kconfig      |   9 ++
>>>>   drivers/misc/Makefile     |   2 +
>>>>   drivers/misc/rsmu_cdev.c  | 239
>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   drivers/misc/rsmu_cdev.h  |  77 +++++++++++++++
>>>>   drivers/misc/rsmu_cm.c    | 164 +++++++++++++++++++++++++++++++
>>>>   drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++
>>>
>>> If you make this all one .c file, the .h file can go away and it will be much
>>> simpler in the end.  And will get rid of the global symbols.
>>>
>>

> 
>>>> +
>>>> +/**
>>>> + * @Description
>>>
>>> What is this format?  It is not kernel-doc :(
>>>
>>>> + * ioctl to set SMU combo mode.Combo mode provides physical layer
>>>> + frequency
>>>> + * support from the Ethernet Equipment Clock to the PTP clock
>>>> + *
>>>> + * @Parameters
>>>
>>> Same here and elsewhere in this file.
>>
>> I was copying the format from xilinx_sdfec.h
>>
>> Is there a place that tells me how to properly document ioctl or can you give me an code example?
> 
> The kerneldoc format should be described in Documentation/ somewhere...

See Documentation/doc-guide/kernel-doc.rst.

-- 
~Randy

