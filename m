Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5E3C1806
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhGHR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhGHR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625765052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZ7gPrQ23oEV+eYOygTymeItqSXzCvRVlevUjXjSw/E=;
        b=hkGu+aaqIVTy0jtlof+LNToC7piSHZQbWRuXCLyMy7SJbVz/WhhO5dKMzMYXD/6FdzCv92
        MPR2/UUgA+MN72TsWX09ecUDB8gwki1aAXp/ndJr9Hf7QFDaXUI14TKA6Z4pv0zyFPHA3U
        u5Yr4eJqW9COWuFSZ4KokHbzVcllApc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Vx3KySOVNP-_ggTKQh3xkQ-1; Thu, 08 Jul 2021 13:24:11 -0400
X-MC-Unique: Vx3KySOVNP-_ggTKQh3xkQ-1
Received: by mail-ed1-f70.google.com with SMTP id m21-20020a50ef150000b029039c013d5b80so3678779eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZ7gPrQ23oEV+eYOygTymeItqSXzCvRVlevUjXjSw/E=;
        b=CelA8e2URbcwLvTJACS7i77Y2C/p1IbURONjVgu11qNc2I3d0ve6FYzk5GmA32BS2p
         buMOw5o1bNXAg6nlb0XI0j1bKCk8IVGavbvRPbhWVVYRq0cA8qI2HpVswZo4eiIGiP/w
         lO083q6cJnI0BaVfB3YJjUXbWKIqDGz2seXoND0HR0F4pnBqDAUkLpfjVwrKute/9mrA
         JGOxeo97y0oz++Lky7MMArAvfy/Oh3wm+9M0flqnXuUfxOxGmyOc1KBKZdOUMyPQReFm
         V0nt3Us87eGyd/ipKBT7f/eTpu4kvOuXA5FXBL7ungCgofv2Z9rUsbYBq56bBguDhGXX
         9ABw==
X-Gm-Message-State: AOAM533guhXZKp8o2fAjbPRMZiGv8wglRA9opXHFxzKg/kOZghFXqXjc
        Fq1DbtOGWRrCYyqwqnZJkcSltZCA1rJ5OfMSg1hc5o19y9wCwx9RIpVNMjcZ2jdx6Lpyk4IFYrq
        fqoIlswdxv0dP6ijjg4oRJEj+
X-Received: by 2002:a17:907:7708:: with SMTP id kw8mr32766361ejc.111.1625765050196;
        Thu, 08 Jul 2021 10:24:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytp4yjvws/8tdKXk5sG9KzhZMhuTdQKn92OVwJ37qdgFHrBMdE3jrriLu845Xt7Ff6hT3jbQ==
X-Received: by 2002:a17:907:7708:: with SMTP id kw8mr32766348ejc.111.1625765050042;
        Thu, 08 Jul 2021 10:24:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g3sm1176208ejp.2.2021.07.08.10.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:24:09 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: SMM fixes
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210707125100.677203-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17d26bd6-44c5-7972-fe95-544f061feb5f@redhat.com>
Date:   Thu, 8 Jul 2021 19:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707125100.677203-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/21 14:50, Maxim Levitsky wrote:
> Hi!
> 
> I did first round of testing of SMM by flooding the guest with SMIs,
> and running nested guests in it, and I found out that SMM
> breaks nested KVM due to a refactoring change
> that was done in 5.12 kernel. Fix for this is in patch 1.
> 
> I also fixed another issue I noticed in this patch which is purely
> theoretical but nevertheless should be fixed. This is patch 2.
> 
> I also propose to add (mostly for debug for now) a module param
> that can make the KVM to avoid intercepting #SMIs on SVM.
> (Intel doesn't have such intercept I think)
> The default is still to intercept #SMI so nothing is changed by
> default.
> 
> This allows to test the case in which SMI are not intercepted,
> by L1 without running Windows (which doesn't intercept #SMI).
> 
> In addition to that I found out that on bare metal, at least
> on two Zen2 machines I have, the CPU ignores SMI interception and
> never VM exits when SMI is received. As I guessed earlier
> this must have been done for security reasons.
> 
> Note that bug that I fixed in patch 1, should crash VMs very soon
> on bare metal as well, if the CPU were to honour the SMI intercept.
> as long as there are some SMIs generated while the system is running.
> 
> I tested this on bare metal by using local APIC to send SMIs
> to all real CPUs, and also used ioport 0xB2 to send SMIs.
> In both cases my system slowed to a crawl but didn't show
> any SMI vmexits (SMI intercept was enabled).
> 
> In a VM I also used ioport 0xB2 to generate a flood of SMIs,
> which allowed me to reproduce this bug (and with intercept_smi=0
> module parameter I can reproduce the bug that Vitaly fixed in
> his series as well while just running nested KVM).
> 
> Note that while doing nested migration I am still able to cause
> severe hangs of the L1 when I run the SMI stress test in L1
> and a nested VM. VM isn't fully hung but its GUI stops responding,
> and I see lots of cpu lockups errors in dmesg.
> This seems to happen regardless of #SMI interception in the L1
> (with Vitaly's patches applied of course)
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (3):
>    KVM: SVM: #SMI interception must not skip the instruction
>    KVM: SVM: remove INIT intercept handler
>    KVM: SVM: add module param to control the #SMI interception
> 
>   arch/x86/kvm/svm/nested.c |  4 ++++
>   arch/x86/kvm/svm/svm.c    | 18 +++++++++++++++---
>   arch/x86/kvm/svm/svm.h    |  1 +
>   3 files changed, 20 insertions(+), 3 deletions(-)
> 

Queued, thanks.

Paolo

