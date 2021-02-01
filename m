Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F530A64B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhBALOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:14:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhBALOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:14:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925C21042;
        Mon,  1 Feb 2021 03:14:04 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF81A3FA1C;
        Mon,  1 Feb 2021 03:14:02 -0800 (PST)
Subject: Re: [LKP] [sched/topology] 620a6dc407:
 BUG:KASAN:slab-out-of-bounds_in_build_sched_domains
To:     kernel test robot <oliver.sang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
References: <20210201074908.GF12524@xsang-OptiPlex-9020>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c6f8afcb-398d-84df-b998-142048cdec00@arm.com>
Date:   Mon, 1 Feb 2021 12:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201074908.GF12524@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 08:49, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 620a6dc40754dc218f5b6389b5d335e9a107fd29 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
>

We also saw an issue with this patch during sched domain build which got
fixed by:

https://lkml.kernel.org/r/6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com
