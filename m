Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83F3793F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhEJQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231636AbhEJQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620664425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qdODaN2OuNSEexqz+L9Iw9HnmwvY9206zRfzY1Y1re8=;
        b=ivxFj92DB3jzHJxbgU/64WrZI171SXPBOQ4D3QY+JG3BrlXk5z1nN23CsqdAEBks94IV1h
        y6dhrDnZgsUn0QBNXsnW6N23iYIS1VuiyTmsXI9yuIo/mwnDb3TiosxIwC2fyllUnZ+TZM
        egxiFbstvEOqyFsDg11UQ4eo6yJsbrs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-TxqCBTqPOb-jNX-tJcEiuw-1; Mon, 10 May 2021 12:33:41 -0400
X-MC-Unique: TxqCBTqPOb-jNX-tJcEiuw-1
Received: by mail-wr1-f72.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso7686081wrf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qdODaN2OuNSEexqz+L9Iw9HnmwvY9206zRfzY1Y1re8=;
        b=MuTHFXaZ9OgksV5wHxMYZf/EYJrOBFsCWTgiO6SMEu93tVIUuctLCzmBPBMvwTLjw/
         1hkYsNjZtjnRGaTiCn1+AWr72pMa0BKemUmFt4kvqgQE7ylIP8REnvXxVs0U9R22N0lE
         G1b/+Pyzo3a3JDpOv9XnVhsb4h8cpOkP/iE5EpH0/2wMEOG3ZACuU0NO77QQcWWUCovg
         mg1Cfc0lyS82iNZfs6xuL9/go1YJfvPwhBtjHuWOg3bdeRlClteZ4wrfmlDmJwNXNAxi
         aNHLhbjeg5+fHI27ISbb3ZyHQBXuUNt+rxaPNuiBcuWt3804LbkpCEM9eUUHPf+bdDqg
         JDAw==
X-Gm-Message-State: AOAM530zf9exHlDkyyQYe/G6ncxGlkEx5oyp+6ql+Il+Rex35yjKiD1F
        y3J+DGlqhK/1y+l0FrmXhhr3pttAh0KwuPCBSWUBV7SnBMPtDoR6nruqGzgecvI0Z0SKbFF+ClJ
        HGFC2FeDYStdLcP1enc349LEl
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr31236156wrs.185.1620664420466;
        Mon, 10 May 2021 09:33:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEuMcVvwepkIW8kBENdv7Ek4C4HWRYfJRgWlPpdHVtYoJM2zVP457NBhPvPMR/41vsF70XQA==
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr31236133wrs.185.1620664420237;
        Mon, 10 May 2021 09:33:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c15sm2310454wml.38.2021.05.10.09.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 09:33:39 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] KVM: x86/mmu: Add a field to control memslot rmap
 allocation
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20210506184241.618958-1-bgardon@google.com>
 <20210506184241.618958-6-bgardon@google.com>
 <CANgfPd-eJsHRYARTa0tm4EUVQyXvdQxGQfGfj=qLi5vkLTG6pw@mail.gmail.com>
 <a12eaa7e-f422-d8f4-e024-492aa038a398@redhat.com>
 <CANgfPd8BNtsSwujZnk9GAfP8Xmjy7B3yHdTOnh45wbmNU_yOQw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03e66630-b967-b91c-b74e-6944bdcaf2d7@redhat.com>
Date:   Mon, 10 May 2021 18:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd8BNtsSwujZnk9GAfP8Xmjy7B3yHdTOnh45wbmNU_yOQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/21 18:14, Ben Gardon wrote:
>> Possibly stupid (or at least lazy) question: why can't it be a "normal"
>> static inline function?
> That was my initial approach (hence the leftover inline) but I got
> some warnings about a forward declaration of struct kvm because
> arch/x86/include/asm/kvm_host.h doesn't include virt/kvm/kvm_host.h.
> Maybe there's a way to fix that, but I didn't want to mess with it.
> 

Let's just use the field directly.

Paolo

