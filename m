Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661033B21C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWUZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 16:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhFWUZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 16:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624479779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9inRY89TsT5DJ1D2z368LNI6P3yOUL9KZ0T/FVXFIE=;
        b=BQzMbnOr8K87nff6XtGU7tGxM7CFfiDdLUpvE0HtpWxVDNAsZ5a2vvaVrIUexO9N5eeyAK
        f6CwU3uPVxZK+AD0A4tjLA/obCFKwZKYDkR9SbQMDft6cUFaILrC+w+BvL88ihFpDE4Gl2
        Zze8lYxEZzfiaooOfqDxjedRcFdJQOc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-RyFfD7kfMduOCGZ0rPDbLA-1; Wed, 23 Jun 2021 16:22:57 -0400
X-MC-Unique: RyFfD7kfMduOCGZ0rPDbLA-1
Received: by mail-ed1-f69.google.com with SMTP id r15-20020aa7da0f0000b02903946a530334so1944374eds.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 13:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9inRY89TsT5DJ1D2z368LNI6P3yOUL9KZ0T/FVXFIE=;
        b=LQeUpxM8UB7eGlOQyD6LcIhnuOxf+xKGI1tTZW7wP7xlSS0QHdL6M92eLVxLqDEFru
         tiEvzBQA1iFALnC1Dx77Opf2FQFtR4srOBcx1E6Cr06Ns+lRVnHCwNX/DsMAFKXuQITK
         q0UJqmDuGmtJBDoaMZZPkcJQwJFPER6AT6tPU3Wmv7+b5TY/r2J0xY5xv2y7kwVlkXXk
         Smo6+ZDXAsegviiBJD80u9OOqw1yJxFmd2Gd2eZmHxFLfsKVOlkjZ3/R2HuotGfmXy6V
         XevAp4fTkmClfO0RhpqHeM4xLEqxFJmLMXaKnZ5MozGwqVmLpy24n4QW6Hf0GWsNaOY6
         /aHQ==
X-Gm-Message-State: AOAM532T8Fv9h+nkPyObwapmRCjinp5nNC29bzqiM/gHiKAYfacI0VtG
        ORxVEOlmI4x2Tr/tfZuy4OPZApKuptTLswa0L1CBWr8la3Azo7sUqNs+W6bqa5MbGaBzSU4nUrs
        LqOuBGiz3Hcj/n7XP4K2SnKDb
X-Received: by 2002:a17:906:b858:: with SMTP id ga24mr1775186ejb.355.1624479776573;
        Wed, 23 Jun 2021 13:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhmVrINxJjx/nb0p2vxzI/BThN7B2LoyvmZnp19v1XWSmDNQv7hN6+V/AP6Jrq0ETmlO010w==
X-Received: by 2002:a17:906:b858:: with SMTP id ga24mr1775174ejb.355.1624479776391;
        Wed, 23 Jun 2021 13:22:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c6sm577571ede.17.2021.06.23.13.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 13:22:55 -0700 (PDT)
Subject: Re: [PATCH 50/54] KVM: x86/mmu: Optimize and clean up so called "last
 nonleaf level" logic
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-51-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7a290c6-aeca-bd7b-d0be-d1af44713138@redhat.com>
Date:   Wed, 23 Jun 2021 22:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622175739.3610207-51-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/21 19:57, Sean Christopherson wrote:
> For 32-bit paging (non-PAE), the adjustments are needed purely because
> bit 7 is ignored if PSE=0.  Retain that logic as is, but make
> is_last_gpte() unique per PTTYPE

... which makes total sense given where it's used, too.

> +#if PTTYPE == 32
> +	/*
> +	 * 32-bit paging requires special handling because bit 7 is ignored if
> +	 * CR4.PSE=0, not reserved.  Clear bit 7 in the gpte if the level is
> +	 * greater than the last level for which bit 7 is the PAGE_SIZE bit.
> +	 *
> +	 * The RHS has bit 7 set iff level < (2 + PSE).  If it is clear, bit 7
> +	 * is not reserved and does not indicate a large page at this level,
> +	 * so clear PT_PAGE_SIZE_MASK in gpte if that is the case.
> +	 */
> +	gpte &= level - (PT32_ROOT_LEVEL + !!mmu->mmu_role.ext.cr4_pse);

!! is not needed and possibly slightly confusing?  (We know it's a 
single bit).

Paolo

