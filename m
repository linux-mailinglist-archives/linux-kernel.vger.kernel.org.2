Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1C3E56C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhHJJZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238969AbhHJJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628587532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RB6Pczk4vDPwq2uSGWS6COud14iPXuDOTUgBGUDVOs=;
        b=UKadjMPsRn2kc7eXn9HSqHj7mcJkQsRvUPyirUTgBvRESc+JkbJERJYprp4ghtf9LbUfyL
        acPxnDfzx0I8mrJyc/2m/O75HOSVuuvXIONTOTj0AExvAvxAEH8rH6lnJR+Yh+6CBBSm6h
        G9ITl9w7hwOlVDibNeow3fcs3+FsXMU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-5673zGcVMluu3KAHmmCvaQ-1; Tue, 10 Aug 2021 05:25:31 -0400
X-MC-Unique: 5673zGcVMluu3KAHmmCvaQ-1
Received: by mail-ed1-f71.google.com with SMTP id y22-20020a0564023596b02903bd9452ad5cso10437967edc.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9RB6Pczk4vDPwq2uSGWS6COud14iPXuDOTUgBGUDVOs=;
        b=J7n1rXSI0sLmj6tGu5KPrOUjpWZm2encyIlilmbHFFK/GVRCAtLwNMLqa3pgSQy0b8
         62tmqf237s6beuy5DzkqhWZNLQHKZtQWRFz2Q1HQUc2rCqnit7WjmITRD69POP9OBTZa
         IaPd7OfypP292AtsHrWkgrMKqv+xhFtV4lc8avPO29s4inF+9zTx+jkxzcvZIBhPWyol
         TKA2sND2uZssxwh0fCoPXH677X5r9Wc68I0Ugvo1if+KuVHwQpW82Ad88zr6sRUNNxZZ
         4wGzsmUHFv6PThy3prtUd/HrlOmwj7ZWjZ6KNxOEYQqy21LOgU5tcQuzhTuKucGPfn++
         yOvw==
X-Gm-Message-State: AOAM532vOY9VvmriOptk98502AvsAaZwFB1JeKVWVXhAPI5XFgcvGVVf
        mFc1yXwy2Faoc5N9r50z+MpJ2xer/OkqiDiZk3SG/kc7B4fO85i4RYU5irN8dXMQzjcUPZVm05w
        Ih82EQ1ppWnWLYJYiDB0W/TTb
X-Received: by 2002:a17:906:1412:: with SMTP id p18mr403414ejc.545.1628587529794;
        Tue, 10 Aug 2021 02:25:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdtVhsz6duqdq2TK6WgLYxnxtIAyk8aZC40PfN4pZYSJW6GS3DgxOlNPPOp8fH24wM2t3hCA==
X-Received: by 2002:a17:906:1412:: with SMTP id p18mr403396ejc.545.1628587529632;
        Tue, 10 Aug 2021 02:25:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id c17sm844174edu.11.2021.08.10.02.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 02:25:28 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: x86: Allow CPU to force vendor-specific TDP
 level
To:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
References: <20210808192658.2923641-1-wei.huang2@amd.com>
 <20210808192658.2923641-2-wei.huang2@amd.com>
 <20210809035806.5cqdqm5vkexvngda@linux.intel.com>
 <c6324362-1439-ef94-789b-5934c0e1cdb8@amd.com>
 <20210809042703.25gfuuvujicc3vj7@linux.intel.com>
 <73bbaac0-701c-42dd-36da-aae1fed7f1a0@amd.com>
 <20210809064224.ctu3zxknn7s56gk3@linux.intel.com>
 <YRFKABg2MOJxcq+y@google.com>
 <20210810074037.mizpggevgyhed6rm@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ac41a07-beeb-161e-9e5d-e45477106c01@redhat.com>
Date:   Tue, 10 Aug 2021 11:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810074037.mizpggevgyhed6rm@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 09:40, Yu Zhang wrote:
> About "host can't easily mirror L1's desired paging mode", could you please elaborate?
> Thanks!

Shadow pgae tables in KVM will always have 3 levels on 32-bit machines 
and 4/5 levels on 64-bit machines.  L1 instead might have any number of 
levels from 2 to 5 (though of course not more than the host has).

Therefore, when shadowing 32-bit NPT page tables, KVM has to add extra 
fixed levels on top of those that it's shadowing.  See 
mmu_alloc_direct_roots for the code.

Paolo

