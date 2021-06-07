Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA039EA22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:32:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:11509 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFGXce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:32:34 -0400
IronPort-SDR: 2SfYvf3OnZD+Lp7o2XKaOpNGiWDL9S+0rkiZ2a2deoY21PKlOvkGLP/Q3Vxl+/hQLjdplCP3G9
 4yBeWOGFPknQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="192063004"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="192063004"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 16:30:40 -0700
IronPort-SDR: XmtRVo0ifH6H/cQB+6ZK+Iq5Le3rbstmpbWjRjCZtZw+tw9qoNq2RBtjlGPVBYMSTScBCFt8hw
 btBtua6mt1Hg==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="637448884"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.69.116]) ([10.209.69.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 16:30:37 -0700
Subject: Re: [PATCH] x86: kernel: cpu: resctrl: Fix kernel-doc in
 pseudo_lock.c
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210602222326.7765-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <017e9a77-d17e-effd-5639-72a06abc4fc3@intel.com>
Date:   Mon, 7 Jun 2021 16:30:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210602222326.7765-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Thank you very much for catching these. I am curious what your goal is 
because when I ran a kernel-doc check on the resctrl area there were 
many more warnings than are not addressed in this patch. Also, while 
this patch claims to fix the kernel-doc in pseudo_lock.c there seems to 
be a few more that are not addressed. Are you planning to submit more 
patches to do a cleanup of kernel-doc or are these the only ones 
bothering you for some reason?

Could you please fixup the subject to conform to this area:
"x86/resctrl: Fix kernel-doc in pseudo_lock.c"

For this subject to be accurate though it should fix all the kernel-doc 
warnings found in pseudo_lock.c - or if not it would be helpful to 
explain what the criteria for fixes are. I tested this by running:
$ scripts/kernel-doc -v -none arch/x86/kernel/cpu/resctrl/*

On 6/2/2021 3:23 PM, Fabio M. De Francesco wrote:
> Fixed sparse warnings about the descriptions of some function
> parameters.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index f6451abddb09..c3629db90570 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -520,7 +520,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
>   
>   /**
>    * rdtgroup_monitor_in_progress - Test if monitoring in progress
> - * @r: resource group being queried
> + * @rdtgrp: resource group being queried
>    *
>    * Return: 1 if monitor groups have been created for this resource
>    * group, 0 otherwise.
> @@ -1140,6 +1140,8 @@ static int measure_l3_residency(void *_plr)
>   
>   /**
>    * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
> + * @rdtgrp: resource group to which the pseudo-locked region belongs
> + * @sel: cache level selector

This is not correct. A more accurate description could be:
"select which measurement to perform on pseudo-locked region"

>    *
>    * The measurement of latency to access a pseudo-locked region should be
>    * done from a cpu that is associated with that pseudo-locked region.
> 

Reinette
