Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD143527C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhDBJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233894AbhDBJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617354106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wgr1zy01y+2hMqoZJiHMBPPBdaSsAhJT7fsIEsgksQ=;
        b=O1HW3X5PjqXKgHf391o0BLGG3mOhEYpZjtmWZLYWVxNMGi+lUUo1x0QORQ1o7BHb2JTLeD
        E7NAC5/9ZGOLm9ey/vSA+vNUY58NxYG98bhzBeTrYqDwNZLVam4paLGhN7MtiD4a08QZ3R
        rpifLM5t4nplSB4L+lQascwrFCkntJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-NKhJMjOTNmudggx_n6jKCg-1; Fri, 02 Apr 2021 05:01:45 -0400
X-MC-Unique: NKhJMjOTNmudggx_n6jKCg-1
Received: by mail-wr1-f71.google.com with SMTP id n17so4102637wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Wgr1zy01y+2hMqoZJiHMBPPBdaSsAhJT7fsIEsgksQ=;
        b=Wvfwmx8fxpSofjPNRyyzLBNSu9ymOVmvmzg31a6C3EfpaRxhfWBg+H/rMEV2DNYDrR
         uLejGuLFcrL8jcwGhppixfmVw96hZfLFOcHI2tCfd109/CigRUHWC3EaCWn4UceDQnS6
         PgwKax9bCDy6a6bGdhCq7yzyU5Vtk860sT4C3DEkUV38keYMSCnTa2w8GLTGdsL8/yWO
         lf1W9lk1fThA9MWjslridQuL5OElPJsqRXEJoSQhK/1c9vhPNMDvR+P/Zj6wQXHTzc49
         VhbF6su8WprgGSF/+o2aT/HGSNozFExjGFU3TkX9wf+tsk1Mi0bTzajyKgYBmfMyvLHr
         KBJg==
X-Gm-Message-State: AOAM5311mVCcWmC9Dvp5jC8CQvfEi906w8mN+vzc70+9Gt9BTP039VuT
        ZHgYPz538jQYd2niodhJJ7qZ8pT0sFmBPBRzTJOTN16JBcxMRZqIkZ0mkEsn/cxx07Ha4pzrIFk
        YYjB7GTrjkgSUa9ZMi8y+gjw9PyRdPjrAcyRDEAGb3B2HRoHCykCzkFHwZ3rwgi+KIX2NxaJhxt
        Ih
X-Received: by 2002:a5d:5083:: with SMTP id a3mr14413803wrt.38.1617354103870;
        Fri, 02 Apr 2021 02:01:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC8Q3AXgIj0cWECGITt1mlVk9cxwR3/7wY+0fX0IgzbfGrhe6WcAEzmqK4DpSqIcHCX8JzYw==
X-Received: by 2002:a5d:5083:: with SMTP id a3mr14413774wrt.38.1617354103679;
        Fri, 02 Apr 2021 02:01:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id u8sm14479987wrr.42.2021.04.02.02.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 02:01:43 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210202090433.13441-1-chenyi.qiang@intel.com>
 <20210202090433.13441-2-chenyi.qiang@intel.com>
 <3db069ba-b4e0-1288-ec79-66ac44938682@redhat.com>
 <6678520f-e69e-6116-88c9-e9d6cd450934@intel.com>
 <ea9eaa84-999b-82cb-ef40-66fde361704d@redhat.com>
 <dc22f0a2-97c5-d54d-a521-c02f802c2229@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d7455a7-dca7-3c60-0c34-3a3ab8f7f1fb@redhat.com>
Date:   Fri, 2 Apr 2021 11:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <dc22f0a2-97c5-d54d-a521-c02f802c2229@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/21 10:53, Xiaoyao Li wrote:
>>
> 
> Hi Paolo,
> 
> Fenghua's bare metal support is in tip tree now.
> https://lore.kernel.org/lkml/20210322135325.682257-1-fenghua.yu@intel.com/
> 
> Will the rest KVM patches get into 5.13 together?

Yes, they will.

Thanks for the notice!

Paolo

