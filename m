Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36FC3E587F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhHJKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238566AbhHJKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628592067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9pAEsCFD860K7G3ngYhHNyW2RsGuwAWwprIRvW0J1w=;
        b=M7rC4LZg2G13JHjQhCnKkJYRGYdvnUikfxwWhnOTvQ12K1Sl9me0UgyJkL8+HylSY8dPtG
        6zuTbOYgyUtE688pVXGk3dtr3eGWcnuz+Qnif+8Zt+DDqowcfj57rucvLChhB2lHCYNM1O
        ak0KOPEysegZvGkQLr3nXxkRtWG07ec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-4oUVZdhQPVe9Nz4MsAUDSA-1; Tue, 10 Aug 2021 06:41:06 -0400
X-MC-Unique: 4oUVZdhQPVe9Nz4MsAUDSA-1
Received: by mail-wm1-f70.google.com with SMTP id f6-20020a05600c1546b029025af999e04dso4772439wmg.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9pAEsCFD860K7G3ngYhHNyW2RsGuwAWwprIRvW0J1w=;
        b=dcEVj38dPGCHjU0hldEyinBCR+P8DV4zfwDhmOmdZTurVkROM+mzNtDVYmLe9vvDAr
         BD/N6KORDSVs2WIRnYthezaMjWGSfLorg3L8VHKMtnBkcvcKgqMSuCqj9yIilfCaT6fG
         mv4mgQ8MZ2BMwHgQQZ1a7izvOhcOEg8s0e5PKr7I97IvCdJtHk2lK8nZa/Ngebv9e6uL
         pIDQ3mAzKTBQxUWGNxJ93N7Bb3Wyx9p0FHPBXR9R4F8Mb1pDcJObRw5boA4+pPDDSpOB
         W1vAS8gb2rh366juoYTysYF8HyUGg+wxbjuivV+K/fhO+UwZq01052ZqbsZ1apf9MLQy
         CdMw==
X-Gm-Message-State: AOAM532IJXwcRTejIlDFu8YvOGQ8aUpPD1qyb1rX4UyWD1AUa4UDXXGe
        /UZhDL3zkxGntev4SrAJodS+GVOTdJUxHmBVlqpIez3/bj0dEBrFjsoPH18IyZxrGlJo0FZ+53k
        DvD0VUmgx3WRci4m/vwOG4fWe
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr17137336wmm.80.1628592065227;
        Tue, 10 Aug 2021 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxFkPOE/WqTwXfIvfEX6UsCx0IVanEKqLpjLWOY4PFuN4uVZV0K/DfrjVsqE4YOlcNDvFg0w==
X-Received: by 2002:a05:600c:2248:: with SMTP id a8mr17137303wmm.80.1628592064999;
        Tue, 10 Aug 2021 03:41:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id s10sm11066606wrv.54.2021.08.10.03.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 03:41:04 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] KVM: X86: Reset DR6 only when
 KVM_DEBUGREG_WONT_EXIT
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
References: <YRFdq8sNuXYpgemU@google.com>
 <20210809174307.145263-1-jiangshanlai@gmail.com>
 <20210809174307.145263-3-jiangshanlai@gmail.com>
 <f07b99f1-5a25-a246-9ef9-2b875d960675@redhat.com>
 <7a1ca89f-7b4e-7df2-e47a-ac5207137a05@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cfedf5c-e901-c65c-b654-4d004e79b6b9@redhat.com>
Date:   Tue, 10 Aug 2021 12:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7a1ca89f-7b4e-7df2-e47a-ac5207137a05@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 12:34, Lai Jiangshan wrote:
>>
>> +     * do_debug expects dr6 to be cleared after it runs, avoid that 
>> it sees
>> +     * a stale dr6 from the guest.
>> +     */
> 
> 
> do_debug() is renamed. Maybe you can use "The host kernel #DB handler".

Or exc_debug.

Paolo

