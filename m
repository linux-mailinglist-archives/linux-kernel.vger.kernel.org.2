Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15EC386C21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbhEQVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhEQVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:20:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB63C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:19:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso361673pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IiCjvzkKhIVpXfcqTma6XBTadoGCsobxQeAd+7dQ/rc=;
        b=EUNJGMY3jn/+w09Csc6utD9z60HC+TthiEUoAHeVLA1iMWtEcRRg64d+U4mdvbCh/x
         45P3zw1blfCY/UQ/rVNJAsfra5gBFTDT7Eh1eVy4TXOOzkf+yYHHP0BfdOHBEXQV6YIh
         PY0Pj/H3mL9jDs7Xw1MXnDHrSsomo8UehMmi0VBuPK4O7+39IrX3mSz6ZUzQCusaOa7M
         QBnkz34ifDw+1lIZRZ8vzK2jxEucfqhY+49oFvTYptKaYH1bV0AG/RT2mRGZPW2WAuuh
         q+kwyOjP/58fDTlB6C60dFOcPRFdLRcGDCUxupB0ribDE5s+hEb6+N8uDgkLCVApO4Ha
         j1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IiCjvzkKhIVpXfcqTma6XBTadoGCsobxQeAd+7dQ/rc=;
        b=KVX4ta/q8RWmF5SWpfbM0OaiXmjJCK/vK3HQb9LNqm0YuQzJju3Ej4bMDPvik0nx8X
         UIDdh8faHNJIxtojYy/JZNSpwdS2bjV8qnQHJgS3IqCZw9PpNHbmJxQy0KS7CPl667fm
         cKm5K2opYRP6VYTB9Kk3IFAehny5YXLgMBRT+PkvqlUsNbmdK81Fw2eFTfombiBzeG11
         xhuXoP5xKN6n6rv5GyH0ulsfsFI++ypuTPqEfFqQojx8x9HwxcVsKyU/MpUy/qe6ZqCt
         v2WWP4HQQLEn714voXSlhVCi425Uz3n6tYqf+EdrH9ImaT5ECYn6wVSOg0JJUxeqMzHc
         dmNQ==
X-Gm-Message-State: AOAM533+PIsU5bX1imTBolMcf1nyfQOBschHiIaKYT3tMn3bPP8EBQR8
        Oilp7njhdaEm8tHnXtOAAD4U9A==
X-Google-Smtp-Source: ABdhPJxxd1FSwcd8EBPRGfdZCdb2K6ixcaLZqE96gJ2AE1yYLFxYWBpIxoaC9Yy7FHqUi48wQ/NOMg==
X-Received: by 2002:a17:902:b947:b029:ec:b04d:c8a2 with SMTP id h7-20020a170902b947b02900ecb04dc8a2mr521720pls.2.1621286345120;
        Mon, 17 May 2021 14:19:05 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id n9sm11463934pgt.35.2021.05.17.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 14:19:04 -0700 (PDT)
Date:   Mon, 17 May 2021 21:19:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Venkatesh Srinivas <venkateshs@chromium.org>
Cc:     "Xu, Like" <like.xu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, weijiang.yang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>, ak@linux.intel.com,
        wei.w.wang@intel.com, Stephane Eranian <eranian@google.com>,
        liuxiangdong5@huawei.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, Yao Yuan <yuan.yao@intel.com>,
        Like Xu <like.xu@linux.intel.com>
Subject: Re: [PATCH v6 04/16] KVM: x86/pmu: Set MSR_IA32_MISC_ENABLE_EMON bit
 when vPMU is enabled
Message-ID: <YKLdxGR72LJIfBNZ@google.com>
References: <20210511024214.280733-1-like.xu@linux.intel.com>
 <20210511024214.280733-5-like.xu@linux.intel.com>
 <CAA0tLErUFPnZ=SL82bLe8Ddf5rFu2Pdv5xE0aq4A91mzn9=ABA@mail.gmail.com>
 <ead61a83-1534-a8a6-13ee-646898a6d1a9@intel.com>
 <YJvx4tr2iXo4bQ/d@google.com>
 <5ef2215b-1c43-fc8a-42ef-46c22e093f40@intel.com>
 <CAA0tLErHZwyk_01jzy3u4Y+iGEM05zt-+inrhFXy4a5iw0X8-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0tLErHZwyk_01jzy3u4Y+iGEM05zt-+inrhFXy4a5iw0X8-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021, Venkatesh Srinivas wrote:
> Should this bit be conditional on the host having it set?

No need, KVM advertises the architectural PMU to userspace iff hardware itself
has an architecture PMU.  Userspace is free to lie to its guests so long as doing
so doesn't put KVM at risk.
