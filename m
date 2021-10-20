Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7043478A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJTJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhJTJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634720526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SbWAPvwrGsfmCsClvuclMH5ynxEMCyyHOSK+E2gdxng=;
        b=C27GOHveYcJwmPszQc6ajYuJ4//L0ergFpE1MiYTzTDbpW9HiD3nPmRbRIG2ff1wXUpAH0
        0esZ/OM+/Z/Emi6F3yiLWQGEtvWxqcFA8D7DD7o5mdKxiuyKNWMj4xEAyoEdPd+HI/KDOx
        NAqKZFuxz/oEVDy9l3tFNDOyv6+UiEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-vBC4J3b0OGOVhd_KeBkMlQ-1; Wed, 20 Oct 2021 05:02:03 -0400
X-MC-Unique: vBC4J3b0OGOVhd_KeBkMlQ-1
Received: by mail-wm1-f72.google.com with SMTP id d7-20020a1c7307000000b0030d6982305bso2284265wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SbWAPvwrGsfmCsClvuclMH5ynxEMCyyHOSK+E2gdxng=;
        b=T844upmsHWC7jJAhm2kBcn6ZHrG3BHywpW59S6ViZIS9HrNntszR3VOfJHmOkNJAG2
         iFUxS4gHl7G57A+0nUffxCU94GaozactispRXEJxU+BSxUXdLUdU/dVbH3RNJNpn3YUS
         QNeafnpcB4RRQKMfmcLawzZXvIK7DMdIiT0sv8wbm77nLRB7v8+EoEUlzJWy5Yc1mjI0
         Lt5n3VWzh8XnuJeRdd4/FBl7ZIT8keLUuAL7hFBVSjO0kpwUqwK3rvxeX34e3qydsMvR
         GCk4wn8pDCOh0TjgKPF6bOtAIKqmmBn8AFKunJbrZbYEChn+JEtIUW9/yf1qKh29pY7S
         uwDg==
X-Gm-Message-State: AOAM532sx2bDP+httxDVIfzIHsXdHYIz0XmeqRP785ci7mbLg/Pu7Ob5
        kR157I1ClYlHGTpMRMO4f9miV7NMe3WrBP8ywrj61jutzLQWPK/vZTOloPd9SPWdK2lYHtBMMHn
        Ex8eWnOC/VxDSrtS1789xuBCl
X-Received: by 2002:a05:600c:1c21:: with SMTP id j33mr12114371wms.163.1634720522367;
        Wed, 20 Oct 2021 02:02:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjy3kD0S8OJSLvBxmrKLVOrUQpa2awD73yfAecGZXNUjdxsBSEbtOPv88vEU6uxjfJUbLg5g==
X-Received: by 2002:a05:600c:1c21:: with SMTP id j33mr12114340wms.163.1634720522117;
        Wed, 20 Oct 2021 02:02:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id s9sm4267578wmj.39.2021.10.20.02.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 02:02:01 -0700 (PDT)
Message-ID: <ead08efc-ab79-7646-3d19-6d808097f688@redhat.com>
Date:   Wed, 20 Oct 2021 11:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v4] KVM: emulate: Don't inject #GP when emulating RDMPC if
 CR0.PE=0
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634719951-73285-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1634719951-73285-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/21 10:52, Wanpeng Li wrote:
> From: Wanpeng Li<wanpengli@tencent.com>
> 
> SDM mentioned that we should #GP for rdpmc if ECX is not valid or
> (CR4.PCE is 0 and CPL is 1, 2, or 3 and CR0.PE is 1).
> 
> Let's add the CR0.PE is 1 checking to rdpmc emulate, though this isn't
> strictly necessary since it's impossible for CPL to be >0 if CR0.PE=0.
> 
> Reviewed-by: Sean Christopherson<seanjc@google.com>
> Signed-off-by: Wanpeng Li<wanpengli@tencent.com>
> ---
> v3 -> v4:
>   * add comments instead of pseudocode

No, the commit message was fine.  What I meant is there's no need to 
change the code.  Just add a comment about why CR0.PE isn't tested.

Paolo

