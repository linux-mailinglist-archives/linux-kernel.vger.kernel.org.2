Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B431DEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhBQSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbhBQSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613584858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWiGWfzcYfTRYNwn5bn45x4oOrqQ38WANY07Gox027I=;
        b=Vg5iOKLlpY3l2AmadbjyvMf0NjuXS4GoP+QpVbwUjPgouEeTTmTI4YcwhqL+9/lPIE+erH
        QIo+HfoXB9fymF7WGqeddGnIFo6Evk+n4awmgDz/Bf+yMRqw6gZQpoeLOnpyFrX4r/klEt
        SpTGJML+NO6CnxhPw3hd6r1HXwkLH8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-TDLMJpbpNXW2ynjUdDCSvw-1; Wed, 17 Feb 2021 13:00:56 -0500
X-MC-Unique: TDLMJpbpNXW2ynjUdDCSvw-1
Received: by mail-wr1-f72.google.com with SMTP id c9so17108506wrq.18
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 10:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWiGWfzcYfTRYNwn5bn45x4oOrqQ38WANY07Gox027I=;
        b=JHWrRotQJrzM9fi/ZRVT3v399u7UbMXGs65QIbxRrRrtICX2c3g2wVwNGNGEavRhbo
         u4FhAjEMh3S4mdKAHse7ZDQTOyHW62GnqWJoiH3yKmNc/LwmusHbqmp3x6AI0guLqOov
         M+nvfepFLZMAoZVYdVunqBWbFJzKUsZQyMKbzSv7uuuNNlkDo8JWTXG1chAXtIQFIdqQ
         Uwg1dXh+FQ75qX9VLQVzAb7d+GePTWEpA34xpYtrwjZj30v8cYoLJ6PT+WZ4RjDFQWH3
         bp+9M6/Wfc3ME2HFMJIKjOuJLj71sAT0FU5f45Gvj3rQJ0gdIDZUknzd33AriywJpqCJ
         e1Rw==
X-Gm-Message-State: AOAM532TEP+qOQX0ZMrdJ8QU1ieKnjl70YJrXs4JKa7Gudf70McimjAf
        Fg9RzfbfjAMWng0/6dH68fTJaSbOTftp4+YcUSuBlQmz97/AvuJOnP7nK7SxWlenIIFRyVItSHl
        Gkp1dJ1A1hloJommg/MBSL1dA
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr333595wrp.345.1613584855099;
        Wed, 17 Feb 2021 10:00:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFbK08+UJ8QUvz0FNgBrsOTzClkMMR80nNg+ZQ4AVeH8xPFZd3/7fo8iwxuuNubrXMLO5KEA==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr333563wrp.345.1613584854817;
        Wed, 17 Feb 2021 10:00:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l1sm3917755wmi.48.2021.02.17.10.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 10:00:53 -0800 (PST)
Subject: Re: [PATCH 4/7] KVM: nVMX: move inject_page_fault tweak to
 .complete_mmu_init
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210217145718.1217358-1-mlevitsk@redhat.com>
 <20210217145718.1217358-5-mlevitsk@redhat.com> <YC1ShhSZ+6ST63nZ@google.com>
 <5a8bea9b-deb1-673a-3dc8-f08b679de4c5@redhat.com>
 <YC1ZI6DW49u0UP7m@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4f00fbb-aeea-0aee-f22a-807aa32a3f39@redhat.com>
Date:   Wed, 17 Feb 2021 19:00:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC1ZI6DW49u0UP7m@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 18:57, Sean Christopherson wrote:
>> That said, I'm also rusty on_why_  this code is needed.  Why isn't it enough
>> to inject the exception normally, and let nested_vmx_check_exception decide
>> whether to inject a vmexit to L1 or an exception into L2?
>
> Hmm, I suspect it was required at one point due to deficiencies elsewhere.
> Handling this in the common fault handler logic does seem like the right
> approach.

I think I'm going to merge a variant of patch 5 just to unbreak things. 
But we should get rid of all this because after the exception payload 
changes we shouldn't need it.

Paolo

>> Also, bonus question which should have been in the 5/7 changelog: are there
>> kvm-unit-tests testcases that fail with npt=0, and if not could we write
>> one?  [Answer: the mode_switch testcase fails, but I haven't checked why].

