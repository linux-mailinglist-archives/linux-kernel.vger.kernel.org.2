Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13EC3DA91F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhG2QbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231878AbhG2Qa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orFog0sxfUadBkEgJaJjuoSWySLaowDikIZVY8CyGTw=;
        b=dspfyz4NrIhmn4vwZf13U/req2N7klc2w6NjrjlDFvhgPo4Xcrt1Ual6Hitn6G5VrUvpNI
        Yx1ZgpH6kxn8J8UMlg6SeOjVjfbuT50yKUrk/QnjNnR1uDmxL6qZjPCpVoqcKoA/U353UG
        ew3vBd4Z5kWA1JZRi7u4cnfPRrhSEwg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-u5e4ZWPTN9GwRUNdtzDZHg-1; Thu, 29 Jul 2021 12:30:53 -0400
X-MC-Unique: u5e4ZWPTN9GwRUNdtzDZHg-1
Received: by mail-wr1-f72.google.com with SMTP id s16-20020adfdb100000b0290140a25efc6dso2421452wri.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=orFog0sxfUadBkEgJaJjuoSWySLaowDikIZVY8CyGTw=;
        b=uPhC9yfuRmPiEzfEeWzQBkGL8nkuypZtfxzkQyuL4NZKtB4Hk5e2hpbAyr03bE3c+f
         ltuKWeajixr6WXeU/M6mZDTapxol5j11Z5UeHTKzBdse9IM2jFP5kVYwnxpzR44M8die
         89y3TH1HAyZY7vtpTEbklyZtw1bt200UCfOVRKhB8vmM0ug45m21qBp4wRLX6Rmdp+is
         UXT47arDzeiOVLe85uyNamYWppJp2F4jUNOEKAQfMNSUSz2WsT3I0m1sleudvhedH6pv
         ClTiOF3fF0/C3OYLp32uSFjvqv/nk8tSX0/pMmcq4XG+98VFR3ypAtu3gg7v1batplVD
         iaUA==
X-Gm-Message-State: AOAM531+Y1d0xi2bnRhMUpCFApMz10Xay76DfN8HHrxJ8dfUeI/gv883
        bdo3iQmTXdnOwDWESaCi/CRO9e/cbTAvSzmbpTZUhH8/hHt5vCfA2A3rFgkWZSVrc6VJTQEQtj5
        2QBN6ryTydDqDMAKqVcUXW9A4
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr5512872wmh.56.1627576252722;
        Thu, 29 Jul 2021 09:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8op0aYdpNBUVNZ07xifizo4nlPJ/0UHrFszSxe4dMu5xaM7/9rONhD05PbI9DYilr5YLi6g==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr5512856wmh.56.1627576252496;
        Thu, 29 Jul 2021 09:30:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g138sm4927501wmg.32.2021.07.29.09.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:30:51 -0700 (PDT)
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210726165843.1441132-1-pbonzini@redhat.com>
 <87zgu76ary.fsf@vitty.brq.redhat.com>
 <1d82501c-05fd-deff-9652-790cde052644@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: SVM: delay svm_vcpu_init_msrpm after svm->vmcb is
 initialized
Message-ID: <38eb919c-2da1-648e-10a4-a76205fd5e96@redhat.com>
Date:   Thu, 29 Jul 2021 18:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d82501c-05fd-deff-9652-790cde052644@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 22:18, Vineeth Pillai wrote:
> 
> On 7/27/2021 11:23 AM, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> Right now, svm_hv_vmcb_dirty_nested_enlightenments has an incorrect
>>> dereference of vmcb->control.reserved_sw before the vmcb is checked
>>> for being non-NULL.  The compiler is usually sinking the dereference
>>> after the check; instead of doing this ourselves in the source,
>>> ensure that svm_hv_vmcb_dirty_nested_enlightenments is only called
>>> with a non-NULL VMCB.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Cc: Vineeth Pillai <viremana@linux.microsoft.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> [Untested for now due to issues with my AMD machine. - Paolo]
> Finally got hold of an AMD machine and tested nested virt: windows on 
> linux on
> windows with the patches applied. Did basic boot and minimal verification.
> 
> Tested-by: Vineeth Pillai <viremana@linux.microsoft.com>

Thanks!  In the meanwhile I had fixed my machine too. :)

Paolo

