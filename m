Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAF3F0099
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhHRJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhHRJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629279137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHYvNfODo5ETK+AbX2YYLKozZTeELQw3jUzDzquAaQ8=;
        b=Af/juhH7fjHGL4c37iuIJ7iAMLxiArAeLxSXk1wKhOF4lFmPSssYZkhHJM1nGOxotE4HB1
        ias8Dlx8WPpf51qi0rfJoCfnZshly9VjiZ496apPTAgVaBAewI6wNyZrXZkCgoGYVgQK1n
        84xeo5v41zbxUBSHlOwF9QjSrBiGqRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-63J6SglzP3KpL8ive1c2UA-1; Wed, 18 Aug 2021 05:32:16 -0400
X-MC-Unique: 63J6SglzP3KpL8ive1c2UA-1
Received: by mail-wr1-f71.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso388400wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RHYvNfODo5ETK+AbX2YYLKozZTeELQw3jUzDzquAaQ8=;
        b=lZ1Pt35MXdVUmO2pBkSuyxmM/K02vXNhPdNDvhnE6Ee53kWRq4Ht64Xg8pSDd9D4vt
         Mx3Scp/vLVTqLotFUw0UNO3Hc05tZUz/QyBUSRArojjpmPCyieqA8dRIyM7BNDPfw/Mj
         r0pA6puwVOXq665XP8lOKWFmG5X7gnBZ2rAAbkyk5nPLuI3rwjZCMcL9KAXpB1ee9EuQ
         AQpnlYSiNemdM/sJvxrS/cK8HUk2i7EkZtHhLw9qgUHm3g4hwXOL/mPphIjU3QQSPz59
         rpcumBXL2qDdU66XxPmTv3lI5brfjvCOmTr7PdHHMMQf4Or8ehwkwpej6os98J7QxYkQ
         L4AQ==
X-Gm-Message-State: AOAM530IqRULXXVGDY2F50z7Frw0lEqxmtoCEbXnxVgQ7cbfnlQ6MGJm
        cdUPlqsLvcwPeJy3zeH2KfdNK9iCKZAA68MY38EhogD4SwMdARJL1w5DmrrAY436F8mvvdioMUO
        eybPvSo7sD0WBdC64VUoJMxX0
X-Received: by 2002:adf:f290:: with SMTP id k16mr9291910wro.88.1629279135301;
        Wed, 18 Aug 2021 02:32:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyyJoTAzImUF2IbKFC+1grXiIm6uPRSomp1hYc24EninkNxslFaPaoRrZa3p9prXkxmGnZEQ==
X-Received: by 2002:adf:f290:: with SMTP id k16mr9291890wro.88.1629279135138;
        Wed, 18 Aug 2021 02:32:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 204sm4784923wmb.38.2021.08.18.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:32:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     suleiman@google.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Sean Christopherson <seanjc@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86@kernel.org, Hikaru Nishida <hikalium@chromium.org>,
        linux-kernel@vger.kernel.org, dme@dme.org, tglx@linutronix.de,
        mlevitsk@redhat.com
Subject: Re: [v2 PATCH 3/4] x86/kvm: Add host side support for virtual
 suspend time injection
In-Reply-To: <2ec642dd-dde6-bee6-3de3-0fa78d288995@redhat.com>
References: <20210806100710.2425336-1-hikalium@chromium.org>
 <20210806190607.v2.3.Ib0cb8ecae99f0ccd0e2814b310adba00b9e81d94@changeid>
 <2ec642dd-dde6-bee6-3de3-0fa78d288995@redhat.com>
Date:   Wed, 18 Aug 2021 11:32:13 +0200
Message-ID: <87o89vksiq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/08/21 12:07, Hikaru Nishida wrote:
>> +#if defined(CONFIG_KVM_VIRT_SUSPEND_TIMING) || \
>> +	defined(CONFIG_KVM_VIRT_SUSPEND_TIMING_GUEST)
>> +#define VIRT_SUSPEND_TIMING_VECTOR	0xec
>> +#endif
>
> No need to use a new vector.  You can rename the existing 
> MSR_KVM_ASYNC_PF_INT to MSR_KVM_HYPERVISOR_CALLBACK_INT or something 
> like that, and add the code to sysvec_kvm_asyncpf_interrupt.

On the host side, I'd vote for keeping MSR_KVM_ASYNC_PF_INT for async PF
mechanism only for two reasons:
- We may want to use (currently reserved) upper 56 bits of it for new
asyncPF related features (e.g. flags) and it would be unnatural to add
them to 'MSR_KVM_HYPERVISOR_CALLBACK_INT'
- We should probably leave it to the guest if it wants to share 'suspend
time' notification interrupt with async PF (and if it actually wants to
get one/another).

On the guest side, it is perfectly fine to reuse
HYPERVISOR_CALLBACK_VECTOR for everything.

-- 
Vitaly

