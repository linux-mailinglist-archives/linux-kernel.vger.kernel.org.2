Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F434F716
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhCaDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCaDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:01:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:01:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso475298pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=stnuRek4sOjIWVbHiF6Zw30QkQ1wKjPo9ZYhQ5gXeIc=;
        b=niXRWlsP6nWYOz464OcK85FUi8OH0IvOD5tYyB/n4qHA/fz+1UeCwrVgIj9QbSKuJs
         9In3WzOp3YhE4aF7+nrgA0j3qQcaR2Ip29sgsP1IuNG6cdVgq7gY8lZe1WCrD2TQJenI
         ORcasWtvvKCFXDM/Fh4//SyDQ3gtU63zmWQ5KS7tS8Pbb5W9fhidBezi8/AEOg9HbmjZ
         k6fL5ju5NVz4MXfKI88aR2rVlZ6HFrSrEYbWH8lTzBYqcWo/QJTstjygBi1tebOXObXF
         d0d5C2yxDVZJemqMLcwdyWiLGKNjvdqITv++rg+ZHPn6OK5imYyRQZqVtPmkWcscIftT
         zYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=stnuRek4sOjIWVbHiF6Zw30QkQ1wKjPo9ZYhQ5gXeIc=;
        b=ZCA9NovuZMLoPbxR2JMpJa7un2p9UbjkH46dtoos2pGxTD2YrN392/8tQITZvlzuc1
         57uXO7NnrImnYSl0QJlZXBT5jNAC/7S7gFH5ivVlt8DF0gd3ALTlvOIzIhdMNnmbpuo4
         gmtmUUZCdedZ/E5+Heo2S9WaTm2Y68oVop+xHuU/u2r86lrfSTUfwX+PoYriz1E6tsdg
         Vd9DPBSwaGw2YGReGi3QdH3C/pcQfL3vGQZYClx/2np55SpSDJdhu1Y1uSmuJzrXjeBf
         n20oPt7dn5X2uB/A3d/IdxbxH6f1jCONyGkTfrJ6O+RZ7TVFyYUe2uydWunJU7kuChi5
         Gd0A==
X-Gm-Message-State: AOAM531/ev1v5KU5HAzoOgMmN9MFheil42d0GH56k/ieMCjeMBvb8sk+
        IfO/83QS37Owid+CbjndtU9b2Q==
X-Google-Smtp-Source: ABdhPJzGQXAE+cVEv4iUgsow9YdddJYSNGV5fSw+Q1hZhK7KifScyxTT+YTaUQqGdwqKrP1GWz8PZg==
X-Received: by 2002:a17:902:c408:b029:e7:3242:5690 with SMTP id k8-20020a170902c408b02900e732425690mr1241746plk.85.1617159697700;
        Tue, 30 Mar 2021 20:01:37 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w84sm360419pfc.142.2021.03.30.20.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:01:36 -0700 (PDT)
Date:   Wed, 31 Mar 2021 03:01:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] kvm: cpuid: adjust the returned nent field of
 kvm_cpuid2 for KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID
Message-ID: <YGPmDbO++agqdqQL@google.com>
References: <20210330185841.44792-1-eesposit@redhat.com>
 <20210330185841.44792-2-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330185841.44792-2-eesposit@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021, Emanuele Giuseppe Esposito wrote:
> Calling the kvm KVM_GET_[SUPPORTED/EMULATED]_CPUID ioctl requires
> a nent field inside the kvm_cpuid2 struct to be big enough to contain
> all entries that will be set by kvm.
> Therefore if the nent field is too high, kvm will adjust it to the
> right value. If too low, -E2BIG is returned.
> 
> However, when filling the entries do_cpuid_func() requires an
> additional entry, so if the right nent is known in advance,
> giving the exact number of entries won't work because it has to be increased
> by one.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6bd2f8b830e4..5412b48b9103 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -975,6 +975,12 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  
>  	if (cpuid->nent < 1)
>  		return -E2BIG;
> +
> +	/* if there are X entries, we need to allocate at least X+1
> +	 * entries but return the actual number of entries
> +	 */
> +	cpuid->nent++;

I don't see how this can be correct.

If this bonus entry really is needed, then won't that be reflected in array.nent?
I.e won't KVM overrun the userspace buffer?

If it's not reflected in array.nent, that would imply there's an off-by-one check
somewhere, or KVM is creating an entry that it doesn't copy to userspace.  The
former seems unlikely as there are literally only two checks against maxnent,
and they both look correct (famous last words...).

KVM does decrement array->nent in one specific case (CPUID.0xD.2..64), i.e. a
false positive is theoretically possible, but that carries a WARN and requires a
kernel or CPU bug as well.  And fudging nent for that case would still break
normal use cases due to the overrun problem.

What am I missing?

> +
>  	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>  		cpuid->nent = KVM_MAX_CPUID_ENTRIES;
>  
> -- 
> 2.30.2
> 
