Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5463F32EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhHTSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHTSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629483501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+jpjQUhasKw0PtDj/cc6cwfjkOlLOS+fOpZTWVMu/Y=;
        b=cUIbXo7XQUlr7lwJdN/Ys/IXe+fdSkdgWEenWg7O3UT17/28cFnKG84ILixMCqtQbsEgEi
        xDh1c3/BAOIaWFhSKX3TDPS8kn5il9cBs6n0Qp5uH8oeAgWng6qta0iLq1XoNrhzZ4fHmf
        Jfn6OPS86uQnLlqXV0SosSPzZ3NnKpA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-TjXw3AM1OrenIymlLHCEvg-1; Fri, 20 Aug 2021 14:18:20 -0400
X-MC-Unique: TjXw3AM1OrenIymlLHCEvg-1
Received: by mail-ej1-f72.google.com with SMTP id e1-20020a170906c001b02905b53c2f6542so4050402ejz.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+jpjQUhasKw0PtDj/cc6cwfjkOlLOS+fOpZTWVMu/Y=;
        b=nYReou4U5ZRAGaUJnPzkqtDgvhiSYYYOQiNw9ow+lFLvQdGxesgZ+Ae+VuwEwTIloW
         xCK9/J83SxelDJ7gQMTpDVHV8nZtDDrKf64N+1k26/AGVn5VObKoClagY20dLSwPvJ72
         YfYg9odmazlve56edWANbX1HgwhKGEbxrxYgr00vDq6Jej22GsFF9MthGJKnXl5RxS3P
         KL1VFjNNgZoqNO3iupC0dQHcm0p+isBoRjalad3y3709X8TRlAQaffwdJFUfG4rRWN9k
         28pYYmrxcqD1nF07VuJeD/RfiZk2d2PI/THvK8rqqm2tkILCQTYPt6h2tcnN13WnT/6W
         AsoQ==
X-Gm-Message-State: AOAM533SpwhGijenKMNh3tpn8LFbICsrdWYU+fWBLsPaF4UhrsDEy/bm
        KBmwQq6nMPPEVyMjIVwpbj1Y3WaU49GUMwkn2Wr0cB0kMq4QsIEA0JJ3ZRXRBqP5hQuvZGLTWSe
        AMXRZDMhgtdXfTureZ7fJsQyS
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr22836800eje.240.1629483499604;
        Fri, 20 Aug 2021 11:18:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2VuqrdaqdEg6hZrIrqA2Updrhnh6IapX2I1XQzoEsUKRXy/2IR0eTsODRhSAc19uzeCZj+Q==
X-Received: by 2002:a17:906:3148:: with SMTP id e8mr22836787eje.240.1629483499437;
        Fri, 20 Aug 2021 11:18:19 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id g29sm4089077edf.31.2021.08.20.11.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 11:18:18 -0700 (PDT)
Subject: Re: [PATCH v5 07/20] platform/x86: pmc_atom: Move to intel
 sub-directory
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com
Cc:     Mark Gross <mgross@linux.intel.com>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ccae9fcb-fa2f-5c44-1241-9f107b358103@redhat.com>
Date:   Fri, 20 Aug 2021 20:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820110458.73018-8-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/21 1:04 PM, Andy Shevchenko wrote:
> Move Intel Atom PMC driver to intel sub-directory to improve readability.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This means that pmc_atom will now not be build if X86_PLATFORM_DRIVERS_INTEL
is not set (and PCI is enabled). Which will cause missing pmc_atom_read/_write
symbols in drivers/acpi/acpi_lpss.c. So I have dropped this patch from the
set, while applying the rest.

Note I'm thinking that we should just remove the whole X86_PLATFORM_DRIVERS_INTEL
Kconfig option and in the drivers/platform/x86/Makefile replace:

obj-$(CONFIG_X86_PLATFORM_DRIVERS_INTEL)                += intel/

with:

obj-y                                                   += intel/

This will also allows us to fix the scu issue without needing any
changes to drivers/mfd/Kconfig .

But this can all wait for the 2nd round of renames after 5.15-rc1.

For now I'm moving forward with this v5 series, except with this
patch dropped.

Regards,

Hans








> ---
>  drivers/platform/x86/Kconfig                | 5 -----
>  drivers/platform/x86/Makefile               | 1 -
>  drivers/platform/x86/intel/Kconfig          | 5 +++++
>  drivers/platform/x86/intel/Makefile         | 1 +
>  drivers/platform/x86/{ => intel}/pmc_atom.c | 0
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/platform/x86/{ => intel}/pmc_atom.c (100%)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index aed7570388ef..e6fb3eb70ee7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1219,8 +1219,3 @@ config INTEL_TELEMETRY
>  	  this interface for SoC state monitoring.
>  
>  endif # X86_PLATFORM_DEVICES
> -
> -config PMC_ATOM
> -       def_bool y
> -       depends on PCI
> -       select COMMON_CLK
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1668f7360833..de7f45b8e4f6 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -135,4 +135,3 @@ obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
>  obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
>  					   intel_telemetry_pltdrv.o \
>  					   intel_telemetry_debugfs.o
> -obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index 7de11636904d..c4d74dff3a14 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -60,4 +60,9 @@ config INTEL_PUNIT_IPC
>  	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
>  	  which is used to bridge the communications between kernel and P-Unit.
>  
> +config PMC_ATOM
> +       def_bool y
> +       depends on PCI
> +       select COMMON_CLK
> +
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index a1555a1e421d..8595f8b92f40 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -19,3 +19,4 @@ intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
>  obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
>  intel_punit_ipc-y			:= punit_ipc.o
>  obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
> +obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/intel/pmc_atom.c
> similarity index 100%
> rename from drivers/platform/x86/pmc_atom.c
> rename to drivers/platform/x86/intel/pmc_atom.c
> 

