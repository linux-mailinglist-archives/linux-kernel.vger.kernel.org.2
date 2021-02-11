Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BE3186C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBKJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhBKJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613034293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM3Da8iocaqkxI1nhtzpteIP7lNMc8fHWHa3MuG0/jw=;
        b=Cv8reZC3bDZrfgNR0KFgvRcb/6Q/76upaqDHllh1/3TMJv5MsyiIt8RGqK50eBv17pPnPL
        y/BOc5/ZdLRj+cHAHRb1UAhCqJmPoYun1tCycLiiHv9q2zXBPCxCgpmTpgBo71ha5jTmw7
        g7RUetzkA0utw6kPeL7QEI23DgmNPv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-8LsMp0htPdGMiItJSwBZeg-1; Thu, 11 Feb 2021 04:04:51 -0500
X-MC-Unique: 8LsMp0htPdGMiItJSwBZeg-1
Received: by mail-wm1-f69.google.com with SMTP id q24so2903710wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kM3Da8iocaqkxI1nhtzpteIP7lNMc8fHWHa3MuG0/jw=;
        b=ajV2X5yguXt2RoyypQOjEw7YX3kxrQcvMVt/DcoLpBXXq17ko+epq5jObdkVlxeON3
         R6uEkKYeabNhvcRl30IPqwJWoFKFcEwC4gfdg8plCO4wcwJUt03qwpnLWovrLp7JT3jH
         UxdK2ZMzWvIysgqofJd+RpN8RRDfTN96Z+zgx77ihfekxME3qeYrg8TvnjLAUiTSDk+g
         PypyXvJByLI7tKMgeIkTg9R94rSv6d37l2grUEFKTKA0ZQR0vPeTFkyRiZQXQLzYgxs9
         awNy/sRypXxQGN0I4giQ2OftMzoRqatTroc2TxTnSwfTtgDYEQxI15UTl8tmgMZ0dFpw
         MVew==
X-Gm-Message-State: AOAM532E510vw+MPoj8Kvo2qXr7ulG0M6XHhYWzeQIw5aNNBUZjuL/o5
        kBd5mkUg5BM4vALA9Ac0JieFgd/J28kZC7vCbZdSPaeU589Xvw+Ac009dMybfsARvxDJeCQRltk
        GS1zCkBFVNLwucuhsQREepxxS
X-Received: by 2002:a1c:998a:: with SMTP id b132mr4043846wme.37.1613034290606;
        Thu, 11 Feb 2021 01:04:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOZKPoxZFJ8Sf+KV1ysVPtGVanqg/2Y3Zx7fdFcB0n+HtmfIIRwiXp0yxjoU2IC7ZFUwOCfw==
X-Received: by 2002:a1c:998a:: with SMTP id b132mr4043825wme.37.1613034290458;
        Thu, 11 Feb 2021 01:04:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v1sm8871459wmj.31.2021.02.11.01.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 01:04:49 -0800 (PST)
To:     Makarand Sonare <makarandsonare@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com, pshier@google.com,
        jmattson@google.com
Cc:     Ben Gardon <bgardon@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
Message-ID: <7c78c6df-36e7-1473-e834-3786e257ebc5@redhat.com>
Date:   Thu, 11 Feb 2021 10:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210212308.2219465-1-makarandsonare@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 22:23, Makarand Sonare wrote:
> +void vmx_update_pml_in_vmcs(struct kvm_vcpu *vcpu)
> +{
> +	if (cpu_has_secondary_exec_ctrls()) {
> +		if (is_guest_mode(vcpu)) {
> +			to_vmx(vcpu)->nested.deferred_update_pml_vmcs = true;
> +			return;
> +		}
> +
> +		if (vcpu->kvm->arch.pml_enabled)
> +			vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
> +				SECONDARY_EXEC_ENABLE_PML);
> +		else
> +			vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
> +				SECONDARY_EXEC_ENABLE_PML);
> +	}
> +}


Since the execution controls are shadowed, they can be read quite 
efficiently.  This means that there's no need for 
vcpu->kvm->arch.pml_enabled, and also that the copy can be done 
unconditionally in prepare_vmcs02 and nested_vmx_vmexit.

If the above is not true, we should at least combine 
change_vmcs01_virtual_apic_mode, reload_vmcs01_apic_access_page and the 
new field in a single bit field, for example 
vmx->nested.dirty_vmcs01_fields or vmx->nested.vmexit_requests.

In any case I expect Sean to take care of submitting this patch and I 
have to do nothing more about it, right?

Paolo

