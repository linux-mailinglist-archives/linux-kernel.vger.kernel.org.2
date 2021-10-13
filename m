Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCC742B57D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhJMFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhJMFgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634103289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9r2xR2EqP/t5FLsHTwtUUvaANXfO/gylgaJSKQRa+8=;
        b=Aln7cKPDmSmUrSA3Px3eLIZFm9ZulRJ2HLhmjniDv0H6jQ0qVcRM8Lq6QDTAVfhxTmMY96
        BhaRJirC3jSg/8iKsx5qa+Q/TROzE9QEfG/WKSlkuC8Pb9LCK36tide8InEHXfFSZdcGjQ
        L2vYctiPpGMoxQd8nkdS/6NZ8polaYA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-4vdsWIRUNby4wvcWIRvbqw-1; Wed, 13 Oct 2021 01:34:47 -0400
X-MC-Unique: 4vdsWIRUNby4wvcWIRvbqw-1
Received: by mail-ed1-f70.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so1197826edx.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s9r2xR2EqP/t5FLsHTwtUUvaANXfO/gylgaJSKQRa+8=;
        b=y/RQxhCdwlsa6p9i4sHDBb2GfFbcOXe2NB+Uosb0ExhQvjHu9r/PBY4T3w8qwjiZLT
         KfF5ptU9i7Fq8IeOVEgthLahdDLPiYbZ3ZkYQWIGMop+ywIQAg1jkIYXX+BgCs8xv0fP
         99TtnyOSO/6R4Knj7azGhTr3JuLxQ3VthhHPmxI7ulL3xmJHLEqISL7UPxduuzACwdyD
         r/w/xZl4+wEYsomLj6FkwAd1O8yn6p9r6+cwbDdzgyyvbiZRYsojgr2hrwzO6uaiRDa4
         lbbU5chFM1Jfd5HipyVP2rZ7zdunwTuxqOKy8KKZX7l/KPIftaGr97L1PFp8vWwOjF5e
         QN4A==
X-Gm-Message-State: AOAM5306ejGIWN39SCaG3no04uREV6QlUjJcR6+pTg/38mToHI9P9L1F
        rgJi2e3b3m0cbpgeAC9VuRCN0cAq2y2hjdxvfyBer7aE9ljEQlysEaRg3T7gjHQUjuNl/a3KcrI
        ELHbTufA5/GW0uLLrt0K4v+4W
X-Received: by 2002:a05:6402:2684:: with SMTP id w4mr6554722edd.108.1634103286330;
        Tue, 12 Oct 2021 22:34:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvbp0lfx3vs0ck1sseLJlqp7mWqgndzQU8vzGaHBI2q4E7j80ZWXtMNpOrO5LTzF7xq9/gig==
X-Received: by 2002:a05:6402:2684:: with SMTP id w4mr6554698edd.108.1634103286140;
        Tue, 12 Oct 2021 22:34:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x26sm1916924ejf.103.2021.10.12.22.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:34:45 -0700 (PDT)
Message-ID: <cc8893f1-df60-2155-d3b6-f889bc1c2201@redhat.com>
Date:   Wed, 13 Oct 2021 07:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [patch 16/31] x86/fpu: Replace KVMs homebrewn FPU copy to user
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        kvm@vger.kernel.org
References: <20211011215813.558681373@linutronix.de>
 <20211011223611.249593446@linutronix.de>
 <0d222978-014a-cdcb-f8aa-5b3179cb0809@redhat.com> <87fst6b0f5.ffs@tglx>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87fst6b0f5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 19:47, Thomas Gleixner wrote:
>> The memset(guest_xsave, 0, sizeof(struct kvm_xsave)) also is not
>> reproduced, you can make it unconditional for simplicity; this is not a
>> fast path.
> Duh, I should have mentioned that in the changelog. The buffer is
> allocated with kzalloc() soe the memset is redundant, right?

Yes, I always confuse the __user pointers with the temporary ones that 
are allocated in the callers.

Paolo

