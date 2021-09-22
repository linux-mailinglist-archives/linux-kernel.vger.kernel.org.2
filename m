Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C734414B60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhIVOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233321AbhIVOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632319638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ba+E7Owd22l9waSriV+JqQxtDijO6mPBTbt1IbtPw9I=;
        b=gojZt7zjxUfTFP0EHbfRHu2IP5j8+0NNffiIQKN6p7jXpqz29zgh5PuRs0CyhnqAHYnwN4
        Jzjsd3q16hgpEApgu6KaNtgEYWEhVqC9c3paky0Z0JMSQc0lezEe/xfLNpdBrEdXM0XxpF
        nSLzoh0PNFpB0WzediqVUe55pyt/I3k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-zRyZ_oSSNee64P01yhryZg-1; Wed, 22 Sep 2021 10:07:17 -0400
X-MC-Unique: zRyZ_oSSNee64P01yhryZg-1
Received: by mail-ed1-f70.google.com with SMTP id r23-20020a50d697000000b003d824845066so3210045edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ba+E7Owd22l9waSriV+JqQxtDijO6mPBTbt1IbtPw9I=;
        b=Fo/l2D0A2En/liik/r24uRPCCynY6oyrCaUAYoDbo0IJSFJ+aAMhQ9H7p1cxWYtCJh
         Hfrq3Dp7r/TE1Ia4WOlOHyFA5DIEb0eqAjFCOyTx2BW3MQx2XABrC1etZRgL1n6MPaEz
         zcjmMc8Y19bjJZfkQyVzHi1hIws5OAeU0Uw5R95NX2PiC9K/q4MO4O0txGbBBMjllUHE
         IrhhqhS2z4Db12weeDw0GQoIJmj6y06OX0s4RAA4iMHeiiWfwtMYSM13AOg8JA2EH5hh
         YOdoRiHHm7BgvyOKWBcgA8a8CN++ZR1mn5+D0CF6YY0yyqSGXFHYwpunLQiSrd4tkYVn
         CeEQ==
X-Gm-Message-State: AOAM530SqCZQ6r+StuGCTV+KTqMfxOAvghUqm1x2tGqLB53LZGpir0Se
        fXijn3XIUDLf+q/cC1VMDhEfv2tw9Cmhn8D+WXwV55LMQ6WAUH6VshGiTBLk29nxLBuQ0iFLGjk
        rTjGi0z7jG1zXjNah7/KlMhFoQXLp76uAar52AdyizFsP++RUFEnAulZPe2q1xstZIUsLhbbQed
        OO
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr40308245eje.178.1632319636187;
        Wed, 22 Sep 2021 07:07:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6M+rFLfczRLlUYHd+A6h2bnYjANTy7Y9pJTrQqXxB4qcEgTjq8X+c/eA49sJeu54GxPp7lQ==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr40308213eje.178.1632319635878;
        Wed, 22 Sep 2021 07:07:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x7sm1263870ede.86.2021.09.22.07.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 07:07:15 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Filter out all unsupported controls when eVMCS
 was activated
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20210907163530.110066-1-vkuznets@redhat.com>
 <YTkwvrMl7SSCtQF7@google.com> <87v93a2pu9.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e97f33c-e4d4-5669-c642-a904c9e22a8d@redhat.com>
Date:   Wed, 22 Sep 2021 16:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87v93a2pu9.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/21 09:03, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
>> On Tue, Sep 07, 2021, Vitaly Kuznetsov wrote:
>>> Let's be bold this time and instead of playing whack-a-mole just filter out
>>> all unsupported controls from VMX MSRs.
>>
>> Out of curiosity, why didn't we do this from the get-go?
> 
> We actually did, the initial implementation (57b119da3594f) was
> filtering out everything but then things changed in "only clear controls
> which are known to cause issues" (31de3d2500e4). I forgot everything
> already but was able to google this suggestion from Paolo:
> 
> https://www.lkml.org/lkml/2020/1/22/1108

The doubt was whether userspaces could be enabling eVMCS blindly, and 
thus would lose features for Linux guests.

Paolo

