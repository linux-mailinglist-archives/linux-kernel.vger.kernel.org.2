Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF53AF6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFUUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:45:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:56593 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhFUUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:45:13 -0400
IronPort-SDR: yyVVEk5WrRMhxKT7psM6f0g8Kkx7hFuxaAyuS4CIc/Xvx9zhN31KUJKd+ruXRb2tPgcQ8xNrl2
 ohVl7ZOlnm2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203914493"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="203914493"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 13:42:55 -0700
IronPort-SDR: kZR73fPxkAoXuh/fs1Fpb782VxeF0W26VxxnLG9sRoqZldC1NPjd7puS4pSCyA5pbKvKhXoxvy
 zZ24VGdkF+VQ==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="473539706"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.236.132]) ([10.212.236.132])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 13:42:54 -0700
Subject: Re: [PATCH v5 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, "Luck, Tony" <tony.luck@intel.com>
References: <20210617175820.24037-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f0e95fab-b1cb-a206-6c7a-79e112d9ac13@intel.com>
Date:   Mon, 21 Jun 2021 13:42:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617175820.24037-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/17/2021 10:57 AM, James Morse wrote:
> Hi folks,
> 
> Changes since v4? Padding in the schemata file, typos and variable name
> changes. The schemata file padding is to ensure that if CDP is supported
> but not enabled, the file looks like this:
> | root@resctrl-cdp-v5:~# cat /sys/fs/resctrl/schemata
> |    MB:0=100;1=100
> |    L3:0=7ff;1=7ff

Thank you James.

...

> 
> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
> behaviour is all contained in the filesystem parts, with a minimum amount
> of arch specific code.
> 

For this series:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
