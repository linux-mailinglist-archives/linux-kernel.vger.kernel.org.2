Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BE363DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhDSIsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232457AbhDSIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618822071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxEU468BRu9ZVaMiIpuJHS/ZcAfBHejQNQ+n217rn6s=;
        b=JxkoshdGQG1+OflsGYfgxasxhLrslr/+bkJLLThxWS6tnKIzmkxB3fD/h4AMOcYpNV5gZ2
        XtPm0pCN1b0I/A5LaEPSq1yduh76vF2gHSkA6/bSD03fexxQvvUxJ7GHVjhYtuN1abOQ5P
        z1i/wQkUlfj3uhL+yn4GH05psVc8Vy0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-AAuQ1uNvN4eZ25jk16MxZQ-1; Mon, 19 Apr 2021 04:47:49 -0400
X-MC-Unique: AAuQ1uNvN4eZ25jk16MxZQ-1
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso10780135edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TxEU468BRu9ZVaMiIpuJHS/ZcAfBHejQNQ+n217rn6s=;
        b=dphAVbIPdziowvjZnS95ZxsRhoWmqWb9XqGxxelETm3M1kpxdj5tGlc+VdRGx22T33
         8UK3fgw9tJh8FCWx72D6H3HAGcsFQbD90KyjD0VMqgHEsCf6jtVKPI6MxKQNSWQGoHcd
         e4aLVdbcHN+IqsMzVqluuQrszjmfsxJxwELFug5Wzx7WdaCPKu7T3Tdx7sLtJ1aQQ3HS
         m9Hje3GyPAafncRjsDqK6O0tL57B/fIMV02c0+bbAfSoDBf0ADchXyT7lJs1hDinXUHJ
         mXySqqoeaMRxrRbmCLWyvdcyE2DnZMS9zMUpc7SxElJAQGxj6yLEgWFIlHHT+PzTK/ES
         ymRQ==
X-Gm-Message-State: AOAM532MGuTOaJRhni080imGA2gZg7Wv4tId6xH7vpKt8GjgCXJ8vVS7
        dKurHcTxUsyLn2Dq96hevgnp4mS/Mhi0uBWE1U0iWbOR9rTGIUVpSyXGdAFXDFoa6Omo/7YFIlE
        JRzYveHgvh9mJ1YvO1WpWCc8z6AiHCWb2xaq+1hR/ZIOt1FaLtxwfFaRGptfzNMRDxRER9EtAH8
        P+
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr24563656edd.284.1618822068219;
        Mon, 19 Apr 2021 01:47:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjZTrj/sQdoPPdiidE/xwn8qOg9Ltfp5oxHdIWPKwp1IK6q2DJKTDbhI5Vh0YwTI4lN8uHaQ==
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr24563633edd.284.1618822067962;
        Mon, 19 Apr 2021 01:47:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l6sm4087909ejc.92.2021.04.19.01.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:47:47 -0700 (PDT)
Subject: Re: [PATCH V2 0/9] intel_pmc_core: Add sub-state requirements and
 mode
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c095e327-a617-6013-1ed1-a6c5f7fbf4e5@redhat.com>
Date:   Mon, 19 Apr 2021 10:47:47 +0200
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

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



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

