Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAEC348672
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCYBfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCYBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:35:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8DEC06174A;
        Wed, 24 Mar 2021 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AGo/RMTNezhheUtkI8URNy+6PhuTvYtFQE2ScXnP62Q=; b=KaDrh4nqakuEYlQCesxZ5Mf9qa
        Fc3RM5WaCkUuxuIb+Sxr3EZOoYSNDUF0XJfYnjadh0R48lli0Xj/710Yp9jk+ATLMkhcv1meMRCjP
        B1H7b+/y8OOJnzQxz65o690jtrG8ZZjgx9xQfWOqhuCEPV00bWACoh42RLkR8hK9aAQnjoGrBiD6X
        DM5zoDSSj2KwtvRR9vFptuGMNqnTaH80S5J5TtreXGIMW1+S1Pwr0bYL0tHd0zVnT2kbgUDZM6iF1
        /ljKRAKqL248tUaJwk4n96pqrmMzGni9jIKmLUOOnSjQrSTSic/1UD/BWbhJUYD4oI3BOUnlbqFlB
        D2S4Yjkg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPEtt-000RQk-Tx; Thu, 25 Mar 2021 01:35:07 +0000
Subject: Re: [PATCH] tools: usbip: list.h: fix kernel-doc for list_del()
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
References: <20210324000223.22043-1-rdunlap@infradead.org>
 <0af7bfad-fff7-84be-8e7c-2ad3e93fb785@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0064f460-de49-98c8-1448-3489aa036384@infradead.org>
Date:   Wed, 24 Mar 2021 18:35:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0af7bfad-fff7-84be-8e7c-2ad3e93fb785@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 4:32 PM, Shuah Khan wrote:
> On 3/23/21 6:02 PM, Randy Dunlap wrote:
>> In list.h, the kernel-doc for list_del() should be immediately
>> preceding the implementation and not separated from it by
>> another function implementation.
>>
>> Eliminates this kernel-doc error:
>> list.h:1: warning: 'list_del' not found
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Valentina Manea <valentina.manea.m@gmail.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> ---
>>   tools/usb/usbip/libsrc/list.h |   10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> --- linux-next-20210323.orig/tools/usb/usbip/libsrc/list.h
>> +++ linux-next-20210323/tools/usb/usbip/libsrc/list.h
>> @@ -77,17 +77,17 @@ static inline void __list_del(struct lis
>>   #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
>>   #define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
>>   +static inline void __list_del_entry(struct list_head *entry)
>> +{
>> +    __list_del(entry->prev, entry->next);
>> +}
>> +
>>   /**
>>    * list_del - deletes entry from list.
>>    * @entry: the element to delete from the list.
>>    * Note: list_empty() on entry does not return true after this, the entry is
>>    * in an undefined state.
>>    */
>> -static inline void __list_del_entry(struct list_head *entry)
>> -{
>> -    __list_del(entry->prev, entry->next);
>> -}
>> -
>>   static inline void list_del(struct list_head *entry)
>>   {
>>       __list_del(entry->prev, entry->next);
>>
> 
> Thank you for fixing this.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>


Thanks. Who do you think should merge this patch?

-- 
~Randy

