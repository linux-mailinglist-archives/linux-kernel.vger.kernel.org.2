Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A90426203
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhJHBaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:30:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:37803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJHBaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:30:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226311061"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="226311061"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:28:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="439750605"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.35]) ([10.249.172.35])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:27:59 -0700
Subject: Re: [kbuild-all] Re: [peterz-queue:sched/cleanup 38/40]
 kernel/irq_work.c:44:6: warning: no previous prototype for function
 'irq_work_single'
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, yujie.liu@intel.com
References: <202110071515.2ivww4qz-lkp@intel.com>
 <20211007074843.GO174703@worktop.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <aa767320-ef44-3d04-e7b2-dd7bf5620595@intel.com>
Date:   Fri, 8 Oct 2021 09:27:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211007074843.GO174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2021 3:48 PM, Peter Zijlstra wrote:
> 
> This mail has dodgy headers:
> 
> To: unlisted-recipients: no To-header on input <;
> 
> Is the robot sick?

Hi Peterz,

This warning is from W=1 option, so the bot didn't send this report to
your mail address which looks like there's a wrong "To:", we'll stop
sending such reports next time.

Best Regards,
Rong Chen
