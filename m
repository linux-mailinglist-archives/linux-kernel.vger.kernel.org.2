Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82A6414D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbhIVPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhIVPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632325525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s47uJvMz2TQnGUC16+QzZF+8Fos67Scg5vuqp2IND9Y=;
        b=eLCLCrbhf8tgSxJuy8xdkXanOTTqkAqG7oaBi2v47h1G5HQ4WtUjPRlrTC0YUPFjJ/0gsQ
        GnvtTFtUyrESNAow/4lUE8aWw8kBUvN6E1yqdMkgpU8Ovex6dq/vhzDll9C37p48Xcr2hH
        lgF1HmkZakpcMa1bAP5g6lywAvO+JPI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-8r7DPuMmMJuXG1R3VY4-FA-1; Wed, 22 Sep 2021 11:45:24 -0400
X-MC-Unique: 8r7DPuMmMJuXG1R3VY4-FA-1
Received: by mail-ed1-f72.google.com with SMTP id o18-20020a056402439200b003d2b11eb0a9so3467947edc.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s47uJvMz2TQnGUC16+QzZF+8Fos67Scg5vuqp2IND9Y=;
        b=aUBdRGZf5nqaG46hjDoKbEu7TGOqY5Xmnrqamu6A2YHMoP9KJS8xuqRagPA+XKIqOo
         4zyHUStDL0ND8/r5uP2ght4srT41r7adh+iiGYgdDspqSehOKU7XSIvv0JmgsOH9azJj
         h0FF6DdxyL/qLQCo/pdcZyY8EyL6oRMuYXBzdzKOlos2YxmXhV+cdTW8Ncz1+dNumzR+
         dOSYh0wgdr2DukYu/OkyudFmbm+nXrSp/nkk3SOWYrWArLkvdRoj06rGY0BmtEoO+YCq
         trIpBJc4LljEI/oF1JPdC0GFH6qteCIg5nH1MEGcvKBnrvX8H/MPG1s3g6uFbQPPj0ce
         IQyg==
X-Gm-Message-State: AOAM530FahjddbXklP88giDyZAqzpx3x6oNoukGZtT6JG/odE3tvjH+a
        RNfzrG9zLVm5rZQiAeRRUVDfWyWqIgr59sxLuAJolgjcwFri0CN9qCgXFhFEf2qP7vnGit4PcMm
        u8qM1Dz7YUF73zs8t063y3P2T
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr335074edu.144.1632325523535;
        Wed, 22 Sep 2021 08:45:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9E7YPbKPpg2K5k5md15deOC/+gq8likqMYfogKDvxQnXwcsGrCD3ObAK82K9RPmuuvaCDIQ==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr335057edu.144.1632325523328;
        Wed, 22 Sep 2021 08:45:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c17sm1407211edu.11.2021.09.22.08.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 08:45:22 -0700 (PDT)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20210913140954.165665-1-mlevitsk@redhat.com>
 <22916f0c-2e3a-1fd6-905e-5d647c15c45b@redhat.com>
 <YUtBqsiur6uFWh3o@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/7] KVM: few more SMM fixes
Message-ID: <427038b4-a856-826c-e9f4-01678d33ab83@redhat.com>
Date:   Wed, 22 Sep 2021 17:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUtBqsiur6uFWh3o@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/21 16:46, Sean Christopherson wrote:
> On Wed, Sep 22, 2021, Paolo Bonzini wrote:
>> On 13/09/21 16:09, Maxim Levitsky wrote:
>>>     KVM: x86: nVMX: re-evaluate emulation_required on nested VM exit
> 
> ...
>   
>> Queued, thanks.  However, I'm keeping patch 1 for 5.16 only.
> 
> I'm pretty sure the above patch is wrong, emulation_required can simply be
> cleared on emulated VM-Exit.

Are you sure?  I think you can at least set the host segment fields to a 
data segment that requires emulation.  For example the DPL of the host 
DS is hardcoded to zero, but the RPL comes from the selector field and 
the DS selector is not validated.  Therefore a subsequent vmentry could 
fail the access rights tests of 26.3.1.2 Checks on Guest Segment Registers:

DS, ES, FS, GS. The DPL cannot be less than the RPL in the selector 
field if (1) the “unrestricted guest” VM-execution control is 0; (2) the 
register is usable; and (3) the Type in the access-rights field is in 
the range 0 – 11 (data segment or non-conforming code segment).

Paolo

