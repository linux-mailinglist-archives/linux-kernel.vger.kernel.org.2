Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4565942AA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhJLRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231985AbhJLRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634058234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8N9AZrtbCUIg+TOcuzcXy+gxTtxbcJnCpc/kWAxsisE=;
        b=BFUWVmGMn1HfqEX3coqS0NFvQ1TtcqHJ0ONjG2FJFvxkM/53CDLHB7AILcs2a5bpTq8jM+
        LzuBxr79XKV9vJcn8cAFieH0UtWNdoz8GPU9B9TUsAHPmSNSLYZxpkKuvinuMxW01ndhPw
        HuY4pzRZmjSVLgEjHMaNYDiIWS3MkT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Pa_U5m3CMa6Z1bmZjx71lg-1; Tue, 12 Oct 2021 13:03:53 -0400
X-MC-Unique: Pa_U5m3CMa6Z1bmZjx71lg-1
Received: by mail-wr1-f71.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso3615681wri.17
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8N9AZrtbCUIg+TOcuzcXy+gxTtxbcJnCpc/kWAxsisE=;
        b=Xy0P+sf5keUSiGMVUfFndnywgNwuWiJSyWBmY0Nj3SywR5lgtBm54sU6gIjWv1HoHE
         7w7Gpz8T7KwRGR30NtfBSoKYyPeRIE9MLeNNkQ2zonODeWCGpNATYORsktTvy9F5ds/Z
         vLE/k/2i6BN9cLt9CkFslZHg9CGiGGFKZiOvVM47Mr1MigeKKOOFnyqUaqzl/FPQloXR
         acSvZMDcbS7/dywYFmd6C7Lrmz1EBkR6tKWf/YFcA9zO2/2CeRRqMqjmDfjgONLozhZE
         QRg4StJDs/h9W0CA/0tHnHxafRcwVV3GdVFHbnuOaUy1UBUeWiFwjRyfthGVNWPe5KsN
         UkBA==
X-Gm-Message-State: AOAM531rqxbmig5Wrm+G2Vnvgyv8vzpyYM88skTIeMa6EXH6VN+AthmP
        Nbn4ZFSlZ2dsH5VKFwE3fX8dHsWw33q6pI+gvR5F/9ZdLrqO3z0duKydr/UkfhZ7FnSJuS6HQRl
        i/7jDdGnemIo6W3bxP8Jc7/vo
X-Received: by 2002:a05:600c:2304:: with SMTP id 4mr7212465wmo.91.1634058231819;
        Tue, 12 Oct 2021 10:03:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi+JbzPS/yYKPH5w4nLLjYQlyxy5Yj2TA/POpelys/M2iGbaCFdKBMDfeABuopr3hTFA4yRQ==
X-Received: by 2002:a05:600c:2304:: with SMTP id 4mr7212422wmo.91.1634058231542;
        Tue, 12 Oct 2021 10:03:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a127sm2818740wme.40.2021.10.12.10.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:03:50 -0700 (PDT)
Message-ID: <22c1c59f-9b7c-69fa-eff3-1670b94c77af@redhat.com>
Date:   Tue, 12 Oct 2021 19:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 2/2] x86: sgx_vepc: implement SGX_IOC_VEPC_REMOVE ioctl
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, seanjc@google.com, x86@kernel.org,
        yang.zhong@intel.com
References: <20211012105708.2070480-1-pbonzini@redhat.com>
 <20211012105708.2070480-3-pbonzini@redhat.com>
 <644db39e4c995e1966b6dbc42af16684e8420785.camel@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <644db39e4c995e1966b6dbc42af16684e8420785.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 18:57, Jarkko Sakkinen wrote:
>> +
>>   static const struct file_operations sgx_vepc_fops = {
>>          .owner          = THIS_MODULE,
>>          .open           = sgx_vepc_open,
>> +       .unlocked_ioctl = sgx_vepc_ioctl,
>> +       .compat_ioctl   = sgx_vepc_ioctl,
>>          .release        = sgx_vepc_release,
>>          .mmap           = sgx_vepc_mmap,
>>   };
> I went through this a few times, the code change is sound and
> reasoning makes sense in the commit message.
> 
> The only thing that I think that is IMHO lacking is a simple
> kselftest. I think a trivial test for SGX_IOC_VEP_REMOVE_ALL
> would do.

Yeah, a trivial test wouldn't cover a lot; it would be much better to at 
least set up a SECS, and check that the first call returns 1 and the 
second returns 0.  There is no existing test for /dev/sgx_vepc at all.

Right now I'm relying on Yang for testing this in QEMU, but I'll look 
into adding a selftest that does the full setup and runs an enclave in a 
guest.

Paolo

