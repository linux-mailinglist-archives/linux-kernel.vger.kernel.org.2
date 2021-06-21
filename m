Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB983AE95A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFUMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhFUMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624279478;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY6nAdAkng/ghHrBQBfm1ZmFUpZlorDdA2kwXRZ+7xU=;
        b=IeJddnMBNzRxZYjoe8AYD16RoMkHPxOOZjzkELNuF5g1EOK8lQSpm44BC6cfjprN4SxDzU
        SefAExNb9XCdWGTfrOBjLck3bM8ni2OrYCX75znUwJrPK0njt6ReISxwaUqq/wHT4aFV79
        906UwvAWHE4Udo6BJa7wt0b5/0LNA74=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-557bAHbMOsS2qQGtZV_jLg-1; Mon, 21 Jun 2021 08:44:37 -0400
X-MC-Unique: 557bAHbMOsS2qQGtZV_jLg-1
Received: by mail-wr1-f69.google.com with SMTP id k3-20020a5d62830000b029011a69a4d069so8180311wru.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xY6nAdAkng/ghHrBQBfm1ZmFUpZlorDdA2kwXRZ+7xU=;
        b=HtF1VUZB3X4NkenvW749VjSUOvXpdY5mHRIBDOTJO+8uBCs+r4RWO1aw+NycI0rAdr
         itd/St/F1t0Z3FEOwuCIK/Rg6m0l535zodgKPE+nRuudjgkxQqhtpPNzBE0XTgPYBW9y
         5rRNhuQlNxrgxlmClQeLlxw6u4v7jWRYrdSmMYrf7aInVuVdzAbZzUB+YWAAGE5J96RD
         ocrhmAXh1eosSDh/8dldmG2MaIk8/grhLbPQjMs6fqgUccieJ3dB0q+vVqoqGTgOkWui
         bvyfODqeWi143NXrSJuP5wMAL+fxJL7BfeUD4rsqeXgVLKieQIIIRJRuZXFt/cCMR4i1
         VhCA==
X-Gm-Message-State: AOAM532iplC4p0+f8K0GpXvt9Movi3OV5SvLsaCzPBQ1m2JXJtHaBiYG
        2oQFtd5Q0hiJixhs0mLroJlkCaC7qx260Qv6KtwDs6qbHV75x/xmVRou8hYktVW0QoUVV92+Iqq
        1zRkokpO22R5CRLpVdvcl7sUf
X-Received: by 2002:a5d:47af:: with SMTP id 15mr27383125wrb.289.1624279475170;
        Mon, 21 Jun 2021 05:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiQHL5PA0rXiLB9N/4Ymzd355PSqLCUCP+mLc4znMmOdX5sFeuYsZH8JOoThSHcMZrCXCncg==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr27383108wrb.289.1624279475043;
        Mon, 21 Jun 2021 05:44:35 -0700 (PDT)
Received: from [192.168.43.95] ([37.173.110.237])
        by smtp.gmail.com with ESMTPSA id r1sm716931wmn.10.2021.06.21.05.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:44:34 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] KVM: arm/arm64: Fix KVM_VGIC_V3_ADDR_TYPE_REDIST read
To:     eric.auger.pro@gmail.com, stable@vger.kernel.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210621121839.792649-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <495e1326-14aa-7d7e-abf4-1054978c8de2@redhat.com>
Date:   Mon, 21 Jun 2021 14:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210621121839.792649-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/21/21 2:18 PM, Eric Auger wrote:
> When reading the base address of the a REDIST region
> through KVM_VGIC_V3_ADDR_TYPE_REDIST we expect the
> redistributor region list to be populated with a single
> element.
>
> However list_first_entry() expects the list to be non empty.
> Instead we should use list_first_entry_or_null which effectively
> returns NULL if the list is empty.
>
> Fixes: dbd9733ab674 ("KVM: arm/arm64: Replace the single rdist region by a list")
> Cc: <Stable@vger.kernel.org> # v4.19
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210412150034.29185-1-eric.auger@redhat.com

so I have resent with the [PATCH for-stable-4.19] prefix.
Please ignore that patch and sorry for the mess.

Thanks

Eric
> ---
>  virt/kvm/arm/vgic/vgic-kvm-device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-kvm-device.c b/virt/kvm/arm/vgic/vgic-kvm-device.c
> index 6ada2432e37c..71d92096776e 100644
> --- a/virt/kvm/arm/vgic/vgic-kvm-device.c
> +++ b/virt/kvm/arm/vgic/vgic-kvm-device.c
> @@ -95,8 +95,8 @@ int kvm_vgic_addr(struct kvm *kvm, unsigned long type, u64 *addr, bool write)
>  			r = vgic_v3_set_redist_base(kvm, 0, *addr, 0);
>  			goto out;
>  		}
> -		rdreg = list_first_entry(&vgic->rd_regions,
> -					 struct vgic_redist_region, list);
> +		rdreg = list_first_entry_or_null(&vgic->rd_regions,
> +						 struct vgic_redist_region, list);
>  		if (!rdreg)
>  			addr_ptr = &undef_value;
>  		else

