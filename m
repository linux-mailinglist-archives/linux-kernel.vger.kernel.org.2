Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5CC30E292
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhBCSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232145AbhBCScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612377055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiOisWoMM5J0+N5wrdR7qjGRMcCnnxa5MwmQ2/1A7Ww=;
        b=XqoUUP8S+eCfDG1g7ePQ9oF1eIoTIPClV0Xyg4LGCZDGotxzYsaz/AzmA2USRAQ+7kIiuv
        I/nHwDXbvkfUSCWO2cMOxZrlVJp2YFurav2AbCnILFPZLdiQroFWb2VojR2zIsw+/Rb29f
        cEoOmbcqXisMEA9OqLSbla9D2det5eY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-LRuGz08NP2WZrhxM1Rv6Zw-1; Wed, 03 Feb 2021 13:30:53 -0500
X-MC-Unique: LRuGz08NP2WZrhxM1Rv6Zw-1
Received: by mail-ed1-f69.google.com with SMTP id g6so404718edy.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TiOisWoMM5J0+N5wrdR7qjGRMcCnnxa5MwmQ2/1A7Ww=;
        b=QoDKeiyRu1EHZJPtaOSqTqZjbC/Fxi18n4L3jAlbjArLyz9kFNvKnFu2K/iwiRfvGp
         RaI1vUsy1OG4bED3WGKS9qg+Itdf/Yb0xFMl8M6L6VhcebcvBhG9GL7WBvF8+Eu0yg/N
         Tp+EDZa6tZDPi4Q6ELE35LUdoszR6B4dP+vs+ov9fbrdXAOpkkgYyhVIuS1q44T3HSBr
         5w5sRvmBNIe3LdZax0hNXyvGVB4EenziUCGLGTJ9UdQ1KDgmGQj0Z3QLat9/zImNVhbj
         XAswFKNRVHd4jZRWw2qyCI65UdOIR09nOv4Gf2uMSVx69vfqn0j0xikQ9wSn6vPI2ekK
         rVZA==
X-Gm-Message-State: AOAM530JW+z3ro5+yYRsY25y7i/UlMKgJIN8bxpRwx/mvEut0Yge0dtK
        +AuTza6yRByUvE6JZuzQeIfPXr8OuFF13Q7hRGdXSH3VEUqfvr6aYozDhhon3Zuns8R66vzyn4c
        yjG17AK28XSMAeKTgZFiIRMNA
X-Received: by 2002:a17:906:2b11:: with SMTP id a17mr4461048ejg.203.1612377052471;
        Wed, 03 Feb 2021 10:30:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuzKzmIpNThLgL2hkQbClOrns4+7OkKK8je1Ds3SP1NLbweMJ1vlqIoalInh1oEg4EUt/rnw==
X-Received: by 2002:a17:906:2b11:: with SMTP id a17mr4461028ejg.203.1612377052335;
        Wed, 03 Feb 2021 10:30:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c18sm1263910edu.20.2021.02.03.10.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 10:30:51 -0800 (PST)
Subject: Re: [PATCH v2 23/28] KVM: x86/mmu: Allow parallel page faults for the
 TDP MMU
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
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
 <d2c4ae90-1e60-23ed-4bda-24cf88db04c9@redhat.com>
 <CANgfPd-ELyPrn5z0N+o8R6Ci=O25XF+EDU-HDGgvVXGV7uF-dQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39751a29-3a47-a108-f626-8abf0008ea09@redhat.com>
Date:   Wed, 3 Feb 2021 19:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd-ELyPrn5z0N+o8R6Ci=O25XF+EDU-HDGgvVXGV7uF-dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 18:46, Ben Gardon wrote:
> enum kvm_mmu_lock_mode lock_mode =
> get_mmu_lock_mode_for_root(vcpu->kvm, vcpu->arch.mmu->root_hpa);
> ....
> kvm_mmu_lock_for_mode(lock_mode);
> 
> Not sure if either of those are actually clearer, but the latter
> trends in the direction the RCF took, having an enum to capture
> read/write and whether or not yo yield in a lock mode parameter.

Could be a possibility.  Also:

enum kvm_mmu_lock_mode lock_mode =
   kvm_mmu_lock_for_root(vcpu->kvm, vcpu->arch.mmu->root_hpa);

kvm_mmu_unlock(vcpu->kvm, lock_mode);

Anyway it can be done on top.

Paolo

