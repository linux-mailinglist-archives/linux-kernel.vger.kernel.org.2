Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38C13AE8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUMYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhFUMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624278113;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhDAKKgaNDrSL7iSXcPu9LD5gECJffFFHIw26sWyyR0=;
        b=EB4NhdvXbk8MaJC3Ss43fjYmDXmrttqEckL9cR3UI7uIFA+MbJB/aozcYf5ov0MNhgMQU+
        8QAvaYBRvJJoZOFFIsqomdD4UuWwHM3qVSceOegL/1ssg3k+MELf8c+KG9MnOzcKVlTHnB
        sB0x1zl6wqI4xTjKvGk2jD2Z2qrMVko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-aOPc2N2jORq-EB6JczOgeg-1; Mon, 21 Jun 2021 08:21:52 -0400
X-MC-Unique: aOPc2N2jORq-EB6JczOgeg-1
Received: by mail-wm1-f71.google.com with SMTP id w186-20020a1cdfc30000b02901ced88b501dso5768468wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VhDAKKgaNDrSL7iSXcPu9LD5gECJffFFHIw26sWyyR0=;
        b=eGov7Ed34O+ZSTdWctpauNtmr4H2zkv9t/AEec9ufZlMaRZfsc3Qn14RUvJ5vtDC4u
         N/XB2Px6ev9lvPEJX0OncgrEOFuY3sl048GzO6Pgvj51wqHWXobrb2rwAtXNImZEDBPl
         XD8Zn8m+tfaAGnbdI07lTmfBQz4yBkpldKvSvPO9BxmRJq3jKlUm+VUTSLEGwhLjcnHQ
         y65EBqyzzlR0fyWixflAYYvZROAvuZIxV27mU9ZXTVhoJ0CIysevnzvqhKo/U5Pr2Qi6
         sFgbh+xKtARYTs/ELb+25V/9Lod1Z9aXDwfHkCUVPOAd5BICLd4/w1mz4brb/nHmY3sI
         idNQ==
X-Gm-Message-State: AOAM533F03w53vez1kPkS/s+jrd62MqZAWfdDA1hGiv9X/w+6jgBadHj
        AMQApdectM58VvNuAaLKzWWHjYn+qMhb5xEd+ACaBAv+D4u/xo9JQ2Ce51TJk65+yP/FSkmUIb7
        Qkeupxkez00Nsc3e2VfWrVRYV
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr12106037wmj.33.1624278110436;
        Mon, 21 Jun 2021 05:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFLQpGIAVfisiyTY6nyCXRe3QRWDsB4/y9R3ja660K2K9yyGgRerGQ+R2pQj2G1e1aEWhFSw==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr12106002wmj.33.1624278110220;
        Mon, 21 Jun 2021 05:21:50 -0700 (PDT)
Received: from [192.168.43.95] ([37.173.110.237])
        by smtp.gmail.com with ESMTPSA id l23sm16824154wmc.5.2021.06.21.05.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:21:49 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] KVM: arm/arm64: Fix KVM_VGIC_V3_ADDR_TYPE_REDIST read
To:     eric.auger.pro@gmail.com, stable@vger.kernel.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
References: <20210621121839.792649-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <f8e6aab9-651c-9ef1-2621-6d61374704cc@redhat.com>
Date:   Mon, 21 Jun 2021 14:21:48 +0200
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

Maybe I should I prefixed the patch with [stable-4.19]. This is already
on master and in various stable but did not apply on 4.19

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

