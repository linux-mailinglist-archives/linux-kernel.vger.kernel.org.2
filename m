Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782783E4888
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhHIPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhHIPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:17:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FDC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:17:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so16668485plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1rBimOQqBfS0t2C1mkadjzVlwSfMw8BGzHKfbOms0qM=;
        b=eEuy9voU/VxU3QqfwPx11xqZ+LWbeO4CKE4jyxRUvQHNazrof0gLp7s0oa13mEDr5/
         EMt9hGLlkJxC1FkYYxe4pTM3etdvInxGOFCVx80YgWpVxxpERvdC0CuGVkdis3yLhJzb
         v5caVKEqR/tu+ruTz+IrEBLPvOLihxvg7q74nnFiKXQjKNfy20RhmebHKWynq5CQwXVe
         cUyqGZHH1+HvTtb4DLQBSdfIkjqpcz2EskM6tgWXignSJRXjLkesTFnf9Yl5e/5koNNj
         TYHi08YJN3EmFGJZbjDIWt5qgQ2Dq0Wnr/WLEV7KND9pTH4jcb9fPOCdB3/jHr5vL4Uk
         IHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rBimOQqBfS0t2C1mkadjzVlwSfMw8BGzHKfbOms0qM=;
        b=VEXifwyG1pTxrVPcaR8Bcbtnaj5iG+ORajWITRU7qduTw//a+/9wqjUt2l9RHkaH++
         doa9O5nbKbySrB0Lbtphj215aj6DYeJHJv8Beq1T2ME5ABIeK+PcIkXyVvfSEASrvdhH
         Bbt5Sf/V3/nQ5us1XqKc6wcDgUnsfqtelzaXUh2T76D4IMe5ih1Tylzyy9zjIjo4hchw
         09CB0PjZDc43R3iUcmM4xv6ROOl9XMphJM1fT/U+5lVFtt3itwannIceAgbbvazV1l5Q
         +O9ROhUWV/PGSNsuDpDnBhZl7ukyqw/JQKb+PJnD5uNO0JV9CkowpSY4+fku7E3SN5tN
         hFbw==
X-Gm-Message-State: AOAM530ngXwtoYJSxLmN5BP0LphDsUDB+CFsBapTQZI0FYRsvj/76TGP
        F/C2aZvHjrg/hb19YY48F5EBmA==
X-Google-Smtp-Source: ABdhPJzxOXGSlzNCK6LhA3GIi8oMTVdR/PW+HlylORrFfgEkdqP9Hpfpz9gtiNOGDRl4WHdrqBu09A==
X-Received: by 2002:a63:e60e:: with SMTP id g14mr96930pgh.212.1628522237874;
        Mon, 09 Aug 2021 08:17:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s23sm14680997pfg.208.2021.08.09.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 08:17:16 -0700 (PDT)
Date:   Mon, 9 Aug 2021 15:17:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2 2/3] KVM: x86: Handle the case of 5-level shadow page
 table
Message-ID: <YRFG+NDkjVK0myDn@google.com>
References: <20210808192658.2923641-1-wei.huang2@amd.com>
 <20210808192658.2923641-3-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808192658.2923641-3-wei.huang2@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021, Wei Huang wrote:
> @@ -3457,10 +3457,19 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  		mmu->pae_root[i] = root | pm_mask;
>  	}
>  
> -	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL)
> +	/*
> +	 * Depending on the shadow_root_level, build the root_hpa table by
> +	 * chaining either pml5->pml4->pae or pml4->pae.
> +	 */
> +	mmu->root_hpa = __pa(mmu->pae_root);
> +	if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
> +		mmu->pml4_root[0] = mmu->root_hpa | pm_mask;
>  		mmu->root_hpa = __pa(mmu->pml4_root);
> -	else
> -		mmu->root_hpa = __pa(mmu->pae_root);
> +	}
> +	if (mmu->shadow_root_level == PT64_ROOT_5LEVEL) {
> +		mmu->pml5_root[0] = mmu->root_hpa | pm_mask;
> +		mmu->root_hpa = __pa(mmu->pml5_root);
> +	}

I still really dislike this approach, it requires visually connecting multiple
statements to understand the chain.  I don't see any advantage (the 6-level paging
comment was 99.9% a joke) of rewriting root_hpa other than that's how it's done today.

In the future, please give reviewers ample opportunity to respond before sending
a new version if there's disagreement, otherwise the conversation gets carried
over into a different thread and loses the original context.

>  
>  set_root_pgd:
>  	mmu->root_pgd = root_pgd;
