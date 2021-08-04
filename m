Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369903DFD96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbhHDJFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:05:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:33559 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235471AbhHDJFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:05:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="212019844"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="212019844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:04:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="521763227"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.199]) ([10.255.30.199])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 02:04:40 -0700
Subject: Re: [kbuild-all] Re: sparc64-linux-gcc: error: unrecognized
 command-line option '-mxsave'
To:     Dave Hansen <dave.hansen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202107271153.7QWf3g6F-lkp@intel.com>
 <efd7ab16-ed45-0ab0-a123-4e8e45c100d0@intel.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <8bee8632-9129-bb02-ab94-f65786e65268@intel.com>
Date:   Wed, 4 Aug 2021 17:04:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <efd7ab16-ed45-0ab0-a123-4e8e45c100d0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2021 10:52 PM, Dave Hansen wrote:
> On 7/26/21 8:11 PM, kernel test robot wrote:
>>>> sparc64-linux-gcc: error: unrecognized command-line option '-mxsave'
> 
> Is there something else funky going on here?  All of the "-mxsave" flags
> that I can find are under checks for x86 builds, like:
> 
> 	ifeq ($(CAN_BUILD_I386),1)
> 	$(BINARIES_32): CFLAGS += -m32 -mxsave
> 	..
> 
> I'm confused how we could have a sparc64 compiler (and only a sparc64
> compiler) that would end up with "-mxsave" in CFLAGS.

Hi Dave,

We can reproduce the error and have no idea too, but we have disabled
the test for selftests on non-x86 arch.

Best Regards,
Rong Chen
