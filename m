Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36D941B1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbhI1ORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241191AbhI1ORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632838553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWD5TlJk9nEWaPVGYxsFMEI0pK3OkzOISyOGy4sUKVk=;
        b=U4MTJA1ip221059GlNadnLFluwpl1ZP+OnNPjv2t2oiaJIcpbRPaR3L0PoFRQXaJ2T2kNV
        fr/JDwbYzo8Lj/K+TOfzaNGu5FFDwcvQzQPQfHFOP0JPLS8a3GOwsteAQmEiVljjydywQ2
        hQfEAaK6qFsKGgol6DFHLN7e1ouFwcU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-Vod1PK04NwubKA0XeWnX-g-1; Tue, 28 Sep 2021 10:15:52 -0400
X-MC-Unique: Vod1PK04NwubKA0XeWnX-g-1
Received: by mail-ed1-f70.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so21899144edv.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWD5TlJk9nEWaPVGYxsFMEI0pK3OkzOISyOGy4sUKVk=;
        b=3FTh1cpNUpxDf4Sc2PvdNW74O5Omloo3Dq/tbgZLeffrjmZLHKi0xqJApOWL+gurqi
         gMZMr07Gqm2NR5e1B33xcGEIjgjXZ3587FWm1Ee92edfUTRvAXV/91eeNOlCh2JOGLt1
         O6U2PLE3r43eSc/VyGtU6Uz/aIXjx1JVga1QfvFHrukbRxsu/7gFmJAG0aEwqwC/v1MA
         ixsjl2DJggoKtF2wR3/TWighunyLvUYcPymbQxtS4aqN7RyJk54ACvm5DsF9Xi3C8rHc
         D6d87XWfipUpRa2XPrWDkYTzHm5MKoyBMOlCog6jCzLmd8Ogfo9h9qmeuscJ4lGau7gj
         JQTA==
X-Gm-Message-State: AOAM530UMUFVj5SB3def3EgfWd5tYrU8l5D01QgIb4a85saHp+4NwoH7
        YY/Ghvbwnnvpu61UzNcCLDGY3MDTOgc9Ca2EpgpQzKTPZa/6HjDWIW0n2lPCb4uSDpG19bYtTZY
        HNf/siBpcQdXIoBkiuxwKx6tUttM62xkpM0F9Mf4trp07Tux87i2WVerMUjxrONHk1EfMYs38da
        Gt
X-Received: by 2002:aa7:cd41:: with SMTP id v1mr7736201edw.393.1632838550554;
        Tue, 28 Sep 2021 07:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfHnHmottUyITNFI3BM8y9fnS2kCoEoR02Q5lm5KG8/zwP0QPMUq5GonGE/k8IAfaEtgzmVw==
X-Received: by 2002:aa7:cd41:: with SMTP id v1mr7736179edw.393.1632838550363;
        Tue, 28 Sep 2021 07:15:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k18sm12063530edv.41.2021.09.28.07.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:15:49 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: amd-pmc: Export Idlemask values based on
 the APU
To:     Nathan Chancellor <nathan@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916124002.2529-1-Sanket.Goswami@amd.com>
 <YUz2t+bdes2I+gMK@archlinux-ax161>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <09b3489b-3474-c626-d312-cde1cb023397@redhat.com>
Date:   Tue, 28 Sep 2021 16:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUz2t+bdes2I+gMK@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/23/21 11:50 PM, Nathan Chancellor wrote:
> On Thu, Sep 16, 2021 at 06:10:02PM +0530, Sanket Goswami wrote:
>> IdleMask is the metric used by the PM firmware to know the status of each
>> of the Hardware IP blocks monitored by the PM firmware.
>>
>> Knowing this value is key to get the information of s2idle suspend/resume
>> status. This value is mapped to PMC scratch registers, retrieve them
>> accordingly based on the CPU family and the underlying firmware support.
>>
>> Co-developed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> 
> This patch as commit f6045de1f532 ("platform/x86: amd-pmc: Export
> Idlemask values based on the APU") in -next causes the following errors
> when CONFIG_DEBUG_FS is disabled:
> 
> drivers/platform/x86/amd-pmc.c:424:2: error: implicit declaration of function 'amd_pmc_idlemask_read' [-Werror,-Wimplicit-function-declaration]
>         amd_pmc_idlemask_read(pdev, dev, NULL);
>         ^
> drivers/platform/x86/amd-pmc.c:424:2: note: did you mean 'amd_pmc_reg_read'?
> drivers/platform/x86/amd-pmc.c:131:19: note: 'amd_pmc_reg_read' declared here
> static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
>                   ^
> drivers/platform/x86/amd-pmc.c:448:2: error: implicit declaration of function 'amd_pmc_idlemask_read' [-Werror,-Wimplicit-function-declaration]
>         amd_pmc_idlemask_read(pdev, dev, NULL);
>         ^
> drivers/platform/x86/amd-pmc.c:536:2: error: implicit declaration of function 'amd_pmc_get_smu_version' [-Werror,-Wimplicit-function-declaration]
>         amd_pmc_get_smu_version(dev);
>         ^
> 3 errors generated.
> 
> Should these functions be stubbed or should there be a different fix?

Thank you for the bug report.

Since these functions are also used outside of the debugfs show functions
they simply need to be moved outside of the #ifdef CONFIG_DEBUG_FS
block. I'll add a patch fixing this to pdx86/review-hans and include
it in my next pdx86-fixes pull-req to Linus.

Regards,

Hans

