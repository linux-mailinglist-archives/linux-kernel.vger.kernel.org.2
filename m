Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCD30B0C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhBATsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhBATqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:11 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF96BC061573;
        Mon,  1 Feb 2021 11:45:28 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id x71so20092108oia.9;
        Mon, 01 Feb 2021 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=idXi+PuqqOaZH/tk7xHqPqL/FZ2CodF9JFMzYOpfyA0=;
        b=sPHfZUlyraGu1I7wBpZbIXd0DsSxvjsFooBD1eC8gCy/19Bd6WL3MK/DBQzs7P1oS3
         rklAmcRtpCopCrRcmm0lon6MbZr18WFTAxq3eFlwVjqkymxuXmh3/RDVC6NZ1QwMXYP/
         gB0ZTjDcQwB1xS66wfu2cjEP2Ak+9FMWEX+r0d6RHombbOH24+F9QZQoW1eeVSZ83qnM
         4jA+3vzWjTfAPZHpp6kSXZ7lj+HJ3E3FM9qMZK6+4J1pnBYGusaeIW72RhblX2m01099
         A0dy5jY0lPbsfP/azMeVCFzdUbZ6hF1nJPWlwt6auiW2FR9fzRPdX7yu2inssh9P1MSv
         1TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=idXi+PuqqOaZH/tk7xHqPqL/FZ2CodF9JFMzYOpfyA0=;
        b=dNNgOl8eClF3GJylyZE9Mlf1E0yl6ZLBbmX54GI9Orey74pYcvGyPVljgRMMJY779W
         EAYrunKNLzz/PP9KDBe5rFh6zsbSxJYXB9+2rOJijaZJntO404qgo5LAV37NZpPuVCcp
         x1nwKHEqYHNYsqH0Jh3xY1ml5tRcvx4fupC85CcUVwCa1KB6cK4fL5RSBBeDZdO+/lru
         n//Esx0GlWq1Y8c/nJt4QLWmoSNRwVZJGCiO+MJ4K1c1ZFbVZgKJYI18Wd9BNQJGJRLk
         tkdCXMioYRsWiFkc3AP8CzI1pM/PTqvxjaFf/5v5n+IIgluRtZ5cH8ZdhVg0ToO4k1Dk
         2mhg==
X-Gm-Message-State: AOAM532uNukVVHt1PVQBXIudiRSrSJp7ucNS7gFWW7ulaIzvm1PwftD8
        ZgMA1q9VrHDBx6jZt0IwuHiR14xraYk=
X-Google-Smtp-Source: ABdhPJz90qBt0os1v1xGHaTp/jY+fIYSU7IJGLSfjAckj2u2RyfhjQdm2WelgrwyojqGL9mboo+t8Q==
X-Received: by 2002:aca:4912:: with SMTP id w18mr316232oia.61.1612208728094;
        Mon, 01 Feb 2021 11:45:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm4567789oiz.43.2021.02.01.11.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:45:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: tcpm: Add Callback to Usb
 Communication capable partner
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210201095309.39486-1-badhri@google.com>
 <20210201151253.GG2465@kuha.fi.intel.com> <YBgcCu7lx036C+KN@kroah.com>
 <20210201160925.GA1433721@kuha.fi.intel.com> <YBgunjrmQsFkYBvm@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <09d28950-3fdc-ed2d-e09b-2b24d2fed551@roeck-us.net>
Date:   Mon, 1 Feb 2021 11:45:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBgunjrmQsFkYBvm@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 8:38 AM, Greg Kroah-Hartman wrote:
> On Mon, Feb 01, 2021 at 06:09:25PM +0200, Heikki Krogerus wrote:
>> On Mon, Feb 01, 2021 at 04:19:38PM +0100, Greg Kroah-Hartman wrote:
>>> On Mon, Feb 01, 2021 at 05:12:53PM +0200, Heikki Krogerus wrote:
>>>> On Mon, Feb 01, 2021 at 01:53:07AM -0800, Badhri Jagan Sridharan wrote:
>>>>> The USB Communications Capable bit indicates if port
>>>>> partner is capable of communication over the USB data lines
>>>>> (e.g. D+/- or SS Tx/Rx). Notify the status of the bit to low
>>>>> level drivers to perform chip specific operation.
>>>>> For instance, low level driver enables USB switches on D+/D-
>>>>> lines to set up data path when the bit is set.
>>>>>
>>>>> Refactored from patch initially authored by
>>>>> Kyle Tso <kyletso@google.com>
>>>>>
>>>>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>>>>> ---
>>>>>  drivers/usb/typec/tcpm/tcpm.c | 16 ++++++++++++++++
>>>>>  include/linux/usb/tcpm.h      |  5 +++++
>>>>>  2 files changed, 21 insertions(+)
>>>>
>>>> ...
>>>>
>>>>> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
>>>>> index 3af99f85e8b9..42fcfbe10590 100644
>>>>> --- a/include/linux/usb/tcpm.h
>>>>> +++ b/include/linux/usb/tcpm.h
>>>>> @@ -108,6 +108,10 @@ enum tcpm_transmit_type {
>>>>>   *		is supported by TCPC, set this callback for TCPM to query
>>>>>   *		whether vbus is at VSAFE0V when needed.
>>>>>   *		Returns true when vbus is at VSAFE0V, false otherwise.
>>>>> + * @set_partner_usb_comm_capable:
>>>>> + *              Optional; The USB Communications Capable bit indicates if port
>>>>> + *              partner is capable of communication over the USB data lines
>>>>> + *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
>>>>>   */
>>>>>  struct tcpc_dev {
>>>>>  	struct fwnode_handle *fwnode;
>>>>> @@ -139,6 +143,7 @@ struct tcpc_dev {
>>>>>  	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
>>>>>  						 bool pps_active, u32 requested_vbus_voltage);
>>>>>  	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
>>>>> +	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
>>>>>  };
>>>>>  
>>>>>  struct tcpm_port;
>>>>
>>>> There start to be a lot of callback there, separate for each function.
>>>> And I guess flags too... Would it be possible to have a single
>>>> notification callback instead, that would take the type of the
>>>> notification as a parameter (we could have an enum for those), and
>>>> then the specific object(s) for each type as another paramter (RDO I
>>>> guess in this case)?
>>>>
>>>> It would then be up to the TCPC driver to extract the detail it needs
>>>> from that object. That would somehow feel more cleaner to me, but what
>>>> do you guys think?
>>>
>>> It's pretty much the same thing, a "mux" function vs. individual
>>> function calls.  Personally, individual callbacks are much more
>>> explicit, and I think make it easier to determine what is really going
>>> on in each driver.
>>>
>>> But it all does the same thing, if there's going to be loads of
>>> callbacks needed, then a single one makes it easier to maintain over
>>> time.
>>>
>>> So it's up to the maintainer what they want to see :)
>>
>> I understand your point, and I guess a "generic" notification callback
>> for all that would not be a good idea. However, right now it looks
>> like we are picking individual bits from various PD objects with those
>> callbacks, and that does not feel ideal to me either. After all, each of
>> those bits has its own flag now, even though the details is just
>> extracted from some PD object that we should also have access to.
>>
>> I think there are ways we can improve this for example by attempting
>> to create the notifications per transaction instead of for each
>> individual result of those transactions. That way we would not need to
>> store the flags at least because we could deliver the entire object
>> that was the result of the specific transaction.
>>
>> So basically, I fear that dealing with these individual bits will in
>> many case only serve individual device drivers, and in the worst case
>> start making the tcpm.c a bit more difficult to manage if we start to
>> have more and more of these bit callbacks.
>>
>> But on the other hand, I guess we are nowhere near that point, so
>> let's forget about this for now.
> 
> If it gets unwieldy, we can always change it in the future, there's no
> reason these types of in-kernel apis can not be modified and cleaned up
> over time.
> 
Agreed.

Thanks,
Guenter

