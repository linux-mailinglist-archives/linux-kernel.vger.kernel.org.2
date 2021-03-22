Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40934463F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCVNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhCVNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616421210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YX43vCy2WUlGP7TvkvyNeq4LZoZxhLjixCZwpawUM0w=;
        b=cqKitgi4NgCIg/ywX7uyTdp8goPb/sxjRrzq0Hq9MfzCkJKlNecO89Z+mHovRlT/+L/42I
        Wwfv9o/jbnY6xUMDKLuQVu/BfySNtwcWOBwkcB58b2ABdxzZhOjkc+CaUgD8rde8IrSrTz
        M41E9PY96ZIwGeBqnXHP9Q9ROnbhIRw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-bENQiTPKM4-Zr7ovOIkERQ-1; Mon, 22 Mar 2021 09:53:28 -0400
X-MC-Unique: bENQiTPKM4-Zr7ovOIkERQ-1
Received: by mail-qt1-f200.google.com with SMTP id f26so2561034qtq.17
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YX43vCy2WUlGP7TvkvyNeq4LZoZxhLjixCZwpawUM0w=;
        b=ejJKOqy7Ydv9jAYrxZw+0NPX3g5vU2JGWzVrz5y3mf5KyK1uaHt+VylcjmQXFFAGYO
         fzE+ousjZJ1ZAJ99UjxAwyCxD3f0fB9lXyma8R4A2BrcK7JvVmVspa5gP0B1uHt6aBsB
         3Wjrcy1PqN9AEPtFGTb1cBNezRBB3oI32tIW9LLXKoV8XXJX6RaPaLIWlDNNT9bpubSc
         1pwe0GKfLs0qyEarpuUdu0nTt9ke9KonKOQOX3qozrQEp0dwnZYDVTlKFTltYZamPF1G
         efdxW2W2pCA5K+rAoMTzPUp1WeukD8HIaqRwbWHn0nET7ltYUnzPNAMiR5M+QtT/eAeQ
         hI1A==
X-Gm-Message-State: AOAM530WijswfBQeVJmddiq12qlIP7zNkMcCWWkJrYh0V4fRiSYxnHkw
        zJ8cRjwYg3XTmABsC7QDhp+qsQcEpSGFIoj/iUw8xR9jwTWsYmtyMINCwuR8rf0/eaVsy3Rg2cq
        BQTMztRXNoOB+9e+/tO0XNDw6ns6dE0D4pisVIyg20R0r2CWiVq2LyhPBTfOni9jYEwkyb38=
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr152174qks.50.1616421207997;
        Mon, 22 Mar 2021 06:53:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygFrO8AcF6UbXAgOCygfrk+do7UcB3lzSBL1CMcFCP6Bt7B9+bXd6RV1hCFS00tg8N4MCheQ==
X-Received: by 2002:a05:620a:806:: with SMTP id s6mr152139qks.50.1616421207623;
        Mon, 22 Mar 2021 06:53:27 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j30sm9086495qtv.90.2021.03.22.06.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 06:53:27 -0700 (PDT)
Subject: Re: FW: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and
 region
To:     Richard Gong <richard.gong@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <21a8817a-e63e-6029-69a6-6bae5398439a@linux.intel.com>
 <1d7fd02b-4ef2-8d11-fba7-87a698699978@redhat.com>
 <MWHPR11MB0015516D86D02A0FE5423D6387669@MWHPR11MB0015.namprd11.prod.outlook.com>
 <7ef6739f-e2f6-d457-5498-1c6ed8ba2075@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f7a0c3fb-84f6-073c-ac41-45ce249cfa1e@redhat.com>
Date:   Mon, 22 Mar 2021 06:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <7ef6739f-e2f6-d457-5498-1c6ed8ba2075@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/21 2:05 PM, Richard Gong wrote:
>
> Hi Tom,
>
>>
>>
>> On 3/19/21 4:22 PM, Richard Gong wrote:
>>>
>>> Hi Moritz,
>>>
>>> Thanks for approving the 1st patch of my version 5 patchest, which submitted on 02/09/21.
>>
>> This change
>>
>> e23bd83368af ("firmware: stratix10-svc: fix kernel-doc markups")
>
> This patch e23bd83368af is not from my version 5 patch set.

Correct.

But since it is already in char-misc-next, your version 5 patchset will conflict with it.

I could not apply this patchset to my unoffical fpga-testing.

I am suggesting you do a test application of your patchset against char-misc-next.

And if you find there are issues, rebase your patchset. 

>>
>> Makes a lot of formatting changes in the same files as this patchset, including the first patch.
>>
>> It would be good to try applying this patchset to char-misc-next and resubmit if there are conflicts.
>>
>>>
>>> Can you help review the remaining 6 patches from the same version 5 patchset? I need your ACKs to move forward, or please let me know if additional work is need.
>>
>> These changes look good to me.
>>
>> I was looking at the patchset again seeing if the firmware/ parts could be split out.
>
> No, we can't split out the firmware parts.

ok

Tom

>>
>> Even though stratix10 is a fpga, from the MAINTAINERS file it is not clear to me if linux-fpga owns them and they come in on Moritz's branch.  I think this change is needed to the MAINTAINERS file to make that clearer.
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa84121c5611..1f68e9ff76de 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9193,7 +9193,8 @@ F:    tools/power/x86/intel-speed-select/
>>     INTEL STRATIX10 FIRMWARE DRIVERS
>>   M:    Richard Gong <richard.gong@linux.intel.com>
>> -L:    linux-kernel@vger.kernel.org
>> +R:    Tom Rix <trix@redhat.com>
>> +L:    linux-fpga@vger.kernel.org
>>   S:    Maintained
>>   F:    Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
>>   F:    Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
>>
>> I also added myself as a reviewer because I want to help out.
>>
>> Tom
>>
>
> Regards,
> Richard
>
>>
>>>
>>> Many thanks for your time again!
>>>
>>> Regards,
>>> Richard
>>>
>>>
>>> On 2/25/21 7:07 AM, Gong, Richard wrote:
>>>> Hi Moritz,
>>>>
>>>> Sorry for asking.
>>>>
>>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>>>
>>>> Regards,
>>>> Richard
>>>>
>>>> -----Original Message-----
>>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
>>>> Sent: Tuesday, February 9, 2021 4:20 PM
>>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Cc: Gong, Richard <richard.gong@intel.com>
>>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>>>
>>>> From: Richard Gong <richard.gong@intel.com>
>>>>
>>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>>>
>>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>>>
>>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>>>
>>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>>>
>>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
>>>>
>>>> Richard Gong (7):
>>>>     firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>>>     firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>>>     firmware: stratix10-svc: extend SVC driver to get the firmware version
>>>>     fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>>>     fpga: of-fpga-region: add authenticate-fpga-config property
>>>>     dt-bindings: fpga: add authenticate-fpga-config property
>>>>     fpga: stratix10-soc: extend driver for bitstream authentication
>>>>
>>>>    .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>>>    drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>>>    drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>>>    drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>>>    include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>>>    .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>>>    include/linux/fpga/fpga-mgr.h                      |  3 ++
>>>>    7 files changed, 125 insertions(+), 18 deletions(-)
>>>>
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>>
>

