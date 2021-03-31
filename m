Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F62350A42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhCaW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhCaW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:29:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:29:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso1951474pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQnN7NHkGrBqjYvsj3wUwlnZQNzy2q4PClXlOY6uvRo=;
        b=iMortkY8rwQv5R7gzR0AH0Oxd0HCB4DK5l1TiZ3ve7TnLIFgCiWjIpKP+NloeK+b9O
         zSrISieAwqCV24o3jmvORHzvnF51sh0lGvseB8cKG0ukduU1iViOeOGYm+j8+q7F5Q5g
         tgaOd7p9dRIRqoKb6qQN1etdZwuoSfZZVZmzimuk0ZdUCscdKaJ2Bq7MXY7c12nf+gPg
         uN0Sh1HWip/Zh2/oV3ZFHVciR0KrTXGmPX0BW51K7smQgsodSeA5K4PFuUVMQhicHHhD
         1PO/V6rZhymhCrAU+Sxc/U7WY6h6g4aFVwL5oQdzxtLBBzGAsPrZUPbIoIinHKX44LUt
         he9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQnN7NHkGrBqjYvsj3wUwlnZQNzy2q4PClXlOY6uvRo=;
        b=BUd+hgn3sPVTQZDU7dSY+PZWSAWfKIX6ygjxUps7asEBT3vdyUiaMhFk+Lz7kojUr4
         GHdLV5nnMbFesYkUaQQX6Wcef9tfFevUA+VULwImP1QuT0rwe/PPkXRylfDSa4vus3UX
         6bDjFzI6t8pErNTi/OUzx3L3CGpehOm4QsRVwWQzA8cnt+iflX2X/vWepPplLsB2kbkU
         jkyNAKSTH6C4Cheb3Q/nfmOPjtTO+gVumOQxZiuPXQUdad1E7iZG6WfkQGu3N26YFFO2
         TcYFFUzxF+qiXmocsZHX5ViPtrVNSVee5VA6WX06jt0c8VU4T8lrVQZKDf7TeUlQT/4S
         BPIA==
X-Gm-Message-State: AOAM532o/7Pj4EydnVklIJMu0cY8wqgxgSnlAC3gbLjEYB3haiKeebrp
        On8E3+qhB+0BdwJXPqVVzIADDQ==
X-Google-Smtp-Source: ABdhPJyiTBSLw8Alpaud1ZG3omKJVcfMmSNJty1jR3bl8poG6iVDs95yRzpoIBXCxqUqOa62CjHuwQ==
X-Received: by 2002:a17:90a:e656:: with SMTP id ep22mr5325358pjb.60.1617229785114;
        Wed, 31 Mar 2021 15:29:45 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id c6sm3619564pfj.99.2021.03.31.15.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:29:44 -0700 (PDT)
Date:   Wed, 31 Mar 2021 22:29:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH 13/13] KVM: x86/mmu: Tear down roots in fast invalidation
 thread
Message-ID: <YGT31GoDhVSXlgP4@google.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-14-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331210841.3996155-14-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021, Ben Gardon wrote:
> ---
>  arch/x86/kvm/mmu/mmu.c     |  6 ++++
>  arch/x86/kvm/mmu/tdp_mmu.c | 74 +++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/mmu/tdp_mmu.h |  1 +
>  3 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 49b7097fb55b..22742619698d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5455,6 +5455,12 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>  	kvm_zap_obsolete_pages(kvm);
>  
>  	write_unlock(&kvm->mmu_lock);
> +
> +	if (is_tdp_mmu_enabled(kvm)) {
> +		read_lock(&kvm->mmu_lock);
> +		kvm_tdp_mmu_zap_all_fast(kvm);

Purely because it exists first, I think we should follow the legacy MMU's
terminology, i.e. kvm_tdp_mmu_zap_obsolete_pages().

> +		read_unlock(&kvm->mmu_lock);
> +	}
>  }
