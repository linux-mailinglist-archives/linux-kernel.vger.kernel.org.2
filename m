Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36B042E4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhJOADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhJOADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:03:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F8C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:01:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v20so5249904plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 17:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3C1UrZNNXgMxvdH1/V3N3KiefA7iOJG+Xsr0iS00I+4=;
        b=bquRmN1WDdNC+Xvp9GU1gkulRsAi+hLpDT7ovRmfKSW5wHeW8q2jpWZ2q6yvRB+iy4
         x6l63zvB2JlX4cDBwiC6gqgtTzq+g9CVnSuHGXw1kHkSRzO9S3OILhFdqXRoZ5AW5/RI
         ibxcWwDssnQafrp3/zYMx3lbDfTAgdBnlp9xPwkGmGjrtupn7RBsqytlQzU0d9yzX8zr
         SVqAnCiXwERwnYKxkQxGzUlGnNLWaUdDTF10ENK6DGSOVXIyG2p+/kzDPq23lY2xOov6
         galxjAbKjCeF9QOcfP8aacjpMZkeh41SH/WuY6phUv4kD0yMhc2D8nddDN0ER0dewQ8m
         UWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3C1UrZNNXgMxvdH1/V3N3KiefA7iOJG+Xsr0iS00I+4=;
        b=6KlDdLDVYb7YPV+qzmsxHfaM46Ku6aQgp+ghlatlWfN2MiARTo3ArUQ3YGwQ5hPEkP
         xUguRnNBIo/E0kKcBZ6iyBVsBfdan2o26+N1NmU0gYTLxCuqEgx7yR2lYcUHayUB3TQ2
         I3clSWheOgv3WWYHe0aOBjoOZreYCGhLRsQoH96XQzK13v22/ZgCLu9FkKadguyzot9I
         R5IPQvsQSBbSAT5NdLmkRvBNy75ram8NJ1Yj3VBbfDCw+V18QuSUk2rr4cx6OrdHgQPF
         kDUVLnuqWsTDaDCinvkeAUW2R1jybAXuoE6zcmvCGJ6muIB10bhCac9P/Fi5jP/tZp3u
         GVBw==
X-Gm-Message-State: AOAM531z8JA7/StRhGS+FgVQfBptUQlkTfJGNMzKEDA1M1ZNaqsqV5lh
        zUpNV5BS9Sp2skELw4kp6mx3KA==
X-Google-Smtp-Source: ABdhPJxKNeoqz2Pi1Hzq6i+4pc/DGIz9rsMqNfGSauVNUWty86uVdHPI/a68vELFfd9L5IjJ6qUDBA==
X-Received: by 2002:a17:902:b40a:b0:13d:cbcd:2e64 with SMTP id x10-20020a170902b40a00b0013dcbcd2e64mr7973030plr.18.1634256086629;
        Thu, 14 Oct 2021 17:01:26 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o12sm3277449pgn.33.2021.10.14.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 17:01:26 -0700 (PDT)
Date:   Fri, 15 Oct 2021 00:01:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        vkuznets@redhat.com, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 15/15] KVM: x86/cpuid: Advise Arch LBR feature in CPUID
Message-ID: <YWjE0iQ6fDdJpDfT@google.com>
References: <1629791777-16430-1-git-send-email-weijiang.yang@intel.com>
 <1629791777-16430-16-git-send-email-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629791777-16430-16-git-send-email-weijiang.yang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/Advise/Advertise

On Tue, Aug 24, 2021, Yang Weijiang wrote:
> Add Arch LBR feature bit in CPU cap-mask to expose the feature.
> Only max LBR depth is supported for guest, and it's consistent
> with host Arch LBR settings.
> 
> Co-developed-by: Like Xu <like.xu@linux.intel.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 03025eea1524..d98ebefd5d72 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -88,6 +88,16 @@ static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
>  		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0)
>  			return -EINVAL;
>  	}
> +	best = cpuid_entry2_find(entries, nent, 0x1c, 0);
> +	if (best) {
> +		unsigned int eax, ebx, ecx, edx;
> +
> +		/* Reject user-space CPUID if depth is different from host's.*/

Why disallow this?  I don't see why it would be illegal for userspace to specify
fewer LBRs, and KVM should darn well verify that any MSRs it's exposing to the
guest actually exist.

> +		cpuid_count(0x1c, 0, &eax, &ebx, &ecx, &edx);
> +
> +		if ((best->eax & 0xff) != BIT(fls(eax & 0xff) - 1))
> +			return -EINVAL;
> +	}
>  
>  	return 0;
>  }
