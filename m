Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32936A5A6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhDYIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 04:10:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:32738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhDYIK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:10:27 -0400
IronPort-SDR: Lg1qf+c4HkfTvxE3C4IYbxVPwvUCSB3gsC2mtZKGis5R4OaBnTwaNECDxYbcvSbBjUDGo0IVyP
 JyVbqTjM5XbQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="183353080"
X-IronPort-AV: E=Sophos;i="5.82,250,1613462400"; 
   d="scan'208";a="183353080"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 01:09:48 -0700
IronPort-SDR: bzWtB4zyf5+dpO7eBbYWRqMp5K8ubkGRTnMywQdnm0a+wD5XPIndVNHr+SbL5k/xS0f29qq0RB
 pYLRHMfOkoCg==
X-IronPort-AV: E=Sophos;i="5.82,250,1613462400"; 
   d="scan'208";a="428987765"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 01:09:46 -0700
Subject: Re: [LKP] Re: [KVM] 4fc096a99e:
 kernel-selftests.kvm.set_memory_region_test.fail
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xudong.hao@intel.com
References: <20210423032514.GB13944@xsang-OptiPlex-9020>
 <871rb1h63v.fsf@vitty.brq.redhat.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <41d6e208-1cc5-9633-fda2-232a9156a824@intel.com>
Date:   Sun, 25 Apr 2021 16:08:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871rb1h63v.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/21 2:23 PM, Vitaly Kuznetsov wrote:
> kernel test robot <oliver.sang@intel.com> writes:
>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 4fc096a99e01dd06dc55bef76ade7f8d76653245 ("KVM: Raise the
>> maximum number of user memslots")
> ...
>
>> # selftests: kvm: set_memory_region_test
>> # Testing KVM_RUN with zero added memory regions
>> # Allowed number of memory slots: 32764
>> # Adding slots 0..32763, each memory region with 2048K size
>> #
>> not ok 32 selftests: kvm: set_memory_region_test # TIMEOUT 120 seconds
> This is a timeout, it can be raised in
> 'tools/testing/selftests/kvm/settings'. I assume the test is running in
> a VM?
>

Hi Vitaly,

It's running in a physical Haswell machine.

Best Regards,
Rong Chen
