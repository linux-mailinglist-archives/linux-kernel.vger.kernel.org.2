Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629D83648B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhDSQ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhDSQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618851558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2yCOAsF2W6pdJQCZiN/BRe+VSsYLOg75hHhxWgADKE=;
        b=ePjpX/PSMNeP6PGla92WIXacnpI4A26dnhB5Mbu/sx42ftNQWHxCqHDvPmueoPq1Ubn+NN
        zSkf2gGc4j/UPH5z8RHl7mGvIs0fAfeWCb6VWDID+sHTdImOTwBLbvDOTWLfwdWTuJoxSH
        Zi7n2VGu2HHHMNdVNDRkRG8TfSdilvM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-ucPL4DFtPyGqS_oSu1bGFw-1; Mon, 19 Apr 2021 12:59:16 -0400
X-MC-Unique: ucPL4DFtPyGqS_oSu1bGFw-1
Received: by mail-ed1-f70.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso11513878edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2yCOAsF2W6pdJQCZiN/BRe+VSsYLOg75hHhxWgADKE=;
        b=CY5GihruIQuNQxq8WWbwdieOpQ6Sr65oGOutv6NpKgtM35YffnEvZ2ZuzEBKMGpY2A
         UREWlsgLJ6SyeHp2On3zgydFM5jcgmAFR65T37kmV+1nTQLharzlX36fn2Q9uJrLj6LX
         sLzxvPaO0YT/73/0O5t3KUjNWiQ7oWAm/+oJavs0xMEOo8PcnfIZpRnDxtEyPtzj8s20
         hifgW/wOLmRddAEB/NC9MKmOpelgNXc9MVGjTEg6cQE/Pb53FnMl9j2xclhLr5GfjNbW
         MzB+GMwxumpPDXwZogAf/bJFhb4pHcrSGa42hR/ckhxwup34i+wHHSfEl3I8dpT/wi13
         8FcQ==
X-Gm-Message-State: AOAM530ks2WYMd68T6SpXA3cTs67H7bPuRDEmvgyG8Cd4tOjBCCjg9VV
        /6NO+ZN8QsXmnRWOKmkcEnoZjn/Tmeg6U5uPjUtI8gUfByA+p7JJQq3x8weEzl8qMKMwLfX/khp
        C5Ea2k2szI//zxQuBm0Qs+5r2
X-Received: by 2002:aa7:d284:: with SMTP id w4mr19343356edq.40.1618851555826;
        Mon, 19 Apr 2021 09:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyFchJESgw+7UFFi7gMjT2GXURWU1V3gPdrMAkm5hmsQSjuAtxEZt7cFqUHIrt8QbpCDwW0g==
X-Received: by 2002:aa7:d284:: with SMTP id w4mr19343332edq.40.1618851555663;
        Mon, 19 Apr 2021 09:59:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n15sm4006185eje.118.2021.04.19.09.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 09:59:15 -0700 (PDT)
Subject: Re: [PATCH] KVM: Boost vCPU candidiate in user mode which is
 delivering interrupt
To:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1618542490-14756-1-git-send-email-wanpengli@tencent.com>
 <9c49c6ff-d896-e6a5-c051-b6707f6ec58a@redhat.com>
 <CANRm+Cy-xmDRQoUfOYm+GGvWiS+qC_sBjyZmcLykbKqTF2YDxQ@mail.gmail.com>
 <YH2wnl05UBqVhcHr@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1909fa3-61f3-de6b-1aa1-8bc36285e1e4@redhat.com>
Date:   Mon, 19 Apr 2021 18:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YH2wnl05UBqVhcHr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/21 18:32, Sean Christopherson wrote:
> If false positives are a big concern, what about adding another pass to the loop
> and only yielding to usermode vCPUs with interrupts in the second full pass?
> I.e. give vCPUs that are already in kernel mode priority, and only yield to
> handle an interrupt if there are no vCPUs in kernel mode.
> 
> kvm_arch_dy_runnable() pulls in pv_unhalted, which seems like a good thing.

pv_unhalted won't help if you're waiting for a kernel spinlock though, 
would it?  Doing two passes (or looking for a "best" candidate that 
prefers kernel mode vCPUs to user mode vCPUs waiting for an interrupt) 
seems like the best choice overall.

Paolo

