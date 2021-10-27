Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A642643C82D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhJ0LBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233865AbhJ0LBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635332317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qj8iuBeW+SwYxG4JX9Q8fVc5FJNZbXtV8v6zQfHvcBQ=;
        b=VFDdqoLFpHp3gZBdvOFFIuwfOMbDx6VgbBrOEXLPcMwV7s2qs7fmU5q5V2O9vweVD2lHVu
        vXr3s+6mZJqCcLDeUHAaP8Wvp1S3GTRykbKL91PVXOor7fb/JbAEhzinYhPHMcRPe4MoIC
        /JvbC/X0uOrv1bC67oQ+EaaWwnajap0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-d6WFbALvPw6aO88fqnn4FQ-1; Wed, 27 Oct 2021 06:58:33 -0400
X-MC-Unique: d6WFbALvPw6aO88fqnn4FQ-1
Received: by mail-ed1-f70.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so1901833edx.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qj8iuBeW+SwYxG4JX9Q8fVc5FJNZbXtV8v6zQfHvcBQ=;
        b=g1LXqGYg0Oo7bhTrlxGuhRMC4Q7cA0tUXNW5DFkO9kAEHAQzMkW+j83AV+AwXpl1+k
         WPi1re8DlbtXrZadbIC7qnn2XtCA7ifmF5OLi9NHkOkKvN/5AJwPoTkOKtdJWL6ctPLY
         1nlw+/OZa+tIj9N0Bxh3o/lTV6iJpcPPrzmr+0uQIEsjQCWRPEM8t+BhlTWzpM1EGsQg
         Ug2XMUgqutxQBQUqD/uGa2ZdNYcE8zRRrn+3WxZ5nI8aZuXkZOTKUZOukGWvzlnhlSUc
         EWFWXaqqvsSKatLkB/1KMmJHVqiZZahAEsMEw3Dcyllg4gKwDBQSUCPxbVb1nYSX0+pO
         L8yA==
X-Gm-Message-State: AOAM531z/aeQRnmqBM4upI5NfYXPxIMTIqAx4uRfFsbUetgaPl6MuA+q
        JC2cSsHEjlD8elNJiWgupMnNBg9wQZAmaC8o4xlbwUeD5gokNc8MTRCOnavKWRsK/YbvE/ugPwx
        GGDaoU573YfJypSuKW8uVtO0c
X-Received: by 2002:a50:fd93:: with SMTP id o19mr521144edt.174.1635332312266;
        Wed, 27 Oct 2021 03:58:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8+o6dvUUaSaBXx8qz7NmzfUaR6FGeBVuoZSngvvAw9kfQvVWaceKd6ZFZNCZp9huNPMjDeg==
X-Received: by 2002:a50:fd93:: with SMTP id o19mr521126edt.174.1635332312094;
        Wed, 27 Oct 2021 03:58:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p25sm12439125edt.23.2021.10.27.03.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 03:58:31 -0700 (PDT)
Message-ID: <1216740e-ba36-4f9b-d393-d6364c545a09@redhat.com>
Date:   Wed, 27 Oct 2021 12:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] MAINTAINERS: Update powerpc KVM entry
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Cc:     npiggin@gmail.com, kvm-ppc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20211027061646.540708-1-mpe@ellerman.id.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211027061646.540708-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/21 08:16, Michael Ellerman wrote:
> Paul is no longer handling patches for kvmppc.
> 
> Instead we'll treat them as regular powerpc patches, taking them via the
> powerpc tree, using the topic/ppc-kvm branch when necessary.
> 
> Also drop the web reference, it doesn't have any information
> specifically relevant to powerpc KVM.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   MAINTAINERS | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca6d6fde85cf..fbfd3345c40d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10260,11 +10260,8 @@ F:	arch/mips/include/uapi/asm/kvm*
>   F:	arch/mips/kvm/
>   
>   KERNEL VIRTUAL MACHINE FOR POWERPC (KVM/powerpc)
> -M:	Paul Mackerras <paulus@ozlabs.org>
> -L:	kvm-ppc@vger.kernel.org
> -S:	Supported
> -W:	http://www.linux-kvm.org/
> -T:	git git://github.com/agraf/linux-2.6.git
> +L:	linuxppc-dev@lists.ozlabs.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/ppc-kvm
>   F:	arch/powerpc/include/asm/kvm*
>   F:	arch/powerpc/include/uapi/asm/kvm*
>   F:	arch/powerpc/kernel/kvm*
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks Michael and Paul!

Paolo

