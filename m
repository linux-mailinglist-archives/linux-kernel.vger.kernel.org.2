Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6389F45959A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhKVTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhKVTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:31:41 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D4C061574;
        Mon, 22 Nov 2021 11:28:34 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so40009533oiw.0;
        Mon, 22 Nov 2021 11:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WaXZ5YfAt8Wv9tvUublQrY49/hBZPfZUJxK7rCdY/0k=;
        b=RTmsNMUAbT5XUlor7StW0QWtHJMYAm3iJOSC+C1xBMI5lMzrjDNixXXbudVZ8mmRUe
         7c1D5FEDk2lHbCi1R3U7NWG3aI4Eopivi9jijQJPCW2XErx3U/Lkc8fWLyaucmWg6VWk
         Kpz3ILFIDtsEhIppAG7GQ6ja4T2YL0W9zlWyXebSARtWXVKb5QTfvcY4DmHQYkWc5rir
         eCWq2P3PapaZxoT6WBsD8P+qpJ4RhtiACYfRIh8nl+DwFnOspQVkJx/6QXswNFSZREQx
         03u5ds5/JAlUity6fXZnAFHkcujuYSLrg+4RAZDPJrtoXhp8fi+vFi2Ia9M+Hsl3NPQ9
         m3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WaXZ5YfAt8Wv9tvUublQrY49/hBZPfZUJxK7rCdY/0k=;
        b=N6PzLYLCZZl++3NWPaHcz5c+EOjoh3ATLF5QOx3TiuAJky5B7Q1+GtO1FpNpWdXWZW
         q1FxSRWjj8hFxNFbxs7f008XTZQ9U8c8099AIIniI67lPl8RhKG3pSGnbs7oO6fIldj6
         vXv9Ha9mpX5C1GZbqrlQkt0cGiGM/mCV0P0+iTeqBkbr6mMVs8ipWyvKyuzEwTGrNxZn
         2AdMZRD8GfmJmPoqtfarxA9X/bUsJM0MVHXTSnpCIKueAkgN5Rxi0E3xtSTztaJllXxq
         cjD9ARLloKjnUTW9pfF5xQdJJZO/VSRnffR7zyxBQWZWFpIixgmD3tj3FyUtL2qgVlF5
         5zVA==
X-Gm-Message-State: AOAM53325TM9WounNBPn/FXuA/DmcWwzInK0DalJUiMZFe1m8Ls4EfdG
        wvkSo+Nem0xTFicRKqK6hJxbCXbUnlA=
X-Google-Smtp-Source: ABdhPJy+4RfX4vQWUgO82u8NIDH8qKEvWQiaR94u2RxEbPNobtzXbnFi6rOr2Zsr3o/3CPedZkyM4g==
X-Received: by 2002:aca:230b:: with SMTP id e11mr23608236oie.22.1637609313478;
        Mon, 22 Nov 2021 11:28:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6sm2092805oic.39.2021.11.22.11.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 11:28:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
 <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
 <20211122191008.uw2tk4orb7p2elb7@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b73d5a00-ecce-0517-4fb5-4af451e1facb@roeck-us.net>
Date:   Mon, 22 Nov 2021 11:28:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122191008.uw2tk4orb7p2elb7@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 11:10 AM, Pali Rohár wrote:
> On Monday 22 November 2021 19:50:14 Armin Wolf wrote:
>> Am 22.11.21 um 18:55 schrieb Guenter Roeck:
>>> On 11/22/21 8:01 AM, Pali Rohár wrote:
>>>> On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
>>>>> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
>>>>> with i8k_mutex held. Judging from the hwmon code, this mutex
>>>>> only needs to be held when setting the fan speed/mode.
>>>>
>>>> Really? I think that there is no difference between setting and getting
>>>> fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
>>>> not need it. Some more explanation is needed...
>>>>
>>> I8K_SET_FAN sets the fan speed and returns the current status. Without
>>> locking, the returned status may not match or be associated with the
>>> previous
>>> set operation.
>>>
>>> Maybe that doesn't matter, and the synchronization is not needed. If so,
>>> you can probably remove the locking entirely.
>>>
>>> Guenter
>>
>> That is the reason i kept the locking code. Since i do not want to break
>> the ioctl interfacein any way, removing the locking code seems too risky
>> to me.
> 
> I see. That is a good point.
> 
> But there is same race condition also when at the same time going to
> change speed via ioctl and also via hwmon sysfs.
> 

I thought the sysfs code does not change the fan speed and report the
fan status in the same request. Did I miss something ?

Guenter
