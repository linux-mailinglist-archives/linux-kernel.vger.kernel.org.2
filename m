Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2F34AD34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCZROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhCZROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616778859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QGdNAKTyvuE9HoUHdxIb+GgZN7iru3jfjd1dnZgCMbw=;
        b=ZkEaxSEc6Y1k55ndRFHoAND9oZ4lmKRV13mkW6IIjmG9TrkU6nVX+m9+ydF+YCEqCqG1YO
        eoRqre0I1vjfXliOXv/g+45j+tkTT3W/RTNaX77f8atK13fE+M6X0SCBIiKIXayMcjmlzJ
        53A/PlyTFc0NOWw1ae2U3g3eUKO74yY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-d4reOwnAMN-xfgIMOcYIiw-1; Fri, 26 Mar 2021 13:14:18 -0400
X-MC-Unique: d4reOwnAMN-xfgIMOcYIiw-1
Received: by mail-ej1-f71.google.com with SMTP id r26so4368570eja.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QGdNAKTyvuE9HoUHdxIb+GgZN7iru3jfjd1dnZgCMbw=;
        b=ErcISSksvp8xTxh5g93KjJw76P9LrExroblKAeU4x9rhtmtr9QSlz/9GqfLSZQ72gm
         vGhFgCrv+3CZMJDdg32r2ffPdkGL4uitwGn+3e5tualn7KwbUpRIS9MABbXLCZxgJLKm
         Gh4t8SM03+eEQrhD4MgOVedNAAaJh3QAsfZ1IjBQiRv/WxeT3+Xw2JF51siSFZOWQ8lv
         prQ5ElSTHd9HKdFbBqu4y5YsYT5c9zlOzXXjlrvGOpcffqeedrPLDMBJbdmZ6NYGsJXk
         I7LXbKZgdN21D+lZPrwUKcl9HT0rZHuKpH+k6AsQOFG4pR6Xsw9LUL3ejjSp0ss+IS1o
         TXJw==
X-Gm-Message-State: AOAM533I3An+BHwK0YHsmIE5z/PN5v/yfbr/1Y+ezzh5vStZfC0tCWof
        jnxX6+aB5U3zTWFwv1x803+UewbBO1lYhgWEZZKV1lR9JLoAm3NxByeVmd7DQFMo7WdnDgvkgYZ
        55vOY7p1pStZZyNBTXPS1O1zrkOE/zm3lyxO1ib39O3L4vSxyP+Ivdu0knQwkVYNHg1HlLy5sgy
        gW
X-Received: by 2002:a17:906:b80c:: with SMTP id dv12mr16714953ejb.110.1616778856400;
        Fri, 26 Mar 2021 10:14:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaTiHmaXAM+TKtmD1MrN4M17ohbs85DP6TOlir6bKZN0oNLD+VTMlMenxI4R9ObpvaPki3YA==
X-Received: by 2002:a17:906:b80c:: with SMTP id dv12mr16714918ejb.110.1616778856155;
        Fri, 26 Mar 2021 10:14:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a26sm4716004edm.15.2021.03.26.10.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:14:15 -0700 (PDT)
Subject: Re: [PATCH 1/1] KVM: x86: remove unused declaration of
 kvm_write_tsc()
To:     Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20210326070334.12310-1-dongli.zhang@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85eeb727-de5f-a42b-0e6a-dd23462a63da@redhat.com>
Date:   Fri, 26 Mar 2021 18:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210326070334.12310-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/21 08:03, Dongli Zhang wrote:
> The kvm_write_tsc() was not used since commit 0c899c25d754 ("KVM: x86: do
> not attempt TSC synchronization on guest writes"). Remove its unused
> declaration.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   arch/x86/kvm/x86.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 39eb04887141..9035e34aa156 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -250,7 +250,6 @@ static inline bool kvm_vcpu_latch_init(struct kvm_vcpu *vcpu)
>   void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs);
>   void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
>   
> -void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
>   u64 get_kvmclock_ns(struct kvm *kvm);
>   
>   int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
> 

Queued, thanks (with slight editing of the commit message as Vitaly 
mentioned).

Paolo

