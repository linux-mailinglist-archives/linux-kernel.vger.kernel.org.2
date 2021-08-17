Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDC3EE3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhHQBpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235957AbhHQBpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629164701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZeGmGrsMaD6/Co8WQ/TYuFAL+84nnPg48GKrtH64yU=;
        b=bXdzx8njk7pgUraI8etp2zTCMSUZ2XH/TVx8bSgZomYqcxnHrVyAg55XQU6EbiVpfaa2/x
        BsTqtaIt/vjdt4w2dfJjx1AmXBhJgvgX6xzArfN1UwNPppSPrUOTx1UY6r7nP0oCRb/hbr
        0OAZVSHGL4aYwf6UU7CTeOA8uECYEpI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-qgRo_YQCP-G_SbIqJoL5KQ-1; Mon, 16 Aug 2021 21:45:00 -0400
X-MC-Unique: qgRo_YQCP-G_SbIqJoL5KQ-1
Received: by mail-lf1-f71.google.com with SMTP id k11-20020ac257cb000000b003ce6a4383f3so1120710lfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZeGmGrsMaD6/Co8WQ/TYuFAL+84nnPg48GKrtH64yU=;
        b=MXsAnR2jUtxzIf8ZyWNlVPs+wxl0Aq5W0Gvz62voMNGEXBu2dMIJPik3grip3Qr4N2
         V0skHN0wY2OWHpNgtWPgI2VmKPFx3P/a7Rk/lksqdDf5IGV/eKmP+YK9YaR6kg/W7RbE
         hZDCAxIszUWqH97BnAkpLO3ZRmH4dmjtyU/O1tVWwd6cpSH/8ZTaaSUUFHlNGrZxRB1O
         6gKN+7j3i9K+fb+fp096rhmF/AY229zqaqll9g2+pc7KuHz1UdwPnPJlhWUSRaTmIamU
         PPJmxhsFe+tkYxspmxAAnvHEuZyvRHvsCtSWQcO5J2scxc014X1HWljEdFQQ4vq/f7Nr
         c60w==
X-Gm-Message-State: AOAM531OWJX1GhsN9EIe8R0terYaJ0Q3wjLOhQqwN1fU6r/guDbQd/RJ
        2wBqsgMN99VSWWlyd/pwr6dpvTgiQNcr9BghiKGRBAcYagOsybqfZzpaUOtW8bV0QOUwGVio5Vy
        oIxjixBU78Rb2CICW2NKFU21kw5K20iNt3oHG6J2X
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr532984lfe.31.1629164698590;
        Mon, 16 Aug 2021 18:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiZVkRTEyJLmQRM/qyNStAQreMH0oRMTTQYp5pzzkGlJoI1A2/ESh2ZMQ+P0HkXauS40bxSFTIkBvYLv5sNYE=
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr532965lfe.31.1629164698326;
 Mon, 16 Aug 2021 18:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210816105119.704302-1-hpa@redhat.com> <20210816105119.704302-12-hpa@redhat.com>
 <bd5c2c0c7863375a0bd3c6894194f7ba70915e17.camel@intel.com>
In-Reply-To: <bd5c2c0c7863375a0bd3c6894194f7ba70915e17.camel@intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Tue, 17 Aug 2021 09:44:47 +0800
Message-ID: <CAEth8oF6yUYe2v_uDFjkh__oH+fUwmZBpRftDpfdBy05xtpJeQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] platform/x86: intel_turbo_max_3: Move to intel sub-directory
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "Ma, Maurice" <maurice.ma@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "Dell.Client.Kernel@dell.com" <Dell.Client.Kernel@dell.com>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 16, 2021 at 10:52 PM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Mon, 2021-08-16 at 18:51 +0800, Kate Hsuan wrote:
> > Move intel_turbo_max_3 to intel sub-directory to improve readability
> > and rename it from intel_turbo_max_3.c to turbo_max_3.c
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I'll add this to the commit message.

Kate

>
> > ---
> >  drivers/platform/x86/Kconfig                           | 10 ----------
> >  drivers/platform/x86/Makefile                          |  2 +-
> >  drivers/platform/x86/intel/Kconfig                     | 10 ++++++++++
> >  drivers/platform/x86/intel/Makefile                    |  4 ++--
> >  .../x86/{intel_turbo_max_3.c => intel/turbo_max_3.c}   |  0
> >  5 files changed, 13 insertions(+), 13 deletions(-)
> >  rename drivers/platform/x86/{intel_turbo_max_3.c =>
> > intel/turbo_max_3.c} (100%)
> >
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index a9eb1f6e184f..666103c7f0de 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1111,16 +1111,6 @@ config INTEL_IMR
> >
> >  source "drivers/platform/x86/intel_speed_select_if/Kconfig"
> >
> > -config INTEL_TURBO_MAX_3
> > -       bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
> > -       depends on X86_64 && SCHED_MC_PRIO
> > -       help
> > -         This driver reads maximum performance ratio of each CPU and
> > set up
> > -         the scheduler priority metrics. In this way scheduler can
> > prefer
> > -         CPU with higher performance to schedule tasks.
> > -         This driver is only required when the system is not using
> > Hardware
> > -         P-States (HWP). In HWP mode, priority can be read from ACPI
> > tables.
> > -
> >  config INTEL_UNCORE_FREQ_CONTROL
> >         tristate "Intel Uncore frequency control driver"
> >         depends on X86_64
> > diff --git a/drivers/platform/x86/Makefile
> > b/drivers/platform/x86/Makefile
> > index 0389fe12e7c0..fb39644db7f9 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -123,7 +123,7 @@ obj-$(CONFIG_WIRELESS_HOTKEY)               +=
> > wireless-hotkey.o
> >
> >
> >  obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE)     +=
> > intel_speed_select_if/
> > -obj-$(CONFIG_INTEL_TURBO_MAX_3)                        +=
> > intel_turbo_max_3.o
> > +
> >  obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)                += intel-
> > uncore-frequency.o
> >
> >
> > diff --git a/drivers/platform/x86/intel/Kconfig
> > b/drivers/platform/x86/intel/Kconfig
> > index 83f7dc3e9506..8070804fe916 100644
> > --- a/drivers/platform/x86/intel/Kconfig
> > +++ b/drivers/platform/x86/intel/Kconfig
> > @@ -99,4 +99,14 @@ config INTEL_SMARTCONNECT
> >           Connect enabled, and if so disables it.
> >
> >
> > +config INTEL_TURBO_MAX_3
> > +       bool "Intel Turbo Boost Max Technology 3.0 enumeration driver"
> > +       depends on X86_64 && SCHED_MC_PRIO
> > +       help
> > +         This driver reads maximum performance ratio of each CPU and
> > set up
> > +         the scheduler priority metrics. In this way scheduler can
> > prefer
> > +         CPU with higher performance to schedule tasks.
> > +         This driver is only required when the system is not using
> > Hardware
> > +         P-States (HWP). In HWP mode, priority can be read from ACPI
> > tables.
> > +
> >  endif # X86_PLATFORM_DRIVERS_INTEL
> > diff --git a/drivers/platform/x86/intel/Makefile
> > b/drivers/platform/x86/intel/Makefile
> > index da8fbe87bf03..cff65fa2b1aa 100644
> > --- a/drivers/platform/x86/intel/Makefile
> > +++ b/drivers/platform/x86/intel/Makefile
> > @@ -33,5 +33,5 @@ intel-rst-
> > y                                                   := rst.o
> >  obj-$(CONFIG_INTEL_RST)                                += intel-rst.o
> >  intel-smartconnect-y                           := smartconnect.o
> >  obj-$(CONFIG_INTEL_SMARTCONNECT)               += intel-smartconnect.o
> > -
> > -
> > +intel_turbo_max_3-y                                            :=
> > turbo_max_3.o
> > +obj-$(CONFIG_INTEL_TURBO_MAX_3)                        +=
> > intel_turbo_max_3.o
> > diff --git a/drivers/platform/x86/intel_turbo_max_3.c
> > b/drivers/platform/x86/intel/turbo_max_3.c
> > similarity index 100%
> > rename from drivers/platform/x86/intel_turbo_max_3.c
> > rename to drivers/platform/x86/intel/turbo_max_3.c
>

