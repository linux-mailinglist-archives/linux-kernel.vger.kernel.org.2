Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D363B2372
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhFWWPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 18:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhFWWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624486379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI3bpzwl+9lRSuSFRNo0yswkG4pYNG6+9xza8sRUOac=;
        b=AS8ujqJ19bS7qdSzWIVgAfUPDOy4dT4k/w6ph6AtWzBfhR1TZcVPbcxF1rjgFR9xRF9nqx
        W3IkG7gl9y2BKCewpbztnoNamJ2SuduyG/7FB1CZ81b0qJBizYPw3sdV7XHR2szSMYRwpY
        +RouoHStoGnSeGU39Qo2LhOpU1UKMNQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-foTOIhPuNGi9MOxn6-g0XQ-1; Wed, 23 Jun 2021 18:12:58 -0400
X-MC-Unique: foTOIhPuNGi9MOxn6-g0XQ-1
Received: by mail-ed1-f70.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so2102714edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RI3bpzwl+9lRSuSFRNo0yswkG4pYNG6+9xza8sRUOac=;
        b=qlV640xOURsSiw+8D0uf8hFmNnmx0MR9TvJmlGLCTUe6XRPRjtaawEEIaOngZB7d3d
         HYNNC0zQzLp+09DLL4EtXUNpv5UF6xfkIvw203wES5KfEymFYIahCFZFDNX4q7T/C0Mq
         elSjV7vB7wm54+xFwEYY8uI8nbOOUp1OUur2yQpFG5h0jdEqcXcVQMhEHoWPskfRDUwc
         IyFhWKI/3FA6nfSju/zVBxkkIvar/odh39GB2e0G+H4Zy2lOu61kz4ipW7rZmP3lyA91
         7m1pPha0OW14D4u/2WuOvffZvnh8uqbYQYjPfdzFguV82qKmffqC5wDfcVW2UrXcNmPl
         3MAg==
X-Gm-Message-State: AOAM530lauW42Qbjy2Xni/PiXQBJ+kEoFZZydiS9pS/Kcz40DMOkNDtL
        /I5q8BtvFeRjFp2x+2nTaKxVwEU61sJOimrlljgJnxN5VgHudAXhLOgZgS+cdly5DNk9uUwNUf2
        qkJrDtYCTTK1kKkm6QKDUdMvk
X-Received: by 2002:a17:906:6ad3:: with SMTP id q19mr2089777ejs.11.1624486377003;
        Wed, 23 Jun 2021 15:12:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz23lnkyS8pgkuHkgkoqeGalGDDxaV/9NdMfAgAvm/CcnpOfH14xYP5wOBkIhPjaaBrvcPTPA==
X-Received: by 2002:a17:906:6ad3:: with SMTP id q19mr2089763ejs.11.1624486376856;
        Wed, 23 Jun 2021 15:12:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y16sm373010ejk.101.2021.06.23.15.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 15:12:56 -0700 (PDT)
Subject: Re: [PATCH 00/54] KVM: x86/mmu: Bug fixes and summer cleaning
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <b4efb3fd-9591-3153-5a64-19afb12edb2b@redhat.com>
 <YNOiar3ySxs0Z3N3@google.com>
 <d9004cf0-d7ac-dc7d-06ad-6669fe11a21b@redhat.com>
 <YNOwz4ln0MsI+/Ts@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80a120a4-305d-33e7-6f97-eb2f154f4cef@redhat.com>
Date:   Thu, 24 Jun 2021 00:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNOwz4ln0MsI+/Ts@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/21 00:08, Sean Christopherson wrote:
>> We can just mark them static inline, which is a good idea anyway and enough
> But they already are static inline:-(

Yep, I noticed later. :/  Probably the clang difference below?

>> to shut up the compiler (clang might behave different in this respect for .h
>> and .c files, but again it's just a warning and not a bisection breakage).
> 
> I was worried about the CONFIG_KVM_WERROR=y case.

CONFIG_KVM_WERROR can always be disabled.  "Unused" warnings do 
sometimes happen in the middle of large series.

Paolo

