Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D747F4467F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhKERfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhKERfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:35:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55955C061714;
        Fri,  5 Nov 2021 10:32:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so8942460pgc.6;
        Fri, 05 Nov 2021 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2OWM37nBksJ7gayzdgOjUg6cXZHlid4wQ9drsluV0C8=;
        b=DQRxCNEXF7tlNikiQLw63G8Y+Dsn+L66+H84HjfKEy4BscuewNUkH2sgfXMLDJHfAn
         70hvD+26uYuolr0JBLTX7LtSCK6egOPeJcWkkXSUqR47XBKqYXNzph3T2TD/mTuAlTFs
         lSnLFZ6A7rH74GeBag2mVNjv5gEry5gBlqYGUO+rQKkDtTrT559Rxam15FBmwuh7s7M5
         QLsW7fuznfV9dng22XiNlj+vpyAL6rnI5cnRTja8k7MrhEX22LWkKABdX4Dnj87Nfrly
         8XKsVaHG3cvhJMfAKbLZlnEEYT5fXydHJ+ZzsJMDbF//OLuIrxEZEkMCcJwQ0c96nr7M
         ZtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2OWM37nBksJ7gayzdgOjUg6cXZHlid4wQ9drsluV0C8=;
        b=ldm22MS6YSsPqjEtVpKZITvxzXdxAfyYFVpmaEmLMpMBU9pZg8eVEO1eHTXxh22nCw
         7aRCgi0EjRXSHw0VUmcmSnMmS0+U9KK4a4EsLa0FS45lS9R3/Y4jPKL/8EBMPBaOVpSO
         QlTilt4xoQKo55CjVnpg6LsBkEyFJ7gYUBUaxZq9srnfTEOIJWsJR+yKAiyzXM9B28kT
         HdQA9r7brEKFeCR2PjzH6q+n05zSxDDl4p7epgJfFb1kQEk6OA5Pr+v7kOiSrD0WZCpp
         Dr+xpaw2hI8KJWtJNJ362Eldt3CdRJ8e06nX6NPJC/+11sSQesUgcdEnSXQHnj2+ehgS
         rMFg==
X-Gm-Message-State: AOAM531M9eZ/uAVdbgzKU8QHF1duzbgdEZYNn5MccRWhf8pTpOzhT2Ja
        QhR9TTgHZxvye1PKuXziz+I=
X-Google-Smtp-Source: ABdhPJykHZw2/9QJGdkoo4Kk9zk/Gp1KOr83+sK4tkJl24z/KpiwOjB5LZro7ajFk49kLCes0PrJww==
X-Received: by 2002:a65:62c4:: with SMTP id m4mr46146521pgv.453.1636133560906;
        Fri, 05 Nov 2021 10:32:40 -0700 (PDT)
Received: from [192.168.50.188] (67.218.130.61.16clouds.com. [67.218.130.61])
        by smtp.gmail.com with ESMTPSA id s25sm7683062pfm.138.2021.11.05.10.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:32:40 -0700 (PDT)
Message-ID: <8301c7f7-4c63-5681-af53-9edc67d96d17@gmail.com>
Date:   Sat, 6 Nov 2021 01:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
 <96925c96-0f87-f110-e279-5b669337948a@linux.intel.com>
From:   "Walt Jr. Brake" <mr.yming81@gmail.com>
In-Reply-To: <96925c96-0f87-f110-e279-5b669337948a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/2021 00:09, Mathias Nyman wrote:
> On 5.11.2021 18.00, Mathias Nyman wrote:
>> Some USB 3.1 enumeration issues were reported after the hub driver removed
>> the minimum 100ms limit for the power-on-good delay.
>>
>> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
>> root hub") the hub driver sets the power-on-delay based on the
>> bPwrOn2PwrGood value in the hub descriptor.
>>
>> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
>> on xhci spec section 5.4.8, but it's clearly not enough for the
>> USB 3.1 devices, causing enumeration issues.
>>
>> Tests indicate full 100ms delay is needed.
>>
>> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
> Walt Jr Brake, just to be sure could you test this one as well?
>
> As Alan suggested this sets 100ms for the USB 3 roothub but
> keeps the 20ms for the USB 2 roothub.
>
> Thanks
> -Mathias

Yes I tested, it works too.

