Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F254D355B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhDFSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhDFSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617734161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onYMsdqIwwMtCr/o99OSThEm1roisnCtNhad6j+yKxI=;
        b=h8NIOadQhwhsFDG/+gTTMBCXnjLqJY2vrhj1l8lXtEPe91dC0Vdmvi4f0yxF1/nWTGE5vi
        NDV3oNYzbeMbPHwdqNWHtv65Gs3FnQz5APvtDCYWIjKfS3XSSdCgWV95EFKxm6n25JfdGW
        HphUoyZ8GYbtGzPlVnrBe6etnueCJsg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-6885pEXDO2G_oOcGE7qKpQ-1; Tue, 06 Apr 2021 14:35:58 -0400
X-MC-Unique: 6885pEXDO2G_oOcGE7qKpQ-1
Received: by mail-ed1-f69.google.com with SMTP id o25so5460436edv.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 11:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onYMsdqIwwMtCr/o99OSThEm1roisnCtNhad6j+yKxI=;
        b=hkLK7jFVM7CQc2q1jMLi1kEKtvgqZClZm+WIXKMpIT8BDpedQ/yzVmDgoskAPQtBnv
         edRgU8pnUTgy9HJgj1qav/vJKPcDP+lJSm4yPwwzbWI2PEkFXWWSUEczdeKSWECgffJ6
         sGfU0KN2FRObe8AFoyQxtKs1t6VhvPUDlVkMDakffw/fRaifC42ZgbZFMmcYqnMFjp1P
         AY/4p51j+pyi1jblVjwEjs06jyZEkZ1PpmpdYzHODbF+gV8hb+6zTY9rzoi2vvctBXHb
         A8JkKOmj/jjqYu7AxEeq6uE0ggztTEfKvw6v7eP72tfYimGXLnLY0aSOCBkJbL/9WxTs
         cQ+w==
X-Gm-Message-State: AOAM532Hx/YzGXEJspECZwU7/nmE4wINpYL0/FuoYPds1I4u1n2wnYIJ
        vLHOPOv7IBdJvvMDqD2GVtVbhcdKM+mjEAqedo+ZMBliG1SVcaZcHRacMA4XApYZQp0ahr5bfab
        LIwrZ+z2gsovf467MHMWoLjC5
X-Received: by 2002:a17:906:c09:: with SMTP id s9mr1792134ejf.145.1617734156988;
        Tue, 06 Apr 2021 11:35:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+m3afEzHGEFBRSYcpNWuNWxD4R4p0GKyEey8a1eUb3RGjB3HAAYaJy/46vwEJJQyto184DQ==
X-Received: by 2002:a17:906:c09:: with SMTP id s9mr1792113ejf.145.1617734156774;
        Tue, 06 Apr 2021 11:35:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b24sm1413630ejq.75.2021.04.06.11.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 11:35:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: preserve pending TLB flush across calls to
 kvm_tdp_mmu_zap_sp
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, stable@vger.kernel.org
References: <20210406162550.3732490-1-pbonzini@redhat.com>
 <YGynf54vwWpyxhz4@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d93cb5c8-e54a-6f5a-c660-9d044ff2c743@redhat.com>
Date:   Tue, 6 Apr 2021 20:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGynf54vwWpyxhz4@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/21 20:25, Greg KH wrote:
> On Tue, Apr 06, 2021 at 12:25:50PM -0400, Paolo Bonzini wrote:
>> Right now, if a call to kvm_tdp_mmu_zap_sp returns false, the caller
>> will skip the TLB flush, which is wrong.  There are two ways to fix
>> it:
>>
>> - since kvm_tdp_mmu_zap_sp will not yield and therefore will not flush
>>    the TLB itself, we could change the call to kvm_tdp_mmu_zap_sp to
>>    use "flush |= ..."
>>
>> - or we can chain the flush argument through kvm_tdp_mmu_zap_sp down
>>    to __kvm_tdp_mmu_zap_gfn_range.
>>
>> This patch does the former to simplify application to stable kernels.
>>
>> Cc: seanjc@google.com
>> Fixes: 048f49809c526 ("KVM: x86/mmu: Ensure TLBs are flushed for TDP MMU during NX zapping")
>> Cc: <stable@vger.kernel.org> # 5.10.x: 048f49809c: KVM: x86/mmu: Ensure TLBs are flushed for TDP MMU during NX zapping
>> Cc: <stable@vger.kernel.org> # 5.10.x: 33a3164161: KVM: x86/mmu: Don't allow TDP MMU to yield when recovering NX pages
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/mmu/mmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Is this for only the stable kernels, or is it addressed toward upstream
> merges?
> 
> Confused,

It's for upstream.  I'll include it (with the expected "[ Upstream 
commit abcd ]" header) when I post the complete backport.  I'll send 
this patch to Linus as soon as I get a review even if I don't have 
anything else in the queue, so (as a general idea) the full backport 
should be sent and tested on Thursday-Friday.

Paolo

