Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E212F3CB7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhGPN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239391AbhGPN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626441961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iApEIi9Miq3UIE5s+yV3GBcv1kZmgG+1mZKk7FrnGGs=;
        b=QAlO/7sGksdBWKAP9bDZ6i53T7VqfVWX4ZXwsekzfz7BiK/O71zx8jAKeYfkxbDIuOs5jr
        1VmIC9eL5fZ7nglsRcYEz1YAFwfzFzbJXjMFKTo7usWyy+/CgKj6aj+e6tsb07ESzrJxz3
        cr7ebiPMZ6Ocf/0gDkcJSkB2w2LYjHQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-vUCUhWssN_CmChbE3dIr5A-1; Fri, 16 Jul 2021 09:26:00 -0400
X-MC-Unique: vUCUhWssN_CmChbE3dIr5A-1
Received: by mail-ej1-f69.google.com with SMTP id r10-20020a170906350ab02904f12f4a8c69so3601664eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iApEIi9Miq3UIE5s+yV3GBcv1kZmgG+1mZKk7FrnGGs=;
        b=gdVF5YTOBouCah3MOpjXIWXF2qxbitGdbTv79Ut2MIhjPnYmnyDO+n5bEjUbmLqeYA
         SMm8H9tTiwrnGQ47PpSnlpb2bTR9hj7ZpMrith8uO2gj5UkEryeylpJdkhNsRw1b+j+Y
         RiT5jNp+anpcYMUQe/qflF5ZPWh3sKGwNrrMaLxIcxNWksY2oTTdPhCKLOBAe8u1NbEM
         qCHsPAFku6Ni5nbgHfhZMgT1PMAu1ZLtr3CryoUf+Ee7nWTBr/vyZbRkvfCfDjt/BbN4
         8CGUOzrwN+6VRJ+o64WpKxPV35mz22u1yf519n2m3aLVS2TY8WSq9YX6ob8y02DxLxW0
         8T9Q==
X-Gm-Message-State: AOAM532PaNSgdAWPyNlMhNK0pj7fL3878itLvAbPZ0swkLGuogOs9zEC
        mInaOkwIPw5/xramnJwSy3Gd5gkRtNn9n8Gb52AzKiNt/Vza+/Qucq8Gg9o4/tLebuPxNLemj8c
        OQA21qoQgra7Tpwch9O4QA/Yq
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12015151ejz.235.1626441958095;
        Fri, 16 Jul 2021 06:25:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzg3o5Zm+WMzmX54XnqqEa0ngeEy6qu5V2lI5nMEf7EnM6pgvBbaS1pcrK55BQ7W7da23k6A==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr12015103ejz.235.1626441957555;
        Fri, 16 Jul 2021 06:25:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dj16sm3781486edb.0.2021.07.16.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:25:57 -0700 (PDT)
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
Subject: Re: [PATCH] x86/hyperv: add comment describing
 TSC_INVARIANT_CONTROL MSR setting bit 0
In-Reply-To: <20210716063341.2865562-1-ani@anisinha.ca>
References: <20210716063341.2865562-1-ani@anisinha.ca>
Date:   Fri, 16 Jul 2021 15:25:55 +0200
Message-ID: <8735se1jbw.fsf@vitty.brq.redhat.com>
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
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 715458b7729a..d2429748170d 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -368,6 +368,14 @@ static void __init ms_hyperv_init_platform(void)
>  	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
>  #endif
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> +		/*
> +		 * Setting bit 0 of the synthetic MSR 0x40000118 enables
> +		 * guests to report invariant TSC feature through CPUID
> +		 * instruction, CPUID 0x800000007/EDX, bit 8. See code in
> +		 * early_init_intel() where this bit is examined. The
> +		 * setting of this MSR bit should happen before init_intel()
> +		 * is called.

It should probably be emphasized, that write to 0x40000118
updates/changes guest visible CPUIDs. This may not be clear as CPUIDs
are generally considered 'static'. 

> +		 */
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>  	}

-- 
Vitaly

