Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81DD3F1A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240078AbhHSNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240010AbhHSNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629380081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ps+yLkOEy/hrcU9IbnjByrznQShPQ8E81PW5BMepISY=;
        b=FBBmDXevac+tySaE7/qYSB27wKdvVHFYmSgzSWvch0k4ZH3JGyxOMtolnlbuDGLFSzs1w+
        D4GQYCcYa+bUtoagGiuaELTLxcdqAkir4r6EJPLQ8IlDKGiN8annVvOjrh8A7xTM7bDqnq
        bgzfpvSIvzdqhL5yx8LC3K0fpsX8Hxk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-XDs8g5TfOFCFTwxZyiAQdA-1; Thu, 19 Aug 2021 09:34:40 -0400
X-MC-Unique: XDs8g5TfOFCFTwxZyiAQdA-1
Received: by mail-ed1-f72.google.com with SMTP id z4-20020a05640240c4b02903be90a10a52so2820962edb.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 06:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ps+yLkOEy/hrcU9IbnjByrznQShPQ8E81PW5BMepISY=;
        b=QVEC8vmFr/kbfzr+9BM9ACVhcCunxyAGrbBvAb0IAj9rSN7iUm7uuSJSMQ58jaV4wN
         xUEeZZ6BmUe42RE+UVzkEdqLLDF/Prq6rZBq3AWveg1RpXIFp6NILUhsvrAlFVfyZCYl
         jcH2kOPcVptXFlidL2T/3UWJKx3MJiNUo+s+DN2FcAFTk+NO9nGRfsRKWUV7LlZvrBy7
         ISXhHQ7DkDVzp9lFyqMSBxTX123gZF7Jom+L4+feKAkSuXzdndhHbXthrELA6dLgj92N
         +Q74vY85CSW9hRO7u09fMf1R0AgQU19EZj5YnrRiyxbrxppin8Kw54AYsZ73NzXyif7A
         ZGHQ==
X-Gm-Message-State: AOAM532N+Y8sXp4aeVbqEh/0aMzSfMyd5hRKZ1/WZrUqi6Mabv3+b0mW
        HMZXuskgcpBBQuSio6RYntJFihasJ5W87a2Mj1IgoNm4PVE16fAcyOq/ovn2AOnzMuA/7DJ2JZK
        uTLVy4Pp9xLM5ZLW8QaOridCO
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr16549120edd.211.1629380078825;
        Thu, 19 Aug 2021 06:34:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwwMpLOCS3BaI6SAkMBcbSfFImX5Pv/q+Bhb98HnIHQoJzN+K8bxXklRlSvXgJvsQvJ0ZGew==
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr16549101edd.211.1629380078700;
        Thu, 19 Aug 2021 06:34:38 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id da1sm1793286edb.26.2021.08.19.06.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 06:34:38 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] Intel platform driver code movement
From:   Hans de Goede <hdegoede@redhat.com>
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
Message-ID: <07cfd37a-cce6-56f2-0ff1-d4daeccfc67c@redhat.com>
Date:   Thu, 19 Aug 2021 15:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a5e52890-c162-ab48-4858-3eb0e971e5a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 3:31 PM, Hans de Goede wrote:
> Hi,
> 
> On 8/19/21 2:14 PM, Andy Shevchenko wrote:
>> On Thu, Aug 19, 2021 at 3:03 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Aug 19, 2021 at 1:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>>
>>>> Thank you for your patch-series, I've applied the series to my
>>>> review-hans branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>>>
>>>> With the changes mentioned in replies to individual patches.
>>>
>>> Can we postpone this a bit, please?
>>>
>>> I have a few comments here and there. I'll send asap.
>>
>> Hmm... It seems it will take less time if I simply take what you have
>> in your repo and produce a v4.
>> Would it work?
> 
> That is fine by me, I might be better to just do a small follow-up patch
> though, given that you seem to only have a few small remarks.
> 
> But if you prefer to do a v4 that is fine too. I was planning on
> keeping this in review-hans for a while anyways.
> 
> I did notice the couple of stray changes which you pointed out but
> they get corrected by other commits (or are removal of extra whitespace
> left-over from other commits), so I decided that they were harmless
> since the end-result Makefile / Kconfig files were good.

p.s.

Note that drivers/platform/x86/intel_ips.h is deliberately not moved
(for now) since it is also used by the i915 driver.

My plan is to merge a follow-up patch moving that through drm-intel-next
once 5.15-rc1 is out.

Regards,

Hans

