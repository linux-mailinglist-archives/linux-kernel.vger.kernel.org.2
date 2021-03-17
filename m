Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27033F9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhCQUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:32:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:14318 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhCQUbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:31:42 -0400
IronPort-SDR: A4drnsLSiLVvaOt+axoZ9MzE5nm2bOtcJL5U5+53lqGwd1S4gcJGBIBzkxmAiQRWlzj25i44Ts
 wA4GCwNxiO/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="168818541"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="168818541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 13:31:41 -0700
IronPort-SDR: zkArHhKZCiFBEtOBTN3hcH2FyOtAHHGlADdtlbU2hBIxOO6ayckOmzHhcJhwwsNVxCiLqajPcj
 4jNUGkocNixw==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="388972540"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.176.237]) ([10.212.176.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 13:31:40 -0700
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
 <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com> <YFJZf0VvNf6Ndp+w@ArchLinux>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d2d6f71a-851d-efc0-df17-bb5dcc8e776e@intel.com>
Date:   Wed, 17 Mar 2021 13:31:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFJZf0VvNf6Ndp+w@ArchLinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

On 3/17/2021 12:33 PM, Bhaskar Chowdhury wrote:
> On 10:54 Wed 17 Mar 2021, Reinette Chatre wrote:
>> Thank you very much for catching this typo.
>>
>> My feedback [1] to a previous patch from you applies here also. The
>> prefix should be "x86/resctrl:" for contributions to this area.
>>
> Thanks for the heads up!

This was the third time I mention this to you.

> Do you want another revision of it, or will you
> take it as it is???

If accepted I am not the one who will merge this patch so having a 
version that is ready for merge (all feedback addressed) would be best.

> I am noting down your point ,so ,I might pull out next
> time I intend to sent out something to this specific area.

Please do note that my comment was not specific to resctrl. This prefix 
style is used by x86 area.

Reinette
