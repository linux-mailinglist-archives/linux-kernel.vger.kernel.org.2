Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6843A2F21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFJPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhFJPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623338220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvvlZU+GigwYDe2gW41VAVg7tPYfG2cr//m/IuHGiJY=;
        b=Xq7QKjgAi6cOuOcjxhZ4bhrFjSG5XEHAk+G2HQy1p/AAXWFOvaQYo6nsYImLEQNzMlofL5
        w+LSoDTlvHakzmNVDikTSfXMt1OVbNuh8bGF4rsEVi+pbkPJx4GGCivmTc5yNIGu1xCcuq
        OARf3e5qwxrVEzWOTqJPUVg6DPuAF28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-xvyWKFcPNmykxAZgSQJHjA-1; Thu, 10 Jun 2021 11:16:59 -0400
X-MC-Unique: xvyWKFcPNmykxAZgSQJHjA-1
Received: by mail-wm1-f72.google.com with SMTP id a19-20020a1c98130000b02901960b3b5621so1249578wme.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvvlZU+GigwYDe2gW41VAVg7tPYfG2cr//m/IuHGiJY=;
        b=gvTnaW1SGFQ42B7gXC+W17+7TR+CIHbIjBKj3s35MGxzmhz9K38Pmn8TnwMCg/cYNU
         Iinbt1oMYXQORgguvVD9+0I6K+0BKYAGVQtrY2TkdOk2Mwaj7uZsueNVTxBdngWf1iRC
         Rx7wu1dbu38Dq7KcOCqxAzHJiuaCQXAFR1DxKJPPKB48DfXFqhy/ViK67CryWrpoQXGy
         sf1Eh98/9O0ZdIj3wHUwF9F4xL0sUbSh4M8gxWW4T7zuMtqG7ZMqwLW8VM4Q3a6RzaXv
         ZuIh2lZBHxgYQNbjqglX/zHKJ0t16RgBDdvLFQIj+CKvu6QDERr8WHjG+xAxg76GeBP2
         9Yig==
X-Gm-Message-State: AOAM531esytAj7kY6YTvvFIvzWT9fzDopkx+JfywmD0UjsNDUE1jGLHs
        RH/0hUJDsXPq0nX/Yw8/IKxqS/T0K8BN8SaqYMrGsXkpmtwYKRPs7o68eOv9eaVS3e/qf6Ph9wm
        Yh0gaI2++ensQIGBWokUEQ3Kn
X-Received: by 2002:a1c:1fc8:: with SMTP id f191mr3963422wmf.33.1623338218397;
        Thu, 10 Jun 2021 08:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOk4REtOe9YUHUfQj5Jwv3P+mhb8LGKgs2qnGVxCH1EYirT5Ot3TtCxvAz3PWOAyYfTIa4qw==
X-Received: by 2002:a1c:1fc8:: with SMTP id f191mr3963407wmf.33.1623338218245;
        Thu, 10 Jun 2021 08:16:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id o9sm3587454wri.68.2021.06.10.08.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:16:57 -0700 (PDT)
Subject: Re: [PATCH v5 7/7] KVM: SVM: hyper-v: Direct Virtual Flush support
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
 <fc8d24d8eb7017266bb961e39a171b0caf298d7f.1622730232.git.viremana@linux.microsoft.com>
 <871r9aynoe.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dacd2187-2952-afa7-3802-9a7b9b99856d@redhat.com>
Date:   Thu, 10 Jun 2021 17:16:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <871r9aynoe.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 13:16, Vitaly Kuznetsov wrote:
>> +int hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
>> +{
> I would've avoided re-using 'hv_enable_direct_tlbflush()' name which we
> already have in vmx. In fact, in the spirit of this patch, I'd suggest
> we create arch/x86/kvm/vmx/vmx_onhyperv.c and move the existing
> hv_enable_direct_tlbflush() there. We can then re-name it to e.g.
> 
> vmx_enable_hv_direct_tlbflush()
> 
> so the one introduced by this patch will be
> 
> svm_enable_hv_direct_tlbflush()
> 

I did the rename, and agree with creating a similar file that is split 
off vmx.c.

Paolo

