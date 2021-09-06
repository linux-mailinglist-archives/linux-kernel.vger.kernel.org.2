Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E2401B23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbhIFMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241934AbhIFMZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630931057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5T3jMeGN4kX5wlrRjGBWKj+SsZVCRR2xQTk1YdLtOs4=;
        b=S2Ll9jT0xlWSYhgif9UJid51o7iLciOZyd26tkxVmAc1imc4t799S/cqSjzSix0kncmY85
        p4z0EibleGJP348VvQHFz8I8K3+OvzP4J24ZVeMw4Q0g1Gs28e6jcqZK++0o5j4TMAS06z
        q9YR7BQXvW0n8SSLegmd2fFyBAmFOzk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-uZRwnPWUP22DCpUTGDkKmw-1; Mon, 06 Sep 2021 08:24:16 -0400
X-MC-Unique: uZRwnPWUP22DCpUTGDkKmw-1
Received: by mail-ed1-f71.google.com with SMTP id g4-20020a056402180400b003c2e8da869bso3614032edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5T3jMeGN4kX5wlrRjGBWKj+SsZVCRR2xQTk1YdLtOs4=;
        b=QyOLByCVT0pwkKqKA7bz6Xu+TMGMtABKGGj3EAlUaiTEN0AI8E8pkXhc9U6cOXbBDK
         uYI6tIxPNPTzVJAgGYxlXdFLhxS3RjBGSZap8W1vcYCOj6zVHUAiTj4ptFutmzWC5agt
         uJvbEGcUjtRB6R4KGq6VfDhTYhU9nx/L0W7ciglAtRpSVFt9Se2EnPRcmqwhjuPfETPd
         p0jMOXAKe6+8SvZWoxsM4s87mbRbcLIBYhh0aUDMCeaprtvzeRI+6u7WVV8P8l8Q4CC7
         +i4H9ud8xhbHdUyZh/8/TGhfyZDdenGahYVnvCLVhM/VGc3/nDL0Md+m9i6hoS7P6qxl
         gZxQ==
X-Gm-Message-State: AOAM531s+b032xQFYWT92PIZ/rTf0oCCB15H+xm6XEuI1P94PHy+iUuI
        L0yrRFjIP3o+tVn8P7jFN7ZXFWZkt1dPqPSGW70Rqp3mJ4zbr4wbsm0wMOkNVmcFuRFV91zZZtU
        NQ3j8t//8yYdWk8Lu4xOUBiOf
X-Received: by 2002:a05:6402:b7c:: with SMTP id cb28mr12962443edb.152.1630931054922;
        Mon, 06 Sep 2021 05:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpxMI6NExBPU/SlkCnU4bFtlsTovlMfLu3JG5Ts6X/yfcGcvonJPvRojtNx12kOY5m7Vxgdw==
X-Received: by 2002:a05:6402:b7c:: with SMTP id cb28mr12962417edb.152.1630931054670;
        Mon, 06 Sep 2021 05:24:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q9sm3864150ejf.70.2021.09.06.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 05:24:14 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: Drop unused kvm_dirty_gfn_invalid()
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20210901230904.15164-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <786bbcc9-50dd-51c9-61e1-fe04204ca3f6@redhat.com>
Date:   Mon, 6 Sep 2021 14:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901230904.15164-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/21 01:09, Peter Xu wrote:
> Drop the unused function as reported by test bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> --
> v2:
> - Fix the subject that points to the right function; the copy-paste failed.
> ---
>   virt/kvm/dirty_ring.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index 7aafefc50aa7..88f4683198ea 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -91,11 +91,6 @@ static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
>   	gfn->flags = KVM_DIRTY_GFN_F_DIRTY;
>   }
>   
> -static inline bool kvm_dirty_gfn_invalid(struct kvm_dirty_gfn *gfn)
> -{
> -	return gfn->flags == 0;
> -}
> -
>   static inline bool kvm_dirty_gfn_harvested(struct kvm_dirty_gfn *gfn)
>   {
>   	return gfn->flags & KVM_DIRTY_GFN_F_RESET;
> 

Queued, thanks.

Paolo

