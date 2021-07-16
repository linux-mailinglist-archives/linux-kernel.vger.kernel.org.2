Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F683CB807
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhGPNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhGPNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626442960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0SM1J4AxB0WAO/+RGPDlAQy4v0R4uwCprlL41GZQ+WY=;
        b=MiZxtuSSOL4KBWfChl8soWRMzLtACSkXdviJqH/Ft+EB6Sfp4k3uG++vN/z9AB71opsI23
        fP2CFdaZQZXcI0cj/TO1GfD2OU3kZV0rDGnju1b2DwsimXJxlGVdwzEKXEhNKs13XhtvU8
        0rjjaFbJ5pEmcFBrOiXak2SkzAIQetg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-3RRvkIhCPEq_KbNcuF60HA-1; Fri, 16 Jul 2021 09:42:38 -0400
X-MC-Unique: 3RRvkIhCPEq_KbNcuF60HA-1
Received: by mail-ed1-f72.google.com with SMTP id z13-20020a05640235cdb02903aa750a46efso4886663edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0SM1J4AxB0WAO/+RGPDlAQy4v0R4uwCprlL41GZQ+WY=;
        b=rsRoH3x+zi7LHHK7nW5jDkaT/y8gu53sf2jEAoFj39iQUWgP4jmxCFg7PeHsR8VA+C
         z8j+7wkRs2nyUVEd6T4VdP34pNq8dV4rxDOwOGdL5QIAZTfnEH31cjBXgmfkSNaHIvVF
         ySxq1h9iYS0CxWaTj7S17HxemrQumZQKE6205KNeroqKqB1EOK/nrfRoki6G8krDvxkz
         j9TbxbiimGliVaZiBhSu2F0U277WwNgnbQkxZxi3mZ355el3kGTfdRgeBVPbnHJkPPTh
         zU0L6QgzZT/CkB6Ld8KG86FtDZVOcNR9wyIDAbsGjMMjv/BQbL0LeeaANCDmGY6qdpZL
         wldQ==
X-Gm-Message-State: AOAM530nO4icBEjEJludkGiNvt1W/iUzqdwI9SGG/dDxRMMoccsHN7pQ
        tvSooMQp4kDNzeXNT6yGQcN75I91v/N3yv6kD7QJSaHTOJdIzjAh/mG8ERH+K4cft6xMlQ/I5TW
        axUxl50mBcdgOM+I/WiOiJ6Cj
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr11912074ejb.431.1626442957470;
        Fri, 16 Jul 2021 06:42:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrGDt56e+ukOx0foKDrNDsirm0LRscu/xWkEFRRC3tUqzl+4xaINTt86OJ9yTpyo3ARlh0ag==
X-Received: by 2002:a17:906:b794:: with SMTP id dt20mr11912037ejb.431.1626442957116;
        Fri, 16 Jul 2021 06:42:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dn23sm3777705edb.56.2021.07.16.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:42:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, mikelley@microsoft.com,
        Ani Sinha <ani@anisinha.ca>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
In-Reply-To: <20210716133245.3272672-1-ani@anisinha.ca>
References: <20210716133245.3272672-1-ani@anisinha.ca>
Date:   Fri, 16 Jul 2021 15:42:35 +0200
Message-ID: <87zgumz86s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ani Sinha <ani@anisinha.ca> writes:

> Commit dce7cd62754b5 ("x86/hyperv: Allow guests to enable InvariantTSC")
> added the support for HV_X64_MSR_TSC_INVARIANT_CONTROL. Setting bit 0
> of this synthetic MSR will allow hyper-v guests to report invariant TSC
> CPU feature through CPUID. This comment adds this explanation to the code
> and mentions where the Intel's generic platform init code reads this
> feature bit from CPUID. The comment will help developers understand how
> the two parts of the initialization (hyperV specific and non-hyperV
> specific generic hw init) are related.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> changelog:
> v1: initial patch
> v2: slight comment update based on received feedback.
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 715458b7729a..3b05dab3086e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -368,6 +368,15 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +		/*
> +		 * Writing to synthetic MSR 0x40000118 updates/changes the
> +		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
> +		 * guests to report invariant TSC feature through CPUID
> +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> +		 * early_init_intel() where this bit is examined. The
> +		 * setting of this MSR bit should happen before init_intel()
> +		 * is called.
> +		 */

This should be very clear now, thanks!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}

-- 
Vitaly

