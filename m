Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174E41B477
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbhI1Qyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241812AbhI1Qye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632847974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYeM2BwVL2FH1znTttVwQ9drxcw+lrSQPQ/aZbJu5sk=;
        b=dUbG5P7a1Zdz1YHzOVNQEEPN7NXOTp2IXcXHHK8fzfClOxQJIZ5Drn3o8faxTzDqnr1ic3
        icvfKxB/hVnorppUi4mS3wjDIk34mbZAJMhc8AsdVgbG9G1xzf6ipEOONH37HrMpa2f6Es
        Sn2Ga3jSFur9x1686GIAsa07xlXFK1s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-3BkHtYTnN2OaMeBcUfebzw-1; Tue, 28 Sep 2021 12:52:52 -0400
X-MC-Unique: 3BkHtYTnN2OaMeBcUfebzw-1
Received: by mail-ed1-f71.google.com with SMTP id l29-20020a50d6dd000000b003d80214566cso22441937edj.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eYeM2BwVL2FH1znTttVwQ9drxcw+lrSQPQ/aZbJu5sk=;
        b=Lzg9QqHoaobffQlbzpkdshtS0zo3V4cG58pQsQyB5dynOeBK7EZ/8YUHWkAUV1WMrL
         dhHg/rH3INhIUzgBvibTir7Sg0EooEA1YHuZ9epKaYISdu1s1l0kG/5mys7C8cW+m9h5
         pfeqSWANY92I7cyQABV4Y+HKHRCuF0Zz6L10ctWdbFM2/DdF2s2tA59qKaJKU9llB4en
         r35lS+52w+VE6R0Ox2zz/zgdmlSCDWrgdJ9wJxVRZenuDaz1R35KKsvDsdNRPGIwK4aY
         VsBP/+qBEuPHkvKvZFGlVbQJxUU0cspwDHAfzKrVqCXeGxiR7TWRydjJ/IfQtPsW5/LL
         YAzw==
X-Gm-Message-State: AOAM531AtNesDUwk/T4eJaSYg8WIUUKcekhXsuTCJ85qCApex0ou5SKI
        SjSOFnmwstnXDYc8e3sMwPywAyBFr8zpQ1CKj2SKzkOirtPdnqB1o135gawv1KYXQwz5lMufAHd
        ko0+PoD8gJl4vWoHcrllahR0x
X-Received: by 2002:a17:906:784:: with SMTP id l4mr7804205ejc.469.1632847971512;
        Tue, 28 Sep 2021 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBqMKGvFrekO+7KM5NYn5YmtQu7sPlCKCYqGEhvrLCtQi3c3I98CsXt4Lv8daCmNKbH67eXQ==
X-Received: by 2002:a17:906:784:: with SMTP id l4mr7804171ejc.469.1632847971294;
        Tue, 28 Sep 2021 09:52:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q17sm3459787edd.57.2021.09.28.09.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:52:50 -0700 (PDT)
Message-ID: <41b9a6c6-37b0-5d23-ebfb-134af360ebf9@redhat.com>
Date:   Tue, 28 Sep 2021 18:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] KVM: nSVM: avoid TOC/TOU race when checking vmcb12
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210917120329.2013766-1-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210917120329.2013766-1-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/21 14:03, Emanuele Giuseppe Esposito wrote:
> Currently there is a TOC/TOU race between the check of vmcb12's
> efer, cr0 and cr4 registers and the later save of their values in
> svm_set_*, because the guest could modify the values in the meanwhile.
> 
> To solve this issue, this serie introuces and uses svm->nested.save
> structure in enter_svm_guest_mode to save the current value of efer,
> cr0 and cr4 and later use these to set the vcpu->arch.* state.
> 
> Patch 1 just refactor the code to simplify the next two patches,
> patch 2 introduces svm->nested.save to cache the efer, cr0 and cr4 fields
> and in patch 3 and 4 we use it to avoid TOC/TOU races.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>

Most of my remarks from the RFC still apply, so I will wait for v3. 
Thanks, and sorry for the time between send and review.

Paolo

