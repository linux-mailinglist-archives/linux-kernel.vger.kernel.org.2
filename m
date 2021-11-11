Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04BB44D7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhKKOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhKKOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636639605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYV/Kt8LdnTM7fdbHHtpv0LhXNre12L903KrAVWKKw4=;
        b=Qen/5amJK6lxEtsUZvza8jBnBI/qQnygg41xeMfqefdRNv9cd+IG0VeCML9SYrPnJh5DCM
        gJgJEyusk9RF8fPqnyfuUhmJGLZThtwwqgeEiqYcc8OP3ZpRRLaQFuVmJPh0B+v75rFEpG
        lRDlMVNxGmMO3aBc+Uh43eevZW72Md0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-EGy_-oZZNm-M1ofVcLRV9A-1; Thu, 11 Nov 2021 09:06:44 -0500
X-MC-Unique: EGy_-oZZNm-M1ofVcLRV9A-1
Received: by mail-wr1-f70.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so1024230wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VYV/Kt8LdnTM7fdbHHtpv0LhXNre12L903KrAVWKKw4=;
        b=PcQJnJP2SJsyuxwcn1PW6PKClKKaADTPAynsKLuouEsyPpePhZDjvB7qkhBYfyzX2G
         FjFHrEsMjbykztTdZhdwsvgX+yQ35LczKNFAmdevkDaveYWU+nXItHS/y6+/PFobaf2S
         YEgXWZAgNVO0dYQF3B42FJGfo51sY7dbqL9zujPtJ9izB6B7LB00piJhwJUZ0nqUacXV
         z9RL8EXNFQ3RNU8S63DPjJqtHBcdsOp2+o/o3BxYl3fwAguEyD78RjtOr+snvyfU6C+v
         4pYbXSbIx8ov02LsI+xpd2WfOkOIIGLNzXjjFzlMkJ929z0YbS5SQnU6jJojwprocAJl
         LPzA==
X-Gm-Message-State: AOAM532+XjGweaGcEyXy/A2qJ5DY+qbP9aipt6ENE0pjDfVaRR6DYgkA
        zQkLAn2Q3wmyjVWHGeVBmAyoDGPPmHf2HnFQE6svWc4zB4EpFPP0Q8BsYknQkiJVTzzmsuyGTIw
        m3bX/ykMtknGDH3jO2ir34PTu
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr26158043wmg.87.1636639603079;
        Thu, 11 Nov 2021 06:06:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8hL2vF5ylxH3HaLC/7tnNeWe0qzM5gXIwg6yQpP0Rp49dJXzUXokSDycSXVCVXX6PsRlwhA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr26158015wmg.87.1636639602909;
        Thu, 11 Nov 2021 06:06:42 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id g18sm3013749wrv.42.2021.11.11.06.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:06:42 -0800 (PST)
Message-ID: <944f0aad-c262-7f33-c54e-9c55fedba553@redhat.com>
Date:   Thu, 11 Nov 2021 15:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/2] Add a helper to read GPR index and move INVPCID
 validation to a common place
Content-Language: en-US
To:     Vipin Sharma <vipinsh@google.com>, seanjc@google.com,
        jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211109174426.2350547-1-vipinsh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211109174426.2350547-1-vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 18:44, Vipin Sharma wrote:
> INVPCID, INVVPID, and INVEPT instructions retrieve the GPR index
> similarly to find the invalidation type. Patch 1 moves the shift and
> mask magic to a single place.
> 
> INVPCID invalidation type check is same for both VMX and SVM. This
> instruction is not documented to verify the type before reading the
> operand from memory. So, moving the check to a common place in patch 2.
> 
> v4:
> - Changed commit message of the patch 1
> 
> v3:
> - https://lore.kernel.org/lkml/20211103205911.1253463-1-vipinsh@google.com/
> - Patch 2's commit message is more detailed now.
> 
> v2:
> - https://lore.kernel.org/lkml/20211103183232.1213761-1-vipinsh@google.com/
> - Keeping the register read visible in the functions.
> - Removed INVPCID type check hardcoding and moved error condition to common
>    function.
> 
> v1: https://lore.kernel.org/lkml/20211011194615.2955791-1-vipinsh@google.com/
> 
> Vipin Sharma (2):
>    KVM: VMX: Add a helper function to retrieve the GPR index for INVPCID,
>      INVVPID, and INVEPT
>    KVM: Move INVPCID type check from vmx and svm to the common
>      kvm_handle_invpcid()
> 
>   arch/x86/kvm/svm/svm.c    |  5 -----
>   arch/x86/kvm/vmx/nested.c | 10 ++++++----
>   arch/x86/kvm/vmx/vmx.c    |  9 +++------
>   arch/x86/kvm/vmx/vmx.h    |  5 +++++
>   arch/x86/kvm/x86.c        |  3 ++-
>   5 files changed, 16 insertions(+), 16 deletions(-)
> 

Queued, thanks.

Paolo

