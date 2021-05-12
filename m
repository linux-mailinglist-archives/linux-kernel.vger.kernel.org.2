Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88337B3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELB6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELB6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:58:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 18:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FaWqp1Iu45pPcSZvbOJXdBQ3cO35b4TFeSVOdKvKBJ4=; b=bIiBhZZEExfGoRThWP/BxLrzRA
        ZlfeXeJ5nUlRWwagKPt3bNK1V8e4/AS/b2PiiSitgcSAoMRN00JGQB3a+NjaMHj066JdOQFyp+KLg
        2i4xg+hUixefLDJsfK3gWBlEpZI9LIca2mIIod5zX9aSxov3Vp1Z3NKsG5kZR1n6wti1bJ7vyym5d
        qImemEs1OBS28x7x9nqTKL9Mk3XnGFVs5jzXz0/PHLmVYvRQ50GdAC3gx0wfCrDvOQFw1tgt56puR
        3YzrIdXDAcp732gK/836QZ7unUiB92WYMOe0BnTnh2352Jknq2Xxb7WDld4scaCn0bE9MJ4vavlTn
        Lg9JmNSA==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lge7I-00A2gL-Dx; Wed, 12 May 2021 01:56:52 +0000
Subject: Re: [PATCH] um: add 2 missing libs to fix various build errors
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Brendan Jackman <jackmanb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Berg <johannes.berg@intel.com>
References: <20210404182044.9918-1-rdunlap@infradead.org>
 <9f7eeb70-8ddc-fb04-a378-5f1e80d485e6@infradead.org>
 <74a0ba94-9a22-b7a4-3c1b-596ddbaa856e@cambridgegreys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a2ddf5b-3d08-1a13-94c8-ae2ca0e6444b@infradead.org>
Date:   Tue, 11 May 2021 18:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <74a0ba94-9a22-b7a4-3c1b-596ddbaa856e@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 10:28 PM, Anton Ivanov wrote:
> On 10/04/2021 05:13, Randy Dunlap wrote:
>> On 4/4/21 11:20 AM, Randy Dunlap wrote:


[snip]

>>
>> There are still some build errors in 2 object files:
>>
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: kernel/irq/generic-chip.o:(.altinstructions+0x63): more undefined references to `X86_FEATURE_XMM' follow
>>
>> and
>>
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x8): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x15): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x22): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x2f): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x3c): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x49): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x56): undefined reference to `X86_FEATURE_XMM'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x63): undefined reference to `X86_FEATURE_XMM2'
>> /usr/lib/gcc/i586-suse-linux/10/../../../../i586-suse-linux/bin/ld: drivers/fpga/altera-pr-ip-core.o:(.altinstructions+0x70): undefined reference to `X86_FEATURE_XMM2'
>>
>> I don't know what to do about these or what is causing them (other than
>> "alternatives").
> 
> I have a patch in the queue which should fix these - it "steals" the bug/feature definitions from the x86 tree.
> 
> A

Hi Anton,

Can you post (repost) the patch for these or point me to it
on a mailing list, please?


thanks.
-- 
~Randy

