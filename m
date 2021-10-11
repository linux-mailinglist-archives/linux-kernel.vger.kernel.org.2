Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F274294B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJKQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhJKQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633970664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5eQ2fdMZRopXBrJf5sFBVPsk6Ix/lYtLMtjFnBm+68=;
        b=KZUYjgjYEPFEq2CLQxRc5Q7lPEbPCfDEh/N4tcEr7Y7IVHgHozWwAWEERgClDkXo1FFG1o
        zNeZM1u1XBb9I25+2AOsMH9X7543gf+oZgLt84dNAzzld3+KTSC8ArqgKgfVY2qMdO30lI
        QtsgSPXNYVZgfAjPsI9TmJVoyFM5Pgw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-P_y-ET_2PCywWOHHW-VdTg-1; Mon, 11 Oct 2021 12:44:23 -0400
X-MC-Unique: P_y-ET_2PCywWOHHW-VdTg-1
Received: by mail-wr1-f71.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso13711274wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5eQ2fdMZRopXBrJf5sFBVPsk6Ix/lYtLMtjFnBm+68=;
        b=hoEek47ID84pFpK6A6gL58M50VyC/hcRc/JuOqhB21FbH2qJXkxJsmHPWapRP/EQ3I
         bUozGf1wRMLfmhA974+vqaUcvpyUHesYkJeZAELoKB89tmViwMaxNxDmCeAcDggxHSDl
         omR5w2023yqq6GT7jQLSMUJPQu6RatkkkRp8WuXzshYVUq/gBC6B6P/7jZJEKb83ymZt
         3P8pIkBGD3MX5SAOO9f85SFz6CVE6KEeoCt5cLfWaVB19BKLemF2JZbM3JTA272Q3GDo
         nDKP2bWUydokfJYWza5ZuIaN+8wi6olSdxSHwhWuTeri6kpMqOtvRI3SiLBBVYWL10Um
         dM5A==
X-Gm-Message-State: AOAM533BT6S1QclHbXPIvGkNaWpS7I9eiFWWucd6/Dp1zS1zq+3QaT6Y
        dOiGmQiVujj6gbtxHtV3xl8RM83+StQxq5prAqazPBC2x1n4GvEvUSTEP6PkgbeVVXS7lfr6Au7
        uB35zQNbytHpuGNNZuCGSHMNI
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr5572wmg.129.1633970661891;
        Mon, 11 Oct 2021 09:44:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkNV6u5+zpDaiAm71jlzVLgMlxlreNuF/u2+P+xbwTXuHkkQCV+OrxvNWndTmUCXbtqs4IEw==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr5550wmg.129.1633970661692;
        Mon, 11 Oct 2021 09:44:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id w8sm5647263wrr.47.2021.10.11.09.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 09:44:20 -0700 (PDT)
Message-ID: <a2142175-c0f3-c511-4a55-ad22fb732af0@redhat.com>
Date:   Mon, 11 Oct 2021 18:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 3/4] KVM: nVMX: Track whether changes in L0 require MSR
 bitmap for L2 to be rebuilt
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20211004161029.641155-1-vkuznets@redhat.com>
 <20211004161029.641155-4-vkuznets@redhat.com> <YWDaOf/10znebx5S@google.com>
 <87zgrfzj9k.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87zgrfzj9k.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 17:13, Vitaly Kuznetsov wrote:
>>
>> The changelog kind of covers that, but those details will be completely lost to
>> readers of the code.
> Would it help if we rename 'msr_bitmap_changed' to something?

Yeah, what about 'msr_bitmap_force_recalc'?

Paolo

