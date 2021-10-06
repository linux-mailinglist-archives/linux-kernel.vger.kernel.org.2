Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67C4239A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhJFIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhJFIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633508503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+xEdVLOEDJbv11lBQeFrrFukY5BGrNDr+9DfcPVA24=;
        b=HxPtCYWWqWW6bKyUwPOG8I5lz56qGYznj9LEL6Ni/96AhkrVGdA5ml5PJDD9eE6oYnYFgq
        juO1e7GxVJEbax15QvgbHZ1h12UT9f1qdZwK/etE3er7fbH9OFGLtws31nE95wuMsc2RHj
        JQ9oKbf9U2282wrvpDrtDcvnVvEjlLc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-Ey9TYyvZMY6L7BVCZBxMsA-1; Wed, 06 Oct 2021 04:21:41 -0400
X-MC-Unique: Ey9TYyvZMY6L7BVCZBxMsA-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so1372342wrb.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H+xEdVLOEDJbv11lBQeFrrFukY5BGrNDr+9DfcPVA24=;
        b=zocAAR5YKuhY9nj7xW3Yls7KLSDZTFCTnpYxJBJnATzA2EgvovG30mmMcVGfjau+Sv
         8sZGb/CXf9q51PiEvdSSZkp32XNcJ4zo2/Z5uEfxrxOdWEmETfgLixsnpudZci2iAPr2
         ADGa8ZC+99rWY1xRy9zbqSvQ8Bz3behiQN3yPw9kRmRLD/FJbHODFP+au+dOr6XGXp+v
         ONgu/PWaX2CoLMmtXzcwZXVRR8/gDXRnzrg1L/x+KZsDOyzBxXTr9AWWgqtJIPuguHfa
         Qqg8b+6iDKuRIfdBY+hOWWljP6kZXUMamJKGCmMS/6RHsjr5cQ205ARtsKm5dYrOA/a0
         TWIw==
X-Gm-Message-State: AOAM530JwSDYO0qI4NUA2v28T1eBwcVVA5h13tu2pIGKZbmjq7JQeUCq
        HF239AbzvgDC13U/oJHX3CtLwsglNRi5JTcDGX7ebNl4fghkv8qepdsjr/9uwXuVgFjIPqzPHdF
        eFVmoizeyLue133oMHjv09FXMTzA4EJTpplWACd2K9hnwWcskzsJxJQXTwbu94k/lAZRwX6K1
X-Received: by 2002:adf:a152:: with SMTP id r18mr27478908wrr.317.1633508500832;
        Wed, 06 Oct 2021 01:21:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN1DumsGWjnPblwYNENSYk4gsLJlVnRVNof7OMB0nHZf2aoVmsGaSajJRX8RUy3TjDiLsS6g==
X-Received: by 2002:adf:a152:: with SMTP id r18mr27478876wrr.317.1633508500631;
        Wed, 06 Oct 2021 01:21:40 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id g1sm5132039wmk.2.2021.10.06.01.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 01:21:40 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Add TDX Guest Support (boot support)
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <181e166e-69a6-4659-c7e9-26c7f0c11dcd@redhat.com>
Date:   Wed, 6 Oct 2021 10:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.21 01:05, Kuppuswamy Sathyanarayanan wrote:
> Hi All,
> 
> Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
> hosts and some physical attacks. This series adds boot code support
> and some additional fixes required for successful boot of TDX guest.
> 
> This series is the continuation of the patch series titled "Add TDX Guest
> Support (Initial support)" and "Add TDX Guest Support (#VE handler support
> )", which added initial support and #VE handler support for TDX guests. You
> can find the related patchsets in the following links.
> 
> [set 1, v8] - https://lore.kernel.org/lkml/20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> [set 2, v7] - https://lore.kernel.org/lkml/20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> Also please note that this series alone is not necessarily fully
> functional.

I had a quick peek over all patches and nothing jumped at me (however, I 
am by far no expert on early x86 code!).


-- 
Thanks,

David / dhildenb

