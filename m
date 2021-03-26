Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F301C34AD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCZRMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbhCZRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616778745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIGcvJbUvG26Onz/7+nbdHpA1lLL+Gpem6I6C5hnz+I=;
        b=GUO1bta/87j/OwZXH95QXRyQ1W/ErK75cutEUM5KDBqjmMrKGsqu2ZaNinAqu0oTFC+BML
        EG8zMEMhIVgBMiAIgUy4vZI0EXVMOoXO/Rt73WrlMLhL8zPHf1+dnA79L5Kz6S8MaYCGWj
        qXl7qeNAlWutJT9SooQfdjjQ+jYzt9M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-6kPUuVvHNUqKPCRKMqA31w-1; Fri, 26 Mar 2021 13:12:20 -0400
X-MC-Unique: 6kPUuVvHNUqKPCRKMqA31w-1
Received: by mail-ed1-f71.google.com with SMTP id o24so4745084edt.15
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIGcvJbUvG26Onz/7+nbdHpA1lLL+Gpem6I6C5hnz+I=;
        b=oDGVMUpgC/zNs9FA5PZV2OTF59h/ekUWt9562S8AMjUWRLf0zgQOM2ZgNV1B5f7GEk
         ynB2EJzP4I5H4bAMj6o7bkn+HE6Xt1+0v/yBoSnFQ4JNPRzip1aeev46D6LOcmCXfqu/
         tdGyKOrxFvXK5+AGq8eBeoDVI2PfMiv2qTD1DbanqU1B4eqAXxfqHTs0uQm4EovwRvy0
         SYjrzCnhlbNMKo8rmxEZGcSmXWnpWVHaVYHa+VoQwwbRY9+DycKuVhas40EE7BcMPTKf
         K1CAvesR91NX9CtwL+LPPtSv8NVpWMdl7SH4mDrzcM3Yl85DbejzVRNpUewcSdBcaxjT
         f4HQ==
X-Gm-Message-State: AOAM5302zqeeF0Z1hRx2XNneQMdb6COUBEyeyy8wTxXXTH8+Q5wt3tSd
        IrhMPrspGViP4CjO+52kPZ65tm+V+eXjaufEldyb4DlmhVfGHG+7mtkSGVHKjsqOEgUDAalyTmL
        EsbTzhb0PH6D2UrVpn04eBTjWavW2gC74Z+ZlREAni5Z7deOKFxb1es0qWMt5DV/WLetqQQo5p8
        8c
X-Received: by 2002:a17:906:7102:: with SMTP id x2mr16822587ejj.355.1616778739316;
        Fri, 26 Mar 2021 10:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy++S5sPsaxk3N74zxpvkE10Iksv0V6S3Z9ojC8XJ8X8gUzJv2zRoT5RkKTG3St3RFKWFkjcA==
X-Received: by 2002:a17:906:7102:: with SMTP id x2mr16822567ejj.355.1616778739071;
        Fri, 26 Mar 2021 10:12:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h15sm4536905edb.74.2021.03.26.10.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:12:18 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] KVM: x86/mmu: Don't allow TDP MMU to yield when
 recovering NX pages
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210325200119.1359384-1-seanjc@google.com>
 <20210325200119.1359384-4-seanjc@google.com>
 <CANgfPd8N1+oxPWyO+Ob=hSs4nkdedusde6RQ5TXTX8hi48mvOw@mail.gmail.com>
 <YF0N5/qsmsNHQeVy@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebcbf024-8bfa-c284-68ea-3b59709cb8d0@redhat.com>
Date:   Fri, 26 Mar 2021 18:12:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YF0N5/qsmsNHQeVy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/21 23:25, Sean Christopherson wrote:
> I don't have a super strong preference.  One thought would be to
> assert that mmu_lock is held for write, and then it largely come
> future person's problem:-)

Well that is what I was going to suggest.  Let's keep things as simple 
as possible for the TDP MMU and build up slowly.

Paolo

