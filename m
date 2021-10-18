Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353643198C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJRMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:46:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRMqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:46:04 -0400
Received: from zn.tnic (p200300ec2f0857009e2a46238f1e0c2c.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5700:9e2a:4623:8f1e:c2c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B68FA1EC01DF;
        Mon, 18 Oct 2021 14:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634561031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=66LoAyEmq4McZJ8nnAu/1jkmuEQpLnHOiHL/1PZ5rBs=;
        b=dM3MuMjJxvSlptImN6DDpo3wQrrj8vHzMW9uxb5DBeJb734OW5PqfSnKpJ9yK68DlKRnW4
        KHkuFPZQUH+qBxfw4T4w1IXNZr5xN1BBqZHMSVtAdYVAm125i3579eq60ORUZDmi9Ur+7C
        aUw4wFWZRcRfTWCcGdbliWZcSQWV5W4=
Date:   Mon, 18 Oct 2021 14:43:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     JY Ni <jiayu.ni@linux.alibaba.com>
Cc:     Luming Yu <luming.yu@gmail.com>,
        wujinhua <wujinhua@linux.alibaba.com>, x86 <x86@kernel.org>,
        "zelin.deng" <zelin.deng@linux.alibaba.com>,
        ak <ak@linux.intel.com>, "luming.yu" <luming.yu@intel.com>,
        "fan.du" <fan.du@intel.com>,
        "artie.ding" <artie.ding@linux.alibaba.com>,
        "tony.luck" <tony.luck@intel.com>, tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "pawan.kumar.gupta" <pawan.kumar.gupta@linux.intel.com>,
        "fenghua.yu" <fenghua.yu@intel.com>, hpa <hpa@zytor.com>,
        "ricardo.neri-calderon" <ricardo.neri-calderon@linux.intel.com>,
        peterz <peterz@infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIXSBwZXJm?= =?utf-8?Q?=3A_optimiz?=
 =?utf-8?Q?e?= clear page in Intel specified model with movq instruction
Message-ID: <YW1sCxRUZBX8iL6w@zn.tnic>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic>
 <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
 <YTnq/3rzmD6ADyZm@zn.tnic>
 <CAJRGBZxHQ3tPrvWWoz9xb0pf=tZ0vrrQYX-Tjr5c=UbxntPtew@mail.gmail.com>
 <1cac1499-6b00-3c18-b64c-a22f269a2706@linux.alibaba.com>
 <YWrSKeT+R2S/+udL@zn.tnic>
 <7b07f141-12f5-397d-9e45-1d507cacae84@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b07f141-12f5-397d-9e45-1d507cacae84@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 03:43:46PM +0800, JY Ni wrote:
> _*Precondition:*__*do tests on a Intel CPX server.*_ CPU information of my
> test machine is in backup part._*

My machine:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 106
stepping        : 4

That's a SKYLAKE_X.

I ran

./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j96 bzImage

on -rc6, building allmodconfig each of the 10 times.

pre-build-kernel.sh is

---
#!/bin/bash

make -s clean
echo 3 > /proc/sys/vm/drop_caches
---

Results are below but to me that's all "in the noise" with around one
percent if I can trust the stddev. Which is not even close to 40%.

So basically you're wasting your time.

5.15-rc6
--------

# ./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j96 bzImage

 Performance counter stats for 'make -s -j96 bzImage' (5 runs):

      3,072,392.92 msec task-clock                #   51.109 CPUs utilized            ( +-  0.05% )
         1,351,534      context-switches          #  440.257 /sec                     ( +-  0.99% )
           224,862      cpu-migrations            #   73.248 /sec                     ( +-  1.39% )
        85,073,723      page-faults               #   27.712 K/sec                    ( +-  0.01% )
 8,743,357,421,495      cycles                    #    2.848 GHz                      ( +-  0.06% )
 7,643,946,991,468      instructions              #    0.88  insn per cycle           ( +-  0.00% )
 1,705,128,638,240      branches                  #  555.440 M/sec                    ( +-  0.00% )
    37,637,576,027      branch-misses             #    2.21% of all branches          ( +-  0.03% )
22,511,903,971,150      slots                     #    7.333 G/sec                    ( +-  0.03% )
 7,377,211,958,188      topdown-retiring          #     32.5% retiring                ( +-  0.02% )
 3,145,247,374,138      topdown-bad-spec          #     13.9% bad speculation         ( +-  0.27% )
 8,018,664,899,041      topdown-fe-bound          #     35.2% frontend bound          ( +-  0.07% )
 4,167,103,609,622      topdown-be-bound          #     18.3% backend bound           ( +-  0.09% )

            60.114 +- 0.112 seconds time elapsed  ( +-  0.19% )



5.15-rc6 + patch
----------------

 Performance counter stats for 'make -s -j96 bzImage' (5 runs):

      3,033,250.65 msec task-clock                #   51.243 CPUs utilized            ( +-  0.05% )
         1,329,033      context-switches          #  438.210 /sec                     ( +-  0.64% )
           225,550      cpu-migrations            #   74.369 /sec                     ( +-  1.36% )
        85,080,938      page-faults               #   28.053 K/sec                    ( +-  0.00% )
 8,629,663,367,477      cycles                    #    2.845 GHz                      ( +-  0.05% )
 7,696,237,813,803      instructions              #    0.89  insn per cycle           ( +-  0.00% )
 1,709,909,494,107      branches                  #  563.793 M/sec                    ( +-  0.00% )
    37,719,552,337      branch-misses             #    2.21% of all branches          ( +-  0.02% )
22,214,249,023,820      slots                     #    7.325 G/sec                    ( +-  0.06% )
 7,412,342,725,008      topdown-retiring          #     33.0% retiring                ( +-  0.01% )
 3,141,090,408,028      topdown-bad-spec          #     14.1% bad speculation         ( +-  0.17% )
 7,996,077,873,517      topdown-fe-bound          #     35.6% frontend bound          ( +-  0.03% )
 3,862,154,886,962      topdown-be-bound          #     17.3% backend bound           ( +-  0.28% )

            59.193 +- 0.302 seconds time elapsed  ( +-  0.51% )

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
