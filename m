Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE830D9F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhBCMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:41:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhBCMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612355998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXIEHt/+ZImaha+lRwXZShNsH0YZB0lQG8cbY1aYCEA=;
        b=Vr3Z+StNSdVpa0QwRpYwVrY3MNdhqpxmTjV8/AcAye3pXcH7z4jMWuEVjebDR1PRtoVSu9
        7JzogTFRShOSNsTN7BNpHiRMQAiRt6Ocge17/ClPT0BBYwiAWYxlB/vxS4oF15E2zF7Sgm
        8UoBF/iHfDkn7Gy3KZCZYUKo3Qa+sHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-h9ppxdDGOIycs1qeStd9wQ-1; Wed, 03 Feb 2021 07:39:56 -0500
X-MC-Unique: h9ppxdDGOIycs1qeStd9wQ-1
Received: by mail-ej1-f70.google.com with SMTP id k3so11878876ejr.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXIEHt/+ZImaha+lRwXZShNsH0YZB0lQG8cbY1aYCEA=;
        b=TYUWhWDVMpmUI9frkXpJnDMRZOxIj/aMVpshWGaaJk5IYcxZ6o8bQSppbmTcHqa3JE
         Sws/yb12+eyIuFxYCHWqBl9MQt6615fatx/rYArSZmkee2sVpfmTM988/6BCXMNGNsIw
         nLgGgR84974Tb4rMdgT0eB9+vEbB08TfWMi9lme7nvl4Ot9ybbLNnBkEmjVrHsaiNP5C
         Vb2Red4t1aiSwwx5voy4BThw8bJVVN4wXTK87MMrUruS6lSLXi9GHG5E6jpY6rtMNwKe
         I+pT6q0Fnir4BcQG9Y/Qh7cNWviNzRVo/HvRp7JyYZYiaBRsk4vFiTKpG7RNn4104FWq
         Si6w==
X-Gm-Message-State: AOAM533AzZz8iVCKe7JhMQfAFaO/Wvfa0CAx8DDaUIza3v5xlEiwlT5e
        nSrd6Btkdmn7VyKzpF43Sd9I4mTq79KR1umY9ALXj2kmzJ1L22bCPsPsUlINOpoRkUegr6P1NN/
        nlCgL1qSzqvTH8E22td3IpiTJ
X-Received: by 2002:a17:906:2993:: with SMTP id x19mr2816798eje.409.1612355995524;
        Wed, 03 Feb 2021 04:39:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTXgGps9Cf5vzp942FAOVNGcW5hyMGurVlJU/3ZT8IdK2S9BrQGLYHWjZgagUazvZZuD63Lw==
X-Received: by 2002:a17:906:2993:: with SMTP id x19mr2816786eje.409.1612355995361;
        Wed, 03 Feb 2021 04:39:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gt18sm952486ejb.104.2021.02.03.04.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 04:39:54 -0800 (PST)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-24-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 23/28] KVM: x86/mmu: Allow parallel page faults for the
 TDP MMU
Message-ID: <d2c4ae90-1e60-23ed-4bda-24cf88db04c9@redhat.com>
Date:   Wed, 3 Feb 2021 13:39:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-24-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> 
> -	write_lock(&vcpu->kvm->mmu_lock);
> +
> +	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> +		read_lock(&vcpu->kvm->mmu_lock);
> +	else
> +		write_lock(&vcpu->kvm->mmu_lock);
> +

I'd like to make this into two helper functions, but I'm not sure about 
the naming:

- kvm_mmu_read_lock_for_root/kvm_mmu_read_unlock_for_root: not precise 
because it's really write-locked for shadow MMU roots

- kvm_mmu_lock_for_root/kvm_mmu_unlock_for_root: not clear that TDP MMU 
operations will need to operate in shared-lock mode

I prefer the first because at least it's the conservative option, but 
I'm open to other opinions and suggestions.

Paolo

