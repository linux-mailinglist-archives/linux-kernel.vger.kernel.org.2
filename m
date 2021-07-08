Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D863C1814
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGHRaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhGHRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625765247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4LV11iVZELSo/KvcHxZoYC72lDjZ2+nfqoEBWf9Mnc=;
        b=DdWkEhKOU9ul6sUSoNATPFfVv8BHR7Fi3MQxSuqGliQfM1BBnmmp7wVGf/KzKFRV8lzu4G
        yFb/Gpju08PXuQxEqSUcb2wIxvc5WbGhhCqWSEDHk/Fs6L0ThYxDmeWAet7jdYvoxKsyuT
        vCPH6+5Qef/4fZ7pJi/iDh5Bad8Ek2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-aYl_0UcOMuecnboAN2kVlA-1; Thu, 08 Jul 2021 13:27:26 -0400
X-MC-Unique: aYl_0UcOMuecnboAN2kVlA-1
Received: by mail-ej1-f72.google.com with SMTP id lb20-20020a1709077854b02904c5f93c0124so2133692ejc.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4LV11iVZELSo/KvcHxZoYC72lDjZ2+nfqoEBWf9Mnc=;
        b=irW4522xVTJB6BpUgmyzgQMERM7KlTPLahn32UAOE4UKMZru4BHsxUP26zFXDnBGVA
         Rajo2bwUH1MY8cPqEYZQmd1m+7NXfXzzeABri3O9iC/CHpI3mjmwv7OUV6NJR9us+rIG
         Nt6QQrktf0wPBwvs9DAGjPOMxm2hBhQUGHbfUwxcQzvY3+bRtPFCA5g9MTTYhVB14ybO
         7fHnvSc6XA3LQJ9emOe3j2JzKrZinFbWwuVqEaEB1n9xO/b+quE+WIEbsD3Cye4ihRyh
         i5Dt2fjaF5PKVEiBS4Npz2w+rkA+N1MvbzYgI8PaEWx3zAjVYxtBTC4u62qTBdCaZQdu
         D1aw==
X-Gm-Message-State: AOAM530JwAGun9O279/jNSRHgECZZUuJxhXr+poM8cx40nSZpVF5x/VK
        ukyHGcpV5M4UiTT+w5GGBXNsgwQJbsLKuKuWuT+HuaGtjIoZVQrYyZEJbKyDUPsY9q8yh0WnRA6
        ybNegS5zQxTzzXJLCVdcQsNLzEZ35IA4jDPW63CW4VdfSXtv72nnZRzDhqq45ro1Js2xuqTt5pp
        Li
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr31290158ejo.230.1625765245320;
        Thu, 08 Jul 2021 10:27:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydovD1OMBAglcKZ1uGCI/v9I2vrIp6kHn2A3kRJnPzGsueYd/9IRuLmfKQXrnCl2+HfiNwyg==
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr31290142ejo.230.1625765245167;
        Thu, 08 Jul 2021 10:27:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cz9sm1602272edb.76.2021.07.08.10.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:27:24 -0700 (PDT)
Subject: Re: [PATCH 1/6] KVM: nSVM: Check the value written to MSR_VM_HSAVE_PA
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20210628104425.391276-1-vkuznets@redhat.com>
 <20210628104425.391276-2-vkuznets@redhat.com>
 <595c45e8fb753556b2c01b25ac7052369c8357ac.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4318c980-6eff-7b74-ae99-b3210021789d@redhat.com>
Date:   Thu, 8 Jul 2021 19:27:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <595c45e8fb753556b2c01b25ac7052369c8357ac.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/21 12:28, Maxim Levitsky wrote:
> Minor nitpick: I would have checked the host provided value as well,
> just in case since there is no reason why it won't pass the same check,
> and fail if the value is not aligned.

The reason not to do so is that it would allow a guest running an old 
kernel to defeat live migration.

Paolo

> Other than that:
> Reviewed-by: Maxim Levitsky<mlevitsk@redhat.com>

