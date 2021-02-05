Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED331068D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBEIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:21:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231654AbhBEIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612513209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Uv+kUPnBdvnVYh3bEPMtMV4L9Cn+q9TAxrYe42PIQs=;
        b=chp6LRzcWiT1u3vQwwWxi4DJZIGoGll0CIb59qkgi9RgTlzYRRmulaaphDT4EPxQkJ0in+
        TvEvZmda+WZJKbpDZkqG/GrincxAomE8+Y4USMkatibbweqf0yS5gRKRsVb3n5FWqHwLAx
        xnnMOflDkfY5ithlo7EjvIDok3WvSIc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-5590w6QrPFWW14-VX9WkjQ-1; Fri, 05 Feb 2021 03:20:08 -0500
X-MC-Unique: 5590w6QrPFWW14-VX9WkjQ-1
Received: by mail-ej1-f71.google.com with SMTP id jg11so6303534ejc.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Uv+kUPnBdvnVYh3bEPMtMV4L9Cn+q9TAxrYe42PIQs=;
        b=XI7TVkw7rCKwD6pcyxaw/afqNcrq4LTEEucYM2jbgeEy7pLgj6YwA0CG9TiHG/6MOL
         iJ+j4STmfWa3En2DXE0s4D366DGvVbUmIJJHqbf5S5Mm9knZLCZELIgaZ1ocDyNyzOR/
         QirCmzTCw/w1xnIkSYX+t0XLlawS/tmMA+V9ohjhi/GGoC/D7QTyNABS/Qx7TvjnlP21
         sHWuqFL8aJgyl0pem9NCiltJHiKNEYGs+kYG002J44P6riah6W3R2QqJa+v0s8hH1Emy
         ioRE+3mu2k11kmRX1FKqchtNoi1DMHyRtWsvtcVkqPSwUbkk6fst+KDF1q++CyQkCi9B
         iTtA==
X-Gm-Message-State: AOAM530WBLxEzUtisfpEojbuAIJhCDODqyBI3O1v2nJJYL6XLWtSszTZ
        jybWE3ekANDYTn6N+T81qCMLaSNKYNM2lPbFxY8svrLbvQ+diPKxk9dAP/Yr3lTb17AlvkFk5SH
        B7jOhnwe1mu5PZApVDK3eZu9Jcprw9t4oK2ksrKU3XfMhZ/qgxyp7nyf08HtUJNoI8A+5Q/mEvJ
        jR
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr2939197ejb.533.1612513206412;
        Fri, 05 Feb 2021 00:20:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMVVf1obQXHw/e9a7PJpU5nRu5b+AplJxWzLRKwZr5NAsLfILIeAEFVEcgHGFzDYLhTaq6Mw==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr2939165ejb.533.1612513206159;
        Fri, 05 Feb 2021 00:20:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a10sm3642992ejk.75.2021.02.05.00.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 00:20:05 -0800 (PST)
Subject: Re: [PATCH 0/9] KVM: x86: Move common exit handlers to x86.c
To:     Sean Christopherson <seanjc@google.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210205005750.3841462-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4eef9d7-a510-048e-df3d-f2f87ac77c3b@redhat.com>
Date:   Fri, 5 Feb 2021 09:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205005750.3841462-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 01:57, Sean Christopherson wrote:
> Paolo, I based this on kvm/queue under the assumption it can all wait until
> 5.13.  I don't think there's anything urgent here, and the conflicts with
> the stuff in kvm/nested-svm are annoying.  Let me know if you want me to
> rebase anything/all to get something into 5.12, I know 5.12 is a little
> light on x86 changes :-D.

Yes, we can make it wait for 5.13.

I'm thinking also of taking the occasion to split x86.c further.  But I 
think it's better to move the ioctl interfaces out of x86.c, so for the 
purpose of this series it is okay to add more stuff to that file.

Paolo

