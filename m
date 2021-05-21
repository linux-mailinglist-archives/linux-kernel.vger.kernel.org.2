Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70938CF09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhEUU1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhEUU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621628766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=538ECF91gJCkNsV6K0m49/DR+WsCYP9T9kKj+WEgQUw=;
        b=ACuHxYNAJK5z6GCMGSL2ToYdyk9LUxNImOhrRI5vbz7EVg1x0GV1++zOn9h+MVPqpwwjW8
        xYNl1FuiNp4n9HxCo0eeGE4PU5PDISf7yY8rcHhXU2gjGHllz8Y3aD3m03B7JFCAMUYLJU
        Y2ToEpi1OpFw3PoFVmlxmLHsZu31UJA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-BU8uUIh-Pm-ejtL5cN0G0A-1; Fri, 21 May 2021 16:26:02 -0400
X-MC-Unique: BU8uUIh-Pm-ejtL5cN0G0A-1
Received: by mail-ed1-f72.google.com with SMTP id v18-20020a0564023492b029038d5ad7c8a8so6962798edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=538ECF91gJCkNsV6K0m49/DR+WsCYP9T9kKj+WEgQUw=;
        b=skdWKAoxihgHHC6GpFwLSGMw0eOryF29wipox4EBvV0W4RR8mkIDw7QQXDprCd2xt4
         Qfi1q4bEnSmb8Xl/B3uC3VcTCFrNQYvgSGeHLtxU1CFO3iI+sa2WyiPox/bCUz20y3El
         X1CibeOlyXVye3MOLzbehmfe21LCiNqa6ra8tLPoPj0n3/33P84QjS07zJcqtUoy2gfn
         H8E+eHjBClCUwUaUGWpbS42+32J7YubSeDoDvU9HGT6z/ah8NoJcetlEQfRh5H9IW26l
         lj50r/y5NG+W4AARkqwDyh3y+9IjxP3hucZ7VmzhcNV9tngyhANtsFI+UPmlWg1jKqOG
         4eRA==
X-Gm-Message-State: AOAM533m9BF/UzVc0t8ZcJK71Nr9JcdOrp+XCu1n8cpIpOJFCgT8W62V
        mdZbSneCLRHUlcDsqs2VaruHEGCeZClkneBuJ5R4QEJVLDnXNBcMtkI/oSy+uix2iOMNnjuU2CV
        axfQy/4PdbsCLuDxnAoz59Wjf
X-Received: by 2002:a17:906:408d:: with SMTP id u13mr3539572ejj.128.1621628761493;
        Fri, 21 May 2021 13:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWdTt0OF6CxsPUnwkdM+BeqLBz1MEl7r1QIb+Pld1fs/jKvj4IlpWl2lFYHMg6LfydV3c3fQ==
X-Received: by 2002:a17:906:408d:: with SMTP id u13mr3539559ejj.128.1621628761262;
        Fri, 21 May 2021 13:26:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l28sm4751766edc.29.2021.05.21.13.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 13:26:00 -0700 (PDT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>, anup@brainfault.org,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, graf@amazon.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <mhng-37377fcb-af8f-455c-be08-db1cd5d4b092@palmerdabbelt-glaptop>
 <ff55329c-709d-c1a5-a807-1942f515bba7@redhat.com>
 <YKfyR5jUu3HMvYg5@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v18 00/18] KVM RISC-V Support
Message-ID: <00d96cc3-026e-bd78-db08-f9e98a4abeff@redhat.com>
Date:   Fri, 21 May 2021 22:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKfyR5jUu3HMvYg5@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 19:47, Greg KH wrote:
> If this isn't in any hardware that anyone outside of
> internal-to-company-prototypes, then let's wait until it really is in a
> device that people can test this code on.
> 
> What's the rush to get this merged now if no one can use it?

There is not just hardware, there are simulators and emulators too (you 
can use QEMU to test it for example), and it's not exactly a rush since 
it's basically been ready for 2 years and has hardly seen any code 
changes since v13 which was based on Linux 5.9.

Not having the code upstream is hindering further development so that 
RISC-V KVM can be feature complete when hardware does come out.  Missing 
features and optimizations could be added on top, but they are harder to 
review if they are integrated in a relatively large series instead of 
being done incrementally.  Not having the header files in Linus's tree 
makes it harder to merge RISC-V KVM support in userspace (userspace is 
shielded anyway by any future changes to the hypervisor specification, 
so there's no risk of breaking the ABI).

At some point one has to say enough is enough; for me, that is after one 
year with no changes to the spec and, especially, no deadline in sight 
for freezing it.  The last 5 versions of the patch set were just 
adapting to changes in the generic KVM code.  If the code is good, I 
don't see why the onus of doing those changes should be on Anup, rather 
than being shared amongst all KVM developers as is the case for all the 
other architectures.

Paolo

