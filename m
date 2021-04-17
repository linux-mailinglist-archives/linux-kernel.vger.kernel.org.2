Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB7362ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhDQJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhDQJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618650747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCAUfIYkdpTGynKIaUv71vkYD7F6xLlVWHSczcQnpTs=;
        b=KtL8iHilJ8nYrFcYNDj9z3h+4pd1dJUP11Ro8AcBaD1QODVpwHXV1c3nh3S9leYkG2Id5+
        4nhtQeUPHQbMg9uyQs8fwvpRK+uRcKa58H5kP80cbLpFLrCk+qwEzmAYPyNkVmXlV2P7qr
        af3nnXX158l+N8QkWDBTO+rIOpmH1Vg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-apaWaSa8Phyor2e-bv_RjA-1; Sat, 17 Apr 2021 05:12:25 -0400
X-MC-Unique: apaWaSa8Phyor2e-bv_RjA-1
Received: by mail-ed1-f70.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so8413019edb.22
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 02:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JCAUfIYkdpTGynKIaUv71vkYD7F6xLlVWHSczcQnpTs=;
        b=lpxmWBFELbvH3kWMI7jRbb6BsD8jYTKzmNCLQTak2GogSD6UMmaTgbi3ZsefwBIotJ
         0LHAdDU9N16y8+rJPakyc1N5zOZ1biTg61pxIvEE2sLoc/kMXRJBJ0PX1Dxt/XgchcWM
         kkHPA2AmViXMOTz6zqT9i78x70/KX3bPoZEDy3NmCDIyofWBTTR8PrNaeCqZDy8AcAor
         ss6zRa+ANBOFOOpSNP43II0lh/35U0TicWjHKP1GvwE/gFv7LQXKlRDglgQG+YOHXnuc
         V3HSeSg/9AwykkVmx5rotVpSq4cAF3Vp988D3fYB5JHbTOnh6A/Nj3+VFyodymQDKbvv
         K2wQ==
X-Gm-Message-State: AOAM533a44VtEH3uZ2sY6hBZvH4uTDRDglsxl/jFEdIgrps01lzwfTzZ
        9tvgLMbzLnf30sw6aAE7DTOhfeRsAbHmIhg1XgMW7qLcT5tf5iebcFy44vwiS52bNwUamGW9fku
        5FYfuurlFMBnrMrzVUhvvWXu4UCwEy9FZeA1pW9kogNQTKv4IeqzicGy4z+2LpguJ/S9ptfo21R
        VF
X-Received: by 2002:a17:906:9bd3:: with SMTP id de19mr11853762ejc.329.1618650744421;
        Sat, 17 Apr 2021 02:12:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhRPpxjMNiQ8NjjYPjJFIyPgs7wEJEFEI5l/ty3UqCm2Hu5sw3UmnEQlOyAvHTghEBsrqt0g==
X-Received: by 2002:a17:906:9bd3:: with SMTP id de19mr11853743ejc.329.1618650744188;
        Sat, 17 Apr 2021 02:12:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b8sm7935010edu.41.2021.04.17.02.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 02:12:23 -0700 (PDT)
Subject: Re: [PATCH V2 0/9] intel_pmc_core: Add sub-state requirements and
 mode
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5b372264-3504-5e98-da20-859709acea8f@redhat.com>
Date:   Sat, 17 Apr 2021 11:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/17/21 5:12 AM, David E. Box wrote:
> - Patch 1 and 2 remove the use of the global struct pmc_dev
> - Patches 3-7 add support for reading low power mode sub-state
>   requirements, latching sub-state status on different low power mode
>   events, and displaying the sub-state residency in microseconds
> - Patch 8 adds missing LTR IPs for TGL
> - Patch 9 adds support for ADL-P which is based on TGL
> 
> Applied on top of latest hans-review/review-hans

Thank you, the series looks good to me know, except for one very minor
issue in patch 5, which as I already mentioned in a reply to patch 5,
I can fixup while merging this.

Once I have you ack for the prososed changes to patch 5 I'll merge this
into me review-hans branch.

Depending on if Linus does a rc8 or not I'll then push this to for-next
for 5.13, or this will have to wait for 5.14 :

Linus does a rc8          -> I'll promote this from review-hans to for-next in time for 5.13
Linus releases 5.12 final -> I'll rebase my review-hans on top of 5.13-rc1 once released and
                             then push this to for-next

Regards,

Hans




> 
> Patches that changed in V2:
> 	Patch 3: Variable name change
> 	Patch 5: Do proper cleanup after fail
> 	Patch 7: Debugfs write function fixes
> 
> David E. Box (4):
>   platform/x86: intel_pmc_core: Don't use global pmcdev in quirks
>   platform/x86: intel_pmc_core: Remove global struct pmc_dev
>   platform/x86: intel_pmc_core: Add option to set/clear LPM mode
>   platform/x86: intel_pmc_core: Add support for Alder Lake PCH-P
> 
> Gayatri Kammela (5):
>   platform/x86: intel_pmc_core: Handle sub-states generically
>   platform/x86: intel_pmc_core: Show LPM residency in microseconds
>   platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake
>   platform/x86: intel_pmc_core: Add requirements file to debugfs
>   platform/x86: intel_pmc_core: Add LTR registers for Tiger Lake
> 
>  drivers/platform/x86/intel_pmc_core.c | 384 +++++++++++++++++++++++---
>  drivers/platform/x86/intel_pmc_core.h |  47 +++-
>  2 files changed, 395 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 823b31517ad3196324322804ee365d5fcff704d6
> 

