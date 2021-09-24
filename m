Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AE417822
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347291AbhIXQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347280AbhIXQE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632499404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeGa7zotF4OBKhVPjQPzs576lzN05jpN0HE3AwYSyTE=;
        b=QyOYGWr5s2Dbs2XFAPfsnTPhwfVFOuobAVW1KqgNfOuRf/aFaH7/OdxtGbs5NGt9Y1q2Qk
        9p3PIjvSSaOIbJm978EJ36y+55X5jRYL1YRHQm0uROWj4CF2XIVQAnOm6DVKHHKIAqsRqT
        fX90rI37vxW5wggIDNzX8YX6k2HZoXY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-60yi4tr7PJ6yC653W8wqMw-1; Fri, 24 Sep 2021 12:03:22 -0400
X-MC-Unique: 60yi4tr7PJ6yC653W8wqMw-1
Received: by mail-wr1-f69.google.com with SMTP id s13-20020adfeccd000000b00160531902f4so776419wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 09:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jeGa7zotF4OBKhVPjQPzs576lzN05jpN0HE3AwYSyTE=;
        b=Iw7oj1gwSmZULDUN2OMEqTSggaVkzxmItPFnbqw9VPGUFnBHUTCUpOfjRzGs3NfYsv
         dpr07K4loFl+FxfUEqdq4YyBwyl9MZlVATyVcJwY08oad3kpGxAVAimMNdNhYakb1cfF
         yz5s8kagklTKiJVnl3b02MHkoIEhmxYu+T/OrMWL1YkWxBR06sr8QAM8t3qtoVTREu2n
         MidIoWB2zMFGDFh8pPTPhQCBcND8FYMc3YXCIKpDMGEraVJxnrueHiVKsHmpeTxJ304G
         b2FWXuROES8WaUGwiN9/RZbcjWurNbXI8nIq5M3ZZcfRa8t/R9DuZRZoiuM6DBOkpPmr
         7Fyw==
X-Gm-Message-State: AOAM530zlVpaGhjq1yO5ShWy/WHckGTwljvyIA7uj/gP9ClrfWW4H/3s
        hfcBxsh03nM8AKnfYU87aBl2zz54HrpWMm60W8Id0IHVYyC4/v+poZxydtHGcfQMOgVSZyHnvRy
        NPLPNtohg/QeMbGhvm4Pdddtb
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr2940280wmh.18.1632499399036;
        Fri, 24 Sep 2021 09:03:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkSPlm4nXNmNz4MsL6i3ikKj/hofQJin1xv9Xzc76Hd6wkVSQwj2Rc48aOebkRJV2Rd5NdvQ==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr2939823wmh.18.1632499394926;
        Fri, 24 Sep 2021 09:03:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k19sm8546808wmr.21.2021.09.24.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 09:03:14 -0700 (PDT)
Message-ID: <bfa9b495-dfe9-df5e-714c-12fd8dbe4fb5@redhat.com>
Date:   Fri, 24 Sep 2021 18:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH V2 03/10] KVM: Remove tlbs_dirty
Content-Language: en-US
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org
References: <20210918005636.3675-1-jiangshanlai@gmail.com>
 <20210918005636.3675-4-jiangshanlai@gmail.com>
 <8dfdae11-7c51-530d-5c0d-83f778fa1e14@redhat.com>
 <8833ef9b-3156-7272-4171-66c4749145ab@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <8833ef9b-3156-7272-4171-66c4749145ab@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/21 17:40, Lai Jiangshan wrote:
> 
> 
> On 2021/9/23 23:23, Paolo Bonzini wrote:
>> On 18/09/21 02:56, Lai Jiangshan wrote:
> 
>>
>> Queued up to here for 5.15, thanks!
>>
>> Paolo
> 
> Any comments on other commits?

Queued now for 5.16. :)

More precisely this is what I have queued from you for 5.16 only:

       KVM: X86: Don't flush current tlb on shadow page modification
       KVM: X86: Remove kvm_mmu_flush_or_zap()
       KVM: X86: Change kvm_sync_page() to return true when remote flush is needed
       KVM: X86: Zap the invalid list after remote tlb flushing
       KVM: X86: Remove FNAME(update_pte)
       KVM: X86: Don't unsync pagetables when speculative
       KVM: X86: Don't check unsync if the original spte is writible
       KVM: X86: Move PTE present check from loop body to __shadow_walk_next()

Paolo

