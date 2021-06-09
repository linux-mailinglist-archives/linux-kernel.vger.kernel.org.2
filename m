Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F23A0BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFIFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232671AbhFIFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623217919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBlO5SUlBu4kEPbM4S2HV+BFWwYYvZMzotDUfmY4wqk=;
        b=KJ4razBWiMTFqlx63bJlGM5k5phL2AowQxKHuVmtWWdhSPlBl6snipK/NvFWjLXnDRjJuH
        0ha10vhvZ/DldI/ViIJcIps1a6TmU2Wpq1lJXgxJmovJ56NoU3ESk/DV5oCJanA8SB7IRb
        V2yPX4QeK6Drd3h+aOntOLDSAV5aPgg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-3G0MkxqsM9qMNkVPo_qWyg-1; Wed, 09 Jun 2021 01:51:57 -0400
X-MC-Unique: 3G0MkxqsM9qMNkVPo_qWyg-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020a5d52d10000b0290119976473fcso8090994wrv.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 22:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zBlO5SUlBu4kEPbM4S2HV+BFWwYYvZMzotDUfmY4wqk=;
        b=Rl4T0aIDRfnwathwPqX13CM4AjtH98xT41UniIXSfZSLaMTgx4JZn8kSCn1FpfnFfP
         CjR3+J2hSrtjjPnjtF1oGWF7/aHYeJwVcntwEzowLAmCXH3/Mhe2h+y3x1r7xmUqDcJj
         52ckUdwGFjFcaw4afg76BKsUnVUuqkJ2C0CxukAqkJFQDVG21zxvb/K8rdYTKJryv05S
         ptdSWimhOGdlWpruVzScOuyR3NrRD4lngynYvb29FMZ/jgrJ+b6hJYZdY43nnZqoTNsO
         ks1LBZCQf/zpw/MKABSnz7iXv9uYJVZgS8gMniLcBciSMik83V9RJTMFQ+nnObOUHufz
         xEnw==
X-Gm-Message-State: AOAM531yc+lzLmU5R2DIskRch8uNnH11zndZNI6KGklE8kwVSQDv8L08
        HFNJdHzmwQDJ3HnAygespNFCLxwDCK25TT7VoMH2eaAej7FByCfX372x/WRJjaAhYJnVoInIPRG
        SzbtWRv8ohuy7gAf8FwsxLzpT
X-Received: by 2002:a5d:568a:: with SMTP id f10mr3117916wrv.252.1623217916626;
        Tue, 08 Jun 2021 22:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypZdy0ngsECXPmFiGY62B4hG9MP8f4LPp2rJ41kW29cDiE/x+WYEv9GMwZIqgrB1AiNqiaig==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr3117897wrv.252.1623217916423;
        Tue, 08 Jun 2021 22:51:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o20sm4700490wms.3.2021.06.08.22.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 22:51:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: LAPIC: Reset TMCCT during vCPU reset
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1623050385-100988-1-git-send-email-wanpengli@tencent.com>
 <1623050385-100988-2-git-send-email-wanpengli@tencent.com>
 <0584d79d-9f2c-52dd-5dcc-beffd18f265b@redhat.com>
 <CANRm+Cx3LpnMwWHAvJoTErAdWoceO9DBPqY0UkbQHW-ZUHw5=g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8c80e8a-0749-eb5b-d5ab-162f504c9d33@redhat.com>
Date:   Wed, 9 Jun 2021 07:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CANRm+Cx3LpnMwWHAvJoTErAdWoceO9DBPqY0UkbQHW-ZUHw5=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/21 04:15, Wanpeng Li wrote:
> On Wed, 9 Jun 2021 at 00:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
> [...]
>> Perhaps instead set TMCCT to 0 in kvm_apic_set_state, instead of keeping
>> the value that was filled in by KVM_GET_LAPIC?
> 
> Keeping the value that was filled in by KVM_GET_LAPIC is introduced by
> commit 24647e0a39b6 (KVM: x86: Return updated timer current count
> register from KVM_GET_LAPIC), could you elaborate more? :)

KVM_GET_LAPIC stores the current value of TMCCT and KVM_SET_LAPIC's 
memcpy stores it in vcpu->arch.apic->regs.  KVM_SET_LAPIC perhaps could 
store zero in vcpu->arch.apic->regs after it uses it, and then the 
stored value would always be zero.

Paolo

