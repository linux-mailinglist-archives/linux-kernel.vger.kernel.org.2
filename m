Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4068A356F42
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbhDGOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353100AbhDGOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617806986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JsGWtEoCdr3zGRUAMmhrIg8TDL4ft+B27TPb9qYrBY=;
        b=LGx6I3PJ8cDn/Kq/ezpe5x7TS5yW1uLyTxxeXLtxO50JkNjMmVC/G4AOyjNty+CV6AnJ13
        8EKVx2KZvIFzBR8wskwimH7UKsIa9uTzgADuXirwdDRjxBNh/l5TVvN1QCxQNlqC5k2mjr
        HJUf/4239HXe1YXVkhONB/y1KOcT0KI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-u85dIExIO3qSr9fFZ1-8Vg-1; Wed, 07 Apr 2021 10:49:44 -0400
X-MC-Unique: u85dIExIO3qSr9fFZ1-8Vg-1
Received: by mail-ej1-f70.google.com with SMTP id jx20so3447880ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JsGWtEoCdr3zGRUAMmhrIg8TDL4ft+B27TPb9qYrBY=;
        b=hsAd1kJOto8avFwmXGl+2QTi0HnEbX6WNI73BkmAWncSt17AVDmOCg1a6ZSyjHqIUE
         eAQ2CYhQXH9qxwjGjob/5FHRg30jgZRCNVg7vIoNdDZ2hmJkAgW2dqPu0unIWFTHC7lG
         8sdrCDq+33u6xXhboXCF0d7dj0Slt8ak7wFG8alaqtNMBN8jDye/pCvE7xtaiQffImCG
         ZndYDLlm7lgnvXUmSQrJKj9IepOkGWxLbFkFaR1TZMW1P7ekFia4wHXUc25KC3S4O/S2
         odQvNUAyv88WWHcv9eedIXMTHPwq7vpCCznogOa6fAZuMrbhfcjxpsz0rOqrMISz/60a
         OChA==
X-Gm-Message-State: AOAM531XUlzC6HXD99PZ8NtjgxPe3AUalqxuP/kvaapxRtilL0vkfQyH
        DTf5muH5FWBsap6WAK5G1A7ZEZjL+feBGWn/tlYCySmbCis63x1wQYlysDJLXq6VGRFnBQW0w5I
        Hlal0sYsnq2BZxiok8tphiCbxjUUP7nbc8p2AsQNLLD27batw2lYr2ItE47O7Rl5kxPiADAKIX0
        Pg
X-Received: by 2002:a17:906:6bcf:: with SMTP id t15mr4255002ejs.252.1617806982640;
        Wed, 07 Apr 2021 07:49:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywzceHMmr/aBnghYFEU/cRHINVV7jvAY6AaT0S4fVfyNds5n7GPvYOsJRF+ILpB089AE4QCA==
X-Received: by 2002:a17:906:6bcf:: with SMTP id t15mr4254975ejs.252.1617806982278;
        Wed, 07 Apr 2021 07:49:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e5sm7975833edr.64.2021.04.07.07.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 07:49:42 -0700 (PDT)
Subject: Re: [PATCH 0/9] intel_pmc_core: Add sub-state requirements and mode
 latching support
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a5d476c8-5c38-b8fc-a0da-65a28c5a14e3@redhat.com>
Date:   Wed, 7 Apr 2021 16:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401030558.2301621-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/21 5:05 AM, David E. Box wrote:
> - Patch 1 and 2 remove the use of the global struct pmc_dev
> - Patches 3-7 add support for reading low power mode sub-state
>   requirements, latching sub-state status on different low power mode
>   events, and displaying the sub-state residency in microseconds
> - Patch 8 adds missing LTR IPs for TGL
> - Patch 9 adds support for ADL-P which is based on TGL
> 
> Applied on top of latest 5.12-rc2 based hans-review/review-hans

Thnak you for this series, this mostly is fine, a few small remarks
on patch 5/9 and 7/9 if you can send a v2 addressing those, then
this is ready for merging.

Regards,

Hans


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
>  drivers/platform/x86/intel_pmc_core.c | 359 +++++++++++++++++++++++---
>  drivers/platform/x86/intel_pmc_core.h |  47 +++-
>  2 files changed, 370 insertions(+), 36 deletions(-)
> 

