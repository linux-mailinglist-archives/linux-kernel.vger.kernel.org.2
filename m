Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5432D12E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbhCDKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238946AbhCDKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614855000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7K0se92r7ie361EjQsRfU3OZ4yW7lXC/6pKaDKswuCo=;
        b=JMOtIwm5s2OtCs3CMc6EZJaYPnvbIzwhajRxY2noBl14FJVZSB/1FlsfAR7noKkJqlZZO2
        EnDL3NUQDcfTR/2ntRvzWHWeMxPxo20fcAR7+KIe/GE0XTiFXQlx9RKsf0Yg+tX5Y3SIO+
        XTtxd5KtQ2clRaX1rLGQJtFszcgzIgw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-xRc6P5XpO0KjZDr1Sn_-Gg-1; Thu, 04 Mar 2021 05:49:59 -0500
X-MC-Unique: xRc6P5XpO0KjZDr1Sn_-Gg-1
Received: by mail-ed1-f70.google.com with SMTP id v27so6887109edx.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7K0se92r7ie361EjQsRfU3OZ4yW7lXC/6pKaDKswuCo=;
        b=NLvwTR7CLQTnKqNpzKhaX71s6Ijuc3qBJ8BIyQsgBPs0haeRUxf9GABuMICQlVAwqS
         lSkp7kyy+CnkeqnwXwQuBKU6AVN3+Yz8/rpQy6vCFTbHMfRnAM2qThPziAf9SllzxZws
         9IXhIa2HQbTkgtaEwoXhJPG7rvj1c8BXfHSTViB7MgjppdscNoKvAIHm+Qf6cTjiM3w7
         SqQtDEuAsldou28DlBPNpL8lT6zPhxRXqJLXxfZcIuOOQxer7XIuojl6zMCK0L97AsMF
         HBHLe4vB/N/9Fxr+W6/9uHZemMusJbr+lnq/OgWT+Qzt7bQ7vcdNMwfZ452WgCaOQ/eJ
         F+Ig==
X-Gm-Message-State: AOAM533enfdTxo3g9xGC/JjqppvLQb8xz3UyxYjQKaNXA8RMDafChp0T
        5l1JZf6YylR4uzsi04C11mYAG8i3N4cSwa8SgV7bsUt/Mgjam41r9mQ6xmIQ6+TTMlMBwgc82gA
        u+23Z268g+yAyOgygun2DUFQC
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr3419390ejf.431.1614854997441;
        Thu, 04 Mar 2021 02:49:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnwDEdjUwK88xnOLeGSKIYo7KevWEWW4v9d+WuMI9dQk4w5zY+tNvftQhypWHuMml8HdF7Mg==
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr3419376ejf.431.1614854997294;
        Thu, 04 Mar 2021 02:49:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l12sm2799011edb.39.2021.03.04.02.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 02:49:56 -0800 (PST)
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <perry979106@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Perry Yuan <Perry.Yuan@dell.com>
Cc:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com>
 <mXtNUreCVsPKizG-fnNKPId9_lQGit0S6pYEpk-aNT1hGQjVwblZDiO4E-YX3hxnrbbNN1-6hSntiv13wz66RxbhXjPJhpAVOIlZmmwUI7w=@protonmail.com>
 <7def1cdc-e275-9ae6-4941-55517359bb1e@gmail.com>
 <ce598a92-73ef-e9a6-d772-59f5da3d251e@redhat.com>
 <facc6270-1e04-b348-a1be-a97f87870c46@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <aaa0d156-3394-b8e3-9a48-196a1265cdd9@redhat.com>
Date:   Thu, 4 Mar 2021 11:49:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <facc6270-1e04-b348-a1be-a97f87870c46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/21 8:24 AM, Perry Yuan wrote:
> Hi Hans:
> 
> On 2021/1/13 2:37, Hans de Goede wrote:
>> Hi,
>>
>> I know there already is a v3 out and I will try to get around to reviewing
>> that soon, still 1 remark about the discussion surrounding v2:
>>
>> On 1/11/21 2:42 PM, Perry Yuan wrote:
>>
>> <snip>
>>
>>>>> *The flow is like this:
>>>>> 1) User presses key. HW does stuff with this key (timeout is started)
>>>>> 2) Event is emitted from FW
>>>>> 3) Event received by dell-privacy
>>>>> 4) KEY_MICMUTE emitted from dell-privacy
>>>>> 5) Userland picks up key and modifies kcontrol for SW mute
>>>>> 6) Codec kernel driver catches and calls ledtrig_audio_set, like this:
>>>>>     ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>>>>         rt715->micmute_led ? LED_ON :LED_OFF);
>>>>> 7) If "LED" is set to on dell-privacy notifies ec,
>>>>>    and timeout is cancelled,HW mic mute activated.
>>>>>
>>>> Please proofread the commit message again, and pay attention to capitalization
>>>> and spacing.
>>> I want to reformat it and move the commit info to cover letter.
>>
>> Please also put a copy of this as a comment in either the wmi or the
>> acpi driver (with a comment pointing to the comment in the other) this is
>> important info to have for someone reading the code and trying to understand
>> how this all fits together.
>>
>> Regards,
>>
>> Hans
>>
> Hans.
> I have added the comments to the dell-privacy  driver file in V4
> 
> -----------------------------------------------------------------------------------
> drivers/platform/x86/dell-privacy-wmi.c
> 
> EXPORT_SYMBOL_GPL(dell_privacy_valid);
> /*
>  * The flow of privacy event:
>  * 1) User presses key. HW does stuff with this key (timeout is started)
>  * 2) WMI event is emitted from BIOS
>  * 3) WMI event is received by dell-privacy
>  * 4) KEY_MICMUTE emitted from dell-privacy
>  * 5) Userland picks up key and modifies kcontrol for SW mute
>  * 6) Codec kernel driver catches and calls ledtrig_audio_set defined by
>  *    dell-privacy-acpi driver.
>  *    codec driver will call like this to switch micmute led state.
>  *      ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led ? LED_ON :LED_OFF);
>  * 7) If "LED" is set to on dell-privacy notifies EC,and timeout is cancelled,
>  *      HW mic mute activated.
>  */
> void dell_privacy_process_event(int type, int code, int status)
> {
>         struct privacy_wmi_data *priv;
>         const struct key_entry *key;
> 
>         mutex_lock(&list_mutex);
> ....
> 
> -----------------------------------------------------------------------------------
> drivers/platform/x86/dell-privacy-acpi.c
> 
> /*
>  * Pressing the mute key activates a time delayed circuit to physically cut
>  * off the mute. The LED is in the same circuit, so it reflects the true
>  * state of the HW mute.  The reason for the EC "ack" is so that software
>  * can first invoke a SW mute before the HW circuit is cut off.  Without SW
>  * cutting this off first does not affect the time delayed muting or status
>  * of the LED but there is a possibility of a "popping" noise.
>  *
>  * If the EC receives the SW ack, the circuit will be activated before the
>  * delay completed.
>  *
>  * Exposing as an LED device allows the codec drivers notification path to
>  * EC ACK to work
>  */
> static int dell_privacy_leds_setup(struct device *dev)
> {
>         struct privacy_acpi_priv *priv = dev_get_drvdata(dev);
>         int ret = 0;
> 
> .....
> 

This looks good, thank you.

Regards,

Hans

