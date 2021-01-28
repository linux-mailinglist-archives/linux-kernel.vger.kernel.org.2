Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6E4307BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhA1REj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232820AbhA1RB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611853202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UH9HnxwYQlcxwQzC5ROXxf5EX99BRvbyCUr9+YZW4as=;
        b=cIlx33rj1mDPTZGUfIBLyEbEfbrp045S9PoND2H90q9n5Qw/B6rRwE5jLf63PbqJZpUKs8
        a907mAofvCKpRjCVBVFwl7GT4PjAz/oCz92iQUizil7my6sgcosxhtoAWYm666khdxa0YO
        /PKhG6pdcHKQPg/IDoGFwVoaKqHyapw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108--SygTdk9O6eZ4nX3-61BdQ-1; Thu, 28 Jan 2021 12:00:00 -0500
X-MC-Unique: -SygTdk9O6eZ4nX3-61BdQ-1
Received: by mail-ed1-f69.google.com with SMTP id x13so3491385edi.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UH9HnxwYQlcxwQzC5ROXxf5EX99BRvbyCUr9+YZW4as=;
        b=lOM9mCiJqDmzvgu/hmK82tFrN0M/T5j2Fe/fWm47gFSOVsGQW//ri42yx2r2fVz2MT
         TLajFUCSNxpiVrjpFeuLdojg6X1TkYR3k3l2TOZf6xwFf/40Rph9e6tU+eMf2vvxugE4
         aWyygeDBA1UjhdLeUuLmr1xpkAmeSzlGZ5661o15Zh5hBy/r/8LAwAu02UzvcOspNZmm
         CnY650EGQ6J1Se1MxeiAH5cfKw1qw2ZoAkSOWoxiVllUMtBDvHNLR2IQTZVty+m/Gybp
         LtxKw7hc/QAuuFZ0p47P/shqdRK1P8XP9Lwuev4OOirCHgDJ4ehlsDMV+vP3J80tgH7S
         8x4A==
X-Gm-Message-State: AOAM533PDVxMIS9XlWWGJXBk4zdoXdbxFJ1qQXXULjwUK0uYjyVHszFc
        9nPcoZf2PULFQFzEp5DPCSR3wioElHsMIKk6k60Wl+bBrAyYkJnpgqVtc2XgM+fL7Ynh6BIncki
        vB08AiNmB3G1yKHVW4dwYMhtt
X-Received: by 2002:a50:da8b:: with SMTP id q11mr523675edj.352.1611853197914;
        Thu, 28 Jan 2021 08:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCYYO4KxHvkD1ek7VplCvdhayWK50wgiLkiCy7nAAszHbgwT/+0cTT4+tdbopcJmj3Hq5WZg==
X-Received: by 2002:a50:da8b:: with SMTP id q11mr523655edj.352.1611853197771;
        Thu, 28 Jan 2021 08:59:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id fi12sm2576705ejb.49.2021.01.28.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 08:59:56 -0800 (PST)
Subject: Re: [PATCH v2 14/14] KVM: SVM: Skip SEV cache flush if no ASIDs have
 been used
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20210114003708.3798992-1-seanjc@google.com>
 <20210114003708.3798992-15-seanjc@google.com>
 <55a63dfb-94a4-6ba2-31d1-c9b6830ff791@redhat.com>
 <YBLmareW9CB0Kcta@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47871650-ed98-4258-69c0-75d8a1a7f4e5@redhat.com>
Date:   Thu, 28 Jan 2021 17:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBLmareW9CB0Kcta@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 17:29, Sean Christopherson wrote:
> On Thu, Jan 28, 2021, Paolo Bonzini wrote:
>> I can't find 00/14 in my inbox, so: queued 1-3 and 6-14, thanks.
> 
> If it's not too late, v3 has a few tweaks that would be nice to have, as well as
> a new patch to remove the CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT dependency.
> 
> https://lkml.kernel.org/r/20210122202144.2756381-1-seanjc@google.com

Yes, will do (I had done all of them myself except the comment in 
sev_hardware_teardown() but it's better to match what was sent to LKML).

Paolo

