Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D744C295
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhKJN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231703AbhKJN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636552517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZoEdq1cAEDDdjqXmBuOIaZKRp+qKO19UTUs+iGQkGE=;
        b=C5UeI67Ps3WjVr4pJM4ZSZ93ausx9WqvfwSlkuYYqTSVTM7IZ3QMfPuGLLFKDWnWR1IAb2
        y1gwktWXeyBnaCzGSuczPPRfZfbYg93ZTJJVVOvtw6jRwblnLmJDOczIySWcGLiBCtGFJe
        201eD+M3H4FK6U+Jtseazbq7GSgjdZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-l2TOJsd6Mk6aSMRFpTkckQ-1; Wed, 10 Nov 2021 08:55:13 -0500
X-MC-Unique: l2TOJsd6Mk6aSMRFpTkckQ-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so438240wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 05:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZoEdq1cAEDDdjqXmBuOIaZKRp+qKO19UTUs+iGQkGE=;
        b=5TEpj9WrH9+kbz0YKtQJ8UBlpFx0yB2tHVHm/kG3Ze/FWocce75+tESL47P4U4YleT
         +eVK6sOfFmhe3WfA4XUeUcUYPn2j4IxxQoajZ7KC16amPxYce0sUmBP4KkWfBnVAZuvO
         riIWhzyasVWcx0AeDKuPvUHE2eg8MtR872LoGPFtNB+lPhhDZmLVJT9u2GarvMhOUZ85
         qVoOuvjo9/ZiaW0416P1p4nRssoCM8x7PzJK8Jvmw0qciBSE8CMJZpbUN+P9qARK2DYi
         zl4U/G26S/g9Ux5r3NYnrblGDAlt0iA05C6Th1McdwjFPF13x+zaCR9R7qlbaTdKwfA1
         buhQ==
X-Gm-Message-State: AOAM530YPBBLjq8t4HRUygKsivxXBcocHnSIFFLioG6CdJFuWbmAt/fv
        PicnUcTS9ZubUcr0P0U3wbdBFm4RLkgKuWqpa2GJcr3XztFTfx6zmsMGSOHOvX3OImhjZloP/AG
        X8eoGdIU+zosXklsSkXR6ubRw
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr16615839wmc.165.1636552512411;
        Wed, 10 Nov 2021 05:55:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzatmcpB1eUzSgZYGxlp7SFChMiFKPXI4SL7EZgVGC7UzmTfba/sBwxlAcTQPukVt/SkxY3jA==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr16615791wmc.165.1636552512138;
        Wed, 10 Nov 2021 05:55:12 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z5sm7918884wmp.26.2021.11.10.05.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 05:55:11 -0800 (PST)
Subject: Re: [PATCH v4 20/21] KVM: arm64: Export SDEI capability
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <20210815001352.81927-21-gshan@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <90fd5226-0889-6a7c-1586-732015943863@redhat.com>
Date:   Wed, 10 Nov 2021 14:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-21-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/21 2:13 AM, Gavin Shan wrote:
> The SDEI functionality is ready to be exported so far. This adds
> new capability (KVM_CAP_ARM_SDEI) and exports it.

Need to be documented in
kvm/api.rst
as the rest of the API

Eric
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/arm.c     | 3 +++
>  include/uapi/linux/kvm.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 215cdbeb272a..7d9bbc888ae5 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -278,6 +278,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_PTRAUTH_GENERIC:
>  		r = system_has_full_ptr_auth();
>  		break;
> +	case KVM_CAP_ARM_SDEI:
> +		r = 1;
> +		break;
>  	default:
>  		r = 0;
>  	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 8cf41fd4bf86..2aa748fd89c7 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_BINARY_STATS_FD 203
>  #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>  #define KVM_CAP_ARM_MTE 205
> +#define KVM_CAP_ARM_SDEI 206
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 
Eric

