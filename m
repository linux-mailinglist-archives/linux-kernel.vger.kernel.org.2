Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3E3AD61A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhFRXqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:46:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:27153 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235189AbhFRXql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:46:41 -0400
IronPort-SDR: UBIEJrLFtxvEGsjW5AFbsoniHS1YyDJv68TjK0peirriIR80l1XNe6GapI/BbFC3SHRX+h/x8K
 d7MSrFeAXltg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="206676451"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="206676451"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:44:31 -0700
IronPort-SDR: Dx8/KkCY67i+ow2RrMnxb8suKWFJFvo45op/9lDV6Njt+DaLVU+9ODQjP+Psli1xH6fwbdYMZ9
 m7EZAeRbtvbg==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485857268"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.236.226]) ([10.212.236.226])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:44:31 -0700
Subject: Re: [PATCH v4] x86/resctrl: Fix kernel-doc in internal.h
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210618223206.29539-1-fmdefrancesco@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <21d58f6c-c112-ddb7-dabf-8fae378cd43f@intel.com>
Date:   Fri, 18 Jun 2021 16:44:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618223206.29539-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 6/18/2021 3:32 PM, Fabio M. De Francesco wrote:
> Add description of undocumented parameters. Issues detected by
> scripts/kernel-doc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Before this patch:
$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/internal.h
arch/x86/kernel/cpu/resctrl/internal.h:78: warning: Function parameter 
or member 'list' not described in 'mon_evt'
arch/x86/kernel/cpu/resctrl/internal.h:93: warning: Function parameter 
or member 'priv' not described in 'mon_data_bits'
arch/x86/kernel/cpu/resctrl/internal.h:93: warning: Function parameter 
or member 'u' not described in 'mon_data_bits'
arch/x86/kernel/cpu/resctrl/internal.h:141: warning: Enum value 
'RDT_NUM_MODES' not described in enum 'rdtgrp_mode'
arch/x86/kernel/cpu/resctrl/internal.h:155: warning: Function parameter 
or member 'mon_data_kn' not described in 'mongroup'
arch/x86/kernel/cpu/resctrl/internal.h:298: warning: Function parameter 
or member 'prev_msr' not described in 'mbm_state'
arch/x86/kernel/cpu/resctrl/internal.h:298: warning: Function parameter 
or member 'prev_bw' not described in 'mbm_state'
arch/x86/kernel/cpu/resctrl/internal.h:298: warning: Function parameter 
or member 'delta_bw' not described in 'mbm_state'
arch/x86/kernel/cpu/resctrl/internal.h:298: warning: Function parameter 
or member 'delta_comp' not described in 'mbm_state'
arch/x86/kernel/cpu/resctrl/internal.h:492: warning: Function parameter 
or member 'membw' not described in 'rdt_resource'
arch/x86/kernel/cpu/resctrl/internal.h:492: warning: Function parameter 
or member 'mbm_width' not described in 'rdt_resource'
$

After this patch:
$ scripts/kernel-doc -none arch/x86/kernel/cpu/resctrl/internal.h
$

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
