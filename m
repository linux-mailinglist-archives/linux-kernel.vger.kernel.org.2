Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646A5421FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJEHwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhJEHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633420240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6yrW50I8Ib+vVPSj2LLrvKy9ZTsmrO7LXIDVvpPep0=;
        b=BVippRmCzYoOS9HCrYQTaTEsSoE14fCY9SDrVCiJMBBdATzCpu7mz4kugZFPMOvlMEb1cH
        vJkdo3yMsrdoyOHTl3kVD0NCAFM6lHuQTI2RBqiS/x7UWuift6WiYZ8eTMKERFf/d1CcqV
        Y5/OItjJbuyFaMZNO8kFtk+sH0Rcez0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-xuqjbifHOgS67EsJcT0kjA-1; Tue, 05 Oct 2021 03:50:39 -0400
X-MC-Unique: xuqjbifHOgS67EsJcT0kjA-1
Received: by mail-lf1-f69.google.com with SMTP id z29-20020a195e5d000000b003fd437f0e07so845766lfi.20
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 00:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n6yrW50I8Ib+vVPSj2LLrvKy9ZTsmrO7LXIDVvpPep0=;
        b=50OJGFO+NDhzkjqdjk+5BQlt98qoVBBUlBrnetDAdY2tPI2SaEVAMYlVlJfd1WFCmz
         PhxsFF55P9p0Kzp7vhEZmV55T+EFT28IWcymnn9iwDgueEHKhcCtKzlZg6tvl/3Pclc6
         6fLkahxApsWSUxt4+1MsdPMxI3caWCix9h5EYDF0map9+6TpOZiLbcdufpAEmAQ/hX/m
         VviCR4MlCKYYwC3GlPl5cXV3+IuZqME4/N2yK8hVBXEuSXOnUfn8cGjl+t/AwAKGXA7x
         mDTYl19JljLcvUAMSwNgMVqbkLtwytNe6J450K7zc2uLDOE4G16NZObHpi1wfEs+bS5/
         QBsg==
X-Gm-Message-State: AOAM531qcC4YY8RFTHriiaFXBkqKRaN1vfIaUPnDCmwhkX8PwknbkqT8
        ZJDgycb+6up4fju6E8wfFf6iLqHCeBg48sr6NXTfQSAUCNFI4Wvn32tkd3d1bB0mJoR6QWCS9O0
        ggtBCh4cjMGuzZ3TpXbP/kmoD
X-Received: by 2002:a05:651c:211a:: with SMTP id a26mr20833091ljq.148.1633420237647;
        Tue, 05 Oct 2021 00:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCwVBDEVlaMlT4cp6MTylyHDa5Eg1SqOfJofYuQRaxS4IL5HAFMPsCOKXyye6wxMwiyT4TmQ==
X-Received: by 2002:a17:907:62a2:: with SMTP id nd34mr1617731ejc.356.1633420226861;
        Tue, 05 Oct 2021 00:50:26 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.162.200])
        by smtp.gmail.com with ESMTPSA id b2sm8399684edv.73.2021.10.05.00.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 00:50:26 -0700 (PDT)
Message-ID: <a5a5812a-6501-ccce-5d42-18131cf26779@redhat.com>
Date:   Tue, 5 Oct 2021 09:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v10 10/28] x86/fpu/xstate: Update the XSTATE save function
 to support dynamic states
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <87pmsnglkr.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87pmsnglkr.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/21 23:31, Thomas Gleixner wrote:
> You have two options:
> 
>    1) Always allocate the large buffer size which is required to
>       accomodate all possible features.
> 
>       Trivial, but waste of memory.
> 
>    2) Make the allocation dynamic which seems to be trivial to do in
>       kvm_load_guest_fpu() at least for vcpu->user_fpu.
> 
>       The vcpu->guest_fpu handling can probably be postponed to the
>       point where AMX is actually exposed to guests, but it's probably
>       not the worst idea to think about the implications now.
> 
> Paolo, any opinions?

Unless we're missing something, dynamic allocation should not be hard to 
do for both guest_fpu and user_fpu; either near the call sites of 
kvm_save_current_fpu, or in the function itself.  Basically adding 
something like

	struct kvm_fpu {
		struct fpu *state;
		unsigned size;
	} user_fpu, guest_fpu;

to struct kvm_vcpu.  Since the size can vary, it can be done simply with 
kzalloc instead of the x86_fpu_cache that KVM has now.

The only small complication is that kvm_save_current_fpu is called 
within fpregs_lock; the allocation has to be outside so that you can use 
GFP_KERNEL even on RT kernels.   If the code looks better with 
fpregs_lock moved within kvm_save_current_fpu, go ahead and do it like that.

Paolo

