Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88033AD267
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhFRS50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:57:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:53236 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhFRS5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:57:25 -0400
IronPort-SDR: 8aWrnFxclmeZRzQd4lH3BVcSBvU2QNsrs2TBM3Vg5qeyxaK9EtGYo4q5lVVo4BEDYXAic1XTRV
 i/+xjbbr6lnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186983129"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="186983129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:55:15 -0700
IronPort-SDR: ZkFD3CWwYBzYk5rAa38DDBPuBN6X3wrD+GCVgp8d31ytg/x4qKY7cvvNvp/1JBXoRykhawn8XS
 GcwCMmDs0SWA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485786540"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.236.226]) ([10.212.236.226])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:55:14 -0700
Subject: Re: [PATCH v4] x86/resctrl: Fix kernel-doc in pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210616181530.4094-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <1bdf84eb-b7d9-a2eb-88db-9ca55aa38d08@intel.com>
Date:   Fri, 18 Jun 2021 11:55:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616181530.4094-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/16/2021 11:15 AM, Fabio M. De Francesco wrote:
> Add undocumented parameters detected by scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Before this patch:
$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/pseudo_lock.c
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:169: warning: cannot 
understand function prototype: 'struct pseudo_lock_pm_req '
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:201: warning: Function 
parameter or member 'plr' not described in 'pseudo_lock_cstates_constrain'
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:529: warning: Function 
parameter or member 'rdtgrp' not described in 'rdtgroup_monitor_in_progress'
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:529: warning: Excess function 
parameter 'r' description in 'rdtgroup_monitor_in_progress'
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:1152: warning: Function 
parameter or member 'rdtgrp' not described in 'pseudo_lock_measure_cycles'
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:1152: warning: Function 
parameter or member 'sel' not described in 'pseudo_lock_measure_cycles'
$

After this patch:
$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/pseudo_lock.c
$

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
