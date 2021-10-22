Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364FD4371D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhJVGgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230428AbhJVGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634884429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1NT4YsOtNzkAlK5Cne+Aothcxr8Ri0vDpNi7WPQfls=;
        b=LqGINmVIjcMZt6StibItGN7uaWz8Jir1v/6gxYMIMesV8yNh9AU0dxCa3f4Y07H9fcnEUE
        Fj9xrU2M099IShwg9TzirIQTXIwGB3jpis1SVYhngsM9s5s9nhsVIK8sxQl1TKsmy4dA0C
        r2xt8L6giFzMHGoj0XUAXMjJ4XBBgiA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-kqg5W_I3MVqofykCTDUrRg-1; Fri, 22 Oct 2021 02:33:47 -0400
X-MC-Unique: kqg5W_I3MVqofykCTDUrRg-1
Received: by mail-wm1-f72.google.com with SMTP id z26-20020a05600c221a00b0030da55bc454so621882wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 23:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c1NT4YsOtNzkAlK5Cne+Aothcxr8Ri0vDpNi7WPQfls=;
        b=sqqhTxLU7VldWL71nwZkI7kSzInWSS8M8KjFuP3BB5zJdbDCRu32yzZ1nZfLO3iLcA
         qEqY1+UjS2zr2M+WMIXP3QZvRSRyQBBSL+Z5b26IxumHI8R5Q5ALx6fn4Ff8QgCj/ZSP
         S+Id/66l+U6qz3h0YXG3uKcrUR/nGQBX0dK8PYN44WmoWLhK+VS7slffAPKgn7aMlzXa
         LnZZGdmF8W1hWtTPuPqsRpHDx63kPBoRdnW2e0jXwnNGoXRSC9oKiv57BtVAP4ZSVgRa
         EzoyfMNuXaRgVlFP9M40vSK8L0em4RZXnOJ3iCW7g+3+zVvWkF0t4vpBIO5KWuL5hT5q
         skRQ==
X-Gm-Message-State: AOAM530wWjJ+GHTK1yRhb3EJsLZc7S54IK6Zv51N9oF1oLbhQ86ogjkV
        uJaPCXoXtwCDRqilLg5epRbirX1p56RH+hesvST2Ou0rFLgIwsDSzFAFv/5MTRIx4xY9atkc8IU
        RRkLzGCnhgeZzE5yHVEBbOH2n
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr2277546wmi.192.1634884426532;
        Thu, 21 Oct 2021 23:33:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTYZfVvouiiSodftXItcALsBOngFeTJ7793dnCEw8VEOUA+K7VM4rQUeNZ6wpHYbV4HaOIvQ==
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr2277525wmi.192.1634884426270;
        Thu, 21 Oct 2021 23:33:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f17sm1779186wmf.44.2021.10.21.23.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 23:33:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 1/2] KVM: x86: Add vendor name to kvm_x86_ops, use it
 for error messages
In-Reply-To: <YXGn70lhcjulaO3r@google.com>
References: <20211018183929.897461-1-seanjc@google.com>
 <20211018183929.897461-2-seanjc@google.com>
 <87k0i6x0jk.fsf@vitty.brq.redhat.com> <YXGn70lhcjulaO3r@google.com>
Date:   Fri, 22 Oct 2021 08:33:44 +0200
Message-ID: <871r4dwotz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Oct 21, 2021, Vitaly Kuznetsov wrote:
>> >  	if (ops->disabled_by_bios()) {
>> > -		pr_err_ratelimited("kvm: disabled by bios\n");
>> > +		pr_err_ratelimited("kvm: support for '%s' disabled by bios\n",
>> > +				   ops->runtime_ops->name);
>> 
>> 
>> I'd suggest we change this to 
>> 
>> 		pr_err_ratelimited("kvm: %s: virtualization disabled in BIOS\n",
>> 				   ops->runtime_ops->name);
>> 
>> or something like that as generally, it makes little sense to search for
>> 'KVM' in BIOS settings. You need too look for either 'Virtualization' or
>> VT-x/AMD-v.
>
> I'd prefer to avoid VT-x/AMD-v so as not to speculate on the module being loaded
> or the underlying hardware, e.g. I've no idea what Hygon, Zhaoxin, etc... use for
> "code" names.
>
> What about
>
> 		pr_err_ratelimited("kvm: virtualization support for '%s' disabled by BIOS\n",
> 				   ops->runtime_ops->name);
>
> to add the virtualization flavor but still make it clear that error is coming
> from the base kvm module.

Works for me, thanks! I just want to make sure people know what to do
when they see the message.

-- 
Vitaly

