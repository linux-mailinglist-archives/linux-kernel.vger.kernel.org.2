Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152A5441A51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhKALD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230520AbhKALD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635764452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joHNzvFQfcbDTZ/dkFJGCsXdvXmYKWaiFrgOXjjG3U4=;
        b=a+RIImCJhfrRU6s3u1RrgcLnsWVs+YoUve9q2xnn5mvwQxFBfb8t/Xxu4XecU/im9QkV8x
        jS5CyaB+gS4oE2zBVbv/c78ZNzCuIWNFYdtBYhqqUWWDPNU7eVtU0ZyErybgbK/ts5ihhS
        1V4iLQ9AAyAlpjosCKVcp4E7tD0ZSmk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-ofC_w0iOMJW5HhDhctJvzw-1; Mon, 01 Nov 2021 07:00:51 -0400
X-MC-Unique: ofC_w0iOMJW5HhDhctJvzw-1
Received: by mail-ed1-f70.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso674205edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 04:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=joHNzvFQfcbDTZ/dkFJGCsXdvXmYKWaiFrgOXjjG3U4=;
        b=JrAsJRjO0cPKb16Reix0tHSJ09BdVxaRlEFBYv2yeRyY7fd5577wSNr3L/7rXbCDbX
         KXVsmkpd9iF7khhg9WsscFbBdtF6QhsjjEs//Ggp5tP9+rWpLQG5ClkiMzKIbBOQ1bBK
         u0G12dRiAZ5lOV1jcyeiO+Byc5vmVFw0/8MCeHMIlW30Mt72MJ4eZiafEcQZPum+dBN6
         PsnKqF4oTa/POrxn8FkUtH7aOybK19wp2vFGiNC8NXu4+wqSKy28uTJq4N8R/bp9W0yF
         cfvwcM1JqTmprC57c+gCJGH6ODWeVtsMLVWNb+4BuXCjejuwZHY0c0T1i0x0aFLrBLPS
         4GYA==
X-Gm-Message-State: AOAM531sSc8cNLMSRdKLrsdtwjZvK5jLeKxGUr37iH8Thmdvb3+CVwH7
        KgLF9bejbpOx/1nIIpBhxeklm/UEUR7mda7Q71aG10vy+na1EJN1LlrLU2eO9UBGgjVzG3jvbbB
        POiP1p6BrKejRnNofpi+7AoL3
X-Received: by 2002:a17:907:1c0a:: with SMTP id nc10mr22593178ejc.211.1635764450402;
        Mon, 01 Nov 2021 04:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsz/WHOhVGJrVLCTGkCypW0KYkc8EOI/EYIO1yZjx/IvEyS0VgbABqYAnWykZcfYTHcUOH7g==
X-Received: by 2002:a17:907:1c0a:: with SMTP id nc10mr22593140ejc.211.1635764450202;
        Mon, 01 Nov 2021 04:00:50 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id g12sm6748963ejs.39.2021.11.01.04.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 04:00:49 -0700 (PDT)
Message-ID: <4aec04d1-0964-e4c3-2c92-f9cef395494a@redhat.com>
Date:   Mon, 1 Nov 2021 12:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 05/11] clk: Introduce clk-tps68470 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20211025094119.82967-1-hdegoede@redhat.com>
 <20211025094119.82967-6-hdegoede@redhat.com>
 <CAHp75VdfwA_3QK2Fo1S34rRZWHCMNzzHug4AKsRfOrKu4CU_YA@mail.gmail.com>
 <ff8c8418-8e73-f949-3734-c0e2e109f554@redhat.com>
 <CAHp75VfUq+DZk_u5Wsyr5nnibbe+WrYDyhvCU22=4Pog06DgHg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfUq+DZk_u5Wsyr5nnibbe+WrYDyhvCU22=4Pog06DgHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/21 11:42, Andy Shevchenko wrote:
> On Mon, Nov 1, 2021 at 12:27 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 10/25/21 13:24, Andy Shevchenko wrote:
>>> On Mon, Oct 25, 2021 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>>> +       for (i = 0; i < ARRAY_SIZE(clk_freqs); i++) {
>>>> +               diff = clk_freqs[i].freq - rate;
>>>> +               if (diff == 0)
>>>> +                       return i;
>>>
>>>> +               diff = abs(diff);
>>>
>>> This needs a comment why higher (lower) frequency is okay.
>>
>> This function is called in 2 places:
>>
>> 1. From tps68470_clk_round_rate(), where higher/lower clearly is ok,
>> (see the function name) so no comment needed.
>>
>> 2. From tps68470_clk_set_rate() where it is NOT ok and this is
>> enforced in the caller:
>>
>>         unsigned int idx = tps68470_clk_cfg_lookup(rate);
>>
>>         if (rate != clk_freqs[idx].freq)
>>                 return -EINVAL;
>>
>> This is not easy to describe in a comment, while being obvious
>> if someone looking at this actually looks at the callers.
> 
> Hmm... but try your best. :-)

Ok I will :)

> While at it, recently I have learned about util_macros.h. Any use of it here?
> Or amending it there and re-using it here?

That only works on straight integer/long/float arrays, not
on arrays of structs where we are looking for a specific member of
the struct to be closest. And reworking that to also work on
structs is really (really really) out of scope for this patch-set.

Regards,

Hans


> 
>>>> +               if (diff < best_diff) {
>>>> +                       best_diff = diff;
>>>> +                       best_idx = i;
>>>> +               }
>>>> +       }
> 

