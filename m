Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B943679FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhDVGe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhDVGey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619073259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32v070lHFea27N/7UXZgNzlr22E5m7KkC6ga6LEk8XM=;
        b=ShGYIVyTYUyCpI/ScihUVNBlfPJ2paX9xYH/FuMNAnGVIymngDHa1Uz5vSQ8ZB5I3QhLMo
        KL3bi7PaO+Ej2J+BaOK+7+jtBaC59gI6eOfd94SS04DDQhtCXJOZlimSIyNHTA884zbGy3
        T2jNSJnW53yvg4jErJdBPwIDMsCozjw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-mXdCI_oGOJeTKL74GfpIsA-1; Thu, 22 Apr 2021 02:34:18 -0400
X-MC-Unique: mXdCI_oGOJeTKL74GfpIsA-1
Received: by mail-ej1-f71.google.com with SMTP id ji8-20020a1709079808b029037c921a9ea0so6815951ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32v070lHFea27N/7UXZgNzlr22E5m7KkC6ga6LEk8XM=;
        b=DNEM5cLOV9ezlb2PELVAZ4bghEB3zgENjVutbGlmXUkZE4+Mnoy+Nk/5xKVofxxNXn
         LZihVQyY7IDUxtWssn1jM2EInL0lDqdz9AdOXoPxBBlXBBZm36+VKN+OHPK+K4o9+V9z
         swAWR9Y61HdrYgozvwZvVHdYji4FyKVhRnROQt7UdDnJfWdSboLvnd6zvGDWlNF2xCrl
         unJ5y6nZ58R09MN5k3cw8J/9syFfc+ILCrNpek+DoovYC4I0rLaIQy91+b96qgeqDFzk
         YkdkshMjVWT7A2pbt4YcXtPj2Ky8LKobjS4ofqLhf5Uw16DIhzV1bkVCDkFCaSddqDKy
         gOoA==
X-Gm-Message-State: AOAM532do3Gnq6ty0gMKRSR2deK4wrj6ezJobnBKxX9d7qfF6TLaS4ms
        wk5XrByAalLnMPY1DCqAsdGi9961XSmiXXwZAR98ttyDFDNm9nldAK05rZYBjJe/RU+jsG5fPvj
        O/iUcaB0rZ2iHoVuIYV9k/+Ir
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr1835095edd.355.1619073257021;
        Wed, 21 Apr 2021 23:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmLCrtpnW7vTQuG1hagGhM6plMHauJ8eOsASBJaES0xqweWLrTtOTKh4p/xUXsGl2I+Vr6Mw==
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr1835080edd.355.1619073256851;
        Wed, 21 Apr 2021 23:34:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u6sm1164854ejn.14.2021.04.21.23.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 23:34:16 -0700 (PDT)
Subject: Re: linux-next: manual merge of the cgroup tree with the kvm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
References: <20210422155355.471c7751@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <124cf94f-e7f5-d6f3-7e7a-2685e1e7517f@redhat.com>
Date:   Thu, 22 Apr 2021 08:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422155355.471c7751@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 07:53, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the cgroup tree got conflicts in:
> 
>    arch/x86/kvm/svm/sev.c
> 
> between commit:
> 
>    9fa1521daafb ("KVM: SVM: Do not set sev->es_active until KVM_SEV_ES_INIT completes")
> 
> from the kvm tree and commit:
> 
>    7aef27f0b2a8 ("svm/sev: Register SEV and SEV-ES ASIDs to the misc controller")
> 
> from the cgroup tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Tejun, please don't commit patches to other tree without an Acked-by 
from the maintainer (which I wouldn't have provided, as the right way to 
go would have been a topic branch).

Fortunately these patches are at the bottom of your tree.  If it's okay, 
I'll just pull from there "as if" you had provided a topic branch all 
the time.

Thanks,

Paolo

