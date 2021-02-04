Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06930FA7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhBDR6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237901AbhBDR6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612461418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s5YZVkjCD5/C4ET3SX6EfcYxaF5+N4XQ299/ZHaz3F4=;
        b=WwZ6rbCmM3azz2xZpC0BAIZ/Yo3LWLQS7LGg3GH8L1sFDa/zR9FNcEXrDfMTV+6a4O5phI
        fTxS6hSHIvg8wxN+U7OMk2bTRZ5nOyCTdjrtFNUgtzuwULU1jipMlmqHFt3UC3jL55KQI9
        eeW1W5zZgb7zC3koVSMLVM/1Axyxc9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-zPuFeRb5MFaMZZpKNiU0og-1; Thu, 04 Feb 2021 12:56:56 -0500
X-MC-Unique: zPuFeRb5MFaMZZpKNiU0og-1
Received: by mail-wr1-f70.google.com with SMTP id o17so3277623wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5YZVkjCD5/C4ET3SX6EfcYxaF5+N4XQ299/ZHaz3F4=;
        b=bM592nAtAhbwWvmVHeMYYkDPL5U2mJeFAorr58hDTTF9D4UCg9aOMdXK5XSNyLOBQO
         8vF1GB5RjWyI1ciw4o7UizCKsjcK0xDHhjNcD5poY57ovEhXWgvzguf703+rKenhyPa5
         aK9Z6XDHE7EFvrcl5JDbC9ec5HxQvNQe0/ruCGsU3RWsb7Wwj3EL7MukBgDlXUwP97eE
         Gn2N6FpXbIXsVKTt1niSzsjIr62Ha1xZmMOuudRZB6BPNYs0RTfaK1J/f/V1VTzX651M
         ylwQe6oQgFN0nqC+j33+uyjR9NptxGux5u1i14UwlXXYDMAkSyQbGIcAJKzaqWuqrdb/
         UqQQ==
X-Gm-Message-State: AOAM531QBH8UJSshxtIHXZ1uZvAYHmiJa9YYiHjcLZsILInBSP2JtBvv
        ZOBo+ct7q6F9zsYqW0HMOYOZc9Dxtz1oPOmHyGh6N4WhOucsYwHQumFbdJbOL+FUtCFc0aXZPs7
        cZG099TH4ZWYIV8ZQEcZhqiyx
X-Received: by 2002:a1c:e905:: with SMTP id q5mr335379wmc.84.1612461415359;
        Thu, 04 Feb 2021 09:56:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdM3Fux/LZYeI1PRL6P2CnPpwWo90HoYMM+BJpvd4gVKVgraKOTq986c9dJjLBOB4uFSVNNg==
X-Received: by 2002:a1c:e905:: with SMTP id q5mr335372wmc.84.1612461415198;
        Thu, 04 Feb 2021 09:56:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i7sm9116584wru.49.2021.02.04.09.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:56:54 -0800 (PST)
Subject: Re: [PATCH 07/12] KVM: x86: SEV: Treat C-bit as legal GPA bit
 regardless of vCPU mode
To:     Sean Christopherson <seanjc@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
References: <20210204000117.3303214-1-seanjc@google.com>
 <20210204000117.3303214-8-seanjc@google.com>
 <5fa85e81a54800737a1417be368f0061324e0aec.camel@intel.com>
 <YBtZs4Z2ROeHyf3m@google.com>
 <f1d2f324-d309-5039-f4f6-bbec9220259f@redhat.com>
 <e68beed4c536712ddf28cdd8296050222731415e.camel@intel.com>
 <YBw0a5fFvtOrDwOR@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c16cbc1c-a834-edd4-bfdf-753ec07c7008@redhat.com>
Date:   Thu, 4 Feb 2021 18:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBw0a5fFvtOrDwOR@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 18:52, Sean Christopherson wrote:
>> Alternatively there could be something like a is_rsvd_cr3_bits() helper that
>> just uses reserved_gpa_bits for now. Probably put the comment in the wrong
>> place.  It's a minor point in any case.
> That thought crossed my mind, too.  Maybe kvm_vcpu_is_illegal_cr3() to match
> the gpa helpers?

Yes, that's certainly a good name but it doesn't have to be done now. 
Or at least, if you do it, somebody is guaranteed to send a patch after 
one month because the wrapper is useless. :)

Paolo


