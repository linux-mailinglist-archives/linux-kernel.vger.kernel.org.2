Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D738F1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhEXQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:54:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:53:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m124so20502016pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N2txpffhQNVmkCUqvMymT/aHNSSwoaT8nmlDPEhUqZE=;
        b=JuZTWaiyOBfD3XdqP+AwRe2GcRlGDJCzTJBkj6Hr69AVEWETsP6Xd230zoK/uKVcBV
         YNeNj5/sWBcjpBgjkAZsovmFsaHaXLH50RRzkqbvrI2vLTif6dxIGQOuw9JipL5TUQtY
         2gYW9rQoiYEUlanIzTylsUCqeeWyWtnYABnTkDQr7Hen2NaEivp37QVMjlHvy8PGLKWC
         6Qtjgcm2iF8NybrBsUIiLLEqgXpU0cJD2fV+ZcaxxKnWARt/Exd6MEOGquHyZ/hH3FFq
         rwAYV/DiTW+n7R0hIwqgqGTLli5WGEc+srYKiJCJ+TU3gHtXzwFXzv+ZncYVqzmHSOaP
         omdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N2txpffhQNVmkCUqvMymT/aHNSSwoaT8nmlDPEhUqZE=;
        b=nXq6yhd9Ib1rX1t63yWaVZBmdrPWQuDuhR5ogXnkISavdgGmG984Fkam63agW6fL/c
         kl+gQF7dtBr0ow7apDR4R33MB7GE84Jl1dXJ9+F/hk60XCL5iAbccef6aO63Ulu4HRnf
         QiDU88mOizy1LGpfk2j17dvFdq0Ub4vKuekMnDu9lIG0azZSWAnpnuNve0X+0ZVTqG4u
         WyNf0hn7u/l71DzG8ocIgsVqeKClORFJadl3/ojDLtGL7SN1g+ZFOUncdfEVbCPguUK6
         7ZMlHuFds7pl0AeD5+EpgGwL67JypnCwVt83KWbgKJFNBawR0lFakKsyDo+5RKzsz4f3
         Jgvg==
X-Gm-Message-State: AOAM533k1crhpcON/8dJATUS8ipZX4NPnhy2U+Cc3mkX6zFKBdtVRr/i
        h3HU07H+7zdzTMPGJBNXiF+Dwg==
X-Google-Smtp-Source: ABdhPJxm2lkNMpPA+aDLQjFOaveDgWcmkqzDYbfuBuoHFySyF+am+K3RAzptfjpecT+LGsr6ntoT7A==
X-Received: by 2002:aa7:8509:0:b029:2e5:8cfe:bc17 with SMTP id v9-20020aa785090000b02902e58cfebc17mr16226973pfn.2.1621875182742;
        Mon, 24 May 2021 09:53:02 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t22sm11233580pfl.50.2021.05.24.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:53:02 -0700 (PDT)
Date:   Mon, 24 May 2021 16:52:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Kechen Lu <kechenl@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: x86: Use common 'enable_apicv' variable for
 both APICv and AVIC
Message-ID: <YKvZ6vI2vFVmkCeb@google.com>
References: <20210518144339.1987982-1-vkuznets@redhat.com>
 <20210518144339.1987982-4-vkuznets@redhat.com>
 <YKQmG3rMpwSI3WrV@google.com>
 <12eadbce-f688-77a1-27bf-c33fee2e7543@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12eadbce-f688-77a1-27bf-c33fee2e7543@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021, Paolo Bonzini wrote:
> On 18/05/21 22:39, Sean Christopherson wrote:
> > > +/* enable / disable AVIC */
> > > +static int avic;
> > > +module_param(avic, int, 0444);
> > We should opportunistically make avic a "bool".
> > 
> 
> And also:
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 11714c22c9f1..48cb498ff070 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -185,9 +185,12 @@ module_param(vls, int, 0444);
>  static int vgif = true;
>  module_param(vgif, int, 0444);
> -/* enable / disable AVIC */
> -static int avic;
> -module_param(avic, int, 0444);
> +/*
> + * enable / disable AVIC.  Because the defaults differ for APICv
> + * support between VMX and SVM we cannot use module_param_named.
> + */
> +static bool avic;
> +module_param(avic, bool, 0444);
>  bool __read_mostly dump_invalid_vmcb;
>  module_param(dump_invalid_vmcb, bool, 0644);
> @@ -1013,11 +1016,7 @@ static __init int svm_hardware_setup(void)
>  			nrips = false;
>  	}
> -	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_AVIC))
> -		avic = false;
> -
> -	/* 'enable_apicv' is common between VMX/SVM but the defaults differ */
> -	enable_apicv = avic;
> +	enable_apicv = avic && npt_enabled && boot_cpu_has(X86_FEATURE_AVIC);
>  	if (enable_apicv) {
>  		pr_info("AVIC enabled\n");
> 
> The "if" can come back when AVIC is enabled by default.

But "avic" is connected to the module param, even if it's off by default its
effective value should be reflected in sysfs.  E.g. the user may incorrectly
think AVIC is in use if they set avic=1 but the CPU doesn't support AVIC.
Forcing the user to check /proc/cpuinfo or look for "AVIC enabled" in dmesg is
kludgy at best.
