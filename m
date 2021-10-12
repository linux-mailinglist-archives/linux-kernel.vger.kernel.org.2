Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32A42AE21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhJLUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhJLUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:47:55 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51BDC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Xzl/CYJXdKNUD7Qf3m8dh46hW/nSMlJGQPPY+m51oJY=; b=bR7pyLnkH5bvpPGOiIJf83baT6
        dztcEDZvqduwgPfkVb9ElLt99UKviIOnHP8Z6O++qBsoz4augy+EhfHJ2T5M+zZRctGA/4cVUEUAD
        LIeSq+c3hzatSFMKBXx2xVQUVKCz36B1YeGwkshOqII+wheaV1GBjz1CEbhKW/gZryTW7MESCPUym
        iaHoRBEd/UqxdzsJr5kHI0hLvKAO6Pk074flx5KqoYc2XEAi7bwstG/UBplcLo4gJrJEqV+EO7X/t
        9UpT4s5Yy5VWr2wXwRIe38/LKgmjIQ0dn6IEf+x9wLqhH7bg3IzRX5LrqcytQjDhcYr9NgKwrNGpf
        HdyDhtyg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maOen-00DxLc-7A; Tue, 12 Oct 2021 20:45:53 +0000
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
 <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
 <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
 <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com>
 <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
 <d02ef168-e105-27b6-0456-6db590807dcb@infradead.org>
 <CAK8P3a2Ox4s7WbSueR85TvkPzt7R46MQL=yBXw2VBy1HK4wduw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50086e69-0a58-147c-e9b6-f0303eabd921@infradead.org>
Date:   Tue, 12 Oct 2021 13:45:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Ox4s7WbSueR85TvkPzt7R46MQL=yBXw2VBy1HK4wduw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 1:42 PM, Arnd Bergmann wrote:
> On Tue, Oct 12, 2021 at 10:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 10/11/21 11:44 PM, Arnd Bergmann wrote:
>>> On Tue, Oct 12, 2021 at 7:54 AM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>>> On 10/11/21 9:37 PM, Arnd Bergmann wrote:
>>>>> On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>>>
>>>> Otherwise it's mostly CRC32 and a couple of odd ones like this that I've
>>>> seen so far:
>>>>
>>>> ERROR: modpost: "dell_privacy_has_mic_mute"
>>>> [drivers/platform/x86/dell/dell-laptop.ko] undefined!
>>>
>>> I have a patch for this one that I should send out.
>>
>> I sent a patch for that. Hans de Goede replaced with:
>> [PATCH] platform/x86: dell: Make DELL_WMI_PRIVACY depend on DELL_WMI
>>
>> <20211011132338.407571-1-hdegoede@redhat.com>
>>
>> so no need to send your patch.
> 
> Unfortunately there is still a related problem that remains with
> "DELL_WMI=m && DELL_SMBIOS=y", and another one with
> "DELL_WMI=m && DELL_LAPTOP=y && DELL_WMI_PRIVACY=y".

OK.  That probably would have been fixed by my patch (just guessing here),
but Hans decided that it wasn't needed.


-- 
~Randy
