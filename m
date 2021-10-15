Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE742FA86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbhJORuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242254AbhJORuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634320091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Zx3QxbiVEuPANTUXByKBFYol9oS003tMx/6Xs2/A9c=;
        b=FAbD7sPN5gUj94l6iK7E7Ajv6X7zMMrYmHwkhGgAeizgLeBO26kaMcESnY6utzMhyOxjDJ
        zkY3p0s20flVn9vgbvUUUI5Q5polL61cDN+7kGLeco6XApeE2xNvsKtHjJKK89ivbRew6n
        Perx4RcxLeT5ChNL4UQkGVwmCxYxh1I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-Iv8hM3K3OLaQYKKeSEj_uA-1; Fri, 15 Oct 2021 13:48:09 -0400
X-MC-Unique: Iv8hM3K3OLaQYKKeSEj_uA-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso8858167edj.20
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Zx3QxbiVEuPANTUXByKBFYol9oS003tMx/6Xs2/A9c=;
        b=PV48yF+0CqZdMN3FeyxEf6MbcNMurViZFOAJsYPTK98n7yqkDuCFXjRb2Wk8nkYi6Z
         PHNeipZhJkNKqUD3ciB/zYrfbrZIQ2TpzGhIHZHmqlAnpP7pQRKEz/rfYXFn1EkIQmXJ
         rkF8pK+xtjRIIE+m//yQRV55ZXKZcZPlHjr58fFRq6SgPoTb+3epI51HAqn5qi3J1UaP
         6SMtvQtug4cFhO/reHMNd/eGnpl0Cg+kPpOZA+xU42D4KvZc0jW2X4A5UXkManz4QKF0
         5Xo5cBDTVzf73ZZrTCUSOaCxio23uwv2kNi7Egj2Fv4THO1UrtCbBvwkI/gSbSufjTdy
         rnHw==
X-Gm-Message-State: AOAM530jGPuw7OJB3QrY7hPpXSZ8mci11n541WttyZkD9Rijsh5030ON
        jQaxuKtfnV12/T2eqVKhpDujaF/wR1meKDV3u3oZ06Yjo9J2XLSATY5zF2XsvkKPMp6lDPvqgQw
        fmpT2H4oGmDvTRrh1tn/T/HyP
X-Received: by 2002:a17:906:af49:: with SMTP id ly9mr8398345ejb.479.1634320088533;
        Fri, 15 Oct 2021 10:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxN8zHTsa2avoK79t+VzDxFG17YeNaDYgRUaBIbvox/PBiiKKv/pjM+2il7eq6d78TEsKK1A==
X-Received: by 2002:a17:906:af49:: with SMTP id ly9mr8398318ejb.479.1634320088336;
        Fri, 15 Oct 2021 10:48:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id t19sm4729162ejb.115.2021.10.15.10.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 10:48:07 -0700 (PDT)
Message-ID: <163c7948-f41d-986d-871b-9689995ba282@redhat.com>
Date:   Fri, 15 Oct 2021 19:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: replace large kvmalloc allocation with vmalloc
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com
References: <20211015165519.135670-1-pbonzini@redhat.com>
 <YWm6KcNvaHDMhfsG@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWm6KcNvaHDMhfsG@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/21 19:28, Sean Christopherson wrote:
>>   	for (i = 0; i < KVM_PAGE_TRACK_MAX; i++) {
>>   		slot->arch.gfn_track[i] =
>> -			kvcalloc(npages, sizeof(*slot->arch.gfn_track[i]),
>> -				 GFP_KERNEL_ACCOUNT);
>> +			vcalloc(npages, sizeof(*slot->arch.gfn_track[i]));
> This loses the memcg accounting, which is somewhat important for the theoretical
> 4MiB allocations:-)

True, and in fact 4 MiB is not so theoretical.

> Maybe split out the introduction of vcalloc() to a separate patch (or two) and
> introduce additional helpers to allow passing in gfp_t to e.g. __vzalloc()?

Yes, this is what actually slowed me down this week.This is the bare 
minimum that I can send to Linus right now to avoid the WARN.

I have patches to clean all of this up, but they will have to go throw 
Andrew Morton; he will decide whether to throw them in 5.15 or go 
through stable, but anyway 5.16.1 or .2 should have the accounting back 
at most.

Paolo

