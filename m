Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC2398084
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 06:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFBFAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 01:00:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:8296 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhFBFAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 01:00:53 -0400
IronPort-SDR: r6NIbzFX4J9Qh4b2fw+dnDupfAoHRUwJt+z0XJ3rf0dkNZ5cO5uWSnLpYPjsXCA3inX9iMmaEB
 Y6PrtKqox7rw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="184068874"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="184068874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 21:59:11 -0700
IronPort-SDR: nFy1Qe13UPJnHQS0YERgmdeyTqd3nLFk+QDJ16uG3sLtP76bBY95FQEHL67R2GC/UQZX7C8Cy3
 v8D2XoRZ+GFA==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="479553468"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 21:59:07 -0700
Subject: Re: [kbuild-all] Re: mm/migrate.c:1406:5: warning: stack frame size
 of 2096 bytes in function 'migrate_pages'
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202105301728.lr6r1Eyr-lkp@intel.com>
 <20210531151412.4dad38dd703119cdd33ca395@linux-foundation.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d61e9459-2d90-340c-a4f8-9cfc05498c35@intel.com>
Date:   Wed, 2 Jun 2021 12:58:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210531151412.4dad38dd703119cdd33ca395@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/21 6:14 AM, Andrew Morton wrote:
> On Sun, 30 May 2021 17:46:48 +0800 kernel test robot <lkp@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   b90e90f40b4ff23c753126008bf4713a42353af6
>> commit: dd4ae78a21fc05d91d841e499dddd057ad64a4df mm: migrate: simplify the logic for handling permanent failure
> migrate_pages() isn't a good place to be using lots of stack.
>
> Am I correct in assuming that this is a bisection result?

Hi Andrew,

I have confirmed the bisection is good.

>
> I don't immediately see why dd4ae78a21fc05d91d would be the main cause
> of this.
>

Hi Clang Team, could you share some experience about this kind of warning?

Best Regards,
Rong Chen
