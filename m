Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0531413953
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhIUSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhIUSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632247113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQSCv/3qlLsI9Nt/RrJNX5Ec9pj4MuIs81DfXtwhpmo=;
        b=YmGy1YPHXCA0kXFY1/yRLfXUT/UpBALR4NDXpS9wgygqzh+MjCxL1LhnHP+uHvb+hApjwQ
        IBMIwICtVy83tK3gPnSKDGVd/wDnV3TFylJPQPRE8bnhOPXdEjphdJ6ibX5plXWb3ZkrkO
        NX5YZEt7uN7OeauRqcNB96p8vEGHljY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-zZLmXU3YPXe1okUqjxXErw-1; Tue, 21 Sep 2021 13:58:32 -0400
X-MC-Unique: zZLmXU3YPXe1okUqjxXErw-1
Received: by mail-wr1-f69.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso8163547wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQSCv/3qlLsI9Nt/RrJNX5Ec9pj4MuIs81DfXtwhpmo=;
        b=ZyrD/lauTRJwxihQpr4prh0WJlddKV9rtx/ZJa5K5bCN1/2qeWP/l/NOMG0Z49aT1b
         p6y6FECAmEjd7spylHUe+oXxaRzd9t6LmyFIeYDcs9bvKKZnQTfG4M/I/+4ShIgF3QT9
         ZmODT/JEFsUiO4KXKVpZzUWPGrD3ecpSjeo+NsZrFvTERovFFe55h10oypDwUKUYFbLd
         +BRsyWX5O32Rv8ci11ixkL9bcd9acSyRQN152yShna7+laG+KfsoueO60nJ5sZbaxvSU
         FFjOV8e+SnYLIWfnCsc0sCsuT+lVIfBrBBJkhiqONEhg6tUWCy3tzrUhcGARsi3nUxoF
         STOQ==
X-Gm-Message-State: AOAM533qHZkgXb0Q7/HBv/6ULeDC7uWB75czjdRA09Yp8IfvSrEy/J0s
        XXTS0xf0fW1AkSZjKoYMhGTxyKcaHbFwMY+3P8IjvhOTN+RjrsawZHeB0j/CKcDDM+LV1nvF5ul
        qF7lRxYn/ijNCiHqCZf+gwUhl
X-Received: by 2002:adf:fd03:: with SMTP id e3mr36783312wrr.46.1632247110864;
        Tue, 21 Sep 2021 10:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCy/iVs4ic4BpLOr6rEVULg59LoAQO//ya4B4K44daOpQG7Cb13ApHTkpMoXqHg+ZapdiohA==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr36783298wrr.46.1632247110681;
        Tue, 21 Sep 2021 10:58:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y11sm13449644wrg.18.2021.09.21.10.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 10:58:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: fix missing sev_decommission in
 sev_receive_start
To:     Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, John Allen <john.allen@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>
References: <20210912181815.3899316-1-mizhang@google.com>
 <YUC/GzN29dWDVCda@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e951cf6b-dac8-776f-1e90-b204712c9618@redhat.com>
Date:   Tue, 21 Sep 2021 19:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUC/GzN29dWDVCda@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/21 17:26, Sean Christopherson wrote:
> With a cleaned up changelog,
> 
> Reviewed-by: Sean Christopherson<seanjc@google.com>
> 

Done and queued, thanks.

Paolo

