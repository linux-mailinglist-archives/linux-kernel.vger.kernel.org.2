Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2555A4045E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhIIHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349701AbhIIHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631170994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUBvw8j4TFsIarEE3fvS4je6Jlh+kiHU2Hz8uuU8quY=;
        b=OMHBICrXOX3Wd5IKXUVlPp9xsXdieMxv9xiTrqDnKWdJQ6yo69nG61tE+NGOUzgzHTAHXt
        PktDFLZ0DXX9AZT9YRETBnwSdF0ssgYt1fQEZWJIv91vWBrHUpctqbbjOrW47hKkiVq1BH
        NH7OU8yDPOOeETnOisouxY0WncUq+Y4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-rq9zq7qsM---_pI0Kw8_xQ-1; Thu, 09 Sep 2021 03:03:13 -0400
X-MC-Unique: rq9zq7qsM---_pI0Kw8_xQ-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so462134wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HUBvw8j4TFsIarEE3fvS4je6Jlh+kiHU2Hz8uuU8quY=;
        b=PqA0xFDVfiqSRQhW1GTLp0nnp6fqIDVFRn8fLLjh4s9Bep4O6aKX5xJMXUiyWVG/sP
         enfubnwbu2kT2CbZWvfEeNgSDsfO4uxs6ZK0kD46hyI5lhC7nb387pUKtE545j8OhE+v
         pFwMCCTwZucGubWBGADUHUm1y3z2PlWnIcvYvoL1zoydsFVBIHBJDIw3rD+F3aMQge0K
         nUtyPQa/l0AUnM4nxrQFMaT2vU0ZRb6cEtLHNL8o4PeLPGHT5XqWxmaNeJBgwf8CPGyJ
         /3KIdHlYYBVAIX+PLVBHD9xDLNqh/LMRJdtzcuiNO1fC9O29gLWLrkQRcWEW+2fxBHFp
         SQHw==
X-Gm-Message-State: AOAM5314Vd6bUm0C//Cet4Uv3qSC4fwvQ+2hPTO9qLQt/AVHr+5crALJ
        K1WrqT9DeFrW1O50FmdyK3/8NRnd45lgJHKbu2skTnxGz8HURDs23hHo2fBUJvKFJj+o5KVSYBX
        uCWU2GVwucHEauPa0tyrLJj+mOyhywEJZpgdZ0LIBn+XiPOZ1/DjryOqRj555qabinEugRmzucx
        En
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1273454wmk.51.1631170992002;
        Thu, 09 Sep 2021 00:03:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5z30hb9JghYpVAxn6JQxbFF6EQTeK8au3fTsIagXnuaKAVmndHuei2cK1lD1nFMAodiZ0bg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1273436wmk.51.1631170991804;
        Thu, 09 Sep 2021 00:03:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l1sm266046wmq.8.2021.09.09.00.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:03:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Filter out all unsupported controls when
 eVMCS was activated
In-Reply-To: <YTkwvrMl7SSCtQF7@google.com>
References: <20210907163530.110066-1-vkuznets@redhat.com>
 <YTkwvrMl7SSCtQF7@google.com>
Date:   Thu, 09 Sep 2021 09:03:10 +0200
Message-ID: <87v93a2pu9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 07, 2021, Vitaly Kuznetsov wrote:
>> Let's be bold this time and instead of playing whack-a-mole just filter out
>> all unsupported controls from VMX MSRs.
>
> Out of curiosity, why didn't we do this from the get-go?

We actually did, the initial implementation (57b119da3594f) was
filtering out everything but then things changed in "only clear controls
which are known to cause issues" (31de3d2500e4). I forgot everything
already but was able to google this suggestion from Paolo:

https://www.lkml.org/lkml/2020/1/22/1108

so finally we've settled on a shortened list. Now as new Windows version
is out, we have new problems to solve)

-- 
Vitaly

