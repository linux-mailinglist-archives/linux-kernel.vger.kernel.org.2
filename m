Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FFB31EF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhBRS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232491AbhBRRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613668094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnXL5td/rfCWV/9goF4hFIOXRkwcCqyl6Ts3in+Jf7k=;
        b=U/2ZnvWc1pNzbVmpslPxbqHhe98t7LjHAmzqc+VPEJ+V/DdRurUeO8RxAuN0K6dZTXwx84
        Z9YsTeu8hVJHXkH2XBlSJsxPuQ/saTn7MNafOvnP1gdiFFygIncTm+kPNhJJI2eRcMh+V5
        oFNOa0tB4gpYgh5B8HeM0dVJgJK7f/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-nI5z_7JdMku6SuP_M84x5Q-1; Thu, 18 Feb 2021 12:08:12 -0500
X-MC-Unique: nI5z_7JdMku6SuP_M84x5Q-1
Received: by mail-wm1-f70.google.com with SMTP id b201so1440459wmb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DnXL5td/rfCWV/9goF4hFIOXRkwcCqyl6Ts3in+Jf7k=;
        b=JX76JF4Og2YWB8c6fwboyZaUOg6/aBX/DCuMqhyzHpYyYwYrc5npRi4qqpLs9JHW3I
         1ECXn+zvGrzdM1/hO9gKUYk9jPsaaHf9q7ZHYVmE7RgEgAz7n1OWksjWOLqYYKaEfbDo
         j1B/mle1NvNIl5B2erhMM0qOt7yLql6iB7YM/sh95IYMjNRzMt6IiOgqVmrAVgAs2rYq
         RbzMsQw/a8UcDSJgpCt9Z4d35lCAFPyPAr7E/HJCFnzLuWmphipdZWEqqd+WUz0s8eN8
         B08FSFvTVknEQJ+XuvfEk/bf1xap85mAMIzHAfsDSFAwotPyZsSfLD5T2xVJxRJ91Z74
         N+LA==
X-Gm-Message-State: AOAM53258a4GkiGNENHuWWLglZfOIwTQFMJjtMoxQy5fDGIxK/Fq6XtP
        nBaP1Y8LqJhPJ8dLGXC/k8oZz7FgsiUQpOQ6AxGT1QD3gUK6BH4apxj4Zx0itQ/TOy/5TfV/2mo
        2vO8rR0UoFWa10GQGhPnIp/us
X-Received: by 2002:a05:6000:c1:: with SMTP id q1mr5409270wrx.114.1613668091035;
        Thu, 18 Feb 2021 09:08:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW7QsKV+sfG8pky5kvnopuPoDLVp/kO709Ty1mNrxU68YKizV3qyUWGG66EB9VKJl7wZFfOw==
X-Received: by 2002:a05:6000:c1:: with SMTP id q1mr5409238wrx.114.1613668090810;
        Thu, 18 Feb 2021 09:08:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r7sm8232164wmh.38.2021.02.18.09.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:08:10 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210213005015.1651772-1-seanjc@google.com>
 <20210213005015.1651772-13-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/14] KVM: x86/mmu: Don't set dirty bits when disabling
 dirty logging w/ PML
Message-ID: <9293da48-8bad-0b70-4548-3df7931b6bee@redhat.com>
Date:   Thu, 18 Feb 2021 18:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210213005015.1651772-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 01:50, Sean Christopherson wrote:
> This means that spurious PML entries will be created for memslots with 
> dirty logging disabled if at least one other memslot has dirty logging 
> enabled, but for all known use cases, dirty logging is a global VMM 
> control.

This is not true.  For example QEMU uses dirty logging to track changes 
to the framebuffer.

However, what you're saying below is true: after a MR_CREATE there will 
be no shadow pages, and when they are created with mmu_set_spte they 
will not have the dirty bits set.  So there's really no change here for 
the case of only some memslots having dirty logging enabled.  Queued 12 
and 13 as well then!

Paolo

> Furthermore, spurious PML entries are already possible since 
> dirty bits are set only when a dirty logging is turned off, i.e. 
> memslots that are never dirty logged will have dirty bits cleared.

