Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9163A45BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFKPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbhFKPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623426780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2DcFVW5UG3Y7uZALNi7/0ctrY+3j3dgaMF4MGWjWKs=;
        b=TmrdXoNBq6bXd5RMFgJiBiWpnkaFI5zp31RTv/eqoSzclMlQuabj0Fx4+eQu+3CSjygP5j
        v+0gYJ2/apTQkUTwkCdYEZqIDovHOa7rWDM/xJcH/VlhUn0IAEGD1gbK0AnDxuGYMKYNki
        OjspLX7chSjxL6Y+MUDf71dQ3caw9cU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-oOZNwWWmMZGCyuOpCEJVUw-1; Fri, 11 Jun 2021 11:52:58 -0400
X-MC-Unique: oOZNwWWmMZGCyuOpCEJVUw-1
Received: by mail-wr1-f72.google.com with SMTP id t14-20020adfe44e0000b029011851efa802so2810560wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 08:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2DcFVW5UG3Y7uZALNi7/0ctrY+3j3dgaMF4MGWjWKs=;
        b=m1R2O8eC3JDeObJM+3N411O4LMzm0YzHq9l8gPLu07kBK7kVLc0rGF0aGGQILT23Ba
         Za6kmU1YQ+WzvSPEE6OetYezjLwoxSPfyXuh1qhsOMmnAUxegm1POcy5RqKob8VznIre
         rag8rpJ7gRyNNZKcPAbujHujswe6D5iFN7JzrujbyyK7cggB4a83SfhROLr1sXPvTJWP
         3xFSBSli7YTmIxHSvzukKvm2SWNMFEAlQ2BvRUqS6ZhWWVSnAjD5tCReaZkyPIS6z/lm
         ba6bQweCCAqpJEV3VbjFWXIDGd0XFYEjh4BO4oWHGcBmNuyOV6DtM59sveIzRqvvIZaj
         SXEw==
X-Gm-Message-State: AOAM532fU5nrUeDM9WUckX+zT4XgyFGFpBL+PC6/TpkEKE6n9K6yDVCH
        S/zL9JxRSFBphSApi3eNecBBwBZSSBqDU/wJ2FLkHrsBJp2E5pRKymmpaZiAE03NqFl6koe+f0A
        aE9r2rFzjwtxXF+yN4o0t1KQV
X-Received: by 2002:a05:600c:358b:: with SMTP id p11mr4589547wmq.112.1623426777467;
        Fri, 11 Jun 2021 08:52:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxce8iY5le8kubRFtLoryRJz2h1QS3oPU9ADdAhaE7kEGsLAbc1qU78T03+2mRS/T9kPOzS1A==
X-Received: by 2002:a05:600c:358b:: with SMTP id p11mr4589530wmq.112.1623426777213;
        Fri, 11 Jun 2021 08:52:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h15sm7413127wrq.88.2021.06.11.08.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:52:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Call SEV Guest Decommission if ASID binding
 fails
To:     Alper Gun <alpergun@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Gonda <pgonda@google.com>
References: <20210610174604.2554090-1-alpergun@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28a0cb0a-b915-0117-2d1d-84d8a13672fb@redhat.com>
Date:   Fri, 11 Jun 2021 17:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210610174604.2554090-1-alpergun@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 19:46, Alper Gun wrote:
> Send SEV_CMD_DECOMMISSION command to PSP firmware if ASID binding
> fails. If a failure happens after  a successful LAUNCH_START command,
> a decommission command should be executed. Otherwise, guest context
> will be unfreed inside the AMD SP. After the firmware will not have
> memory to allocate more SEV guest context, LAUNCH_START command will
> begin to fail with SEV_RET_RESOURCE_LIMIT error.
> 
> The existing code calls decommission inside sev_unbind_asid, but it is
> not called if a failure happens before guest activation succeeds. If
> sev_bind_asid fails, decommission is never called. PSP firmware has a
> limit for the number of guests. If sev_asid_binding fails many times,
> PSP firmware will not have resources to create another guest context.
> 
> Cc: stable@vger.kernel.org
> Fixes: 59414c989220 ("KVM: SVM: Add support for KVM_SEV_LAUNCH_START command")
> Reported-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: Alper Gun <alpergun@google.com>
> ---
>   arch/x86/kvm/svm/sev.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e0ce5da97fc2..8d36f0c73071 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -199,9 +199,19 @@ static void sev_asid_free(struct kvm_sev_info *sev)
>   	sev->misc_cg = NULL;
>   }
>   
> -static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
> +static void sev_decommission(unsigned int handle)
>   {
>   	struct sev_data_decommission decommission;
> +
> +	if (!handle)
> +		return;
> +
> +	decommission.handle = handle;
> +	sev_guest_decommission(&decommission, NULL);
> +}
> +
> +static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
> +{
>   	struct sev_data_deactivate deactivate;
>   
>   	if (!handle)
> @@ -214,9 +224,7 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
>   	sev_guest_deactivate(&deactivate, NULL);
>   	up_read(&sev_deactivate_lock);
>   
> -	/* decommission handle */
> -	decommission.handle = handle;
> -	sev_guest_decommission(&decommission, NULL);
> +	sev_decommission(handle);
>   }
>   
>   static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
> @@ -341,8 +349,10 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>   
>   	/* Bind ASID to this guest */
>   	ret = sev_bind_asid(kvm, start.handle, error);
> -	if (ret)
> +	if (ret) {
> +		sev_decommission(start.handle);
>   		goto e_free_session;
> +	}
>   
>   	/* return handle to userspace */
>   	params.handle = start.handle;
> 

Queued, thanks.

Paolo

