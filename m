Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C403439A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhJYPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhJYPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635175321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XvEiZf2+PlOP4jQfZDuL7k1/1lBVAKJKfCdxPMRvMw=;
        b=CnwpXNQe/idtrRgtPQgeSRgqoDOBe+e6awH1nrHPpZE+vRcI2aJhFcZrfB/an1dFRb0mOL
        rdxgmMgQFLnMBFutvX6Ms83LM5UmASbkocsgew181xyJys24SUCOvdsOHN6muPA+PAjSmE
        dqWdz4tlSvx+jqVCCtyvS+10Kt8d2Zc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-qDQjy8hJPxqGOVfROb_nyg-1; Mon, 25 Oct 2021 11:21:58 -0400
X-MC-Unique: qDQjy8hJPxqGOVfROb_nyg-1
Received: by mail-ed1-f69.google.com with SMTP id w7-20020a056402268700b003dd46823a18so4372672edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4XvEiZf2+PlOP4jQfZDuL7k1/1lBVAKJKfCdxPMRvMw=;
        b=ZBkqkmc26uskW5Y9L/2y88y6uz4z/A0vM2IzIfErxsGbsw9u2EzAXRPIB95WT/CLXz
         c/TO+rDhlGdjULfLIQiKqYn/DECu+MqcWqyWDH6id60p2KCAiSL4xJHmvBmgwv46L5dd
         RmL5TN7dOGrZUZAqxNRDMtLuvD/L2XaOFj9C1rGYvLgpqNPn25NLM9ri3tVrEMmq5qvg
         1x11dQ5J6LxE9X0gpBp+XS7XbSr+hZZO9YvxYoK0WTttxaiplycbwnT/t214ZMos//SJ
         MENhBWeb9DGM/gc+EHWxaT1v+klrriuBfKn5E6swDVQqdKcpTqsIW42RQnq4BhNk/cSI
         AU+w==
X-Gm-Message-State: AOAM531kJ6bOWWsQNcRF1DKzFYZ9AwLevN5MyBKhsz4d60+ZMtIPjkVI
        eHxzXdSiWz62OrAbpQN3mOSXF4ityeU7AzzqIgGJda2LG6N2w3JJ6BrkEj3K3IBbHKWw49L2x54
        lNl7D/T0mwe8zWf0yufOdVuJr
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr23395539ejd.462.1635175317467;
        Mon, 25 Oct 2021 08:21:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF6LPnRTghCLifJUp2dbPdHn31IcztASGLIuIqGJjD3b3HXwvY7pD47zsSUkWHV1930VgzTA==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr23395507ejd.462.1635175317210;
        Mon, 25 Oct 2021 08:21:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cn2sm2671320edb.83.2021.10.25.08.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:21:56 -0700 (PDT)
Message-ID: <674bc620-f013-d826-a4d4-00a142755a9e@redhat.com>
Date:   Mon, 25 Oct 2021 17:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] KVM: x86: APICv cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211022004927.1448382-1-seanjc@google.com>
 <23d9b009-2b48-d93c-3c24-711c4757ca1b@redhat.com>
 <9c159d2f23dc3957a2fda0301b25fca67aa21b30.camel@redhat.com>
 <b931906f-b38e-1cb5-c797-65ef82c8b262@redhat.com>
 <YXbAxkf1W37m9eZp@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXbAxkf1W37m9eZp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 16:35, Sean Christopherson wrote:
>> So yeah, I think you're right.
> Yep.  The alternative would be to explicitly check for a pending APICv update.
> I don't have a strong opinion, I dislike both options equally:-)

No, checking for the update is worse and with this example, I can now 
point my finger on why I preferred the VM check even before: because 
even though the page fault path runs in vCPU context and uses a 
vCPU-specific role, overall the page tables are still per-VM.

Therefore it makes sense for the page fault path to synchronize with 
whoever updates the flag and zaps the page, and not with the KVM_REQ_* 
handler of the same vCPU.

(Here goes the usual shameless plug of my lockless programming articles 
on LWN---I think you're old enough to vaguely remember Jerry 
Pournelle---and in particular the first one at 
https://lwn.net/Articles/844224/).

> Want me to type up a v3 comment?

Yes, please do.

Paolo

