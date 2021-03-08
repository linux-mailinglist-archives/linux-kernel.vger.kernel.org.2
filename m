Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE683314D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhCHR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:28:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230502AbhCHR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615224509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68Q1xwUkanNcV5e2B7tNzGwWeOXg0fkQwRdlSBUoc5s=;
        b=LUkBKHp0432rJAnzhgKRc8ZYdTrEEZBcTrHRRaWOZzevNfp3uDh8GlSay7N0Z5x4qFlh6r
        fX5wxQBoHtRnM5ojMGTaE65URRh4wiQtGET42RW2z2frjrjM6gMKoOZ+rhvGCrTLE5taoS
        1eoxWUACCDuOOsszxY/fJGmP2nQv5A4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-fB5Ei00oO1ebpZrMfAvupA-1; Mon, 08 Mar 2021 12:28:27 -0500
X-MC-Unique: fB5Ei00oO1ebpZrMfAvupA-1
Received: by mail-ej1-f72.google.com with SMTP id au15so4417124ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68Q1xwUkanNcV5e2B7tNzGwWeOXg0fkQwRdlSBUoc5s=;
        b=r6hUIq7akxbZWL6ITOBGGWtmgOSl7i5YIiZWLs7K1NcU54mol1QepfHHIV0DUG5TgI
         pMyG6nde4M2twcQBuiOhx0JpEsYl6dMOXRcstZM059Vp/Fh33c3E/09I4XNxZQe3F0kP
         YqdM45xxB9AQfb0nLr9rhxg6XQ02O+R5XJhs9FqWYr5Ra7BkishI0bynF/MurC4L6ccF
         xHJzmnN8rw9kmQUS2RFMBT6unFCABEnl79IU8uhMj0m0HuKDzfnC/BpH6vqwc+yw9e3f
         fofcoCXhil2JP9Ks+mh66IxwEiad6pkx5s9mfdX4qn1XBs0Rb6rb72tVU5N8X7b9mOb5
         1xBQ==
X-Gm-Message-State: AOAM532iAQQdj7AlQ6fy7S0G6+RVE24GMlVhRmKwcDmsH+wSHjNJK0J1
        BsDFXim+j98MnTS7BGXk1bh/6KSgLfP56Go2aJV49Et3R6JsxtlbwI59u9IGfuelX54N09UrNaF
        ol3VDgWsZVaUD7bPlNWot5fzZ
X-Received: by 2002:a50:fd15:: with SMTP id i21mr21495787eds.384.1615224505893;
        Mon, 08 Mar 2021 09:28:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0Zyu+67mVRR61VYO+4Xe2/P4FYPxhpFhPj3T0/5mSt00vh1v0MKUMP1YkBf0lkUxJl9kuAQ==
X-Received: by 2002:a50:fd15:: with SMTP id i21mr21495773eds.384.1615224505712;
        Mon, 08 Mar 2021 09:28:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j14sm7353450eds.78.2021.03.08.09.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 09:28:25 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com,
        Jim Mattson <jmattson@google.com>
References: <YELdblXaKBTQ4LGf@google.com>
 <fc2b0085-eb0f-dbab-28c2-a244916c655f@redhat.com>
 <YEZUhbBtNjWh0Zka@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/28] KVM: nSVM: inject exceptions via
 svm_check_nested_events
Message-ID: <006be822-697e-56d5-84a7-fa51f5087a34@redhat.com>
Date:   Mon, 8 Mar 2021 18:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YEZUhbBtNjWh0Zka@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/21 17:44, Sean Christopherson wrote:
> VMCALL is also probably ok
> in most scenarios, but patching L2's code from L0 KVM is sketchy.

I agree that patching is sketchy and I'll send a patch.  However...

>> The same is true for the VMware #GP interception case.
>
> I highly doubt that will ever work out as intended for the modified IO #GP
> behavior.  The only way emulating #GP in L2 is correct if L1 wants to pass
> through the capabilities to L2, i.e. the I/O access isn't intercepted by L1.
> That seems unlikely.

... not all hypervisors trap everything.  In particular in this case the 
VMCS12 I/O permission bitmap should be consulted (which we do in 
vmx_check_intercept_io), but if the I/O is not trapped by L1 it should 
bypass the IOPL and TSS-bitmap checks in my opinion.

Paolo

> If the I/O is is intercepted by L1, bypassing the IOPL and
> TSS-bitmap checks is wrong and will cause L1 to emulate I/O for L2 userspace
> that should never be allowed.  Odds are there isn't a corresponding emulated
> port in L1, i.e. there's no major security flaw, but it's far from good
> behavior.

