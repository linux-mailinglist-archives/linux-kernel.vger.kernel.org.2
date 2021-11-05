Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB4446324
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhKEMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 08:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232884AbhKEMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 08:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636113984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JEVL9kaZ5YWgWyM6e1AP/E44Yg0OSeQJGoU0yyFJn4=;
        b=Nf65vuYYta31fnfrSpWXHYgeLEMXRTxPxCluEHSko8fLl+W07UC+JhfiPfXFmruPqTTu9J
        3/uAnWWp64t/HlN+Opph+u9H8eMZAhV07f6Tb8V558IJSh8SsPbi8iVBlIPQFY3jgcFbR9
        8sUpfTzbvXKdWzJ7iD1CXPLDLiCvi3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-dteQ7GAsP6yBYHzN5O4jmg-1; Fri, 05 Nov 2021 08:06:23 -0400
X-MC-Unique: dteQ7GAsP6yBYHzN5O4jmg-1
Received: by mail-wm1-f70.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso5588236wml.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4JEVL9kaZ5YWgWyM6e1AP/E44Yg0OSeQJGoU0yyFJn4=;
        b=YYPn7cNFm0X+PPPLYExeDhMYiP9ZIbN/5Xve2ofl+9clsWCn7R6oua6aEAxoqYV7dU
         ohM1zlq0+tQ4QsjZ0derA6S/28reJVUfTlInQnDthFjgJ2JxGxEy9IZ0blAl/VFea20y
         SYJcae03YIJyUky7hOrYMuR/fpfooMYowGn5hPKfZsnMP2D/JiG17gBkyJMsnEAm+81c
         DGw3ix535ISKVJNPWFB2eTQJReAeDYFvxIUwvPcXbxzMGbjVu4IpmmZbRzUFBze/BDCL
         4SGuXJPcrynfZQqkzqLocDjEZdn1YqCFQHNTDEjMK2fNuFKs5MLJQRQPt+kbASJ6XgAA
         dnLw==
X-Gm-Message-State: AOAM531qt6wsZTH8ZlMvYE9DU38RaGsMtxtaDVzfqlh6iytNzjxXzhnm
        x8eLqC2LRgEYDR5iBYlQPFY9jBlw8ve+OIqoKObavp2QfmnO5YvPRHMMm+Nx9t5yDX6vLo+n0AM
        StOMwpSZEHcofqtpgtnYKcdZBQYKoQQGhs3soHYv9sRAXEj0fMcsdGqKb1f2fD098lZtRoM2Q65
        Lw
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr8999964wmq.138.1636113981820;
        Fri, 05 Nov 2021 05:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxVGb6OVsbfH4wjAEiB5USq1IGqLSb7//D+Ranuv7y7/+oIc7B9YN0mcWZvlV9LAlGYyNpgg==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr8999921wmq.138.1636113981528;
        Fri, 05 Nov 2021 05:06:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l4sm7494011wrv.94.2021.11.05.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 05:06:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: nVMX: Track whether changes in L0 require
 MSR bitmap for L2 to be rebuilt
In-Reply-To: <YYSDbljJgpEOnx+W@google.com>
References: <20211013142258.1738415-1-vkuznets@redhat.com>
 <20211013142258.1738415-4-vkuznets@redhat.com>
 <YYSDbljJgpEOnx+W@google.com>
Date:   Fri, 05 Nov 2021 13:06:20 +0100
Message-ID: <875yt6lscj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 13, 2021, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index 592217fd7d92..2cdf66e6d1b0 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -148,6 +148,15 @@ struct nested_vmx {
>>  	bool need_vmcs12_to_shadow_sync;
>>  	bool dirty_vmcs12;
>>  
>> +	/*
>> +	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
>> +	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
>> +	 * this flag can only be used reliably in conjunction with a paravirt L1
>> +	 * which informs L0 whether any changes to MSR bitmap for L2 were done
>> +	 * on its side.
>> +	 */
>> +	bool msr_bitmap_force_recalc;
>
> Belated bikeshedding...  What about need_msr_bitmap_recalc to follow the above
> need_vmcs12_to_shadow_sync?
>

'msr_bitmap_force_recalc' was suggested by Paolo but
'need_msr_bitmap_recalc' sounds equally good to me.

>> +
>>  	/*
>>  	 * Indicates lazily loaded guest state has not yet been decached from
>>  	 * vmcs02.
>> -- 
>> 2.31.1
>> 
>

-- 
Vitaly

