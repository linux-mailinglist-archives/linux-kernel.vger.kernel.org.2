Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0260545A41F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhKWNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhKWNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637675565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hg3rpdgYxxcOBJc5G9ynr2yksQKyjRICI2KgG4YRajw=;
        b=KK7H/zCirjKHQ0vDA9ej11lu6jweZUQD7SGd7cZ4hlGnkM6h6vRMik97ZGX4A3cnWb2EDV
        1w1Ucv9ZCNjHSjC8t2LmMwl11G+kdkjJ5bU815K5O+muen7rf85YwMYMdxQJres5oJPTby
        laCdp+LkAVtyDUc07ypKV79hI1EA5KM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-oqUsUDXTPH6qvOzrt1vxRA-1; Tue, 23 Nov 2021 08:52:44 -0500
X-MC-Unique: oqUsUDXTPH6qvOzrt1vxRA-1
Received: by mail-wm1-f71.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso2909655wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 05:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hg3rpdgYxxcOBJc5G9ynr2yksQKyjRICI2KgG4YRajw=;
        b=HdZ9+sRWSLvPsNqKmMmsZ2VogWEs9uk4PL0LlyFdKwZAgpz+qrv2Z4az1/3MoOG78C
         MVw63Z4pIEaX1ZYnvxGSUed0Qk0gUwgo9qcHdshEXbJ4k+GphhCduRq55kQmD0AYTKff
         hAAL215lGnvSQxiE3jgJ3honaGwH0OzYr60SekW5tFSFDuOtMOh5r1D18rF06yMMKSL/
         v5hid+p0tzw06fzn8+M5Cgh+EXlrbAd+lMSVNKgJ1tqjKRklAz4FXjeR1fg5ZtE8qQPV
         QcdNQUgptBIVqpA4TBPFZR1UFh3xQoIJN6KvrTxAjhK95l2wfJ4DweyCZhKABP6RiJNy
         I1FA==
X-Gm-Message-State: AOAM531HAc4eoCXIhBrJyVMub6U8HE0rGbbg2g9EYTGGUj1Cpa8OP1l4
        8/z417tEdZN61RSqbnGCSIbT49mJOddGJaJ4XXEmhelUfxOYuWyivMyczA9ZaYodhMC93dmuEfX
        yRE+2k9LCJYZKYsK3h2txKfHVW6ESTU1Z6zBuV+5Ic/XC7L1khJpTvRSbZ3Ic8Fjn1CmRMvtGI5
        3m
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr3279220wmc.134.1637675562950;
        Tue, 23 Nov 2021 05:52:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7iTjEl+nEyfMdplA1sJxP2OTCbcZNTVWZJYf4xKxVJgZBJzKPzNLaMH3ChCLer/E4VRC5uQ==
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr3279190wmc.134.1637675562732;
        Tue, 23 Nov 2021 05:52:42 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o1sm12066278wrn.63.2021.11.23.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 05:52:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Make sure kvm_create_max_vcpus test
 won't hit RLIMIT_NOFILE
In-Reply-To: <87czmsm5iv.fsf@redhat.com>
References: <20211122171920.603760-1-vkuznets@redhat.com>
 <YZvVeW6qYNb/kkSc@google.com> <87czmsm5iv.fsf@redhat.com>
Date:   Tue, 23 Nov 2021 14:52:41 +0100
Message-ID: <877dczm11y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

>>>  
>>> +	/*
>>> +	 * Creating KVM_CAP_MAX_VCPUS vCPUs require KVM_CAP_MAX_VCPUS open
>>> +	 * file decriptors.
>>> +	 */
>>> +	TEST_ASSERT(!getrlimit(RLIMIT_NOFILE, &rl),
>>> +		    "getrlimit() failed (errno: %d)", errno);
>>
>> And strerror() output too?
>>
>
> Sure, will add in v2.
>

Actually, there are two issues with the code above. First, TEST_ASSERT()
already prints both errno and strerror() (setrlimit() counterpart which
is easier to make fail):

KVM_CAP_MAX_VCPU_ID: 4096
KVM_CAP_MAX_VCPUS: 1024
==== Test Assertion Failure ====
  kvm_create_max_vcpus.c:68: !setrlimit(RLIMIT_NOFILE, &rl)
  pid=344504 tid=344504 errno=1 - Operation not permitted
     1	0x0000000000402485: main at kvm_create_max_vcpus.c:68
     2	0x00007fcb2e8b4041: ?? ??:0
     3	0x000000000040254d: _start at ??:?
  setrlimit() failed, errno: 0

Second, note "errno: 0" above. There's no guarantee that getrlimit()
will be executed before evaluating 'errno' in C. I think I'll just drop
redundant errno printout then.

-- 
Vitaly

