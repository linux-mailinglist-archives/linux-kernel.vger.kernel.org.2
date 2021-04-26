Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F136B374
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhDZMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233227AbhDZMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619441269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQdCHOe62bXCUObB7ftv9+tjr7VJYbLJGJoCLuz1X7U=;
        b=gIfl832STN6x5gPbawlHeVhhCz9MncUgLxtzmcBT0TUJSKBjqNcbXvgns6FTvpg1pFicN7
        +TtRpuhjoDJl4BnSjkOmPBilC5p9liH7W0DBYqI6Hpc3MkorznIbJHKpZRTd1foFF9onPa
        J8e5iLikqCL9FPl3UtaXWuTci5zZBtI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Zvu3xgiqOU6Gtf3NPYPGzQ-1; Mon, 26 Apr 2021 08:47:47 -0400
X-MC-Unique: Zvu3xgiqOU6Gtf3NPYPGzQ-1
Received: by mail-ej1-f69.google.com with SMTP id f15-20020a170906738fb029037c94426fffso10171564ejl.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 05:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nQdCHOe62bXCUObB7ftv9+tjr7VJYbLJGJoCLuz1X7U=;
        b=CqWt+YOep5veSnugvN4ZriKEJ5qtcA7zlKiBJw6tE1yZk4haZmy1ukLPh5QjO+/Sn/
         9do/Jjg9RAZ3Bo8BY9ARLbVRImazq4euKonzfmJbnEkl1YHWjyCLPoC+bwbrO422f0y6
         T7WXssYHkdX4zGx++nK/w1ay7xiHWmRGJ1DBkNB5l4wB/l/viUIHPQyShjxsvmJhnz+F
         IAWRb6gHaZ8emstDrSvetlUnj1ZSFDAgE2JxRs4eHNWzQYAxET8Ih3yNP9juxiXoPbqz
         Y+7K1cMQO/kXGPDBL35415a5UdTU+Mw5GfgUew4p/uG2qpWwgWX3iYR6c7JRAnF3lUBI
         uuJg==
X-Gm-Message-State: AOAM531HozamvdVgAMMK9mEHUT0Rg3YwvsQgHZkYxQRIh9p2vEYalYMz
        v99mdYYL8usGvG5GUsuNmbvwzA2r1214ynUMoS1OtcFG0KhP7JW1aWtmUyYuOziwJLsLPaTl2eG
        gyFKqDtrIBwFeLIsWKYjvFCHu
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr20816401edv.333.1619441266030;
        Mon, 26 Apr 2021 05:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbf2y/mQgtAsZcPsxxoN9z07EgkQb+qhjfxYCHAX+WP5bo9763WQC/PFGsr5birI1JQWeVDQ==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr20816383edv.333.1619441265862;
        Mon, 26 Apr 2021 05:47:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j8sm4146619edq.67.2021.04.26.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 05:47:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xudong.hao@intel.com
Subject: Re: [LKP] Re: [KVM] 4fc096a99e:
 kernel-selftests.kvm.set_memory_region_test.fail
In-Reply-To: <41d6e208-1cc5-9633-fda2-232a9156a824@intel.com>
References: <20210423032514.GB13944@xsang-OptiPlex-9020>
 <871rb1h63v.fsf@vitty.brq.redhat.com>
 <41d6e208-1cc5-9633-fda2-232a9156a824@intel.com>
Date:   Mon, 26 Apr 2021 14:47:44 +0200
Message-ID: <87bla1fc0f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 4/23/21 2:23 PM, Vitaly Kuznetsov wrote:
>> kernel test robot <oliver.sang@intel.com> writes:
>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 4fc096a99e01dd06dc55bef76ade7f8d76653245 ("KVM: Raise the
>>> maximum number of user memslots")
>> ...
>>
>>> # selftests: kvm: set_memory_region_test
>>> # Testing KVM_RUN with zero added memory regions
>>> # Allowed number of memory slots: 32764
>>> # Adding slots 0..32763, each memory region with 2048K size
>>> #
>>> not ok 32 selftests: kvm: set_memory_region_test # TIMEOUT 120 seconds
>> This is a timeout, it can be raised in
>> 'tools/testing/selftests/kvm/settings'. I assume the test is running in
>> a VM?
>>
>
> Hi Vitaly,
>
> It's running in a physical Haswell machine.
>

Ok, let's try to speed up the test. I'll send a patch.

-- 
Vitaly

