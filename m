Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8ED4366A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJUPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhJUPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrRcdVxpJS7I9scrv7ojtxkuOUqX9VRgc3hJ9YIuX40=;
        b=fvlBwZ4xNPbg/x3NgJfdRBchdNC7u0oHzVEjZM18YbTAluLQ1JP18KUTFjUAOqyYB0UcpC
        kohDMK6yoTPABgA8tKQ8QsTPrh7oL9MG3ldRBbBoSyN4qhJS58o5cuQ8X3L5rIRyn9dr8B
        ZwLmCi3vZFZP7oK0HFRtqrmYJb6We+w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-4W4tVg3IOxWE0GFhSvN8Uw-1; Thu, 21 Oct 2021 11:43:25 -0400
X-MC-Unique: 4W4tVg3IOxWE0GFhSvN8Uw-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so748715edl.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wrRcdVxpJS7I9scrv7ojtxkuOUqX9VRgc3hJ9YIuX40=;
        b=WEFDE4K3Y+qbAtoWAFgfSLE0frFnsrpUvywEA30kSpsgWSf8t8weqf0hSIuZNhKhz7
         l4ybidw6gHJ2Fx2kUqxsCCn6nxwjrpBEtmpGfkfXV1UfUgNvKSBV1xJiV1Wdfdfv1LiR
         xPo7NkVj+ZubjX3C05ax9/ZGdQWCnDYYOlzppeGoqkhxfHbgNtWffkRP2eJuiBWbizK+
         4HSDtnGQNQib8Nub/SUEnnJ0UN1+l7DM/yW5SB2hj6YFwfNlDgVoBvkXVaxzybm6toFY
         KWAwnEwo4POkV5lLCeJP+KQgzaJ6W6kelA1Ys8zymH2TDSiEe6wWwUuRqSH7fkz6LvLP
         k6Aw==
X-Gm-Message-State: AOAM531L3Qzc8GrlEV7q3YqBP5ZCAXjIARME6Hbz5Q6+n7X6pxsrI3rp
        1UnDazsU6B/yUGGN7e0SgVyfl4oQQVCngpuOBoTla4eekWFWAPMZmuILf+2mAXYBxUqicU0tucQ
        P1+dBaQRojxnGtNclh3WTqKuN
X-Received: by 2002:a50:e14c:: with SMTP id i12mr8504878edl.125.1634831003864;
        Thu, 21 Oct 2021 08:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDPWN/en5wVhnU7VDIOTI9urEVpR9kawe7unnx2IoWCOSX4QAfTGwzdlyzb3yZgI4S+oNiQw==
X-Received: by 2002:a50:e14c:: with SMTP id i12mr8504826edl.125.1634831003495;
        Thu, 21 Oct 2021 08:43:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id x22sm3063222edv.14.2021.10.21.08.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:43:22 -0700 (PDT)
Message-ID: <850e87f4-ad0b-59d7-6e31-b3965b6b6492@redhat.com>
Date:   Thu, 21 Oct 2021 17:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>, Marc Orr <marcorr@google.com>
Cc:     linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203710.13326-1-michael.roth@amd.com>
 <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com>
 <20211012011537.q7dwebcistxddyyj@amd.com>
 <20211012125536.qpewvk6cou3mxya7@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211012125536.qpewvk6cou3mxya7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 14:55, Michael Roth wrote:
> One more I should mention:
> 
> 4) After encryption, the page table is no longer usable for translations by
>     stuff like addr_gva2gpa(), so tests would either need to be
>     audited/updated to do these translations upfront and only rely on
>     cached/stored values thereafter, or perhaps a "shadow" copy could be
>     maintained by kvm_util so the translations will continue to work
>     after encryption.

Yeah, this is a big one.  Considering that a lot of the selftests are 
for specific bugs, the benefit in running them with SEV is relatively 
low.  That said, there could be some simple tests where it makes sense, 
so it'd be nice to plan a little ahead so that it isn't _too_ difficult.

Paolo

