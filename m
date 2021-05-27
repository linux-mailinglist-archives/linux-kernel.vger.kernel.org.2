Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA24393093
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhE0OSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235170AbhE0OSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622125033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFRh8Zq0BfhpvEnOLzrG4u+nWlZsKcz3rQE4b2A0A/I=;
        b=dMqS7x97T5vd6gwbby8YQMwVe4SCBL+nCQ40K7RN9raFEhkBFfj5XILHtt1FnobzLXPAVm
        v09gyEKGGJoY6NlAAEQBB/AtyAhTlMQai1DVsUxmhyrGSMd16n0efYZkq2ivSEisyWGTI+
        jJtnIQZJsqwVYrGPecbd4RxMxDBo4Cs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-o5PoYpfSNQmxBQCFZkbsiQ-1; Thu, 27 May 2021 10:17:11 -0400
X-MC-Unique: o5PoYpfSNQmxBQCFZkbsiQ-1
Received: by mail-ed1-f71.google.com with SMTP id q18-20020a50cc920000b029038cf491864cso383274edi.14
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFRh8Zq0BfhpvEnOLzrG4u+nWlZsKcz3rQE4b2A0A/I=;
        b=iNHmuvZr+wHUyEkayeHFmtz49n3qIgWIGJQ/xEI8SuiliwLYaeWMKneFfNEuUk77t2
         5HpG3SbP3rIr99MZ5bcCId6NXg8cB+i3qMJyu9APpSVl8w2b0ytql1nsKN03AFvD1F4I
         QLo+tJffJLDjm0m8kBEm/SDJboTT4c+8pYXE4jsGpcBjIdqWnJFGz5I1UUDqQMBm93kR
         iKsN2RGc096P8DcZCuVf2k+KQnwhNwrFKR9qp+2XXqXr90mYhLxp7D9t278ZxGk+AYqz
         9ssWs1HWWSHS43sJILRsRRtKucRqTe0GIFpb+rJU/TZjODp1ZMp9oG33c9tlSaXyR3TE
         qTvw==
X-Gm-Message-State: AOAM530Ypwd51DzZBCPQfshvTRHIJ4mg3tMbYpD6bOnor0h+5b+RKVO8
        RI0r1XKT8/OVu/FuvIDbbkeSTvbd3HeXVjQLlgn4LRSa7LJ6qJDhezQAsoBmgR1WgRz+g1JtdpR
        fDBQLstHeHze1zR5XSN+kSm5J
X-Received: by 2002:a17:906:854e:: with SMTP id h14mr3961594ejy.455.1622125030527;
        Thu, 27 May 2021 07:17:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSne7h0iO5WP+6HwZkcfRo6UFiyx8CquwEp6qtnZn5m/q38GOGPj/uq/PWB2psw697hNrogQ==
X-Received: by 2002:a17:906:854e:: with SMTP id h14mr3961565ejy.455.1622125030207;
        Thu, 27 May 2021 07:17:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k14sm1176846eds.0.2021.05.27.07.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 07:17:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] KVM: nVMX: Fixes for nested state migration when
 eVMCS is in use
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210517135054.1914802-1-vkuznets@redhat.com>
 <ea9a392d018ced61478482763f7a59472110104c.camel@redhat.com>
 <8735uc713d.fsf@vitty.brq.redhat.com>
 <5a6314ff3c7b9cc8e6bdf452008ad1b264c95608.camel@redhat.com>
 <87a6og7ghb.fsf@vitty.brq.redhat.com>
 <3b76c3da7af87c576862fa6a538505fe89a47702.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7539613-2a25-bcdb-cfe2-c57c6c0da39f@redhat.com>
Date:   Thu, 27 May 2021 16:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3b76c3da7af87c576862fa6a538505fe89a47702.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/21 16:11, Maxim Levitsky wrote:
>> Using 'nested_run_pending=1' perhaps? Or, we can get back to 'vm_bugged'
>> idea and kill the guest immediately if something forces such an exit.
> Exactly, this is my idea. Set the nested_run_pending=1 always after the migration
> It shoudn't cause any issues and it would avoid cases like that.
> 
> That variable can then be renamed too to something like 'nested_vmexit_not_allowed'
> or something like that.
> 
> Paolo, what do you think?

(If it works :)) that's clever.  It can even be set unconditionally on 
the save side and would even work for new->old migration.

Paolo

