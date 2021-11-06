Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23F446D62
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhKFKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 06:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232631AbhKFKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 06:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636193712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VADd4gTiJa1m6CydMS+TiNIJa+MD2CtW9ThTxidLXA=;
        b=Lj5JkfpiusfStReSzDiYtGQda2RmMNp6vldPPSYrtrttA7VT5v86yqJy1lhbRy5ndnxdH1
        nAyngx/MHo+cHyNdeONiY+NT9CmwRSxUWO1wM/p15wfjwoJji6BA/dQafKGyc8XzG3bnLV
        PthTS0Bga/XVWtPpwt+oC3u8bMjJbi4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-xNa1o-RbM6KVzBujMWRZtQ-1; Sat, 06 Nov 2021 06:15:09 -0400
X-MC-Unique: xNa1o-RbM6KVzBujMWRZtQ-1
Received: by mail-ed1-f70.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso5316112edc.14
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 03:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=4VADd4gTiJa1m6CydMS+TiNIJa+MD2CtW9ThTxidLXA=;
        b=ld7ZDZ0mL2oZOF/AsKzA1Pxg85yTp95HGn++5qimBmZWOoCcENMgg2oOjZeG6HPJbZ
         f3HlYS75gC3sCGLBq5AyoPsPhSDe5ym0bqEckR/j1Sj7uImV4fHr/Q8BtTM+yLcCuhqc
         v54m10XgMKosHMj9/eSNX3MpDF3xN52+tLtrfoj4eh+pHJia1yFY0Vn80S7gyvLhipLt
         dPZcf8H7JhmYA+8VZbxNEYGAfuePw1/j7h/4vrzv9kWDvb7NrVRFYtSdjtKvi0kjVvLb
         zEQdSEXVlqph1NjQ10fya/HXNu40B9BXCJqUKUT6iY8ORCIlNbnYs4YEwA14ogaTi/IV
         syIA==
X-Gm-Message-State: AOAM530X50FAloHrBnCz/2hBE51a0QDEfuli6sMyAqA39iJG070mBSOE
        RaOX7W9PAe4vcNzwrSaAd24930VLqaHoN0RglA/IbtfrYTluc+x8lCSx3o0gRr1r8piTpmCAqK5
        Ae8RyswMI7b7+IjTK131U1ZpP
X-Received: by 2002:a50:9dca:: with SMTP id l10mr87188895edk.61.1636193708702;
        Sat, 06 Nov 2021 03:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygiuOhV0P+f5+fXP96kXpyL8GmJfV9M0FckPenKEjrqh4fkbmavNe/eCGePjStOIoqdD0D1g==
X-Received: by 2002:a50:9dca:: with SMTP id l10mr87188862edk.61.1636193708522;
        Sat, 06 Nov 2021 03:15:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm6079623edb.59.2021.11.06.03.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 03:15:08 -0700 (PDT)
Message-ID: <c85a917e-143d-1218-61fa-e4f4810c4950@redhat.com>
Date:   Sat, 6 Nov 2021 11:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/2] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, stable@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20211020211455.GA2641031@bhelgaas>
Content-Language: en-US
In-Reply-To: <20211020211455.GA2641031@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 10/20/21 23:14, Bjorn Helgaas wrote:
> On Wed, Oct 20, 2021 at 12:23:26PM +0200, Hans de Goede wrote:
>> On 10/19/21 23:52, Bjorn Helgaas wrote:
>>> On Thu, Oct 14, 2021 at 08:39:42PM +0200, Hans de Goede wrote:
>>>> Some BIOS-es contain a bug where they add addresses which map to system
>>>> RAM in the PCI host bridge window returned by the ACPI _CRS method, see
>>>> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
>>>> space").
>>>>
>>>> To work around this bug Linux excludes E820 reserved addresses when
>>>> allocating addresses from the PCI host bridge window since 2010.
>>>> ...
> 
>>> I haven't seen anybody else eager to merge this, so I guess I'll stick
>>> my neck out here.
>>>
>>> I applied this to my for-linus branch for v5.15.
>>
>> Thank you, and sorry about the build-errors which the lkp
>> kernel-test-robot found.
>>
>> I've just send out a patch which fixes these build-errors
>> (verified with both .config-s from the lkp reports).
>> Feel free to squash this into the original patch (or keep
>> them separate, whatever works for you).
> 
> Thanks, I squashed the fix in.
> 
> HOWEVER, I think it would be fairly risky to push this into v5.15.
> We would be relying on the assumption that current machines have all
> fixed the BIOS defect that 4dc2287c1805 addressed, and we have little
> evidence for that.
>
> I'm not sure there's significant benefit to having this in v5.15.
> Yes, the mainline v5.15 kernel would work on the affected machines,
> but I suspect most people with those machines are running distro
> kernels, not mainline kernels.

I understand that you were reluctant to add this to 5.15 so close
near the end of the 5.15 cycle, but can we please get this into
5.16 now ?

I know you ultimately want to see if there is a better fix,
but this is hitting a *lot* of users right now and if we come up
with a better fix we can always use that to replace this one
later.

So cam we please just go with this fix now, so that we can
fix the issues a lot of users are seeing caused by the current
*wrong* behavior of taking the e820 reservations into account ?

Regards,

Hans

