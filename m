Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1D3F1324
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhHSGQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:16:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:6923 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhHSGP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:15:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216488260"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="216488260"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 23:15:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="522193920"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.111]) ([10.249.170.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 23:15:19 -0700
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
To:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ced3f2ab-54b6-95d7-7f5b-b6bb6a299330@intel.com>
Date:   Thu, 19 Aug 2021 14:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRjTkkpDjaWxEpjb@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2021 4:42 PM, Borislav Petkov wrote:
> Hi,
> 
> On Sun, Aug 15, 2021 at 04:36:40PM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
>> branch HEAD: 064855a69003c24bd6b473b367d364e418c57625  x86/resctrl: Fix default monitoring groups reporting
>>
>> possible Warning in current branch:
>>
>> arch/x86/kernel/cpu/resctrl/monitor.c:310 __mon_event_count() error: uninitialized symbol 'm'.
>> arch/x86/kernel/cpu/resctrl/monitor.c:315 __mon_event_count() error: potentially dereferencing uninitialized 'm'.
>>
>> Warning ids grouped by kconfigs:
>>
>> gcc_recent_errors
>> `-- i386-randconfig-m021-20210812
>>      |-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:potentially-dereferencing-uninitialized-m-.
>>      `-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:uninitialized-symbol-m-.
> 
> AFAIR, I had already asked you guys to make those reports more useful
> as, for example, adding a link to that randconfig above or even
> attaching it so that a person - not a machine - reading it, can
> *actually* act upon it.
> 
> But that hasn't happened.
> 
> Until it happens, I'm going to ignore all those reports from you.
> 

Hi Borislav,

Sorry about it, the actual link is at 
https://lists.01.org/hyperkitty/list/kbuild@lists.01.org/thread/PZVMY3VJU4QY4HQXHK3MLPQ2KZ5CNAYH/,
and it's still an internal report that the robot don't know whether it's 
a false positive or not, we'll update the mail contents to avoid 
misunderstanding.

Best Regards,
Rong Chen
