Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8D428282
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhJJQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 12:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJJQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 12:23:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00534C061570;
        Sun, 10 Oct 2021 09:21:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k2-20020a056830168200b0054e523d242aso8966729otr.6;
        Sun, 10 Oct 2021 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5sscExSwZ6oagxYzS/h8Gwk2Sycu4czkRbPI4eQMxXs=;
        b=G/VYzeW3wsA6iq0n0eRY0IFkO0y6Vse/yXS/o5sfzk5JjZdfAr1Rk5jPCTKaRdTx+H
         esGQrZ5DQTjoAHjkz8tnO0RxSsUFlMrXyY0DFloT+o63+TrYFrKQtC5e9J7rLqq3Y+X0
         rccu1q+s+WosXCPS8eD+DdoPnOcs9V2DPuOMs7exn9oeryNbb3btLQ38tA2x82aDeMKN
         F5st2BEg2w7VLa+4mgl/m13FbIneIv8o+NpHgutZ9+lYH1/0p8NqlsweHl0auro3UoD9
         joa0VmO1y1PJ6npPi6VAuIwr8O5xtA/40v58A9Wt/+jA6DM6Bsha4LbVNe7u1rUxJz+O
         mVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5sscExSwZ6oagxYzS/h8Gwk2Sycu4czkRbPI4eQMxXs=;
        b=ICEIBn+xjF0hG2wbjLCdRn/WeJ+Krg0gDC+cIfrLj0hAXMgnXN3hi5Np4CPF9WnAGW
         lwX6FdapxDPQ4xpJ9KEf7Qm0NliFRBz8/FJtoNCO4KUoqZ0e8+BQsDsi0IKinzwCIWPh
         gJZuB0f8zdXbFnYTXtA982lvp4fBuuvar8iYuo723F1rWDDKFCLe6jxGorju7WcGz/o3
         L3SSb/fbNM+kU+RpmJ6zEi3iVUXxDAVcOqJJ/4Ya2+6lkmHx8RWjF6VOH1+AYmTDlZfN
         6J36QdNMi8DUrCqLfP33eJCpfOVcdXpmo+sZFeLi9x38NOShtqhWFj6QwuW/O9tfGYXr
         oB1Q==
X-Gm-Message-State: AOAM532SJS2bao2T9akHTxgF60tRPPxBzejPMx1ONfMlJNtOvWC7z5Ks
        jNNPGIGj8RPzlipzZo6GQzfmRuCnics=
X-Google-Smtp-Source: ABdhPJy8VFH66gWLW22i1yGmbUtDqWlg3NQ9Om04m/NHLCMfvy07srAsdzTBhOue+scRsCqkd5ZHdA==
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr17719013otp.212.1633882866059;
        Sun, 10 Oct 2021 09:21:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14sm1203160otq.65.2021.10.10.09.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 09:21:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Denis Pauk <pauk.denis@gmail.com>, eugene.shalygin@gmail.com,
        andy.shevchenko@gmail.com, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211010095216.25115-1-pauk.denis@gmail.com>
 <20211010095216.25115-3-pauk.denis@gmail.com>
 <0a037ce5-87bb-4aad-a30a-d954ff0910a7@t-8ch.de>
 <7658358e-5ba6-b764-463c-317f5b318707@roeck-us.net>
 <13b23940-88d9-4c72-a55b-a66e8c8edffb@t-8ch.de>
 <e25063b9-634b-3f56-bcaf-77d8526b9a67@roeck-us.net>
 <64dda962-4ef1-496a-aa8e-7332e9fcce31@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: (asus_wmi_sensors) Support X370 Asus WMI.
Message-ID: <8c77f5f9-8eb3-0f66-8518-8662ab979c0d@roeck-us.net>
Date:   Sun, 10 Oct 2021 09:21:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <64dda962-4ef1-496a-aa8e-7332e9fcce31@t-8ch.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 8:28 AM, Thomas Weißschuh wrote:
> On 2021-10-10T07:56-0700, Guenter Roeck wrote:
>> On 10/10/21 7:10 AM, Thomas Weißschuh wrote:
>>> On 2021-10-10T06:38-0700, Guenter Roeck wrote:
>>>> On 10/10/21 3:20 AM, Thomas Weißschuh wrote:
>>>>> Hi,
>>>>>
>>>>> for WMI drivers the list platform-driver-x86@vger.kernel.org should probably be
>>>>> on CC too.
>>>>> Also all other WMI drivers, even for hwmon stuff are located in
>>>>> drivers/platform/x86 so it may be better to put it there, too.
>>>>>
>>>>
>>>> Not really. If any of those other drivers are pure hwmon drivers, they
>>>> should reside in drivers/hwmon instead. And, yes, that really includes
>>>> the gigabyte-wmi driver. We don't have arbitrary drivers in drivers/pci
>>>> either just because they are drivers for pci devices.
>>>
>>> Fair enough.
>>> I suppose it would be too much churn to move gigabyte-wmi to
>>> hwmon now though, correct?
>>>
>>
>> Is it ? I don't recall the reason why it was added to drivers/platform/x86
>> in the first place. I see other single-use wmi drivers in that directory
>> as well (eg xiaomi-wmi, which should be in input). Is there some unwritten
>> rule stating that all wmi drivers shall reside in drivers/platform/x86,
>> no matter what subsystem they touch ?
> 
> There was no specific reason. I saw all the other WMI drivers in
> drivers/platform/x86 and added mine there and sent it to the recipients as
> reported by get_maintainer.pl.
> 

Sorry, that is not a valid reason or argument for me.

> You mentioned that it could move to hwmon but Hans said there are other
> single-use wmi drivers in drivers/platform/x86 so I left it as is.
> 
> If you want me to move it, I'd be happy to do so.
> 

At this point this is out of my control.

> In any case I think it would make sense to have some sort of written and
> well-known policy about this, though.
> 
Absolutely agree. Historically single-use drivers resided in subsystem directories,
and for multi-use drivers it was handled on a case-by-case basis. If that is being
changed (meaning subsystem driver control/maintenance/review is taken away from
subsystem maintainers), it should for sure be documented.

>>> Having the platform-driver-x86 on Cc would still be useful as they can provide
>>> guidance about using the ACPI/WMI/platform APIs.
>>>
>>
>> Sure, but that is unrelated to the driver location, and the opposite argument
>> can be made as well (that drivers implementing subsystem code should be reviewed
>> by subsystem maintainers). That is a much stronger argument in my opinion.
>>
>> Guenter
> 
> Absolutely. I wanted to make two different points in my mail:
> 
> 1) Maybe the driver should be moved into drivers/platform/x86 as the other
> (single-use) WMI drivers are living there.

Doing something wrong is neither a reason nor an argument to keep doing it.

> I don't know about any rule demanding that but was mentioning this so it stays
> consistent.
> 
> 2) The patch should *also* be reviewed by pdx86 as it is using their
> infrastructure.
> This was not meant to replace any of the hwmon involvement.
> 
> For example when I submitted gigabyte-wmi to pdx86 the maintainers they told
> me to also solicit feedback from you as the hwmon maintainer.
> And in the end both the hwmon parts (thank you!) and the wmi parts
> (platform-device vs WMI bus, same as here) were much better than in the
> first version.
> 

Sure. Unfortunately that is not always the case. Many drivers registering
with hwmon were never reviewed by a hwmon maintainer, and some of those make
me shiver when I look at them. Since v5.12, get_maintainer.pl lists hwmon
maintainers as reviewers if a driver makes a hwmon API call, so hopefully
that will help a bit.

Guenter

>>> For example by using the WMI bus as mentioned in my other mail would allow
>>> to completely remove the manually maintained DMI list and instead directly bind
>>> to the WMI GUID for any device that supports this GUID.
>>> (This is possible as this WMI API seems to be self-describing, so all
>>> specific parameters can be discovered by the driver)
> 
> Thomas
> 

