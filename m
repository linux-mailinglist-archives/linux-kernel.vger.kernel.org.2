Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26A13A46FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFKQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhFKQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623430169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kblKhK/Cn+MGOQREIYRuIm8BGjc7hukPIOl/Du66sQg=;
        b=EUZXbQYSK4w5IprraI3/8wNAeSc7ptPpgQrLQw5IgAWl+zbwU4m4k+PC0GcdT0sz5VroTn
        mmLd3zZD/HK4aPP8PnJp0CWdBAqTfz3wm87htGNyTsil2GSxKa9Mkk918Vw996gGt16Oj4
        ggwfSA1nIP7PMRT5frA1PLkQyvKD3Ck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-0SBH2E14NQ2ySr4wUUpiUg-1; Fri, 11 Jun 2021 12:49:28 -0400
X-MC-Unique: 0SBH2E14NQ2ySr4wUUpiUg-1
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1cb7d70000b0290198e478dfeaso2225333wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kblKhK/Cn+MGOQREIYRuIm8BGjc7hukPIOl/Du66sQg=;
        b=FR7d11Qx7RsquP+UO/7H1viOuvrpi91kXBS8YQvg0YB7hOboxAyNzOx4JDuf5cGkGR
         GQs89aIBNvYK0oCeLC2bvX7Jwa8eDRx5kC12JG/mPXGUlIZUccEMzg4UOWuoS29H/Roa
         DYgMB3Ju9VFaEEe1SNmH7oNx+2Hox3nqKKbYLfqG3vqcCMsGEJk7+Qav9s/n7f02rDBw
         PhiupVEvKoVoL93cnp3XYTyvqUFBI6UjcyysnBOXqZPZHMrv/07/wahnKuq/ezKHstSU
         mNHVBSQeyBbeRL7T4mzn4MlHTnh46AGaMfyNmfvRHE042YcKdlgczybXh/93R8BYMaPQ
         1e8Q==
X-Gm-Message-State: AOAM530csEsvXK6vlPnzvw+dS7SpcDzLGo5IGmqOVe/F0OVIMFyfB21c
        n2fL9G0k0nYfjmMHfwlxqeIfEs2JAplFBxRPPWK24t1ZcYMN9h1VsEvvCeLZXHkgSc1RW5FH62u
        fX8suorSxt1ab6PxoYMacCH7MMkJWkZUqZtnbHKuYBi1AY1HWvOMWph3jJrdE14XoKKKLfoKJyj
        jb
X-Received: by 2002:adf:ba07:: with SMTP id o7mr5052797wrg.160.1623430166993;
        Fri, 11 Jun 2021 09:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybTDwM/CdA8ErNMBIJxXQI+bJBJuQTcrCW0oIHYBQm92cpmp6n40y/9FBVqz0TEU/RoYtXPA==
X-Received: by 2002:adf:ba07:: with SMTP id o7mr5052775wrg.160.1623430166766;
        Fri, 11 Jun 2021 09:49:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 2sm7476295wrz.87.2021.06.11.09.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:49:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Calculate and check "full" mmu_role for
 nested MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210610220026.1364486-1-seanjc@google.com>
 <b2084f55-3ce5-57c4-f580-d6a2de6ce612@redhat.com>
 <YMOTK7eYytpw58Vc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64d774e4-affa-b96e-5116-66756dc160dd@redhat.com>
Date:   Fri, 11 Jun 2021 18:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMOTK7eYytpw58Vc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/21 18:45, Sean Christopherson wrote:
>> Along which path though?  I would have naively expected those to be driven
>> only by the context->root_level.
> The functional code is driven by context->root_level, but if KVM doesn't include
> the level in the mmu_role then it will fail to update context->root_level when
> L2 changes from 32-bit PAE to 64-bit.  If all the CR0/CR4/EFER bits remain the
> same, only the level will differ.  Without this patch, role.level is always '0'
> for the nested MMU.
> 

Yes the problem is the

         if (new_role.as_u64 == g_context->mmu_role.as_u64)
                 return;

and the patch lets you preserve the optimization instead of dropping it. 
  I was wondering if I was missing something else because of the "when 
walking the guest page tables" remark.

Paolo

