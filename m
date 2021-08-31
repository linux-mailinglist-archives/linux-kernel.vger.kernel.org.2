Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8643FCE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhHaUQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232698AbhHaUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630440944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+3bK63F6vZV9gF02enJmq1IwAzxVldbfTOh+NENPz4=;
        b=XAIS078aFLvwDF9G6Pq+DoRdW806EK+1YyqapSPR4RbRQ4m5M4eHx8Doq6/Dpvjp96kZZd
        rwbCWoxbypHEe3ztVIAe9A1k+F0rW+bEHbr3ytQuLl6MBvcvCAIeoZ9I2QH0Tapog+B8lI
        1Xr3PYyIkvZ8WczI8fEMdqpwp1DJrD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-R9veAn6BOSWLziU-fu_Hpg-1; Tue, 31 Aug 2021 16:15:43 -0400
X-MC-Unique: R9veAn6BOSWLziU-fu_Hpg-1
Received: by mail-wm1-f72.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso120469wml.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=g+3bK63F6vZV9gF02enJmq1IwAzxVldbfTOh+NENPz4=;
        b=Ib/Q7sy2HoscIKcrIJtVDjGTDD+eICPBTxQtbJCCG9QeDeOP0kUpDs6MYfvS23CHf1
         bRAB58RHM7NDvXl+8ITyXNumdXLdj6GvFG4nMhxyh2pD58a8LXnO7hh+H8H7LDmPRuOn
         +J7/L8vCwxLqnfVf1vdQNvsQbU+beFqxQQsaYvc8fSDlXaBxGcgsrXNjPdY4ZjpfVUuH
         BNbUoQexoGzxMgzuolmVRcjLqS+jjNGJML0FQ8YbKbz0GpoGd2z7NlqftXlP3mQOC39k
         19BvKfNdlA92wpFrbcgEY+TYa/Ej/JPcfyU6yBiaRol8PnJiAlFP2OFUpKmbk3VjDul3
         /H+g==
X-Gm-Message-State: AOAM532r1eg1/iVfXQnbsErNJ8rHS/se717z/zDJ1uzD9xpKz9Q073Oq
        5ZfJl9OdcZ6Sb6y+x8FA9nXOLEZm9O8MZrYWeBLBSsvKMFtD1lUyYoGR3Y5jgjwW5yZlGLNa8On
        WKadyc8zbUpTE5pcaPDjB3YvL
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr6178332wmc.30.1630440942385;
        Tue, 31 Aug 2021 13:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB2RQAmO5BS/DvOxJgqehQUn6XNwZTVP2aL40tssuajSfi8Q5/tHrZmF44xOFZj1btCjBABg==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr6178303wmc.30.1630440942231;
        Tue, 31 Aug 2021 13:15:42 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id p11sm3438168wma.16.2021.08.31.13.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 13:15:41 -0700 (PDT)
Subject: Re: [RFC] KVM: mm: fd-based approach for supporting KVM guest private
 memory
To:     Andi Kleen <ak@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
References: <20210824005248.200037-1-seanjc@google.com>
 <307d385a-a263-276f-28eb-4bc8dd287e32@redhat.com>
 <20210827023150.jotwvom7mlsawjh4@linux.intel.com>
 <243bc6a3-b43b-cd18-9cbb-1f42a5de802f@redhat.com>
 <765e9bbe-2df5-3dcc-9329-347770dc091d@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4677f310-5987-0c13-5caf-fd3b625b4344@redhat.com>
Date:   Tue, 31 Aug 2021 22:15:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <765e9bbe-2df5-3dcc-9329-347770dc091d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.21 22:01, Andi Kleen wrote:
> 
>>> Thanks a lot for this summary. A question about the requirement: do
>>> we or
>>> do we not have plan to support assigned device to the protected VM?
>>
>> Good question, I assume that is stuff for the far far future.
> 
> It is in principle possible with the current TDX, but not secure. But
> someone might decide to do it. So it would be good to have basic support
> at least.

Can you elaborate the "not secure" part? Do you mean, making the device 
only access "shared" memory, not secure/encrypted/whatsoever?

-- 
Thanks,

David / dhildenb

