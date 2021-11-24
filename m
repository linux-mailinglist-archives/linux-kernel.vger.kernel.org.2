Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE245CC75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbhKXSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbhKXSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:53:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1198C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:50:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i12so3525756pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtxqvmfYyjV5kqAkoLEk1bhpShL7DWU8Cpqaq7bMIag=;
        b=dIvro56HBbwAQqpGseOSqXPF0mIszsOSaEg9JoPUYaWa147Z6ejhgAB8hwhNtxUYbm
         58L8uHWX1zI+Cake7GJ+ZgrLgD4P0yeiyLjQjK3jDWOVu8PsOE9th5vDKdLngLK2wH+e
         tNmAIHnPPpeSL4l7TjzPoQBSpbxwSWMU4Cl/RvYC0K/a2JDMuliRYCeF8/pV/pSCn4Gm
         X9VLjZMqSdLdJntIbKEeF3eIaZQTingTD8X+AUi4/0USWVFN448dGN1SCwBGnrjXuKAy
         3Ssm8SQubzFV6dJLuqE6jkUGXXNVYYhyJBndQq10UqxfsgxwAqdGyQ1JqC9AI07p2+JX
         rKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtxqvmfYyjV5kqAkoLEk1bhpShL7DWU8Cpqaq7bMIag=;
        b=5ySIdKjAtqH7pwGVcnMrfPUS62ZtIzaNYHNmYHCfhjvTnl33lo+x6CRQaxALHTLb1M
         xXfy1MAMcE/5nxquGBTxD/u8BQELz3sYJ+l0S0VdcQYOZwf1WM7ck0MKhY2+35ruPDH/
         2ve8SEjnSJQRgDCeYl4FeOOCPi6XOvJb3+X8YhSQ6dEURzdrQxMRFylnj/ml/nSGAlza
         n//B+IdtDddfCOSPBAPaEcgooGabpNYGlZpj+5+f1KYgax/2m+9YQnetPHQ7R8MmBKm4
         3GSNDrMzOEYjobSsaa8rIZ05868n96K0kGht6sBI9TarcyupDPXe9lly1q/6704dMFx8
         meWw==
X-Gm-Message-State: AOAM5326qrj5qsSiNGnXz/el1xfDkmeEmdnEy8dapg1IAOzM9VsgKzz+
        ae61PWIIhjCvsSev3Nwopx7+Wg==
X-Google-Smtp-Source: ABdhPJyP43zhAcXYQ4mG3ffOeGB2G9GGgULeHqkqp6RRIKGoFpSRv0ppJgaFtd/RNCmj6qvtrEiCVw==
X-Received: by 2002:a63:680a:: with SMTP id d10mr11840328pgc.116.1637779803945;
        Wed, 24 Nov 2021 10:50:03 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e14sm513450pfv.18.2021.11.24.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:50:03 -0800 (PST)
Date:   Wed, 24 Nov 2021 18:50:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Make sure kvm_create_max_vcpus test
 won't hit RLIMIT_NOFILE
Message-ID: <YZ6JWGCaDihh4KoG@google.com>
References: <20211123135953.667434-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123135953.667434-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021, Vitaly Kuznetsov wrote:
> With the elevated 'KVM_CAP_MAX_VCPUS' value kvm_create_max_vcpus test
> may hit RLIMIT_NOFILE limits:
> 
>  # ./kvm_create_max_vcpus
>  KVM_CAP_MAX_VCPU_ID: 4096
>  KVM_CAP_MAX_VCPUS: 1024
>  Testing creating 1024 vCPUs, with IDs 0...1023.
>  /dev/kvm not available (errno: 24), skipping test
> 
> Adjust RLIMIT_NOFILE limits to make sure KVM_CAP_MAX_VCPUS fds can be
> opened. Note, raising hard limit ('rlim_max') requires CAP_SYS_RESOURCE
> capability which is generally not needed to run kvm selftests (but without
> raising the limit the test is doomed to fail anyway).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
> - Drop 'NOFD' define replacing it with 'int nr_fds_wanted' [Sean]
> - Drop 'errno' printout as TEST_ASSERT() already does that.
> ---
>  .../selftests/kvm/kvm_create_max_vcpus.c      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index f968dfd4ee88..ca957fe3f903 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -12,6 +12,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/resource.h>
>  
>  #include "test_util.h"
>  
> @@ -40,10 +41,31 @@ int main(int argc, char *argv[])
>  {
>  	int kvm_max_vcpu_id = kvm_check_cap(KVM_CAP_MAX_VCPU_ID);
>  	int kvm_max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	/*
> +	 * Number of file descriptors reqired, KVM_CAP_MAX_VCPUS for vCPU fds +
> +	 * an arbitrary number for everything else.
> +	 */
> +	int nr_fds_wanted = kvm_max_vcpus + 100;
> +	struct rlimit rl;
>  
>  	pr_info("KVM_CAP_MAX_VCPU_ID: %d\n", kvm_max_vcpu_id);
>  	pr_info("KVM_CAP_MAX_VCPUS: %d\n", kvm_max_vcpus);
>  
> +	/*
> +	 * Check that we're allowed to open nr_fds_wanted file descriptors and
> +	 * try raising the limits if needed.
> +	 */
> +	TEST_ASSERT(!getrlimit(RLIMIT_NOFILE, &rl), "getrlimit() failed!");
> +
> +	if (rl.rlim_cur < nr_fds_wanted) {
> +		rl.rlim_cur = nr_fds_wanted;
> +
> +		if (rl.rlim_max <  nr_fds_wanted)
> +			rl.rlim_max = nr_fds_wanted;

Nit, this could use max().

Reviewed-and-tested-by: Sean Christopherson <seanjc@google.com> 
