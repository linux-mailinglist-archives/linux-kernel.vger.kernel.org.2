Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0768F3F45D9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbhHWHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235110AbhHWHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629704126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6OA8eH4X+/rUwV1XCNtrrURDB+H2MofOHgguQaSqFBQ=;
        b=FiPk9U9+p44wds9zlFaBMHVuHZoIMuD0PyFi5kInNQGtFJXnowDlvc/lvsOdRssBU34YfQ
        ALn8e6FEYK4+nSUyC+T7gDjN5NG8R154Ajp2ZVqRijwMxOw3nejd5ByKf6Pm9FUs9gVY+M
        KBfiKRFALbWb+NRPPCGgLYkmuViVzgk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-LmPJ9y7mM1CxfEBUHVtXEw-1; Mon, 23 Aug 2021 03:35:25 -0400
X-MC-Unique: LmPJ9y7mM1CxfEBUHVtXEw-1
Received: by mail-ej1-f70.google.com with SMTP id ak17-20020a170906889100b005c5d1e5e707so581890ejc.16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OA8eH4X+/rUwV1XCNtrrURDB+H2MofOHgguQaSqFBQ=;
        b=FmNnx9IyoD0KcKBLyverps6i1E4EOlLC0/46RBzpycn5GdizJeRCPhq2llwrh+Tc4s
         64xOvGYUO8Z74qIeaupczvKokZDRVIk4Dt+k1A6g27WELKCweu48fKRcOX7wYGNAJ0Uq
         75NsCQvxhpVMFNGUkLD7AeYL4KUsnb37QRcVftNvkVRlPRLwQEISL7180fT5AKgJzKXZ
         yGvnYH3NESCbaExL+fkLnofbLIX+AGwAZHSd4Ru8SZAsbh2VCO0Mvu7GKSQnLhms9Jng
         i1buyVYLla7KpB5KwWSP0+29rFA9k1l80vLMLpA60hlCfPxy9R/12TYSiU/Tewsc6xCf
         TLpg==
X-Gm-Message-State: AOAM530+zrqIvt8gig4GeLtHlL+h8mnL5QmpcvCt9DOGV87gqMZr11W2
        NDsvwc3dXETqw2x8lYpyQWd6iQ3SPgpVNwX+yxv8QcKos6COqTH0NmTBkleG9+ADHqJkBk1vOan
        4GlQZgVefHBfW/sh7e1o3P1mN
X-Received: by 2002:a17:907:12d5:: with SMTP id vp21mr11270073ejb.144.1629704124137;
        Mon, 23 Aug 2021 00:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBq9QKj048GdBmdC2ZCRCqLH/ZUbEYowgfxS/omx9bPbu/e87I0uqUwgFEMLs/NTuvVxYNiw==
X-Received: by 2002:a17:907:12d5:: with SMTP id vp21mr11270062ejb.144.1629704123966;
        Mon, 23 Aug 2021 00:35:23 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id oy11sm3669357ejb.104.2021.08.23.00.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 00:35:23 -0700 (PDT)
Subject: Re: [PATCH v5 07/20] platform/x86: pmc_atom: Move to intel
 sub-directory
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
 <20210820110458.73018-8-andriy.shevchenko@linux.intel.com>
 <ccae9fcb-fa2f-5c44-1241-9f107b358103@redhat.com>
 <YSNPGRt6azqfXFKP@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6a2c03a2-cb25-5e64-04bd-0e387c2d4cb1@redhat.com>
Date:   Mon, 23 Aug 2021 09:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSNPGRt6azqfXFKP@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/21 9:32 AM, Andy Shevchenko wrote:
> On Fri, Aug 20, 2021 at 08:18:17PM +0200, Hans de Goede wrote:
>> On 8/20/21 1:04 PM, Andy Shevchenko wrote:
>>> Move Intel Atom PMC driver to intel sub-directory to improve readability.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> This means that pmc_atom will now not be build if X86_PLATFORM_DRIVERS_INTEL
>> is not set (and PCI is enabled). Which will cause missing pmc_atom_read/_write
>> symbols in drivers/acpi/acpi_lpss.c. So I have dropped this patch from the
>> set, while applying the rest.
>>
>> Note I'm thinking that we should just remove the whole X86_PLATFORM_DRIVERS_INTEL
>> Kconfig option and in the drivers/platform/x86/Makefile replace:
>>
>> obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)                += intel/
>>
>> with:
>>
>> obj-y                                                   += intel/
>>
>> This will also allows us to fix the scu issue without needing any
>> changes to drivers/mfd/Kconfig .
>>
>> But this can all wait for the 2nd round of renames after 5.15-rc1.
>>
>> For now I'm moving forward with this v5 series, except with this
>> patch dropped.
> 
> Indeed. Thanks for the analysis.
> 
> Btw, should we convert Dell subdir to something similar in terms of Kconfig?

I'm not sure, if someone is trying to build a minimal kernel then being able
to say 'N' once for all the Dell drivers make sense. OTOH even someone
building a minimal (x86) config very likely still needs some of the Intel
drivers.

So I think we should just keep the Dell bits as is.

Regards,

Hans





> 

