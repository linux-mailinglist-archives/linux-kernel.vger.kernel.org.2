Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C140307D29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhA1R4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231352AbhA1RzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611856415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YskuCpCMOLyt7huWW2O6XvKKvTstAPbd7OXgDJIEAJM=;
        b=N5nent8Zv16+v4vMDZKXb64uipb2E1ruOetZpgdNCQAy3qjBVMWNiGVDtawGHTwJJL1T2B
        +oDMgKYvaVDwqNfa+zxZFuqmhxKb0Ath+Ksw3S82dOS+VIHsuQ+ehpcLlbGIqWhDShIn60
        C6+66nFqAkVD+riM3LnvXNCrinlrkxk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-5uRErIiYN3K74mQPxXxTRA-1; Thu, 28 Jan 2021 12:53:33 -0500
X-MC-Unique: 5uRErIiYN3K74mQPxXxTRA-1
Received: by mail-ed1-f69.google.com with SMTP id dg17so3561367edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YskuCpCMOLyt7huWW2O6XvKKvTstAPbd7OXgDJIEAJM=;
        b=GUFzvW9wJjSN1NcmZeX66+NA/MO5d1q05Vf1agrzTVzB1653wKRxIu/QJ1C0ncNkXe
         RLyOHKO10OQjELMffkzeAI4VCoIC7wwSPCv39fNz6qCcxliXexhV3/ss0/dzIJxypKZv
         1ZrP58KuyllrF+mLG41eslYV2qzcvKwGGhC1vD4kHo+oSf19zvLRqdO3CY/IWpQh6lj+
         brbk+mUc2L7oGDu7asAKCG+Xq04P8JY6kLEEG/3dNeNvEuVv+xUeUPRrf0NjRSaeueCG
         4/Qt7nhLLGT16Fv0Fdi0FnSqGj/AOQ6nReSjsrD2msC8kVxOWo7dRfgiFhYBZC23HU61
         Guig==
X-Gm-Message-State: AOAM531grcZmiarWLzXCNgKJiC+VQrzhLeAhdxtZ+q0R9ISFN85/M0gV
        fRk9SnWQGgmQkRjMFRpX5wkD/sCvIl9YytdDfjw9+P7ZexA8lnY5vxhDXeezscUKgFkdp3QLbyU
        +IiA0d2EceYPkTofLk7LYc33H
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr552450ejb.21.1611856411961;
        Thu, 28 Jan 2021 09:53:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvi2gSz5ZEUEAfWbrtzMkaY1oh+pFlG0GsIg7hArk/C890LvbBeQp42BPOz7UKRbAFP8sNug==
X-Received: by 2002:a17:906:24d1:: with SMTP id f17mr552436ejb.21.1611856411789;
        Thu, 28 Jan 2021 09:53:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id rh6sm1327275ejb.45.2021.01.28.09.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 09:53:30 -0800 (PST)
Subject: Re: [PATCH v14 10/13] KVM: x86: Enable CET virtualization for VMX and
 advertise CET to userspace
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        jmattson@google.com
Cc:     yu.c.zhang@linux.intel.com
References: <20201106011637.14289-1-weijiang.yang@intel.com>
 <20201106011637.14289-11-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7a7a337-c1ca-8221-73c6-7936d1763cae@redhat.com>
Date:   Thu, 28 Jan 2021 18:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201106011637.14289-11-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/20 02:16, Yang Weijiang wrote:
> 
> +
> +	if (((cr4 ^ old_cr4) & X86_CR4_CET) && kvm_cet_supported()) {
> +		vmcs_writel(GUEST_SSP, 0);
> +		vmcs_writel(GUEST_S_CET, 0);
> +		vmcs_writel(GUEST_INTR_SSP_TABLE, 0);
> +	}
> +

Is this behavior documented for bare metal?  I suspect it is at least 
not true for S_CET and INTR_SSP_TABLE, because SMM entry does not save 
those to SMRAM (and clears CR4.CET).

Also, you need to save/restore GUEST_SSP to SMRAM.

Paolo

