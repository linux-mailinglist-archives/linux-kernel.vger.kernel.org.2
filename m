Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30C317232
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhBJVVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBJVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:21:43 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0374C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:21:03 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 100so3249257otg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=skCZAnYC/J+OpbtCkFsFwnqTinOfbpgEwbQYU8Qx0fY=;
        b=FUWq0dueCeEVzYAbu9J3bym4tVMzu16e91m9TvWVb6MkBD8H/VFKluxwxDuc1Q5tf/
         vssOYue8HeQjI/Ok5FrtIMJJsgZaltssJf3snRw0eRLC4f710CVrrFcC8qxL35zvvQE2
         zTEkvnenyOGwATGMnD4r7vCUCqLZxIQVe+uDmTlL52MMqq3NcD0DR8WqDaBjJLNrJ4yz
         ESyubYltWxycm0cqKHhiMsAVO7MmSB4vBMDNTgy/MOsoDy7xoMHkfG6lp1Eum1R4qRMz
         /QdMy069Vums4x6kcz1MjK5rv2K8nCHQxQ9D9Vfb/0+zQCDS3w27vrxgUaXVRtcAAWmb
         YH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=skCZAnYC/J+OpbtCkFsFwnqTinOfbpgEwbQYU8Qx0fY=;
        b=QmC6VJTv+8m2seKspMX62sFyfvJwguJmbEjRzY4PrloVVs/OYBHkAfhi3sMRtNSbQt
         NEPnar6LR73nVbTi1T4n3YSgBv7Jzg+ullz/2Z31uDh5+PRVCbKrPDBLwWidS2gElTu/
         j+ejmlh3n1nuftTFxGFl6nNPvlhIEYiWJBs3KwMAelD/hyhLOdFVXHQYq3TvvvrxnUk1
         rTrZglrenzhQIuOOZOgE9XqaZv/hAX7WY+NSpOybPERPufzanS+UDTYHyzlhmDnhIKAq
         qlf44D+TV//3k0HJ2r7CeliA2xjG+uZEUgcOxqKiv13Q506Ub5s3OhnHonUT3LIF9Uq5
         X+YA==
X-Gm-Message-State: AOAM532QydDAeZeUxNYOPIFyNe+FPujax3x6t/cZLWU228iqhVj2/Z4k
        evs/NwFjFnBAsztgdzIP5O8=
X-Google-Smtp-Source: ABdhPJzqcHo4QkzoMdRCH0fJM6vUyOdSCgS9xXiAfoTYGwIjt9i74qigwaMXlmjCXMsnYazxJJ1VMQ==
X-Received: by 2002:a05:6830:140a:: with SMTP id v10mr3590604otp.355.1612992063039;
        Wed, 10 Feb 2021 13:21:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f29sm229709ook.7.2021.02.10.13.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 13:21:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com>
 <20210210055430.GA73123@roeck-us.net>
 <CAGETcx-UaYEeYVXg0sd4=9t2zbBe8YH1LOoOms9ANGix=Zmypw@mail.gmail.com>
 <33f643b9-9f6d-e59a-64e7-2d2b7d3e71a4@roeck-us.net>
 <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <db598d8c-cf59-8478-2248-2ad2ab065c37@roeck-us.net>
Date:   Wed, 10 Feb 2021 13:21:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8QRDo2t==Ng2Cvs_+ZXXnM2SjMzo+A1b78XXAj1iYKSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/21 12:52 PM, Saravana Kannan wrote:
> On Wed, Feb 10, 2021 at 7:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/10/21 12:20 AM, Saravana Kannan wrote:
>>> On Tue, Feb 9, 2021 at 9:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Thu, Dec 17, 2020 at 07:17:03PM -0800, Saravana Kannan wrote:
>>>>> Cyclic dependencies in some firmware was one of the last remaining
>>>>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
>>>>> dependencies don't block probing, set fw_devlink=on by default.
>>>>>
>>>>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
>>>>> only for systems with device tree firmware):
>>>>> * Significantly cuts down deferred probes.
>>>>> * Device probe is effectively attempted in graph order.
>>>>> * Makes it much easier to load drivers as modules without having to
>>>>>   worry about functional dependencies between modules (depmod is still
>>>>>   needed for symbol dependencies).
>>>>>
>>>>> If this patch prevents some devices from probing, it's very likely due
>>>>> to the system having one or more device drivers that "probe"/set up a
>>>>> device (DT node with compatible property) without creating a struct
>>>>> device for it.  If we hit such cases, the device drivers need to be
>>>>> fixed so that they populate struct devices and probe them like normal
>>>>> device drivers so that the driver core is aware of the devices and their
>>>>> status. See [1] for an example of such a case.
>>>>>
>>>>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>
>>>> This patch breaks nios2 boot tests in qemu. The system gets stuck when
>>>> trying to reboot. Reverting this patch fixes the problem. Bisect log
>>>> is attached.
>>>
>>> Thanks for the report Guenter. Can you please try this series?
>>> https://lore.kernel.org/lkml/20210205222644.2357303-1-saravanak@google.com/
>>>
>>
>> Not this week. I have lots of reviews to complete before the end of the week,
>> with the 5.12 commit window coming up.
> 
> Ok. By next week, all the fixes should be in linux-next too. So it
> should be easier if you choose to test.
> 
>> Given the number of problems observed, I personally think that it is way
>> too early for this patch. We'll have no end of problems if it is applied
>> to the upstream kernel in the next commit window. Of course, that is just
>> my personal opinion.
> 
> You had said "with 115 of 430 boot tests failing in -next" earlier.
> Just to be sure I understand it right, you are not saying this patch
> caused them all right? You are just saying that 115 general boot
> failures that might mask fw_devlink issues in some of them, right?
> 

Correct.

Guenter
