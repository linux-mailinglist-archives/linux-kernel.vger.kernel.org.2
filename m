Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143433DBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbhCPR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236422AbhCPR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615917526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JF+/EvZtJVhKD33W6FqDvREuQ9YbTe24q46xCPM6xE=;
        b=Y7y9hSBOjTrMT7ddLN8et8Kl+DLmwK8ezmX459EudpofP+RgQky+NJ9CfrG3puo8lFD+L9
        gNtN4z5zT7gCkhRzhKBUd81jyH6DLskgz4ifG81NHv5MAGnYV18t6FVAgYxvitGeHVVDEQ
        fI4gjHzs6B5d2o1FhSJvMRomK60gRBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-6-h5AlkCNjSj2VfbL_B7bg-1; Tue, 16 Mar 2021 13:58:45 -0400
X-MC-Unique: 6-h5AlkCNjSj2VfbL_B7bg-1
Received: by mail-wm1-f71.google.com with SMTP id z26so9935352wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0JF+/EvZtJVhKD33W6FqDvREuQ9YbTe24q46xCPM6xE=;
        b=suWtER110vkuGzHdCDA6qfOv79LQ5/s9nxtxGSJHdbgSwszbXMpHPWIxajpD+r8300
         OSwdIezf44yUf7djuUrJJxP2hUCKNNgQb8+zSjCVxhQYrz0VZJZibfcjT8pvJUdEAhF6
         6cAEvpqBO4pcmiL2Z+i7B9XUyeGyYmvX3O3Rr2BmG4vSQ/xg02kK4VA4sSwk97jHF6cu
         PmExkxup8BKBnUMuzKxcB2Ebe2Smav7oQoMZ3N823TBMGIlpmdI9k3bgeThURdvURig4
         8r7b0PC6gDBuwGMbGvRsk1lfJ4zW7u8R1c01bXOT5bfD7SfT0m2fGMpliO1mmykXfjTx
         +SfA==
X-Gm-Message-State: AOAM531/KBqFOABL4Kjf91PDyy95mqR/rMW+E3WeOZDFlQ63JsZgmGXU
        UrZgS+fqTesFtU7Q6DN3eTjsemKFDH8t8SeratPiRiGcSbd+aqiLpQ81YwkhnGG+QYk4N08H4cl
        J7gg7yPMfXta4oUGacQbVwtoH
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr81722wml.162.1615917524173;
        Tue, 16 Mar 2021 10:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz8qaQiIOeDTIxZu7wmd1Y+fc2q4azsyR8hIQCQE4eF5SdedLniWyjPV6zPBLTn4HqoZPj4w==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr81708wml.162.1615917524031;
        Tue, 16 Mar 2021 10:58:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j26sm22582822wrh.57.2021.03.16.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 10:58:43 -0700 (PDT)
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Sean Christopherson <seanjc@google.com>,
        Nathan Tempelman <natet@google.com>
Cc:     Thomas Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Rutherford <srutherford@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
References: <20210224085915.28751-1-natet@google.com>
 <YDaOw48Ug7Tgr+M6@google.com>
 <CAKiEG5qtTbm8dtE3pZDy_rfSfTfvhCYhDCh2DD-uh2w6xZnvcQ@mail.gmail.com>
 <YFDwU3CC/DgRo6Vk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df2e2cd9-18d5-f35e-6c05-5ba0c399ccbe@redhat.com>
Date:   Tue, 16 Mar 2021 18:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFDwU3CC/DgRo6Vk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/21 18:52, Sean Christopherson wrote:
>> I don't
>> know that holding the fd instead of the kvm makes that much better though,
>> are there advantages to that I'm not seeing?
> If there's no kvm pointer, it's much more difficult for someone to do the wrong
> thing, and any such shenanigans stick out like a sore thumb in patches, which
> makes reviewing future changes easier.

On the other hand holding the fd open complicates the code, reference 
counting rules are already hard enough.

I think we only need a replacement for "mirror", what about "dependent"? 
  "is_dependent_enc_context" seems clear enough.

Paolo

