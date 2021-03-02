Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06EB32A3EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577790AbhCBJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238575AbhCBJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614677644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UiswwEqWgCcc6JVEOoT/GV1Yehm2pU+siqiY2RK3s7M=;
        b=YrRqBTLVrOVBSXtT/5DMnD9TYdpaZfPXi1/pxbXWeAXl5IuWNi88iSmBQMhYlptA8F7iPh
        6qXYCSAzgz+NEP5Jb/pWhpi0T9gNxSkhYO/OiVVBgXr6gAbn7aL/G8+4rZPiy5ZLj216/P
        08B3LooJQnajsMJZ3mijzRgAhDObGr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-vkQhMMdZMWWP3PWz5PHNlg-1; Tue, 02 Mar 2021 04:34:02 -0500
X-MC-Unique: vkQhMMdZMWWP3PWz5PHNlg-1
Received: by mail-wm1-f69.google.com with SMTP id r21so306874wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 01:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UiswwEqWgCcc6JVEOoT/GV1Yehm2pU+siqiY2RK3s7M=;
        b=qYZhnjEAkYcNGwDR1fpMZOra77geXF6579u/rnZIhc2UokEZNmlTRJgCayerM85A2D
         FS6HoKKVqeVXfRjMohzwP/DRG2wCkR3bdwhDYjUqPPecHtqgMrHW623AUKbDs0pnonN0
         RcFw6XfsBDYQuxfnjo7nlefi4VpAnMdEppAhDRFDO6Hpvc+zoJqDDoiytqs/m2L7cEf6
         LR/Acrcp6+CUBdeHVWMoZVPFPP6Rz0F/wFedmv+PeoRlDEah7AYBtBVM4txbENEhcbpB
         wlK/KMh+PEN7DH0gMziCSR+tI414ueDCZ7/cD6H6e+LozDiUM5t21dHYzC8cq+9Z5VxP
         G/oQ==
X-Gm-Message-State: AOAM530xTyrA8z8ztXcwp4QZk1nakjGjOK417RI9fnUXMiCnVyjLE+FN
        6p3kXwJ/VYS7R6/c4nDNiJtdcnup00ZIv3d82h/zo1o1vPuVuBMiPyfb58OPQNdbRzYtfWeud9b
        GFN4JGvOtJQxsDkIgHfVs9vKg
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr3137760wmf.148.1614677640851;
        Tue, 02 Mar 2021 01:34:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoXcwmapp7HZMXF9WKS7S9md99CuclLhyuqLkFLsTZMmv0tMBvmgShASamrRonSac04nM/rg==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr3137742wmf.148.1614677640649;
        Tue, 02 Mar 2021 01:34:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a131sm1972171wmc.48.2021.03.02.01.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 01:34:00 -0800 (PST)
Subject: Re: [PATCH v2] KVM: nVMX: Sync L2 guest CET states between L1/L2
To:     Yang Weijiang <weijiang.yang@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20210225030951.17099-1-weijiang.yang@intel.com>
 <20210225030951.17099-2-weijiang.yang@intel.com>
 <YD0oa99pgXqlS07h@google.com> <20210302090532.GA5372@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39737fcf-ac15-006e-c21f-39f6caa3b342@redhat.com>
Date:   Tue, 2 Mar 2021 10:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302090532.GA5372@local-michael-cet-test>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/21 10:05, Yang Weijiang wrote:
> I got some description from MSFT as below, do you mean that:
> 
> GuestSsp uses clean field GUEST_BASIC (bit 10)
> GuestSCet/GuestInterruptSspTableAddr uses GUEST_GRP1 (bit 11)
> HostSCet/HostSsp/HostInterruptSspTableAddr uses HOST_GRP1 (bit 14)
> 
> If it is, should these go into separate patch series for Hyper-v nested
> support? I have some pending patches for the enabling.

Yes, it should be a separate patch.  The main patch however should add 
the CET fields to EVMCS1_UNSUPPORTED_VMENTRY_CTRL and 
EVMCS1_UNSUPPORTED_VMEXIT_CTRL.

Thanks,

Paolo

