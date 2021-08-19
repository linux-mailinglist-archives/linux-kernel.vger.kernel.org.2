Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92F3F1B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbhHSOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238385AbhHSOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629382128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F1dSKGuznQXHJo/a/g/86LxQF+PyMn3A5VP447VPq4=;
        b=N2YeB+cPAFaAS6JnSwKzbWiWZrRXyQ9gtWd093ufLU1HsPVvgLTbOvpYdjAvC7lE/Eoh9K
        wHiD3iRT5JL/n6peiIUHo51TrRNtGS29zGbtTi6/up2puwjotmW2eaqNyILw2ld2pbIocK
        9aWCBFhlZL8uwnHvRayyLj9o4uiMcAs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-BBzawbQAMjyc9QjqHbwdWA-1; Thu, 19 Aug 2021 10:08:47 -0400
X-MC-Unique: BBzawbQAMjyc9QjqHbwdWA-1
Received: by mail-ej1-f69.google.com with SMTP id h7-20020a17090619c700b005bc3c7dead9so2300141ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 07:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2F1dSKGuznQXHJo/a/g/86LxQF+PyMn3A5VP447VPq4=;
        b=B3zUvLfU6HLq3FayAKrvdOcbyEEtBoUpf6BhuxZ6zuTQKY4vZ1StL6u+t8GZZVBEmn
         DeUlsNNSMpo/HVhljyp7M4GwF+GAX7qDcbQ55F6bMuuhJwVYBe5Q9R94HaYBPmBFd9b0
         JZWwoqsjeN4qLtRtyFyg2nAHtAYC5ds9bDVfqejUvdOMTaHdm7qbix/g19d4TbrAdALx
         1GdBRO8nO5UeymrO0xYaSPGCmQAz3CirrJRjqikCELYDdN6xax6ylpHH2ann7Mt6lQsu
         GbsECsF/uvMmcCiUOQH5yFAMGDl8Uq+EEGPpyuB3/et1Z9b7wF2QbLT45GgcG3jmT1+c
         IoDw==
X-Gm-Message-State: AOAM530hnrqvGSY/3PHKMMvS44NOm8dKM4cH49LKzTe+R3L0WdhfwD5N
        grj7E4WfLg7hYBeMVIRxvEUi5K455mShMkv8XxoPzC62dEiq6S9vsbupbfc13t/ETkpsjj6kV1v
        85PiShRIMX0OUmk6L/mSir3Cz
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr16175952eje.29.1629382126022;
        Thu, 19 Aug 2021 07:08:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9zhOERw3eniU+oEfoni7CeWjvoPSXJX1DSQJT2CcpSeJlKv7kqgKMujE5GRkMIuAeDeN3vg==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr16175936eje.29.1629382125840;
        Thu, 19 Aug 2021 07:08:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ne22sm255341ejc.113.2021.08.19.07.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 07:08:45 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Intel platform driver code movement
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20210819033001.20136-1-hpa@redhat.com>
 <1360c64f-b695-a4b8-8b61-a4dfb0e896f0@redhat.com>
 <CAHp75VcdOc+G1Yov9HcGhMbEqzGwemmD7=SHd3qOOsEdAqjg2Q@mail.gmail.com>
 <CAHp75VfvjVeq716d=aGvZXvmzbpW4+XG66ryVYrBxk5G5Wd6cg@mail.gmail.com>
 <a5e52890-c162-ab48-4858-3eb0e971e5a1@redhat.com>
 <07cfd37a-cce6-56f2-0ff1-d4daeccfc67c@redhat.com>
 <CAHp75VfTc5tyoVnWYBsu9dNJyqyN1wLB2qEqSXyCdtYqZEzq9Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b521dd02-4ea6-c604-b851-ee41e8d1ad33@redhat.com>
Date:   Thu, 19 Aug 2021 16:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfTc5tyoVnWYBsu9dNJyqyN1wLB2qEqSXyCdtYqZEzq9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 4:01 PM, Andy Shevchenko wrote:
> On Thu, Aug 19, 2021 at 4:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 8/19/21 3:31 PM, Hans de Goede wrote:
> 
> ...
> 
>> Note that drivers/platform/x86/intel_ips.h is deliberately not moved
>> (for now) since it is also used by the i915 driver.
>>
>> My plan is to merge a follow-up patch moving that through drm-intel-next
>> once 5.15-rc1 is out.
> 
> Why we can't do it in the same patch?

Because the intel-drm code is seeing a lot of churn, so that will
cause conflicts. It will be a lot easier to do the move of that
last file through the drm-intel-next tree once this rename series
has landed in 5.15-rc1

Regards,

Hans

