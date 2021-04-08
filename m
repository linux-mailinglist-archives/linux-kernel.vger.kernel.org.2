Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD83589C7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhDHQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhDHQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617899413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4lfbTcUn40NhH6SPLDopboHGBG7ClEKdMUOAOGm9X8=;
        b=gmpl9r5fP6KDON19H1eOB32TXMg8VGifHY50XqNX1YAqhF4zUNyxV/rTgCSEvbWhBaIoj9
        I43ANVPi898YjO1VW0aoR1lkBQjscc53jPQjbp6RNbB8ntdgRUrwJVkMOKuz5BSNltYLHo
        hD2Z+PX0pVZH2jmDw7q7M6AgPb6x/HQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-67Xrb3LUNQWn5raheY3g_A-1; Thu, 08 Apr 2021 12:30:12 -0400
X-MC-Unique: 67Xrb3LUNQWn5raheY3g_A-1
Received: by mail-ed1-f71.google.com with SMTP id dj13so1285696edb.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O4lfbTcUn40NhH6SPLDopboHGBG7ClEKdMUOAOGm9X8=;
        b=FewGeHNu+oLrvqNdkNR+PBRGXvpzknqmRdlGKkVGDDlAFiYdqhupvekRtWSXsImDPl
         feOtIIISjjGER9USxNiRyCZ0Oktj669tiPOaDOxrH3VOJvVl1MXWjFqZ6uvnEBhm2smy
         ISSThxfF2IHLgDAIpB0DO7piOeSf0jlrUb9frFU6gBBSpnHiSvAufkbBNr0QKijDiA1+
         sZRbNmOTWfHN9XKTzyBWqLeY4bQKXFEE4pSb66Gk29KKsoCe3pHZm2BDaiNeLH7TmwjM
         tBKpsVP7Z1bw0W0atSojWeZIU9mQiG4jK4o1eRz5stDbRV5bVN2z6M0q8QAecv6VnPgg
         t7iQ==
X-Gm-Message-State: AOAM530qFjNnowygYCHLlbW1medDGiNHUioaKeWZ0vcc/GV7V519JMId
        zmw2+wmbEPRq4CT2WLR2y3BSNqEzmkExo52AUY756m8P+Jx9LyGU49YhLmcCybfF0vK53lxpNYO
        zTecnP32P+6advCTjLtXi9p00
X-Received: by 2002:aa7:c351:: with SMTP id j17mr9839701edr.199.1617899411099;
        Thu, 08 Apr 2021 09:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTDwqV/P6EhYvUAHlyr3YimJfoVAFKZLgaFq2or2LlrGXaxuLi7ZwvU1MKde2NCQ9NRw/hzA==
X-Received: by 2002:aa7:c351:: with SMTP id j17mr9839673edr.199.1617899410915;
        Thu, 08 Apr 2021 09:30:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id bx19sm1801808ejc.53.2021.04.08.09.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:30:10 -0700 (PDT)
Subject: Re: [PATCH v2 07/17] KVM: x86/mmu: Check PDPTRs before allocating PAE
 roots
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210305011101.3597423-1-seanjc@google.com>
 <20210305011101.3597423-8-seanjc@google.com>
 <CANRm+CzUAzR+D3BtkYpe71sHf_nmtm_Qmh4neqc=US2ETauqyQ@mail.gmail.com>
 <f6ae3dbb-cfa5-4d8b-26bf-92db6fc9eab1@redhat.com>
 <YG8lzKqL32+JhY0Z@google.com>
 <8b7129ed-0377-7b91-c741-44ac2202081a@redhat.com>
 <YG8u5zv/5+WCYEVT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5663f36-b56d-ce07-872e-d9af3a5b8007@redhat.com>
Date:   Thu, 8 Apr 2021 18:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YG8u5zv/5+WCYEVT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/21 18:27, Sean Christopherson wrote:
> For your approach, can we put the out label after the success path?  Setting
> mmu->root_pgd isn't wrong per se, but doing so might mislead future readers into
> thinking that it's functionally necessary.

Indeed, thanks for the speedy review.  I'll get it queued tomorrow.

Paolo

