Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABE3F1E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhHSQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhHSQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629391430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ovmo8eHJLt09NnHE2KsMUgZOEZ1fOMoSIqw+9nEdI3o=;
        b=ZUMJVEpP1xrmW7YNVk9CRMYFcOoeFAmJpqZbUz0D238R/Zoa69hP8VBeSfP0xBn6ftIjlO
        B42ELNnRoIfCALfxnpGqIH8+fftJKaxkECCkd+EdslTBdz4CyC9IE6W32o9MIflJYX6E0O
        HBUJRxCsnlXorZQxxTRCOjwiVQoR7Qw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-vwsNdLjOOgO9jOdOq1L-Qw-1; Thu, 19 Aug 2021 12:43:49 -0400
X-MC-Unique: vwsNdLjOOgO9jOdOq1L-Qw-1
Received: by mail-ed1-f71.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso3104514edh.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ovmo8eHJLt09NnHE2KsMUgZOEZ1fOMoSIqw+9nEdI3o=;
        b=CrFdF5sk7UepDf5pWsFz5c2lFmEXsis1rApOTh/U953TGjRuNNb2HIhtv+5edNbOzp
         E4WwQKdB7X1cqFXZsHep0OA2gEfKoEIZV6d76WRfcUiGPavRpll15/IeuYdNMc2H32a5
         Iv/oFvZsdLPoYNyzjDxVv07Gv1BRmQV95RGbhSflIab97vLHmQEDrQQLtYlTf87hly2c
         woIXTYNJK0wuG8cWbXOYVCIz5dj4SJXhdjYXCHxZrBfcTlXwLcUQHl35gR10JzYKKlTS
         v54dKdhWmWvegbwpSUxVwt5MqRFUHfm4bfwqm3Te4yuIFk3Kr6dij0OcXm9Kjq3fqr6P
         WIUA==
X-Gm-Message-State: AOAM533FYz9PIMve60WQF9InNeo5685Fn6g/7s72cFmxAW1iUrx3v4ZI
        t98VlCcAV8pnloBCK+H51yfqEuBF113BNsbzS0EH0FcL+kCD3Bt98hru8R1d2t9l9wbRmw9lV2R
        Xpz0RJg1nSdxze+bpLD82u4ui
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr17265799edb.95.1629391428204;
        Thu, 19 Aug 2021 09:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBQI9xf53Gfkx4OcP68mxTenuILG5G2+AguBk/JQcIho0t27TP75Z4OOF/3/ibyGxTkTNgoA==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr17265786edb.95.1629391428020;
        Thu, 19 Aug 2021 09:43:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q21sm1504758eji.59.2021.08.19.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:43:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] SVM 5-level page table support
To:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        seanjc@google.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
References: <20210818165549.3771014-1-wei.huang2@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46a54a13-b934-263a-9539-6c922ceb70d3@redhat.com>
Date:   Thu, 19 Aug 2021 18:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818165549.3771014-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/21 18:55, Wei Huang wrote:
> This patch set adds 5-level page table support for AMD SVM. When the
> 5-level page table is enabled on host OS, the nested page table for guest
> VMs will use the same format as host OS (i.e. 5-level NPT). These patches
> were tested with various combination of different settings and test cases
> (nested/regular VMs, AMD64/i686 kernels, kvm-unit-tests, etc.)
> 
> v2->v3:
>   * Change the way of building root_hpa by following the existing flow (Sean)
> 
> v1->v2:
>   * Remove v1's arch-specific get_tdp_level() and add a new parameter,
>     tdp_forced_root_level, to allow forced TDP level (Sean)
>   * Add additional comment on tdp_root table chaining trick and change the
>     PML root table allocation code (Sean)
>   * Revise Patch 1's commit msg (Sean and Jim)
> 
> Thanks,
> -Wei
> 
> Wei Huang (3):
>    KVM: x86: Allow CPU to force vendor-specific TDP level
>    KVM: x86: Handle the case of 5-level shadow page table
>    KVM: SVM: Add 5-level page table support for SVM
> 
>   arch/x86/include/asm/kvm_host.h |  6 ++--
>   arch/x86/kvm/mmu/mmu.c          | 56 ++++++++++++++++++++++-----------
>   arch/x86/kvm/svm/svm.c          | 13 ++++----
>   arch/x86/kvm/vmx/vmx.c          |  3 +-
>   4 files changed, 49 insertions(+), 29 deletions(-)
> 

Queued, thanks, with NULL initializations according to Tom's review.

Paolo

