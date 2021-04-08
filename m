Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE319358A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhDHQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhDHQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:56:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13009C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:56:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m11so2260186pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfNWWgdKdl9R3c8saiXMYMVU97LjgEbiqFdKW/3lJXg=;
        b=WFgtnS5NoKTB+ZP6o9d1NkasuXh5ajH+f/ry0L2iI6fB0e4/RJW2i7aGpMeuWAopOC
         mFbJtebwpT08W/9H8wvIETf6JcWKo0Vvtb5KcmEu8TZlJ6QMa6jECD4llYw7abiVXIPS
         hSRdpmBRbiMqs5LJbh0G3sHC7iME0eo1VBloo5VlQtt4B6Tq50nBLzuKtQB9491memvn
         J5VH3lrqLENAUn6A4L92AZjH1m0HoMsIHI57i289OUkjN1Xatz5eSu80brcJI1tMkptZ
         qqU0UEPTHY1nZUYgv70Km8tmR0Mw2puChjwx9L0s+RBwujrGSVZXQMTg+bC+3Fe49zdT
         zgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfNWWgdKdl9R3c8saiXMYMVU97LjgEbiqFdKW/3lJXg=;
        b=tF07kh7LzZGtMWV73LdtHr1suiwdVW9b23yOK7mQRGe8IrkYK+7btFRs/KsH8lTs4j
         cXFbMs75QlmuE0kAKNj6tlzQHHo6eJJ0/+0kBSzrNSDI/DuUbpzQdyD4SI/J1M8hwtJQ
         xdgsHdbELWmQjy/9rd7OUaehyZ9PmJa9rwTVv4KOuzYX6OAxDNCii2qrjXgiW4nrqTib
         0huWdJ0vwO06rK1pNKrsP3cc4oh5j7CaYnQvRnzhapYbMSVUCJ4EQe5gEcGcWRcv/b/D
         DuLqosTMhVnbfdbV3eGELvQDhkjpp7JUM7qT7uNZxdN+C15WgRsH7C5OZFWRrpjTW/R1
         t9kQ==
X-Gm-Message-State: AOAM531kgc864pspLHl+NV5UK777QtCjyYOIV6InMNdao1jnLVPc+s+Z
        BAZeJ1oiaxixl/6Q4XHCjX8vrEEKZhUlWQ==
X-Google-Smtp-Source: ABdhPJx0bYX1CLTWtqLHar66ui00ZkBdtoTTFFJnWejqc8Sunz6Gt5WRmNTXUPkVa/xZyEI4YS/9ig==
X-Received: by 2002:a65:4985:: with SMTP id r5mr8845677pgs.65.1617900986405;
        Thu, 08 Apr 2021 09:56:26 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id u18sm54005pfm.4.2021.04.08.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:56:25 -0700 (PDT)
Date:   Thu, 8 Apr 2021 16:56:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: X86: Do not yield to self
Message-ID: <YG81to0nF/M7DEGA@google.com>
References: <1617880989-8019-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617880989-8019-1-git-send-email-wanpengli@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> If the target is self we do not need to yield, we can avoid malicious 
> guest to play this.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> Rebased on https://lore.kernel.org/kvm/1617697935-4158-1-git-send-email-wanpengli@tencent.com/
> 
>  arch/x86/kvm/x86.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 43c9f9b..260650f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8230,6 +8230,10 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
>  	if (!target)
>  		goto no_yield;
>  
> +	/* yield to self */

If you're going to bother with a comment, maybe elaborate a bit, e.g.

	/* Ignore requests to yield to self. */

> +	if (vcpu->vcpu_id == target->vcpu_id)
> +		goto no_yield;
> +
>  	if (!READ_ONCE(target->ready))
>  		goto no_yield;
>  
> -- 
> 2.7.4
> 
