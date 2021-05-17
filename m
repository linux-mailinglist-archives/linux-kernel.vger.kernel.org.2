Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103FB383A45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhEQQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238203AbhEQQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621269841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLOobSjCbQskFqMnll0HyKDl5KNjQO+RBewEeO7jSSc=;
        b=OJo83D5XBo7wOXIjAqfaqKpqPYo2hHSOWX/CyQqS+VStR0ePJ765qTWOk8O82gwBVxDs8l
        vP476E7fLp5DOabnRsEs/0ULUXmsbaIMOX6OM46ffjleolJej33Sk7aqojf+g0DXbKjqwc
        3dDzxopEZ4IQvVT4f2uJcsF3B05ofCc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-JvKSz-YZM16yrEwGLw63Ag-1; Mon, 17 May 2021 12:44:00 -0400
X-MC-Unique: JvKSz-YZM16yrEwGLw63Ag-1
Received: by mail-ed1-f72.google.com with SMTP id i3-20020aa7dd030000b029038ce772ffe4so4276164edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 09:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pLOobSjCbQskFqMnll0HyKDl5KNjQO+RBewEeO7jSSc=;
        b=fhqs5mTePUD6RjC65vFR02wfleiZuyG6i17mEJLG1w9gu3NtQfQtHZpLSBlXu8ND0G
         eL3s48te+vjsZWvSOMx3fBXm71mGYbXa5SVDhUIEbYl1nlo3pfhruOm28haw/ocFMiFc
         0DkMIBde4I0FscBi6+dbluUqkF6/uk4jJ7qWGV0Je6VaEJCucP9UbWWlYDAH9SrogNs1
         rPzPjHN8ZIJGMKxUIYsmwMQwALpuVg2eJ95MNTZOX5hfcAqSPLlwlEueE1NQGPjza7IR
         1K+3Gy+i6RnuFVjfG3zaP0sM+W2W5K709Midztz4n+7261TiNBz7IfVWgmGZMaPUIwWK
         bl2w==
X-Gm-Message-State: AOAM533kRiQZDbVvRHz901tDraY3P8Zgecd1q2HR0g7tAnYS/iO1q06m
        iQT4PjKiiV8Qr8s2iY9721ktztPRmpo7Qg1s4pK0K3QbtFRa7QzWHPi7MVkOJKrfZ7BH/8Une0q
        M4KFQsFePGN2QE8jCRANByzU4
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr1149992edj.178.1621269839204;
        Mon, 17 May 2021 09:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybcPfcPZg8fUCw2rYDP5qsCQxq7rGzcUbcnUmTWFmLAlzNQpmPlCsCiTwFNHTun2K89RcSNQ==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr1149967edj.178.1621269838988;
        Mon, 17 May 2021 09:43:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i5sm4826603edt.11.2021.05.17.09.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:43:58 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: add hint to skip hidden rdpkru under
 kvm_load_host_xsave_state
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, Jon Kohler <jon@nutanix.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Juergen Gross <jgross@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
References: <20210507164456.1033-1-jon@nutanix.com>
 <CALCETrW0_vwpbVVpc+85MvoGqg3qJA+FV=9tmUiZz6an7dQrGg@mail.gmail.com>
 <ccdf00d8-7957-de95-68cd-7d61ece337c0@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8033c48-86aa-397b-57aa-71d65d834e9f@redhat.com>
Date:   Mon, 17 May 2021 18:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ccdf00d8-7957-de95-68cd-7d61ece337c0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/21 15:54, Dave Hansen wrote:
> On 5/13/21 10:11 PM, Andy Lutomirski wrote:
>> I don't even want to think about what happens if a perf NMI hits and
>> accesses host user memory while the guest PKRU is live (on VMX -- I
>> think this can't happen on SVM).
> 
> What's the relevant difference between SVM and VMX here?  I'm missing
> something.

SVM has the global interrupt flag that blocks NMIs and SMIs, and PKRU is 
loaded while GIF=0.

Paolo

