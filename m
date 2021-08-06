Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F253E2A33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbhHFL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbhHFL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628251084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsFUm2Fex09UP/JQJ5oBYUs9L6S3a0XW+Bgd7Je/qd4=;
        b=jACuhYfxkKpvtW1oBoy4GeWbeXBO++3To//qIz6KlPgn2sw9qnd2qolnAo2KmvpV5gm+h+
        iP6tHmGBRKbM5Rg2lyoKustnGQqrqiis4IQnBh92DpYHN03fkiqCQtxZkjkY8teN7ZhV8q
        lj+AonJYEkF4b/yWwDSd5lZ+CEl+bf8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-ULLuJHCqOumihPoL332QdQ-1; Fri, 06 Aug 2021 07:58:03 -0400
X-MC-Unique: ULLuJHCqOumihPoL332QdQ-1
Received: by mail-ed1-f69.google.com with SMTP id dn10-20020a05640222eab02903bd023ea9f6so4776078edb.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsFUm2Fex09UP/JQJ5oBYUs9L6S3a0XW+Bgd7Je/qd4=;
        b=OryVfBfI9XiPcP/ZgxXk+JFGuSEflfgnDUHZvQwzZmKwOzmT2rm+7Fz5/BcfhPgWUl
         B8EcxCYqSMA28ZYlqv5EgHGLsyyfcIPRwu/rBO6/m46DwvFteypaBKWwM7rxCTS3LRQF
         9b+aSkOkjXzXjptM0sRX7JC9spC/KDBfKOUutegTum2nmU9U9VgBAbq9fZ+7iL1HgTL6
         WlJZxBEks/RLM1ERP3r1i0BJfNFU0cgzCH8xz82ZFS1VmGd+g1P5dzLzzyp3P4xZgvnL
         pKvhleEVftJYiYYBJxAJJGeeW+0Ojib+qINXz+hjRXvX3KEeM/b6YSd1Jsx4a8j3r/V3
         Twhw==
X-Gm-Message-State: AOAM5322n7PoYlpiA6zH1bYAT/iIn1ml5BcmOVHwv1OmUT3k1su8qRCk
        dzVFTg//52fB3e05ikQlRiiec8cEQ8+oq8vjDwYOppsOgEWQST77qL9y9jsHVah/sB7vpamOy2D
        gbJHo6ozkJ/9ygJIuhoLUWmM/W++wiP9PHzkK/cg3DzUrhKNmQgOxOmSZ57kFHK7YBC6Up5wXdG
        iX
X-Received: by 2002:a17:907:2595:: with SMTP id ad21mr9166371ejc.430.1628251082398;
        Fri, 06 Aug 2021 04:58:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylY//hOXD/73qc587D65K41qOTA088fVA2wMV+LUzQVJR46b1Vn56ScUwZQ9Yhu1huHNyzmA==
X-Received: by 2002:a17:907:2595:: with SMTP id ad21mr9166352ejc.430.1628251082174;
        Fri, 06 Aug 2021 04:58:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id w23sm3708888edx.34.2021.08.06.04.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 04:58:01 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Allow guest to set EFER.NX=1 on non-PAE 32-bit
 kernels
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210805183804.1221554-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec7165f9-a008-e11d-a7d4-c12503b08434@redhat.com>
Date:   Fri, 6 Aug 2021 13:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805183804.1221554-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/21 20:38, Sean Christopherson wrote:
> Fast forward to today, and KVM has long since stopped running the guest
> with the host's EFER.NX.  Not only does KVM context switch EFER if
> host.EFER.NX=1 && guest.EFER.NX=0, KVM also forces host.EFER.NX=0 &&
> guest.EFER.NX=1 when using shadow paging (to emulate SMEP).  Furthermore,
> the entire motivation for the restriction was made obsolete over a decade
> ago when Intel added dedicated host and guest EFER fields in the VMCS
> (Nehalem timeframe), which reduced the overhead of context switching EFER
> from 400+ cycles (2 * WRMSR + 1 * RDMSR) to a mere ~2 cycles.

Both pretty good points. :)  Queued, thanks.

Paolo

