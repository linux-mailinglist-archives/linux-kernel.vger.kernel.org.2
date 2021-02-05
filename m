Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE92E310919
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBEKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhBEK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612520835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Rp1DAXoKwp5REwuto3wxp77HAsY8NDKCCfTe7Gd61I=;
        b=MrAeHEd70Nf9QqLTlZkE7K5BO4T73OEJf8Tv4kaataoww06rYHI4hiz/ksCqTgX8C8cGO/
        3Z2PwEqGNoLwVtra2KE8SkJoqRPSUg9uu5iTBjdya6N/dYmNklGkRO42G9tP3fK2/0mRgx
        +R7BiBM/Rkb7L0qemtOYkAsRiJzYIac=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-XChZw8VbN2ulgCsoH0BiTw-1; Fri, 05 Feb 2021 05:27:14 -0500
X-MC-Unique: XChZw8VbN2ulgCsoH0BiTw-1
Received: by mail-ed1-f69.google.com with SMTP id o8so6763797edh.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Rp1DAXoKwp5REwuto3wxp77HAsY8NDKCCfTe7Gd61I=;
        b=EDcf5/w9jOolKPuYCcpFp52yHVqbgmdsZs+cxP8SbgpJRkA0vbSaFp1oU+ghCPY8hf
         kDnVnwQuMzXZAgMSbqFItAmmoGOMJYHSMmEyGTKXcQFzXW6pwvsNVDlo8da6YRiGRdCR
         q7qW+kMyb9YYx/vMauraLqIEZcVdrcZsGKkujCZajn2590Mhe8ssus8QOXl22qIXIW6e
         Xm+duqJ+WOlZNQqwOhKXF+I43k9K2lZ+ZQ7LwRUsfYgbsqdZOQFGvplXUHX7RyEMb9fU
         oyqUx9fRUbXPHYQilG9RG29c/wylUSwKcKzul/8A/JK42Z/IRTnL7SicCVxxRNyCFk+O
         fhQg==
X-Gm-Message-State: AOAM531iU8AxzIctiyvD3e7zgFgZTdHG4ny6FUjpoVdFkidARAOXGKjJ
        is+/KgH7RXXzIaVzKE3bhKpmJBEnHBFQ10XGCLX4Dw/kVhjPVfBPFJb6nS6T2vtdIjc9g5q4DSo
        cmxWmLLLtHDhEFVuLFs4TdHmc
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr3476371ejc.176.1612520832979;
        Fri, 05 Feb 2021 02:27:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMeg8vtWuCF2yvK1oMI22FhfdUctuk7E5CMiQad8OqQUhNz1iB2hVXUKr+G1e2k93ewhGYbA==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr3476355ejc.176.1612520832790;
        Fri, 05 Feb 2021 02:27:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id f6sm1044759edr.72.2021.02.05.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 02:27:12 -0800 (PST)
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <CGME20210204112515epcas1p27a866811ba15a8cd8b0be9a3f7bf86e5@epcas1p2.samsung.com>
 <20210204112502.88362-1-hdegoede@redhat.com>
 <49c77228-75fa-8e0a-0cb9-57afdd3f6b86@samsung.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cf5cbd8c-2e00-03ef-5c38-dc6a5b80cf85@redhat.com>
Date:   Fri, 5 Feb 2021 11:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <49c77228-75fa-8e0a-0cb9-57afdd3f6b86@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/5/21 3:00 AM, Chanwoo Choi wrote:
> On 2/4/21 8:24 PM, Hans de Goede wrote:
>> Hi all,
>>
>> Here is v4 of my series to rework the arizona codec jack-detect support
>> to use the snd_soc_jack helpers instead of direct extcon reporting.
>>
>> This is a resend with some extra *-by tags collected and with the extcon
>> folks added to the "To:" list, which I somehow missed with the original
>> v4 posting, sorry.
>>
>> This is done by reworking the extcon driver into an arizona-jackdet
>> library and then modifying the codec drivers to use that directly,
>> replacing the old separate extcon child-devices and extcon-driver.
>>
>> This brings the arizona-codec jack-detect handling inline with how
>> all other ASoC codec driver do this. This was developed and tested on
>> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
>>
>> This was also tested by Charles Keepax, one of the Cirrus Codec folks.
>>
>> This depends on the previously posted "[PATCH v4 0/5] MFD/ASoC: Add
>> support for Intel Bay Trail boards with WM5102 codec" series and there
>> are various interdependencies between the patches in this series.
>>
>> Lee Jones, the MFD maintainer has agreed to take this series upstream
>> through the MFD tree and to provide an immutable branch for the ASoC
>> and extcon subsystems to merge.
>>
>> Mark and extcon-maintainers may we have your ack for merging these
>> through the MFD tree ?
> 
> 
> About patch2~patch6, I agree to take these patches to MFD tree.
> Acke-by: Chanwoo Choi <cw00.choi@samsung.com>

Great, thank you.

Regards,

Hans


