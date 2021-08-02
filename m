Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126F33DDCAE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhHBPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235311AbhHBPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627919222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBaO0yskfvB1zK3p27gj9eBCF5tIPQg8vdX0L4bNNNI=;
        b=D/XG4psezmFJruwEZnNCG71qpTl4kQUueS9YKs/r5T6iQIyug1OqKr3u2fW3aArsxmpjXy
        8mbpQmRGa1TMtUEHbv+XIPqoYxq+rhHBaFlFeny6rDjTbJiq9jBhnf4LdUtNhx7ckixfbH
        pPuIw8TPehEb3FZms8T6wh2QKV9jT8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-gcVxWTANOou7s2UxHQ-YbQ-1; Mon, 02 Aug 2021 11:47:01 -0400
X-MC-Unique: gcVxWTANOou7s2UxHQ-YbQ-1
Received: by mail-wr1-f71.google.com with SMTP id l12-20020a5d6d8c0000b029015488313d96so884022wrs.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OBaO0yskfvB1zK3p27gj9eBCF5tIPQg8vdX0L4bNNNI=;
        b=nKqVWyPxrgbHmiMcSNB1Kd118c8VkPoQoTJDyPIBvrGA32DFx3BrEQQQjFk4zhQhrQ
         ktnGmHgShb4RPi0B0VIdlTqXdAgqU9cqEkJwj7NUaReVy+CGlhv9AgpgWv/2R3/ey+3T
         F6EnbDMlESY2voKZ5Jr2UeSq8bQK5VhCqiddpwvzeUxFONVpRJHTPxEHS6w62SbPNQAb
         L0xmVIHCU/CLWZSFelsF7bMMaYkk02iAn7ulqJONdXHo315hbH3xrn6mo5O3C44RY7zf
         RA+vdOhuLwqQj+h9YWLTG/iSEmZFLKFuPJ1/8ehiGhwKOTVRAVvI8+2hqJlbuJe688qU
         DfmQ==
X-Gm-Message-State: AOAM530Lv8IHVG2MhmQCo7LYy/mK+2cd8UwBabB8zZdEjHzg/2KcDrKK
        Qt9DC6P8MTxZFeVuuCM3kXTYiVOz22tGtwqZkTQvVmA9XYyuHlYvZEsQSYMNUEh/exfXefHBGBa
        +ay28bETpZZ1sSaxRAWDyZfKx
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr18076322wrm.59.1627919220028;
        Mon, 02 Aug 2021 08:47:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKJ0oh7T9bL3qnP5LMKCiXliBLU7Zbaacor1yX+gUNmJc7/SXOmdfjRXe8LvdFZ+x7zCoTAQ==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr18076294wrm.59.1627919219812;
        Mon, 02 Aug 2021 08:46:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o28sm12119412wra.71.2021.08.02.08.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:46:59 -0700 (PDT)
Subject: Re: [RFC PATCH v2 00/69] KVM: X86: TDX support
To:     Sean Christopherson <seanjc@google.com>
Cc:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        isaku.yamahata@gmail.com
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <0d453d76-11e7-aeb9-b890-f457afbb6614@redhat.com>
 <YQGLJrvjTNZAqU61@google.com>
 <dc4c3fce-4d10-349c-7b21-00a64eaa9f71@redhat.com>
 <YQgLRLPz3YNiIVK6@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72587835-d315-a1bb-b240-e957a586da7c@redhat.com>
Date:   Mon, 2 Aug 2021 17:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQgLRLPz3YNiIVK6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/21 17:12, Sean Christopherson wrote:
>> Fair enough (though, for patch 2, it's a bit weird to have vmxoff in
>> virtext.h and not vmxon).
> I don't really disagree, but vmxoff is already in virtext.h for the emergency
> reboot stuff.  This series only touches the vmxon code.
> 

Yes, that's what I meant.  But anyway I've dequeued them.

Paolo

