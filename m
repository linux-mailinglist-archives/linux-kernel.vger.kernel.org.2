Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08A138CDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbhEUSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhEUSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:46:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:45:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b7so11036757wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJGJXprpTKILrZaxFSGW7s+yTHWLxKatKlSr8cuQGgM=;
        b=QmC+zfCDoxapBeWsj/1Kp3xCVqHKtdsW7aDJfzuXvw2u2iuNgfMOJEId2VME6+10aT
         phjOwMSbFqAn8PUGnp+zuPQCRR4TPw0hoODk2sB1OGD20bhsthamnTgD17fkBHG4Oiif
         xY9+dUjv5V+DpFbB8BNelqNj1bP47fBcsKurPzJ+OjlPuiQH/l9se8fMYfPpmU+Hpxqr
         kCUlSZS1qCvqoU5jF3aCMNcFJTpvTHavessBjkj0kt2HEZH5IvPNfsqRZvB28bXhRq1q
         9Jvg8+nQVvfjXnota3LZMClvEN0inBRfBuRlsYj+JLlm06jhd6BeW45bXmOQcHKUMiqS
         U3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJGJXprpTKILrZaxFSGW7s+yTHWLxKatKlSr8cuQGgM=;
        b=WemF1XCWaKZQf68plK55qKP4TkmdQya76/HzdChaRvGn8r65hE5+j7O9p7Gy1BRZBX
         M/AeAZTyY4Cr5KsN1zz2skml3UFP719oZ97TDvWzcClVPeueRq5No6MoqMxsOZu9JHpY
         tKRkgN3jJPHTCt6F5dANoyQ3Ff40VgrKOMlHo1zLMsx+AFvW/hfHRc3xehclPNyvE82B
         fZZd8Q1mvDbPCSYK4/f0D4As9/i4l334b/51rN8zvjJEOyk8Hk+XBifkugiNHjrVC2Iw
         d0jTLFg9K+18cQ8IK2efT5lBoPgqly7sJK/lllZWSVeoXDQP2m86PvERS32x7ptaOASr
         s4KA==
X-Gm-Message-State: AOAM532f9vDCvm0JrrU07SnAyxkXGyzimePdOudaN2WSwTs1dUXwjmFS
        ErbXlyPvJVf8S6H0+TbHkuWQm0ENat0=
X-Google-Smtp-Source: ABdhPJySEB2vLauRw1fX4DCpSwxDOz6LEcupt1GWmNV05JV/wqot+4M4OL+ihQJW2Wt9esIvnNuvzA==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr10358192wmb.92.1621622712094;
        Fri, 21 May 2021 11:45:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:3901:4092:a56:60d4? (p200300ea8f384600390140920a5660d4.dip0.t-ipconnect.de. [2003:ea:8f38:4600:3901:4092:a56:60d4])
        by smtp.googlemail.com with ESMTPSA id n6sm326906wmq.34.2021.05.21.11.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 11:45:11 -0700 (PDT)
Subject: Re: [PATCH 1/2] sysfs: Add helper BIN_ATTRIBUTE_GROUPS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
 <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com> <YKVFO4bmW/hkoUnx@kroah.com>
 <1facebe2-1368-9b52-e0a1-f7a6eafc91ea@gmail.com> <YKf+2KY9ssWc999p@kroah.com>
 <YKf+9W1BcLGkVRPF@kroah.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <eec73690-1f86-5e21-bd3f-bb4cffcfedb5@gmail.com>
Date:   Fri, 21 May 2021 20:45:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKf+9W1BcLGkVRPF@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.2021 20:41, Greg Kroah-Hartman wrote:
> On Fri, May 21, 2021 at 08:41:28PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, May 19, 2021 at 09:02:47PM +0200, Heiner Kallweit wrote:
>>> On 19.05.2021 19:04, Greg Kroah-Hartman wrote:
>>>> On Wed, May 19, 2021 at 06:33:14PM +0200, Heiner Kallweit wrote:
>>>>> New helper BIN_ATTRIBUTE_GROUPS() does the same as ATTRIBUTE_GROUPS(),
>>>>> just for binary attributes.
>>>>>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>>  include/linux/sysfs.h | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>>>>> index d76a1ddf8..a12556a4b 100644
>>>>> --- a/include/linux/sysfs.h
>>>>> +++ b/include/linux/sysfs.h
>>>>> @@ -162,6 +162,12 @@ static const struct attribute_group _name##_group = {		\
>>>>>  };								\
>>>>>  __ATTRIBUTE_GROUPS(_name)
>>>>>  
>>>>> +#define BIN_ATTRIBUTE_GROUPS(_name)				\
>>>>> +static const struct attribute_group _name##_group = {		\
>>>>> +	.bin_attrs = _name##_attrs,				\
>>>>> +};								\
>>>>> +__ATTRIBUTE_GROUPS(_name)
>>>>
>>>> Is this really needed by more than just 1 driver?
>>>>
>>> Few more use case I saw:
>>> devcd_dev_groups in drivers/base/devcoredump.c
>>> w1_f3a_group in drivers/w1/slaves/w1_ds2413.c
>>> w1_slave_default_groups in drivers/w1/w1.c
>>
>> Ok, might as well, can't hurt to add this :)
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Oh wait, I'm the maintainer of the other file that uses this, I'll take
> both of these then :)
> 
Even better, thanks!

> thanks,
> 
> greg k-h
> 
Heiner
