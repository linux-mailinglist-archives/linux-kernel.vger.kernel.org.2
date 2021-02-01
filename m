Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50A230A19D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBAFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhBAFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:45:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00FEC0613D6;
        Sun, 31 Jan 2021 21:44:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w124so17610231oia.6;
        Sun, 31 Jan 2021 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+yMaOX3uAlYS73ernU41tJP1b11omW2KpIzzwqJIVE=;
        b=TKRfdV1JluhJ4/doNZBn2Az8QUDVsnFT7koLjWEZMY0fKyg0LU8PihWthqgHCgjggp
         t4doV4NTx1CAaHVGWCdbkxHeU0/MIbaxj+694PgI/xHR8wYvg+GjxIX8rQeFikfdGzLg
         Kx+Xr6XniqyrOlPFGuVG5gbPRPesyvZfnX9rgIYbZEn2/4/CmObKcUchfiglYGcdFVlj
         v1lQBAiN+v5MMcqgmZhWsRzwKMrSJkR+IFCT0EWiYYo7PujRYPGyIF0BNdY5wo5CdjEe
         891xZ9d9z3q7OhTKhB5vf0sFcqW0iY3vY4mXRFyFvr/P5rTpqspe68a7xSZ39hPtqAPE
         a0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q+yMaOX3uAlYS73ernU41tJP1b11omW2KpIzzwqJIVE=;
        b=hv8nKjSUn+rA8hMn+VMYT6cLYe7BRYbtzqXKsVGorcCKFnyklFe/Q7dttpx2Uvxt8t
         3olEMuzXrW1NgLc+RsJeUbZ1x86TEO69njZyg3mFghcuOdFJDwPRsfpoKRZVJfG6BY08
         vup4yh95XgJiD3wA1EgUOf/INrBmoFV2sDzws2TRRvK+62PeW84M1y2SdoXzh+9shQm+
         fOjpfxfpDTYE7bTff3/+5fT+GlbH+zTSn5TjXd3ppzTDUN/Ms82lTW8ebYSSwdTHTSl2
         teZd7qpAE52FmswTAz1Ekz+GLRcKtg7N8j59prFgnvA6j0BgIxGHwWUtThjjhE9qXKLq
         cTcA==
X-Gm-Message-State: AOAM531X2/aK1AgqJ+EhMXOv0SiH6uJhMUwrzUfuujjSjtvY6na6bqd/
        +vmPQbPmUF2RHz2gQpEDS4iCWe7keQE=
X-Google-Smtp-Source: ABdhPJywnY9Miw8AWQF5h0jRCBANw6qMM66V4AUpgWNub2ecTKGy0XmyHkrW3x0n87oOXNw4/xTHqw==
X-Received: by 2002:a05:6808:57d:: with SMTP id j29mr10066192oig.146.1612158283874;
        Sun, 31 Jan 2021 21:44:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o98sm3893291ota.0.2021.01.31.21.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 21:44:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: Get Sink VDO from fwnode
To:     Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, robh+dt@kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
References: <20210131151832.215931-1-kyletso@google.com>
 <20210131151832.215931-4-kyletso@google.com>
 <950a9361-4cc8-5c01-8c3d-80d812fd663d@roeck-us.net>
 <CAGZ6i=3uUnPNDd1SbcNWG85Rv+jZqJEdFQ6uW2=_WRrhrJaP6A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7aa2085b-66ef-0a56-a678-58de238d0377@roeck-us.net>
Date:   Sun, 31 Jan 2021 21:44:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGZ6i=3uUnPNDd1SbcNWG85Rv+jZqJEdFQ6uW2=_WRrhrJaP6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/21 9:11 PM, Kyle Tso wrote:
> On Mon, Feb 1, 2021 at 12:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/31/21 7:18 AM, Kyle Tso wrote:
>>> Commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config
>>> configuration mechanism") removed the tcpc_config which includes the
>>> Sink VDO and it is not yet added back with fwnode. Add it now.
>>>
>>> Signed-off-by: Kyle Tso <kyletso@google.com>
>>> ---
>>> Changes since v1:
>>> - updated the commit message
>>>
>>>  drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>> index 403a483645dd..84c8a52f8af1 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -5677,6 +5677,18 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>>>                       port->new_source_frs_current = frs_current;
>>>       }
>>>
>>> +     ret = fwnode_property_read_u32_array(fwnode, "sink-vdos", NULL, 0);
>>
>> fwnode_property_count_u32(), maybe ?
>>
> That's the same and looks like fwnode_property_count_u32 is better to read.
> I will revise it in the next version.
> 
>>> +     if (ret <= 0 && ret != -EINVAL) {
>>> +             return -EINVAL;
>>
>> Why return any error except -EINVAL (including return values of 0) as -EINVAL,
>> and -EINVAL as no error ?
>>
> sink-vdos is not a mandatory property which means -EINVAL is acceptable.
> 
> If the return < 0 and the value is not -EINVAL, it means that the
> error is other than "not present" in the device tree.
> If the return == 0, it means that the sink-vdos is present in the
> device tree but no value inside it.

I think that should return -ENODATA. Not sure if/when it would actually return 0.

> Both of the above situations are not acceptable.
> 

Personally I would prefer that a bit more explicit in the code, ie
handle errors first and drop the else statement below. But maybe
that is just me.

>>> +     } else if (ret > 0) {
>>> +             port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
>>> +             ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
>>> +                                                  port->snk_vdo,
>>> +                                                  port->nr_snk_vdo);
>>> +             if (ret < 0)
>>> +                     return -EINVAL;
>>
>> static analyzer code used to complain about overriding error codes.
>> Not sure if that is still true. Either case, why not return the
>> original error ?
>>
> Returning the original error codes is good. I just followed the return
> value of other error handling in this function.
> will revise it in the next version.
> 
Never mind, with the rest of the code being similar I guess that either
static analyzers gave up complaining or they already have a field day
anyway.

Thanks,
Guenter

> Thanks,
> Kyle
> 
> 
> 
>> Thanks,
>> Guenter
>>
>>> +     }
>>> +
>>>       return 0;
>>>  }
>>>
>>>
>>

