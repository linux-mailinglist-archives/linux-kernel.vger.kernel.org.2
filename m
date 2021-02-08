Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB967313FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhBHT41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235211AbhBHSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612807948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Em5Q6izKRwuYnxNNv2p6LEzG/SfeITVQD9/V+T5jR/M=;
        b=AuwqrnhytR+H7MDdRU82YX0yVC3tEWmtf8XESeYH+YDQfTJ63hu0ezRcF2Z/ae583/2Zb4
        M0+uQYJaqARHwNpZijRIFfJqltst8kXPDbpKI6zkybkFZYZRGLKYaFI0eEhihmz/p92Jr4
        +PqOqFJOzbLgUkqFgjmbr+cNz46FbD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-ZGIFpHUfNYKIMd6afTpH0w-1; Mon, 08 Feb 2021 13:12:25 -0500
X-MC-Unique: ZGIFpHUfNYKIMd6afTpH0w-1
Received: by mail-wm1-f72.google.com with SMTP id y9so9214935wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Em5Q6izKRwuYnxNNv2p6LEzG/SfeITVQD9/V+T5jR/M=;
        b=cQCBHkKHI748LmS4rSqZdWB0Ix6cUBDsRPccTINZvvw8sUH+9Mm0Tge0O7o0yvc9Fd
         nLmPwhWWjDsItdiJVFzU8SIi0yf7ytfI7qBfT1Kmf1R+E4qcq0Bbyu3smZQObAKkqtDC
         WpRCLO04nan7QtACr6cExhgXT6l9v9/ZmfE5FWxd0LeNUhkYb+QvqxG5FDpXaQo6vyhJ
         bg9HeqLf/VKHJ6hffZF73GHu57mPGtwzmmAHiSfSo8M2vvGFikmCGXJFjHA621Jh3HcQ
         8Rax8Ju3tf8uuOaDOwGbmZOmif+Kjnn3oDJBInbsV/BoufS/J+cumZMEq06ZHQj2k3sz
         w/Aw==
X-Gm-Message-State: AOAM530hFiMOU3Z9S1W2lnoE8vOWKlZ6SnulJs9tpcdb963wsu7Sm0qi
        4VqtFvqdPmfNYL7F6XJtCr6Kn8UTM4Dg0L8EnvCKJ/ahphC7IQZxu7LEW3J2PWSnCh3jv3ye4O+
        gsfWe4+AagjjCNIQTqfy4uoqq
X-Received: by 2002:adf:b64f:: with SMTP id i15mr20465103wre.279.1612807944284;
        Mon, 08 Feb 2021 10:12:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWpAeK4msgOmM8v7VqEwvUaMXj+/R0pAL/O0nlqtcHUVclMsQXrcY9KuBLfX7dfzMQi4j5pA==
X-Received: by 2002:adf:b64f:: with SMTP id i15mr20465080wre.279.1612807944075;
        Mon, 08 Feb 2021 10:12:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i3sm12022645wrr.19.2021.02.08.10.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 10:12:23 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jing Liu <jing2.liu@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jing2.liu@intel.com
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-4-jing2.liu@linux.intel.com>
 <ae5b0195-b04f-8eef-9e0d-2a46c761d2d5@redhat.com>
 <YCF1d0F0AqPazYqC@google.com>
 <77b27707-721a-5c6a-c00d-e1768da55c64@redhat.com>
 <YCF9GztNd18t1zk/@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 3/7] kvm: x86: XSAVE state and XFD MSRs context switch
Message-ID: <c293cdbd-502c-d598-3166-4e177ac21c7a@redhat.com>
Date:   Mon, 8 Feb 2021 19:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCF9GztNd18t1zk/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 19:04, Sean Christopherson wrote:
>> That said, the case where we saw MSR autoload as faster involved EFER, and
>> we decided that it was due to TLB flushes (commit f6577a5fa15d, "x86, kvm,
>> vmx: Always use LOAD_IA32_EFER if available", 2014-11-12). Do you know if
>> RDMSR/WRMSR is always slower than MSR autoload?
> RDMSR/WRMSR may be marginally slower, but only because the autoload stuff avoids
> serializing the pipeline after every MSR.

That's probably adding up quickly...

> The autoload paths are effectively
> just wrappers around the WRMSR ucode, plus some extra VM-Enter specific checks,
> as ucode needs to perform all the normal fault checks on the index and value.
> On the flip side, if the load lists are dynamically constructed, I suspect the
> code overhead of walking the lists negates any advantages of the load lists.

... but yeah this is not very encouraging.

Context switch time is a problem for XFD.  In a VM that uses AMX, most 
threads in the guest will have nonzero XFD but the vCPU thread itself 
will have zero XFD.  So as soon as one thread in the VM forces the vCPU 
thread to clear XFD, you pay a price on all vmexits and vmentries.

However, running the host with _more_ bits set than necessary in XFD 
should not be a problem as long as the host doesn't use the AMX 
instructions.  So perhaps Jing can look into keeping XFD=0 for as little 
time as possible, and XFD=host_XFD|guest_XFD as much as possible.

Paolo

