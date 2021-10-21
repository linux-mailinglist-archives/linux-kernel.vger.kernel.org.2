Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6744365F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhJUPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231533AbhJUPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634829771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pB0OKk0sXihZTGW0ponhLiCPuMdm6BJGDBBh4jppD/I=;
        b=MWs6+Z1lBUU9D7EqZqt2r3z4J+8HqRTe91zSkMHMcFOcY3Ne2JuLbQccHaS/Z+arXbJNrz
        HOVbtZxCXVXMTr2Nvb/7suDYec/eZVvoC2Yf4FuLGDqv3bpv6kpkyrTAuqins4sI+m+CuB
        5fuXq6145tW2ga3UNI3nY8HD/040efo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-hvlpMy7PMN660PQp7qQLEQ-1; Thu, 21 Oct 2021 11:22:50 -0400
X-MC-Unique: hvlpMy7PMN660PQp7qQLEQ-1
Received: by mail-ed1-f69.google.com with SMTP id p20-20020a50cd94000000b003db23619472so680301edi.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pB0OKk0sXihZTGW0ponhLiCPuMdm6BJGDBBh4jppD/I=;
        b=yuyEZtg5Ig2pAd4n33iT5Lw46IdP97zajexEwDUUuDS5UAhUNBp73Xq6boIvuqff8g
         Q2LinIbQhhG5FDiQzvfeWkHe+6vk/h+oZLqAbTCchlC+pvuoRSDwWEYgcldmf03UMcGN
         g5NCS3Ra78eekFx/5nmvUTTQm5dXlj58Ux7IQ5wIH+tlkTxCLlxGky3hUDik2W04YOou
         XdG+HlT4ZRQKKKk5wfnM0RXiXkcn3DXiwBwkORIuPjiF3RmqChwD8QYmqBL0PlrWvE5f
         QHWXhxU86avdO4EdFP7BBPpwAUKuKFwIIa5oKF7lMul6rdE4l9AkrI5CrLT0gHnGo2T1
         L6aA==
X-Gm-Message-State: AOAM5333D/s6lV5C+9I28WhLklbuiCq5++r8qRzuFSuZzuBVHBitKmsu
        UaS6A7Nh7BYDb4qj6leVxnx+SByt9Dk5lz4e7uM1sqtDabvnm45sCq3KEFddVJs+qyE6dDepPPR
        k61xyiP+mYNcU/+OnfJ3NWol4
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr8188887edb.67.1634829769338;
        Thu, 21 Oct 2021 08:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm5zy+bVdhGS6ehh9nY0zcbRzhx5q8oMxMLk/wp+LnBV7GtCAZEJhxnoikSAKgtbD7UE1Gkw==
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr8188866edb.67.1634829769164;
        Thu, 21 Oct 2021 08:22:49 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id c8sm2772289edt.55.2021.10.21.08.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:22:48 -0700 (PDT)
Message-ID: <7920a4e5-edb4-504c-a30b-7410e425eb14@redhat.com>
Date:   Thu, 21 Oct 2021 17:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 02/16] KVM: selftests: add hooks for managing encrypted
 guest memory
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
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
 <20211005234459.430873-3-michael.roth@amd.com>
 <6b8e4fb7-fb96-bc3a-dc46-70d9f07d3c8d@oracle.com>
 <20211013150719.mnde2lw6ffks7pm4@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211013150719.mnde2lw6ffks7pm4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 17:07, Michael Roth wrote:
>>
>> For readability, it's probably better to adopt a standard naming convention
>> for structures, members and  functions ?  For example,
>>
>>          encrypted_phy_pages    ->     enc_phy_pages
>>
>>          struct vm_memcrypt  {    ->    struct vm_mem_enc {
>>
>>          struct vm_memcrypt memcrypt    ->    struct vm_mem_enc  mem_enc
>>
>>          vm_get_encrypted_phy_pages()    -> vm_get_enc_phy_pages
>>
>>
>>
> Makes sense, I will use this naming convention for the next spin.

And again I liked yours more. :)

Paolo

