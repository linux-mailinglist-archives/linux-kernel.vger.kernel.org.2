Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA4373156
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhEDUYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhEDUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620159783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZKovbJ8lKtotNg9ShvdPO02WF5aXDGNpj87pCUgbWM=;
        b=acGWK4G6g2NXiHyfiPSFyeVyynJiXbRYWOkSN74PgCUxWNbK/PeEPgUU0zpKPf/onImLL8
        367ke7noPmRiHQjxpy9DLh7SZEHAu4a0dB9UvB/fhm+lVHcgFYIc9ZkGFtKHKd4O5DMnky
        65RPlKx3oiurh42ZVf+0s9I7lTuHZhE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-fWFsnfg2OA2z6rMCiFgsuA-1; Tue, 04 May 2021 16:23:02 -0400
X-MC-Unique: fWFsnfg2OA2z6rMCiFgsuA-1
Received: by mail-ed1-f71.google.com with SMTP id d18-20020aa7d6920000b0290388b4c7ee24so4273756edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZKovbJ8lKtotNg9ShvdPO02WF5aXDGNpj87pCUgbWM=;
        b=SxKTxIztxmLEU04Ztnz9f14P1IvS4f5y1c+ARg1gHbSRIbobSbpr9w5H/gXThGjBCp
         q3v5WE0OtTaiVqfu/RJReQzVpLpWgsxhDvRdo0DuYJmDw656JcITQuj/MUva/MH+4OGj
         iTFnWkJufz6LhwKp2REBDY8UsqfkRhdRWOxTd/1NFwsgQUG0Y8/hnP2ujH/E4BzLp13t
         IHpGX76jU9dCu2QVRHxFORbEGg9fhVhXu86a2zL369W4Uuy4BjVihFzRQKzRnAD5pgdS
         HDi0Y2gRBiAJlkofYpgo+4fy2aOBvjJ0Q/clQgYOrn1lN34NiN8SBu+rOt5u9SgHxHQ9
         v2vA==
X-Gm-Message-State: AOAM531xANvShJNdSQA5JJoYCOuVWmwnmThgjIzpE2ljp7QuwdtzJj5m
        p6NZLCQykk9QkT6BK/7S/9GE+VF2DXWqi9cQWy9jOJ3KOtXb47ON4qC5bI/qTiiaR9lVG4Rp2UI
        wFuPfhKCgAjfYggoeOiikAIu4
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr23568687ejz.160.1620159780863;
        Tue, 04 May 2021 13:23:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/ehuSnSyvhjGI2eJylw4RSt91+go0x6ZX/64OwCIMlzvvHaAvwWoFTchd058/nFJcvnoIXw==
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr23568673ejz.160.1620159780652;
        Tue, 04 May 2021 13:23:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id p22sm15250338edr.4.2021.05.04.13.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:23:00 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] KVM: x86/mmu: Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
 <20210429211833.3361994-8-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1e50ae22-16a3-c43d-594a-a20d2ea3caa5@redhat.com>
Date:   Tue, 4 May 2021 22:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429211833.3361994-8-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 23:18, Ben Gardon wrote:
> +	/*
> +	 * If set, the rmap should be allocated for any newly created or
> +	 * modified memslots. If allocating rmaps lazily, this may be set
> +	 * before the rmaps are allocated for existing memslots, but
> +	 * shadow_mmu_active will not be set until after the rmaps are fully
> +	 * allocated.
> +	 */
> +	bool alloc_memslot_rmaps;

Let's remove the whole sentence starting with "If allocating rmaps 
lazily".  The part about shadow_mmu_active should go there, while the 
rest is pointless as long as we just say that this flag will be accessed 
only under slots_arch_lock.

(Regarding shadow_mmu_active, I think I know what Sean will be 
suggesting because I had a similar thought and decided it introduced 
extra unnecessary complication... but maybe not, so let's see what he says).

Paolo

