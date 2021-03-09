Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC47332652
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCINNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhCINMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615295551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps2kLvFjhgXjurX+hYMjJ+zVbhy9iDfc123Xi053PeY=;
        b=XIlby2QCNGplux0wOPKp49IQEdzWNFwp3b3HXhGKNVzwwAaHMmVnBDCzegnhhcCxQtAwHW
        jFaatNebIgTi4TTeQHvTyU3gGH43z/nfXmm5uMfQZo1GGNhLw0uotCa1Py7gLWjI6+/DaC
        egGPlKWDalkylvt+Vjtzobi2K21uUN4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-sBVYQvw4MoS2qYqjZKNBDw-1; Tue, 09 Mar 2021 08:12:29 -0500
X-MC-Unique: sBVYQvw4MoS2qYqjZKNBDw-1
Received: by mail-ed1-f71.google.com with SMTP id h2so6678683edw.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ps2kLvFjhgXjurX+hYMjJ+zVbhy9iDfc123Xi053PeY=;
        b=rPclf/b5TJnbhF76OnZXqYWaMWyrR6DCSkL2AjrhVAfYuBQeX3nxG2wRKbFYc/6jNg
         kXR/4wCQjM5ktPVYBRLSd2XsF3E4YKktnvwZsH0BGjljvdzrxF7WoyK8w5TPgTadiL2X
         NzS9mbZsaGAxsK/nwqANsamsYvKGFEiEESRNbsGWWUtzSAzjhoak1tW4Xu8yWiqRxzOu
         WmIq/jlTag9ZpX/loInomNSue8sRSOgx+jmwSTz8IRce91b4ArDz+r4WE4P5y+mkUyfc
         /LNJk3UUt9sP9moHefRFU0/bn3chUrSrVtUNvH6I8La+RSez86qqofwaVPqM/rlIY+oB
         nhiQ==
X-Gm-Message-State: AOAM533ZHbM/mY6ppJXfj8Sb5qpyLAmVBVyVSx9jD8JnIIEDZFKQ3ht5
        DwjkB0hwj974TQUumTVsSlKCnG0HzV23ZLabFnKMpQDsBS2wkSGKAB7FZSOlRo6NlW8/AZ1rVn7
        4L/fvlOUIQ+AQ+uk6T/jgbbYt
X-Received: by 2002:a17:906:c005:: with SMTP id e5mr20257873ejz.270.1615295548205;
        Tue, 09 Mar 2021 05:12:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywu9MgyyJTri+Kb3HnKjUtQMNeGnxCefYjkKYtSfQ7PVSAD9cnCTNq3JCgvmmH9TEMSJYzVQ==
X-Received: by 2002:a17:906:c005:: with SMTP id e5mr20257860ejz.270.1615295548067;
        Tue, 09 Mar 2021 05:12:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v9sm8261280ejc.37.2021.03.09.05.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:12:27 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Exclude the MMU_PRESENT bit from MMIO
 SPTE's generation
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210309021900.1001843-1-seanjc@google.com>
 <20210309021900.1001843-3-seanjc@google.com>
 <785c17c307e66b9d7b422cc577499d284cfb6e7b.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d72993d9-c11c-a5f4-0452-b2bed730938c@redhat.com>
Date:   Tue, 9 Mar 2021 14:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <785c17c307e66b9d7b422cc577499d284cfb6e7b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 11:09, Maxim Levitsky wrote:
> What happens if mmio generation overflows (e.g if userspace keeps on updating the memslots)?
> In theory if we have a SPTE with a stale generation, it can became valid, no?
> 
> I think that we should in the case of the overflow zap all mmio sptes.
> What do you think?

Zapping all MMIO SPTEs is done by updating the generation count.  When 
it overflows, all SPs are zapped:

         /*
          * The very rare case: if the MMIO generation number has wrapped,
          * zap all shadow pages.
          */
         if (unlikely(gen == 0)) {
                 kvm_debug_ratelimited("kvm: zapping shadow pages for 
mmio generation wraparound\n");
                 kvm_mmu_zap_all_fast(kvm);
         }

So giving it more bits make this more rare, at the same time having to 
remove one or two bits is not the end of the world.

Paolo

