Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA03AF98C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhFUXju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhFUXjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624318653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2h6ntSeAPBXrHus5BZXUFPmgMImlj4zJ8JJFLLmnt0=;
        b=NxFzAnDGhs0dDGL3LSLFTo0BqqU7dI3VOT4+DPBd3JuWqUhJHD/QrwFzyBvzXWhzvXhxWc
        irvcpw5gG0dNtSxeq++fOQudRKfX4SpMqIhgWnjGpu0u984lqrsSb/JSExw9FGGp5Ks7Yd
        P3wiBpo6DKpaw60wmfWQmceT7VDMJuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-1c7wcb4SNJmF3yMUWUYxWA-1; Mon, 21 Jun 2021 19:37:32 -0400
X-MC-Unique: 1c7wcb4SNJmF3yMUWUYxWA-1
Received: by mail-wm1-f69.google.com with SMTP id i24-20020a1c54180000b02901dbcf5d699eso676867wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2h6ntSeAPBXrHus5BZXUFPmgMImlj4zJ8JJFLLmnt0=;
        b=SVqB7d/vD9x6rzyA7e7JefCS75jq9hzM0Q5QeuhyHea1cHzcYn9JVN0rZ03ZBdLaIy
         yiKXDDpcDA+gZ8PqdByOcpVSjjCGO2bmhEguYIilWEWSOrM5ZWYSU75zbKRyY4edLlVB
         byChc1BaPNwek3rqKHahKFdI0z6+VTBwy20Fb//Rzh/3716GFYlabUjqxkcYjnfpr2Lo
         5nbmALIbZuwwCGGgWopBhHL8hNq7K2Bz5vmDZW74px98Mcs5wefOmoJ9Rn9CsuA1g/4L
         5xcPxdP0ZXq+7gXqIvph9DdeZbSn3hSjvFCdmOV+qSOHgEK8GdS1l8RcO+957AaDizDC
         w5Iw==
X-Gm-Message-State: AOAM531RxmnRqYNZ8ITNvmaiAMSKGeEU8+YBQON6tVtODEqjE/gCglVe
        TvlBQmIITQ67H3BGyKX85cNFoGMfj6SSVsw7kXFMbxxG9kS6nEBED71k6H0/HCrbv6Ran4lPfgX
        Y5Tr9arhroz3rR2OTUDydWSht
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr941639wmn.26.1624318650861;
        Mon, 21 Jun 2021 16:37:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRzhGoq4MyZdBYJJOc6VuvbNjdwrkuj0chXTnZdAAPB32sCkLfNpTv6WHpRNsQBsgqOcoqgA==
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr941621wmn.26.1624318650692;
        Mon, 21 Jun 2021 16:37:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id v1sm9765652wru.61.2021.06.21.16.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:37:30 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the kvm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210622081809.13dd2299@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fbab918a-a6f0-b1d4-90ba-1ab0172b68de@redhat.com>
Date:   Tue, 22 Jun 2021 01:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622081809.13dd2299@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 00:18, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    ade74e1433f3 ("KVM: x86/mmu: Grab nx_lpage_splits as an unsigned long before division")
> 
> Fixes tag
> 
>    Fixes: 7ee093d4f3f5 ("KVM: switch per-VM stats to u64")
> 
> has these problem(s):
> 
>    - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: e3cb6fa0e2bf ("KVM: switch per-VM stats to u64")
> 
> It is very hard to get the commit SHA right when the commit you are
> "fixing" is after the fix commit :-)

Yeah, that Fixes tag should have been removed since the patch can be 
kept separate (does not have to be squashed).

Paolo

