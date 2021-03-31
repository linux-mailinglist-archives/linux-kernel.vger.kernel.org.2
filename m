Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE36234FD17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhCaJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234709AbhCaJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617183471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKblSJ4G0KZUK+AaVEZrXgxohGJNTUFgpIBBMocDTZk=;
        b=ADY+mXCUVqOeSKoorM7p/U9MvrPaw9VRfa6ga6QMxYagduVxQ2NO8KmMoToDVikrcBlkbJ
        EymJnUo4+bP0Yo0h/WsFuffNFyhL7j2r6OBsbVi+tRTCl7NGgQrElfP4DeC53v3/MdLIhM
        Vzq/961wkB3lW6Gi6xTJlSYrjbYipzY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-sy4_b5a2Nje-2O4dMsHXdg-1; Wed, 31 Mar 2021 05:37:49 -0400
X-MC-Unique: sy4_b5a2Nje-2O4dMsHXdg-1
Received: by mail-ed1-f69.google.com with SMTP id m8so805243edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKblSJ4G0KZUK+AaVEZrXgxohGJNTUFgpIBBMocDTZk=;
        b=XWhuJQqU8eyLhmQYQt10LAasHih1odsX95L9fwvHTqYpQKkvNKNMbslX0zZdNfCf7b
         W/I8M0xBE1NItQ/tKfYjZXhmj6pnffJxDofX0cDECFBLpfc5qoAquSXZdSkzB1xrwbmw
         1NIUGk8IT08550lk0TBn6uWJwRNe28MlIBxv/HMsJYJ/pi180N0KgIQDltEgIYYcHuHm
         4lQGPMdQottoIJx2n9NjBPPzagX5yYPq3iJXnr2NX0zcGQcSAxfKEonKcMoDjjA6cvxo
         3sY77xkoSYSsOHh8fJ0ifrBEHxT/QyudjKl1AM8sDxAP++J06ePgXTs03TQS6F8w8GW1
         n/BA==
X-Gm-Message-State: AOAM5318bdC7TJF2+qGdpFtByZeFUFO+/Y5txPnn1GUSlUHJ8UeVpEHI
        rPDCkd2hOwmHcKRvvUOAW7+XOdBYhBjV5LocNi86IJbbE9KVT/ZEWjvpZ/J8pRZ58aD+IWe2mbS
        OYPmR+1WFdb5heMh4Mn5Rz5Hb
X-Received: by 2002:a17:907:1c05:: with SMTP id nc5mr2690487ejc.320.1617183467655;
        Wed, 31 Mar 2021 02:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZcxSfehGEq1uk0BhaU+rqvnGQbflSyBdwqBUHUIWYd27faaA/TMixMBIoJUdVVqwTGBc/mg==
X-Received: by 2002:a17:907:1c05:: with SMTP id nc5mr2690475ejc.320.1617183467509;
        Wed, 31 Mar 2021 02:37:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id p24sm1149846edt.5.2021.03.31.02.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 02:37:46 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: SVM: SEV{-ES} bug fixes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210331031936.2495277-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d1f42be-9e9d-2fb8-cc82-f4ebdbb6147c@redhat.com>
Date:   Wed, 31 Mar 2021 11:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331031936.2495277-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 05:19, Sean Christopherson wrote:
> Misc bug fixes in SEV/SEV-ES to protect against a malicious userspace.
> All found by inspection, I didn't actually crash the host to to prove that
> userspace could hose the kernel in any of these cases.  Boot tested an SEV
> guest, though the SEV-ES side of patch 2 is essentially untested as I
> don't have an SEV-ES setup at this time.
> 
> Sean Christopherson (3):
>    KVM: SVM: Use online_vcpus, not created_vcpus, to iterate over vCPUs
>    KVM: SVM: Do not set sev->es_active until KVM_SEV_ES_INIT completes
>    KVM: SVM: Do not allow SEV/SEV-ES initialization after vCPUs are
>      created
> 
>   arch/x86/kvm/svm/sev.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 

Queued, thanks.

Paolo

