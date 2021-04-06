Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A33555A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbhDFNsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238092AbhDFNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617716884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhcIbSTem0++Uo9Wv8Vmhg9c/hOyhArpG7XvuFEipNM=;
        b=c0o2dte2iZcDjJ7CwlwKLVklXJdtaJO2z9/4/hW95gY+g31By2K7ytDmh0y/GoNM0FaVrh
        3qdmhXxfc/TkXmPgPiBH7Eph/ZYbv+kryfAO2Y79PcEoW/VOXFnMovgfVU/tbhs250svsp
        ekgb6NSBb8dISwjA2kapnNtLEYRmPcI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-4DHD3X_xN8yEMySRS_vMGw-1; Tue, 06 Apr 2021 09:48:03 -0400
X-MC-Unique: 4DHD3X_xN8yEMySRS_vMGw-1
Received: by mail-ej1-f70.google.com with SMTP id a22so5457539ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FhcIbSTem0++Uo9Wv8Vmhg9c/hOyhArpG7XvuFEipNM=;
        b=XotXqA+Lt9xwslNiOfAxf98l9Y9AypEZ5sc7BUa8AGLpICsja0LCwfWBLVRA7OKoc9
         dg9Es1cY01jVo+9t1n2ucCZIPaDwOcSRTFbPR1JJ5REfUVpD9KNHDpwuAKhuKgspTYV/
         waaZ0BVRZ10R1HkYEEBrTB2pouibVqNkfGjYwZ67f8JuU3ObQ5asbD5EQN5f2h4zWrdj
         xEWlEILmxECtiSxSr+sKh4KmGbEIdI3tureoY48o3hG5G7wD5f52/o2V+btlsVmm+l9G
         xvUwbPYQ3Txb2HOdVt6JyL+xQNaTpAuGqvoNPTiVAwiVfcYsRqDABFSYnmDwTQRJi681
         ThMw==
X-Gm-Message-State: AOAM530yVJoa229g4MY6xH7JIeHoIYg0MuhodJ75TIp2msacK/HuxL/3
        bsVJo7rzqqqNXI4n5L2jPi8Xr9dcDJo6PNUV4IgFTLM2rRKEzlXnuRDiBNXPzu3ttJLP4uapFA9
        AD4ewF42sOVbj3N1lwGSNliXf
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr38302730edy.312.1617716881861;
        Tue, 06 Apr 2021 06:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV+i+kYPSIhkfD4H44Hsb+wtCbRL65VQeboMCwdBXk+AxQCumzW0N8zz6JMQCX4WELpUaSaQ==
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr38302707edy.312.1617716881666;
        Tue, 06 Apr 2021 06:48:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e15sm4780089ejh.56.2021.04.06.06.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:48:01 -0700 (PDT)
Subject: Re: [PATCH v11 10/13] KVM: x86: Introduce new
 KVM_FEATURE_SEV_LIVE_MIGRATION feature & Custom MSR.
To:     Ashish Kalra <ashish.kalra@amd.com>,
        Steve Rutherford <srutherford@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1617302792.git.ashish.kalra@amd.com>
 <69dd6d5c4f467e6c8a0f4f1065f7f2a3d25f37f8.1617302792.git.ashish.kalra@amd.com>
 <CABayD+f3RhXUTnsGRYEnkiJ7Ncr0whqowqujvU+VJiSJx0xrtg@mail.gmail.com>
 <20210406132658.GA23267@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a59b2a76-dada-866d-ff2b-2d730b70d070@redhat.com>
Date:   Tue, 6 Apr 2021 15:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210406132658.GA23267@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 15:26, Ashish Kalra wrote:
>> It's a little unintuitive to see KVM_MSR_RET_FILTERED here, since
>> userspace can make this happen on its own without having an entry in
>> this switch statement (by setting it in the msr filter bitmaps). When
>> using MSR filters, I would only expect to get MSR filter exits for
>> MSRs I specifically asked for.
>>
>> Not a huge deal, just a little unintuitive. I'm not sure other options
>> are much better (you could put KVM_MSR_RET_INVALID, or you could just
>> not have these entries in svm_{get,set}_msr).
>>
> Actually KVM_MSR_RET_FILTERED seems more logical to use, especially in
> comparison with KVM_MSR_RET_INVALID.
> 
> Also, hooking this msr in svm_{get,set}_msr allows some in-kernel error
> pre-processsing before doing the pass-through to userspace.

I agree that it should be up to userspace to set up the filter since we 
now have that functionality.

Let me read the whole threads for the past versions to see what the 
objections were...

Paolo

