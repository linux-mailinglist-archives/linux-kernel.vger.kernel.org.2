Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE943AC8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhFRKd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhFRKdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624012306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kxjjVfDr06FdqvB+NtA55I89EuxwDAZ4o8llHKwLkQ=;
        b=Je/CbXuoBIxw9hbim4PTBG6jnZrZc2b4oZxRI1xjRONOKF5Z/FfBh1nNNM7ovg1Al+GhX5
        9Xw+vyEoQbU6JvIqdGViDVhTrWYMhT98eQiW4FcHxia0+qewGxe91iPy/XjzqBzzQMMyQc
        ZheI00EdnGZ2HUzV+2pj2rfCsePbDA0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-w7EHF6VbMf2i3m0OeO937w-1; Fri, 18 Jun 2021 06:31:44 -0400
X-MC-Unique: w7EHF6VbMf2i3m0OeO937w-1
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso3700408ejn.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kxjjVfDr06FdqvB+NtA55I89EuxwDAZ4o8llHKwLkQ=;
        b=BVUSDdfFcLDlsTppLGu+Jlr0WkzN3zngxjuv+sFz0Fczt4bAofRYHR2Sd+ZzPNEsTL
         TSEfftVfhDNnH2pOtOT0YAxvzd4GBhZjiJEKZ4Yocn46AdaMAIN2IAE/bFPY3PPGDzeY
         EHZqT+MqudfHAtfmGsqsyhOMvGBQbHlFALnz/zsPO4/EIr2hI3uL7xyDcxd4IfbL86R6
         vLsY3Tp83Q2LNx29Vj+WDX+fCQ/IDgZ7aSNP6lDoKxArmadqS4/yI1wGPKeZmcJY2Y0b
         mzkn/aqMSJptMYRRdT2Oa7LCOgaxReWp6ztOJ7Iomh+NerCeBJu7XEJypIfeaRnEov8x
         TuCg==
X-Gm-Message-State: AOAM531CGIFUpBUDg8oDN7Rxw6xnpd5cLrsKOxItkV8VDYz57eyrq6wQ
        hT/e8cRKCz/pFv0nGPne43dBaqtmumSv2Eq5QAsAHgRiuuSI4JnPKQh0fh/sS6rUmk+rFnVEnYu
        q+EyRGaiDllrH70hw44CPmoI3sPfB2Gy1VQkXYgB/e+/spVB/scnjL5BG4O/UScw2PP+enJ+Mb3
        pT
X-Received: by 2002:aa7:d14d:: with SMTP id r13mr4088085edo.212.1624012303485;
        Fri, 18 Jun 2021 03:31:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbt3wJrddbRFGnPR6wPSg0b+MAsEry4G6dxNcer2lCh+oPeXK8W3vzerWkcD5lf0rLxjOGjw==
X-Received: by 2002:aa7:d14d:: with SMTP id r13mr4088049edo.212.1624012303218;
        Fri, 18 Jun 2021 03:31:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s2sm6176459edt.53.2021.06.18.03.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 03:31:42 -0700 (PDT)
Subject: Re: [PATCH 4/4] KVM: x86: Simplify logic to handle lack of host NX
 support
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210615164535.2146172-1-seanjc@google.com>
 <20210615164535.2146172-5-seanjc@google.com>
 <CALMp9eRGj_5+dZXQazVEkeKeDnc7GFm1Vnt2RS_V6akAR=rZsA@mail.gmail.com>
 <YMk40yLeyV1DHpYp@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24c8db9d-cee3-7f43-08fc-287bca4d6f08@redhat.com>
Date:   Fri, 18 Jun 2021 12:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMk40yLeyV1DHpYp@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/21 01:33, Sean Christopherson wrote:
>> It would be nice if we chose one consistent approach to dealing with
>> invalid guest CPUID information and stuck with it. Silently modifying
>> the table provided by userspace seems wrong to me. I much prefer the
>> kvm_check_cpuid approach of telling userspace that the guest CPUID
>> information is invalid. (Of course, once we return -EINVAL for more
>> than one field, good luck figuring out which field is invalid!)
> Yeah.  I suspect this one can be dropped if EFER.NX is required for everything
> except EPT, but I didn't fully grok the problem that this was fixing, and it's
> such an esoteric case that I both don't care and am terrified of breaking some
> bizarre case.
> 

It's dating back to 2007 when EPT didn't even exist, I would just drop it.

Paolo

