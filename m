Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42B3316C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhBJRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:16:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232557AbhBJRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612977226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFX3jjRUER4UZdU7PFbS3TkyUV8Z8Ppstc5W8FSKy30=;
        b=OY6d6vINDn3SP436/uTRKvkmX/Oz+JE0TB4ZzW24tF8YWJuyKUhV3XsesjLrF+CGviXItw
        sGs3mdLtngCqCOWpGqe02t3kzxlyY2AlpOmfm/qv+JNr4kL1qG86Dq5kktigiJsrlc5XxV
        VUgWRqfc6uMCkKXBs+HmVhr995Fam/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-myv5c-6yOZugnUAqknqdsw-1; Wed, 10 Feb 2021 12:13:44 -0500
X-MC-Unique: myv5c-6yOZugnUAqknqdsw-1
Received: by mail-wr1-f69.google.com with SMTP id h18so2232075wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFX3jjRUER4UZdU7PFbS3TkyUV8Z8Ppstc5W8FSKy30=;
        b=nr7C8UG9bzaO1sqtu/6vSXi3HQieVwUDywySetJrKGE/AbCynOGKblbO0rpDTjx5dp
         zkhQ9hrM7N+E822HEehqK5OQiXTWjt3ASeHp/C8KbmfGw0ljQsG6LBwTg6D5WTPP8Nje
         1z0++YpwS/eYw84d06E0aJJLWTnNfc6hFhRvnwCxC4bpcjNQUcTts9E1AO8S4p9PJo13
         1bDmF1yTOd8u5cqCv2/Twx8yB1vbYk7IirF9ilGkxvkQYwcJUC3mpE8UMiC5qhunA6tY
         NrQu+R0UhFcXaO4LlN3bsxjBLpaDAZ12oRAtaDfpTJo+zFtgZmhqqSi1wQDy9N1R7B34
         avmw==
X-Gm-Message-State: AOAM532++HpjnK1pTjppncm6Epuj3ham79ztP6mSWClvc9cA9FXRR9CM
        /QEfbp5cKjz3Iow48x8TPBkUJbDQsMjVWoL30Zju6VZwM8laQ2ll01iLBJog9QeUlQnAfB6gJ4N
        iNikhlDU2WKM2gREbf+YM+d/L
X-Received: by 2002:adf:b60f:: with SMTP id f15mr4798437wre.83.1612977223596;
        Wed, 10 Feb 2021 09:13:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVqUXEPhN9TSYiOENZMLPL57e4EOLRAStCo11fUbD3cpOCl1wX3JmRP7t91EwAacpRIutg4g==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr4798418wre.83.1612977223419;
        Wed, 10 Feb 2021 09:13:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p4sm1421909wma.36.2021.02.10.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 09:13:42 -0800 (PST)
Subject: Re: [PATCH] KVM: selftests: Add missing header file needed by xAPIC
 IPI tests
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
References: <20210210011747.240913-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82615c80-b904-d655-0c68-b9ad504a04b2@redhat.com>
Date:   Wed, 10 Feb 2021 18:13:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210011747.240913-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 02:17, Sean Christopherson wrote:
> From: Peter Shier <pshier@google.com>
> 
> Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Peter Shier <pshier@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Delta patch taken verbatim from Peter's original submission.  Applying the
> original patch directly is mildly annoying due to conflicts with kvm/next
> in other files.
> 
>   tools/testing/selftests/kvm/include/numaif.h | 55 ++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/include/numaif.h
> 
> diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
> new file mode 100644
> index 000000000000..b020547403fd
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/numaif.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * tools/testing/selftests/kvm/include/numaif.h
> + *
> + * Copyright (C) 2020, Google LLC.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + *
> + * Header file that provides access to NUMA API functions not explicitly
> + * exported to user space.
> + */
> +
> +#ifndef SELFTEST_KVM_NUMAIF_H
> +#define SELFTEST_KVM_NUMAIF_H
> +
> +#define __NR_get_mempolicy 239
> +#define __NR_migrate_pages 256
> +
> +/* System calls */
> +long get_mempolicy(int *policy, const unsigned long *nmask,
> +		   unsigned long maxnode, void *addr, int flags)
> +{
> +	return syscall(__NR_get_mempolicy, policy, nmask,
> +		       maxnode, addr, flags);
> +}
> +
> +long migrate_pages(int pid, unsigned long maxnode,
> +		   const unsigned long *frommask,
> +		   const unsigned long *tomask)
> +{
> +	return syscall(__NR_migrate_pages, pid, maxnode, frommask, tomask);
> +}
> +
> +/* Policies */
> +#define MPOL_DEFAULT	 0
> +#define MPOL_PREFERRED	 1
> +#define MPOL_BIND	 2
> +#define MPOL_INTERLEAVE	 3
> +
> +#define MPOL_MAX MPOL_INTERLEAVE
> +
> +/* Flags for get_mem_policy */
> +#define MPOL_F_NODE	    (1<<0)  /* return next il node or node of address */
> +				    /* Warning: MPOL_F_NODE is unsupported and
> +				     * subject to change. Don't use.
> +				     */
> +#define MPOL_F_ADDR	    (1<<1)  /* look up vma using address */
> +#define MPOL_F_MEMS_ALLOWED (1<<2)  /* query nodes allowed in cpuset */
> +
> +/* Flags for mbind */
> +#define MPOL_MF_STRICT	     (1<<0) /* Verify existing pages in the mapping */
> +#define MPOL_MF_MOVE	     (1<<1) /* Move pages owned by this process to conform to mapping */
> +#define MPOL_MF_MOVE_ALL     (1<<2) /* Move every page to conform to mapping */
> +
> +#endif /* SELFTEST_KVM_NUMAIF_H */

My fault. :(  I had the file locally of course, but ended up not being 
committed.

Paolo

