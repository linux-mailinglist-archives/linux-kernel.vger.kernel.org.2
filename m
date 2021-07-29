Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C093DAA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhG2Rpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhG2Rpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627580731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/uKqwlZEaxXqiQ3vzJCP51ioL56l4Vk/s9bff9c0N0=;
        b=Ae9H4lMZRmjbL87Tq/Bv/ttgDLFNDsfXre5MM+3GyBT4AwAojnX9km1tk/3mbi0kz0j3j0
        VDAxTiSfcktvxtZr+J5eNaIJGklGICgq7C8UF2CXflAQqezjbGM8fSNMKWGHvk9fiMq0an
        qU+W8vB2c8K/VuSwmQSR1pU/qzZPRyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-CnFv7vKUPVeer0gUGcVR-A-1; Thu, 29 Jul 2021 13:45:30 -0400
X-MC-Unique: CnFv7vKUPVeer0gUGcVR-A-1
Received: by mail-wm1-f72.google.com with SMTP id g187-20020a1c20c40000b02902458d430db6so1013590wmg.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/uKqwlZEaxXqiQ3vzJCP51ioL56l4Vk/s9bff9c0N0=;
        b=GufkoRVpYFy6TE7eQXl1w3wW979GQnODsvKiXJFeka+fBxwV00oKLHn+0h3pNcVBe/
         nZgTfwvsPWm+IK+EarlShICgZtDQ3eUYNb5Adg25WLsMtRtRdP+guUyu9WxnsuVGVD4k
         zW7wH+5htXYAm7AYNuE9WWO+OAgrgaJ0XCOKynU7rGc/JSB5JlgMbSWyK62SJtxWutg/
         P/eJe6hNY/DkZkm7GNpiA5e0bl4Y/X1ZXwTD5zNS327jLod94T03pnNLpiJZtsx12ZKn
         wlDlF+3faZVuAXhT9io9agyurmj7yIssSd1T7cejGYOC8ea/7cduGrQ3lft57YgFhH+c
         FDoQ==
X-Gm-Message-State: AOAM530dDEwNBp05BdZ83a3KD7iONzgJBVPy5kdBN/ANbyu7HirWUYlJ
        2/F8+hF0thiikzQfh5Fv+k3F62x8wKO0cy7nKSZraNyJhwEKvSpzioe1oDUAKFzhoVILHTo77UQ
        o2Mxdqm/K+WyyYbYlLr7nds8aHr8OwUU0emO7VxcFR0DPgwdFj7B4dxcvW000TMwTiYMDZ/nn1T
        lC
X-Received: by 2002:a1c:7314:: with SMTP id d20mr5830493wmb.167.1627580729328;
        Thu, 29 Jul 2021 10:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHGElmv5LPxm24VprwxC3qUzw6eNh/ws6LgsB+BsrVb0dmnSMDmImODHonZa5HTliLopvo9w==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr5830472wmb.167.1627580729127;
        Thu, 29 Jul 2021 10:45:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l41sm4328868wmp.23.2021.07.29.10.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 10:45:28 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] KVM: MMU: Add support for PKS emulation
To:     Sean Christopherson <seanjc@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-5-chenyi.qiang@intel.com> <YQLkczVfCsFp4IxW@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fd1b39b1-ce99-3626-b502-eb1324001163@redhat.com>
Date:   Thu, 29 Jul 2021 19:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQLkczVfCsFp4IxW@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/21 19:25, Sean Christopherson wrote:
>> -		unsigned int cr4_pke:1;
>> +		unsigned int cr4_pkr:1;
> Smushing these together will not work, as this code (from below)
> 
>> -     ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
>> +     ext.cr4_pkr = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
>> +                   !!kvm_read_cr4_bits(vcpu, X86_CR4_PKS);
> will generate the same mmu_role for CR4.PKE=0,PKS=1 and CR4.PKE=1,PKS=1 (and
> other combinations).  I.e. KVM will fail to reconfigure the MMU and thus skip
> update_pkr_bitmask() if the guest toggles PKE or PKS while the other PK* bit is set.
> 

I'm also not sure why there would be issues in just using cr4_pks.

Paolo

