Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE83ECF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhHPHof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234168AbhHPHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629099842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QIX04iLjnCf2vT5vquc36H0oSWZk+G6f4T6BcmkOvGo=;
        b=PBZhKOjI0dRIQUzNTCWz4oggw3BwdANskN5vqQ4JJES3uzLO/mw9usxpszV9RrdQV9F5sp
        fBdKL0HPwS9UCL3A2c06lERXbPSGaYlKxzXoiRCWt8ARn8GQM6W98+vJjNU2ncUr5XSwxe
        /ZFbQnCMWA7azfez7YhzCnlfo2yFSGw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-7W3ANGzLNyi2EkRug8ZQRA-1; Mon, 16 Aug 2021 03:44:01 -0400
X-MC-Unique: 7W3ANGzLNyi2EkRug8ZQRA-1
Received: by mail-lj1-f200.google.com with SMTP id e13-20020a05651c112db02901b29ccfa84fso5625245ljo.22
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIX04iLjnCf2vT5vquc36H0oSWZk+G6f4T6BcmkOvGo=;
        b=oPKC6A076HDWIS24XEbjAMvUcpaMS9Lgr5XEr+CC4dWNtcyzIkU5PGkSMBMslNzonw
         4AMjfuTXHtVfaeLBVpzgb2315WmvE0IPkAYnRA1DZnQzJNB2H6Mq/kuD7+ejiC8UPgxY
         DxJFWx8jwKX1p20c9OYh8ZfJTT7cn2ZQprIjJy39UodgH6kZ+SVfWc4ToCpohZP81bzl
         qi4d+apJrt3FBM8TqkctTib5nnJGWE+l0Jra914DT4q7nNyA7JFxoxgLL+pk8SBh7Dnq
         sS/NX6MqsKevSNhcFMyyrTP7shjL36QxfkV63uPjiXqGVkMh/IllROCs88jBz8XcPNzK
         csaw==
X-Gm-Message-State: AOAM5317swRMe6OD8xIEqEzfWaDpHHnBkCxfV5auqTzVhgsksnmhh9bH
        OGfccjFyTjMyqxWDPDPPBePxwGwV1cVOeP0kKrJAxHvEhqr3hDoNrjIK4NvKcF9fGewPwwLHUx1
        C3/N53zd3YcGwceHzt3FgRBEitgwBRPYYCvFZW8zH
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr10397735lfa.108.1629099839760;
        Mon, 16 Aug 2021 00:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvRSNzROcYYK6EadpNVDBwFmCb8c3uDhuU5GBcLxcE6RgVpcKxQHBPHENxIALF2lINTj7GYITh8XLBqLNJrxw=
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr10397716lfa.108.1629099839460;
 Mon, 16 Aug 2021 00:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210810095832.4234-1-hpa@redhat.com> <20210810095832.4234-19-hpa@redhat.com>
 <95801e67-f09e-64f3-abd6-f38a8f1f1d51@linaro.org> <2cc45082-692d-1a0e-cb44-7e2393c95152@redhat.com>
 <5a80a56e41369204b7729d25f72dfcdd09919033.camel@intel.com> <e76e99b1-e66b-6339-00a7-b3e2aa0ab8a8@redhat.com>
In-Reply-To: <e76e99b1-e66b-6339-00a7-b3e2aa0ab8a8@redhat.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Mon, 16 Aug 2021 15:43:48 +0800
Message-ID: <CAEth8oF29LwJq3iEdW5KNqYdZcV04F9L91857LaoX_V+q+vwCQ@mail.gmail.com>
Subject: Re: [PATCH 18/20] Move Intel thermal driver for menlow platform
 driver to intel/ directory to improve readability.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "djrscally@gmail.com" <djrscally@gmail.com>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Ma, Maurice" <maurice.ma@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 3:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 8/16/21 5:11 AM, Pandruvada, Srinivas wrote:
> > On Sun, 2021-08-15 at 16:08 +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 8/14/21 12:39 PM, Daniel Lezcano wrote:
> >>> On 10/08/2021 11:58, Kate Hsuan wrote:
> >>>
> >>>
> >>> Why not move it into drivers/thermal/intel ?
> >>
> >> This cleanup is really something which Intel should have been doing
> >> itself, but they have not done that, so now Kate has stepped up to
> >> do this.
> >>
> >> Figuring out if there is a better home for each of these drivers
> >> really falls outside of the scope of this. If Intel and specifically
> >> Sujith Thomas, the maintainer for that driver who is in the Cc,
> >> believe that drivers/thermal/intel is a better place then they
> >> can submit a patch for this themselves.
> >>
> >> If Intel does that right away, then this patch can be dropped from
> >> Kate's patch-set. Otherwise this can be moved a second time once
> >> someone from Intel gets around to it.
> > We can move to thermal/intel. I will submit a change to do that.
>
> Great, I see that you've already send a patch for this, thank you.
>
> Kate, please drop this patch from your series.
>
> Regards,
>
> Hans
>

Got it. I have dropped it.

--
BR,
Kate

>
>
> >>>> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> >>>> ---
> >>>>  drivers/platform/x86/Kconfig                       |  8 --------
> >>>>  drivers/platform/x86/Makefile                      |  2 +-
> >>>>  drivers/platform/x86/intel/Kconfig                 |  1 +
> >>>>  drivers/platform/x86/intel/Makefile                |  2 ++
> >>>>  drivers/platform/x86/intel/menlow/Kconfig          | 14
> >>>> ++++++++++++++
> >>>>  drivers/platform/x86/intel/menlow/Makefile         |  6 ++++++
> >>>>  .../platform/x86/{ => intel/menlow}/intel_menlow.c |  0
> >>>>  7 files changed, 24 insertions(+), 9 deletions(-)
> >>>>  create mode 100644 drivers/platform/x86/intel/menlow/Kconfig
> >>>>  create mode 100644 drivers/platform/x86/intel/menlow/Makefile
> >>>>  rename drivers/platform/x86/{ => intel/menlow}/intel_menlow.c
> >>>> (100%)
> >>>>
> >>>> diff --git a/drivers/platform/x86/Kconfig
> >>>> b/drivers/platform/x86/Kconfig
> >>>> index b9c0d2d97793..50ded236a841 100644
> >>>> --- a/drivers/platform/x86/Kconfig
> >>>> +++ b/drivers/platform/x86/Kconfig
> >>>> @@ -632,15 +632,7 @@ config THINKPAD_LMI
> >>>>
> >>>>  source "drivers/platform/x86/intel/Kconfig"
> >>>>
> >>>> -config INTEL_MENLOW
> >>>> -       tristate "Thermal Management driver for Intel menlow
> >>>> platform"
> >>>> -       depends on ACPI_THERMAL
> >>>> -       select THERMAL
> >>>> -       help
> >>>> -         ACPI thermal management enhancement driver on
> >>>> -         Intel Menlow platform.
> >>>>
> >>>> -         If unsure, say N.
> >>>>
> >>>>  config INTEL_OAKTRAIL
> >>>>         tristate "Intel Oaktrail Platform Extras"
> >>>> diff --git a/drivers/platform/x86/Makefile
> >>>> b/drivers/platform/x86/Makefile
> >>>> index f4c6ced59da1..ea5f5dd3f78a 100644
> >>>> --- a/drivers/platform/x86/Makefile
> >>>> +++ b/drivers/platform/x86/Makefile
> >>>> @@ -67,7 +67,7 @@ obj-$(CONFIG_THINKPAD_LMI)    += think-lmi.o
> >>>>  obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)               += intel/
> >>>>
> >>>>
> >>>> -obj-$(CONFIG_INTEL_MENLOW)             += intel_menlow.o
> >>>> +
> >>>>  obj-$(CONFIG_INTEL_OAKTRAIL)           += intel_oaktrail.o
> >>>>  obj-$(CONFIG_INTEL_VBTN)               += intel-vbtn.o
> >>>>
> >>>> diff --git a/drivers/platform/x86/intel/Kconfig
> >>>> b/drivers/platform/x86/intel/Kconfig
> >>>> index 4efb5ad3e3e1..59c9b602c784 100644
> >>>> --- a/drivers/platform/x86/intel/Kconfig
> >>>> +++ b/drivers/platform/x86/intel/Kconfig
> >>>> @@ -36,6 +36,7 @@ source
> >>>> "drivers/platform/x86/intel/intel_speed_select_if/Kconfig"
> >>>>  source "drivers/platform/x86/intel/turbo_max_3/Kconfig"
> >>>>  source "drivers/platform/x86/intel/uncore_freq/Kconfig"
> >>>>  source "drivers/platform/x86/intel/int0002/Kconfig"
> >>>> +source "drivers/platform/x86/intel/menlow/Kconfig"
> >>>>
> >>>>
> >>>>  endif # X86_PLATFORM_DRIVERS_INTEL
> >>>> diff --git a/drivers/platform/x86/intel/Makefile
> >>>> b/drivers/platform/x86/intel/Makefile
> >>>> index fe5058c3af18..b2326554bd84 100644
> >>>> --- a/drivers/platform/x86/intel/Makefile
> >>>> +++ b/drivers/platform/x86/intel/Makefile
> >>>> @@ -12,6 +12,7 @@ obj-$(CONFIG_INTEL_HID_EVENT)         += hid/
> >>>>  obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)  += wmi/
> >>>>  obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)    += wmi/
> >>>>  obj-$(CONFIG_INTEL_INT0002_VGPIO)      += int0002/
> >>>> +obj-$(CONFIG_INTEL_MENLOW)             += menlow/
> >>>>
> >>>>
> >>>>  # Intel PMIC / PMC / P-Unit devices
> >>>> @@ -38,3 +39,4 @@ obj-
> >>>> $(CONFIG_INTEL_SPEED_SELECT_INTERFACE)    +=
> >>>> intel_speed_select_if/
> >>>>  obj-$(CONFIG_INTEL_TURBO_MAX_3)                        +=
> >>>> turbo_max_3/
> >>>>  obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)                +=
> >>>> uncore_freq/
> >>>>
> >>>> +
> >>>> diff --git a/drivers/platform/x86/intel/menlow/Kconfig
> >>>> b/drivers/platform/x86/intel/menlow/Kconfig
> >>>> new file mode 100644
> >>>> index 000000000000..b2920d259ff7
> >>>> --- /dev/null
> >>>> +++ b/drivers/platform/x86/intel/menlow/Kconfig
> >>>> @@ -0,0 +1,14 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>> +#
> >>>> +# Intel x86 Platform Specific Drivers
> >>>> +#
> >>>> +
> >>>> +config INTEL_MENLOW
> >>>> +       tristate "Thermal Management driver for Intel menlow
> >>>> platform"
> >>>> +       depends on ACPI_THERMAL
> >>>> +       select THERMAL
> >>>> +       help
> >>>> +         ACPI thermal management enhancement driver on
> >>>> +         Intel Menlow platform.
> >>>> +
> >>>> +         If unsure, say N.
> >>>> diff --git a/drivers/platform/x86/intel/menlow/Makefile
> >>>> b/drivers/platform/x86/intel/menlow/Makefile
> >>>> new file mode 100644
> >>>> index 000000000000..0e9fda9bff98
> >>>> --- /dev/null
> >>>> +++ b/drivers/platform/x86/intel/menlow/Makefile
> >>>> @@ -0,0 +1,6 @@
> >>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>> +#
> >>>> +# Intel x86 Platform Specific Drivers
> >>>> +#
> >>>> +
> >>>> +obj-$(CONFIG_INTEL_MENLOW)             += intel_menlow.o
> >>>> diff --git a/drivers/platform/x86/intel_menlow.c
> >>>> b/drivers/platform/x86/intel/menlow/intel_menlow.c
> >>>> similarity index 100%
> >>>> rename from drivers/platform/x86/intel_menlow.c
> >>>> rename to drivers/platform/x86/intel/menlow/intel_menlow.c
> >>>>
> >>>
> >>>
> >>
> >
>

