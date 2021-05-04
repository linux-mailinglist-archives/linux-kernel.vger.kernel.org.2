Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2837271C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEDIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhEDIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620116513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GhadwQE+exPzSFPPwlRcTnkbJ2oOmGADkphoNgd5n4k=;
        b=KKWqNzHwG/uLBxKaPz92thgixkQhg0WG1tsXJ+Y+F8j/JGQNXNhOwptFAQ2sYj1MEMIWLG
        QJslHxhvWSJM+m16E1hPE3uTODHeiH5IDw+OaE56Udd0VNZQhiJSk+VtM/DOMqw+TLHvJa
        rpotwfHAWvLZDWWvpjC5shC9eszDLqg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-FjCO7xIIPWC6Mwp8TcNOwA-1; Tue, 04 May 2021 04:21:50 -0400
X-MC-Unique: FjCO7xIIPWC6Mwp8TcNOwA-1
Received: by mail-ed1-f71.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so6043413edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 01:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GhadwQE+exPzSFPPwlRcTnkbJ2oOmGADkphoNgd5n4k=;
        b=dRjgQIG/dqCKQSt7Dx41GEK3ehQPimubp3hY/J1MdmrCDrWMCMj1fyYVN9ppZnsmC1
         w8cv1inYYIWMlBnztW+0L7dj8KVZsOMem46OwHe9Kdb1cUSbdroiFLfYm33qb2fB2W3s
         ccGnDtKOrzRSa59oqkpMyFNZH3jTc4M/wvyO4joMhv6GMLHHD7U3BCU7/lTLnFhhibKC
         UzUqlIYYh82NynVGTG59lZ28Oq5UXEHEcbpSTIQZrkesAX1aSg1P1pu9cqzYSJO9X+Jc
         ajDYYPC4aItZdPdHmbCbdKJaRdV+uug/KtevpsU8nLlkBTn7tCBRvrzNGVK7Ha2hLKee
         Rd7Q==
X-Gm-Message-State: AOAM5325oVrkAUI0+2g09kqRjfTwaRCW6vEoYvJpVuhbKHYYTHcNnX78
        3d/Z5Q/k+G1n9rDGlnGeclld5FXeh0JjT5CdOxe/BaiWZhjpcgnrK2th+PiidpVUoFDYia8iZX0
        xWWaHVWUw/0mmdjtFkX+6gJCD
X-Received: by 2002:aa7:c30c:: with SMTP id l12mr24469557edq.217.1620116509419;
        Tue, 04 May 2021 01:21:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaVeUuxtPavqNx+CwxlQ0X1+K+Hn5qr9xpndSgFIyEPL3es3Is06zysstjxyTbN1yZ/OOt8A==
X-Received: by 2002:aa7:c30c:: with SMTP id l12mr24469533edq.217.1620116509277;
        Tue, 04 May 2021 01:21:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ch30sm13593625edb.92.2021.05.04.01.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 01:21:48 -0700 (PDT)
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
To:     "Denis V. Lunev" <den@openvz.org>,
        Sean Christopherson <seanjc@google.com>,
        Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
 <YIoFFl72VSeuhCRt@google.com>
 <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
 <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
 <63e54361-0018-ad3b-fb2b-e5dba6a0f221@redhat.com>
 <048b3f3a-379d-cff3-20b6-fc74dd12a98f@openvz.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <514b5373-c07b-ad34-5fba-f8850faf6d68@redhat.com>
Date:   Tue, 4 May 2021 10:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <048b3f3a-379d-cff3-20b6-fc74dd12a98f@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/21 10:15, Denis V. Lunev wrote:
> As far as I understand only some testing within kernel now.
> Though we have plans to expose it for QAPI as the series
> in QEMU
>    [PATCH 1/2] qapi: fix error handling for x-vz-query-cpu-model-cpuid
>    [PATCH 2/2] qapi: blacklisted x-vz-query-cpu-model-cpuid in tests
> is not coming in a good way.
> The idea was to avoid manual code rework in QEMU and
> expose collected model at least for debug.

KVM_GET_CPUID2 as a VM ioctl cannot expose the whole truth about CPUID 
either, since it doesn't handle the TSX_CTRL_CPUID_CLEAR bit.  Given 
that QEMU doesn't need KVM_GET_CPUID2; it only needs to save whatever it 
passed to KVM_SET_CPUID2.

Paolo

