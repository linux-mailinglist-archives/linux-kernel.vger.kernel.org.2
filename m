Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649FC3DE984
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhHCJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234781AbhHCJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627981877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIKn03z5ubB6Wa0ZSYCt0KU7dO1+0oO63GdVTUDnmss=;
        b=iS4JVfrFyoSqFXO8rIn8Dbtbpcnz6G2TcOoizKobKAVM0HYK5dCmyDnNSPbBkCOft4Do7T
        7NMXXZKJ1VUP2m6eaGOJKzXlriSCIopdP+gduC2aU3IjT/jP6FVsi49lo5+JfaNhXewozh
        wpMO+w81cf2g1RhLUwUIrSFwl3VUQ4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-h-WrQPIlMU21MGrq6DzgGw-1; Tue, 03 Aug 2021 05:11:16 -0400
X-MC-Unique: h-WrQPIlMU21MGrq6DzgGw-1
Received: by mail-wm1-f71.google.com with SMTP id a197-20020a1c98ce0000b029025831695a2eso2873567wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIKn03z5ubB6Wa0ZSYCt0KU7dO1+0oO63GdVTUDnmss=;
        b=Mg0c3K4pVOeGrK4tiq+F7J7tkHLuMc43Xs5dGumhfqa2FZHZhYEg1eA1p/IZxAcYSU
         LbOSqnsrGlNIE08+HFBTQxAP81RRW/FOpGltpDz7HAbnU5ahEr7KPqUn8U5HjavJqYTS
         geHGP3SIoAi28XJ867TmfUKKvZUTTM030ttEXaARcPeWCUG9MiENr3+K1m+NnXgb81UC
         GP02bjTw8UddTHUCXGdXhcPZ3IjjNQ7kgFz2DPlexguDyVpXkkRHi1jpgWgQvpv7e8Eg
         7WjCbjPUUkJR7AsHq5vqR9Lnq5O/ZUnqu02xIkBcKonKyXKSjGoUaeqNYR4hdlOy5ANF
         7HwA==
X-Gm-Message-State: AOAM533iSuzk25snopQVGw8xohvqo3nqPSaftjH9mNcF4Kd+XcYMwcd8
        bHwesxX5A28oukjQmgwhDj9loJuzmvID9UP9AMIAqm7163PpylRSCNcLrW58sXPeTItSLwb2x6u
        /43NkDpKXWMp1BffbZKhzWioZ
X-Received: by 2002:a5d:690e:: with SMTP id t14mr21732605wru.258.1627981875490;
        Tue, 03 Aug 2021 02:11:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4/UB0WUjU/bXx6Z4ps32z0caP8P3/YmiKmwO/bxrc/2M2ngav+Pqn9V54P1P19/m4tmnhZA==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr21732583wru.258.1627981875299;
        Tue, 03 Aug 2021 02:11:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id v15sm1980057wmj.39.2021.08.03.02.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 02:11:14 -0700 (PDT)
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210802183329.2309921-1-mlevitsk@redhat.com>
 <20210802183329.2309921-10-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 09/12] KVM: x86: hyper-v: Deactivate APICv only when
 AutoEOI feature is in use
Message-ID: <eb012e5e-e116-98e9-ef77-8690be66b06c@redhat.com>
Date:   Tue, 3 Aug 2021 11:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802183329.2309921-10-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/21 20:33, Maxim Levitsky wrote:
> +	if (!auto_eoi_old && auto_eoi_new) {
> +		if (atomic_inc_return(&hv->synic_auto_eoi_used) == 1)
> +			kvm_request_apicv_update(vcpu->kvm, false,
> +						APICV_INHIBIT_REASON_HYPERV);
> +	} else if (!auto_eoi_new && auto_eoi_old) {
> +		if (atomic_dec_return(&hv->synic_auto_eoi_used) == 0)
> +			kvm_request_apicv_update(vcpu->kvm, true,
> +						APICV_INHIBIT_REASON_HYPERV);

Hmm no, Reviewed-by rescinded.  This is racy, you cannot use atomics. 
The check for zero needs to happen within the lock.

The easiest way is to have a __kvm_request_apicv_update function that 
leaves it to the caller to take the lock.  Then synic_update_vector can do

	if (!!auto_eoi_old == !!auto_eoi_new)
		return;

	mutex_lock(&kvm->apicv_update_lock);
	bool was_active = hv->synic_auto_eoi_used;
	if (auto_eoi_new)
		hv->synic_auto_eoi_used++;
	else
		hv->synic_auto_eoi_used--;

	if (!!hv->synic_auto_eoi_used != !!was_active)
		__kvm_request_apicv_update(vcpu->kvm,
					   !!hv->synic_auto_eoi_used,
					   APICV_INHIBIT_REASON_HYPERV);
	mutex_unlock(&kvm->apicv_update_lock);

Please add a note to synic_auto_eoi_used that it is protected by 
apicv_update_lock.

Thanks,

Paolo

