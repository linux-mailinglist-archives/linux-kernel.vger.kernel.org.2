Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE8412420
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352666AbhITSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378306AbhITSYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632162176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRI2avQuBNPO4mZTVFj4yY0DXqukEShEdAk6taZEnJk=;
        b=cV+rEkxVVpi8hgrpFdw8Oj9BL4m66kM4kVd3EyEFhjQLUr5rb3Se5XI9amNgg5bZPN8AS6
        GW5HMHgVscLcHGQERaRfgeuELNomHJxNu4lXg/s2P6om1IgbiZLDJ1/wtAussDC3xFrSST
        BxwWvG2BpeXuEYebkdWe/9JMTYiKnUg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-4QYV6KclNCyjusWfoXOolA-1; Mon, 20 Sep 2021 14:22:55 -0400
X-MC-Unique: 4QYV6KclNCyjusWfoXOolA-1
Received: by mail-ed1-f71.google.com with SMTP id l29-20020a50d6dd000000b003d80214566cso12106449edj.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vRI2avQuBNPO4mZTVFj4yY0DXqukEShEdAk6taZEnJk=;
        b=CTUMXQ79LprDQilKlvrsLbiyBpomtCJDlbFLb5ezeW5BDHYFEHCf6RRwUtY+D++lV4
         1A6LtcViQnRK3q8BKJcm1Qiwzu4d5qTFBX9N+0SnLCqtOfr4zkqpQU+V8fZ93h7wYMb2
         tsouv+4EGgcbTaRJcN19vc6IOi9v++u25mjAs9cq9ftrse6k4NA9BtR+kLh0v9nTNJch
         r+aOY4YrymnXHTYZ8Bjp9/h94jM0nsEhQ9qUQM/UQ/l8XCPnE225M9D8AQ5LECRlf+81
         NTJtXTQkitu7DLAweHiYcfRNarP7zI2edEOtJy++5xJ7xqjBRkFaYKjUfWg06ISzDlCf
         +aog==
X-Gm-Message-State: AOAM532WlM8/xon0OLYvg4L1H0UCMfsj8oax0o1cqjJAJ2St3R2O9vEd
        rUVbyeMlQCP1/NlXXIFuyHCjvq6M4iNmnMvLd9pJ6gUN+rjanesATfEIpTgGJmeTpEFYGWhVKk2
        HdkQ1ldNCoMWs5Rgpam2Aq03s
X-Received: by 2002:a17:907:76b2:: with SMTP id jw18mr31101768ejc.120.1632162173781;
        Mon, 20 Sep 2021 11:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSoRFsPRM/7K22YQ1jPmATj4IuvLfgFOqCYFtPnEIPU80lrUpqlQ2FpuvfaQh3tH7XvhJmFg==
X-Received: by 2002:a17:907:76b2:: with SMTP id jw18mr31101728ejc.120.1632162173428;
        Mon, 20 Sep 2021 11:22:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w25sm7281095edi.22.2021.09.20.11.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:22:52 -0700 (PDT)
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828201336.GD4353@worktop.programming.kicks-ass.net>
 <YUO5J/jTMa2KGbsq@google.com>
 <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
 <662e93f9-e858-689d-d203-742731ecad2c@redhat.com>
 <87tuifv3mb.wl-maz@kernel.org>
 <7a5825d1-d6e9-8ac8-5df2-cce693525da7@redhat.com>
 <87o88nuzzc.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
Message-ID: <0eb2d4b1-23a4-c318-9f91-8dce78c6c8ad@redhat.com>
Date:   Mon, 20 Sep 2021 20:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o88nuzzc.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/21 15:40, Marc Zyngier wrote:
>>> At least not before we
>>> declare the arm64 single kernel image policy to be obsolete.
>>
>> --verbose please.:)   I am sure you're right, but I don't understand
>> the link between the two.
>
> To start making KVM/arm64 modular, you'd have to build it such as
> there is no support for the nVHE hypervisor anymore. Which would mean
> two different configs (one that can only work with VHE, and one for
> the rest) and contradicts the current single kernel image policy.

Ah okay, I interpreted the policy as "it's possible to build a single 
kernel image but it would be possible to build an image for a subset of 
the features as well".

In that case you could have one config that can work either with or 
without VHE (and supports y/n) and one config that can only work with 
VHE (and supports y/m/n).  The code to enter VHE EL2 would of course 
always be builtin.

> It is bad enough that we have to support 3 sets of page sizes.
> Doubling the validation space for the sake of being able to unload KVM
> seems a dubious prospect.

It's not even a configuration that matches kconfig very well, since it 
does have a way to build something *only as a module*, but not a way to 
build something only as built-in.

That said, if you had the possibility to unload/reload KVM, you'll 
quickly become unable to live without it. :)

Paolo

