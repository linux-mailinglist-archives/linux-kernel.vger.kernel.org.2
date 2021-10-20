Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB543554D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhJTVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhJTVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634765573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+m6bzLId3io/wO6+zODL/eJosW6ab9oTsOZW/f6Hvcg=;
        b=NBraPcCOctoxqrPqXpZV2yFoieST2s/j+hC4KGNbnHWD9YXiyWXIsjObssydZLbJh5bPKH
        bTRsMrg52hU/RkiviDC2XKEaIgearkH78PsFxOatsWPvpNi6PAKPd4ZvDXdgGW/+ELzGjL
        LR/CePRAQfrpmGFBcBbeRncPSXX2UJs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-AYo8OobqPGqF3KslyxOL7A-1; Wed, 20 Oct 2021 17:32:50 -0400
X-MC-Unique: AYo8OobqPGqF3KslyxOL7A-1
Received: by mail-wm1-f69.google.com with SMTP id a85-20020a1c9858000000b003231f6f95cbso95988wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+m6bzLId3io/wO6+zODL/eJosW6ab9oTsOZW/f6Hvcg=;
        b=yzPgXxI138G3k2DvYu94JA2PvrR8E+OjSesq9qcHcm0HaBTr9FAqbNQ2lcSMeFRvl0
         KyIS7S+pQjnksPYOhyLs19SnUJ27BAn0MFsVFYxa68KL+Mp86itQniMOZbm5dt/D8AVY
         rGRUdqpx+cv2XXppo6J3pn4PNhJPpOkzI9mpZ8sXTlMfiScTjDZWnyXyQ/nqcubbmH5l
         ZAfI6gR/OqUn+UuOmamSemCtPiOyJ38z4lxrZTec6qeSaTKm9tL/haZjlVnCloM25w33
         Us8JmuzOudRKPZVzODPedJVvn37RvfacGGeUsooAFwxnYj4CsRDgrtRnaao3zlQmF1Zf
         7uYQ==
X-Gm-Message-State: AOAM532897LjiWJ90TNTS2NRybYkgChVVxrll5atR6xk0ka4VHouYQMi
        oHDnA1QgQrbH3SVSC5IpQvcgk+eesiIShWrTI0ASm2+Cr8tOTdOlQFP03PpORtoQo3T6Y/+weHn
        iMAeFQTKP8W8mcBSlfnk4eXdu
X-Received: by 2002:adf:a387:: with SMTP id l7mr2116799wrb.214.1634765569148;
        Wed, 20 Oct 2021 14:32:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsw9X0b8cQNRNSYxe4USWipSUlN9OgVtuvQLNO8/HE+MVnZi8sGbuuT/LMlBZEQXYCM2cTCg==
X-Received: by 2002:adf:a387:: with SMTP id l7mr2116781wrb.214.1634765568932;
        Wed, 20 Oct 2021 14:32:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id c7sm145262wrp.51.2021.10.20.14.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 14:32:48 -0700 (PDT)
Message-ID: <78be3e02-aac5-0f5b-339e-5969a14974d7@redhat.com>
Date:   Wed, 20 Oct 2021 23:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: Avoid atomic operations when kicking the running
 vCPU
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wanpengli@tencent.com
References: <20211020145231.871299-3-pbonzini@redhat.com>
 <YXBvOR1qQpsbNUIs@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXBvOR1qQpsbNUIs@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 21:34, Sean Christopherson wrote:
>>
>> +	/*
>> +	 * The only state change done outside the vcpu mutex is IN_GUEST_MODE
>> +	 * to EXITING_GUEST_MODE.  Therefore the moderately expensive "should
>> +	 * kick" check does not need atomic operations if kvm_vcpu_kick is used
>> +	 * within the vCPU thread itself.
>> +	 */
>> +	if (vcpu == __this_cpu_read(kvm_running_vcpu)) {
>> +		if (vcpu->mode == IN_GUEST_MODE)
>> +			WRITE_ONCE(vcpu->mode, EXITING_GUEST_MODE);
> 
> Fun.  I had a whole thing typed out about this being unsafe because it implicitly
> relies on a pending request and that there's a kvm_vcpu_exit_request() check _after_
> this kick.  Then I saw your other patches, and then I realized we already have this
> bug in the kvm_arch_vcpu_should_kick() below.

Yeah, the three patches are independent but part of the same rabbit hole.

> Anyways, I also think we should add do:
> 
> 	if (vcpu == __this_cpu_read(kvm_running_vcpu)) {
> 		if (vcpu->mode == IN_GUEST_MODE &&
> 		    !WARN_ON_ONCE(!kvm_request_pending(vcpu)))
> 			WRITE_ONCE(vcpu->mode, EXITING_GUEST_MODE);
> 		goto out;
> 	}
> 
> The idea being that delaying or even missing an event in case of a KVM bug is
> preferable to letting the vCPU state become invalid due to running in the guest
> with EXITING_GUEST_MODE.

On one hand I like the idea of having a safety net; for example a test 
similar to this one would have triggered for the naked 
kvm_vcpu_exiting_guest_mode(vcpu) call in vmx_sync_pir_to_irr.

On the other hand, "request-less VCPU kicks", as 
Documentation/virt/kvm/vcpu-requests.rst calls them, are a thing; PPC 
book3s_hv does not use vcpu->requests at all. For an artificial but more 
relatable example, the ON bit takes the role of vcpu->requests when 
processing PIR.  Hence the code below would be suboptimal but still correct:

         for (;;) {
                 exit_fastpath = static_call(kvm_x86_run)(vcpu);
                 if (likely(exit_fastpath !=
			   EXIT_FASTPATH_REENTER_GUEST))
                         break;

                 if (vcpu->arch.apicv_active && pi_test_on(vcpu))
                         kvm_vcpu_kick(vcpu);

                 if (unlikely(kvm_vcpu_exit_request(vcpu))) {
                         exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
                         break;
                 }
         }

All that really matters is that every call to kvm_x86_run is guarded by 
kvm_vcpu_exit_request(vcpu), and indeed that's what is restored by "KVM: 
x86: check for interrupts before deciding whether to exit the fast 
path".  The other architectures also have similar checks, though again 
it's a bit hard to find it for book3s_hv (due to not using 
vcpu->requests) and MIPS (which only uses KVM_REQ_TLB_FLUSH).

Paolo

