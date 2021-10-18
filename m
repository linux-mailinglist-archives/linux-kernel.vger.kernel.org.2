Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CE4326FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhJRTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbhJRTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634583493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPCBK4+qqhN59Q6AXab9sUjlmniUhlFiGiZrEdBuk6s=;
        b=JgSfjavM+lQ+BK0DZmqJAWa382fTICfypWPKH35yF3B1Dgt9/ixHmXvrzjiN0J4gqiILXq
        EH7+ND4f3+0Wn8rpkDwjOUpNYcSi0f0IQbCO35BKcSUQu1TnkZoCmgSJobPiLFktWYCtGs
        +gefR6YKm8UhQjEXGwjy4+q1TZ4nOmE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-p3NNz3-LMS-CCPpSzNJWAw-1; Mon, 18 Oct 2021 14:58:11 -0400
X-MC-Unique: p3NNz3-LMS-CCPpSzNJWAw-1
Received: by mail-ed1-f70.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so8584081edj.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YPCBK4+qqhN59Q6AXab9sUjlmniUhlFiGiZrEdBuk6s=;
        b=BeBRJ6QTEIp2D6iZhK8TAbgd4IzLWiXHuR2DFiLfCR7E0MaEpjSPpkzYkCniBvP80g
         B2QRNTr+kG85rLBbUdUtgC0NwaCkGYxiR7SBNJsnb8xLVUXZAdWASq0Cqm/22pkBJ22X
         uZQgpJxj334nYSnhJzauFLrVo8ib6okF9rkxlT2hAZYvlJnq+577+slFyn2NzxtlXyyd
         qepM8U9AB+eioyiv8NAGz6kMXUuVAMBOk+MnFz5+eDssgAfOkAnSOwcG2y+NmpnAhu01
         Xlwmcm/CLcyNbexQ4I94Nmw6oc5gV/bDWPJREOHyRlhpMh88qy0ckIBJoWkSB6I6bkEb
         +kTg==
X-Gm-Message-State: AOAM532IykcLcRk1GehF09Vo/RhKMTCwoKMooDr2jZLCWhzbgfkVhNc/
        xOML2YOtXtnU8RsMgkdlgZzjfAoff88pNnNZVjl7rE2t/nV7Y0PPqn8aaKYe195qlw+zpIND0qZ
        zWYisLrgg/O2KxpHbGCmNhFm8
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr48453438edb.344.1634583490631;
        Mon, 18 Oct 2021 11:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGzK2DGqC5lNBWwnAI2+ei1GtdSNm5wkCuN7xuHyVhKJiiPol/b31DZz0l2mHQvwfG1aPAMQ==
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr48453414edb.344.1634583490469;
        Mon, 18 Oct 2021 11:58:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y21sm9192732ejk.30.2021.10.18.11.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 11:58:09 -0700 (PDT)
Message-ID: <77444c94-e88a-ab96-cbea-674375ddee5c@redhat.com>
Date:   Mon, 18 Oct 2021 20:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: cleanup allocation of rmaps and page tracking data
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
References: <20211018175333.582417-1-pbonzini@redhat.com>
 <YW25ZiTE1N6xS4FN@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YW25ZiTE1N6xS4FN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/21 20:13, Sean Christopherson wrote:
>> Co-developed-by: Sean Christopherson<seanjc@google.com>
> Checkpatch will complain about a lack of
> 
> 	Signed-off-by: Sean Christopherson<seanjc@google.com>
> 
>> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
>> ---
> ...
> 
>> +	bool shadow_root_alloced;
> Maybe "allocated" instead of "alloced"?

Sounds good.

Paolo

