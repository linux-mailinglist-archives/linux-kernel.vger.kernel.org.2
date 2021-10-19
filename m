Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15C433AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhJSPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJSPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:40:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEBC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:38:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ls18so231024pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4R24uiP3AWTPwnTkUy3o4jaYTgjkE8f9tFEPy2wfsfc=;
        b=Z206A9md+kGzg5G31WtDmERS6yZ+AJHUUxywdfU4LCrh0LyH+2ke2Trl4SHK0ysU7l
         jTZTLoxJznK6ham+QaAogE3fCmf3FjDXmMYW1o3SdC4VULQFcOdY4OHEp8514Iq773n0
         fAHLCLfsuvUMPLFvf0nY8yBu7eCRioSCkYUZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4R24uiP3AWTPwnTkUy3o4jaYTgjkE8f9tFEPy2wfsfc=;
        b=LB/S0qZ6dAzUnQG7grN42w9yC3o019pHpS2MZv+zTgkvyV7qfJDWUcl1hsY2lQhTq8
         xF3FRiqzxUeeHmRWHpOQiu6U2iJ6WDNZ5vTOJwWn11KL4y2EeLLDcB1fF+fosOGH8zfP
         zFfxT1DddiY/u/t1LndKOptgwIGZXUBcEEkw5ke4Eu2ufc5QWPxg3ehvmYRU3+UnOU+a
         QMiApm6Cpk2SX3L1X1hYf8nl8SREjC3lziEelLsgHzMrN9B2XrNxdkLLwFiv0IYDFwfj
         rbFAqbO5eoeFXwiURy2WDJqxQwB4mDjL9bAD4jHjN2ShL9MFNrZltpX1Vyoqe1jdUUzX
         ewPw==
X-Gm-Message-State: AOAM531tDYmkgOuK5GftTcBrErqETKfmoiA4VTzgYMCJvTuUTOc5H7oN
        z0LRvzkSIY+ZMgzoo/EVjfuadA==
X-Google-Smtp-Source: ABdhPJxTUXlRdWRfZs59UAiIjI2Eg1rfFSYbgdf3gjWiZkTkefYZ/VTjLY3CJ763AtjDmOA/dJwjzg==
X-Received: by 2002:a17:90b:4b48:: with SMTP id mi8mr675489pjb.13.1634657889765;
        Tue, 19 Oct 2021 08:38:09 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:490f:f89:7449:e615])
        by smtp.gmail.com with ESMTPSA id x7sm16710686pfj.164.2021.10.19.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:38:09 -0700 (PDT)
Date:   Wed, 20 Oct 2021 00:38:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHV2 3/3] KVM: x86: add KVM_SET_MMU_PREFETCH ioctl
Message-ID: <YW7mXF9DNLk4fVkQ@google.com>
References: <20211019153214.109519-1-senozhatsky@chromium.org>
 <20211019153214.109519-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019153214.109519-4-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/20 00:32), Sergey Senozhatsky wrote:
>  static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
>  {
>  	struct kvm_clock_data data;
> @@ -6169,6 +6189,15 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	case KVM_X86_SET_MSR_FILTER:
>  		r = kvm_vm_ioctl_set_msr_filter(kvm, argp);
>  		break;
> +	case KVM_SET_MMU_PREFETCH: {
> +		u64 val;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&val, argp, sizeof(val)))
> +			goto out;
> +		r = kvm_arch_mmu_pte_prefetch(kvm, val);
> +		break;
> +	}

A side question: is there any value in turning this into a per-VCPU ioctl?
So that, say, on heterogeneous systems big cores can prefetch more than
little cores, for instance.
