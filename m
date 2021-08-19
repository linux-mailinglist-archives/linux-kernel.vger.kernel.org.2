Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F73F1296
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhHSEuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHSEuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:50:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB79D610CF;
        Thu, 19 Aug 2021 04:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629348579;
        bh=0Cg8oLWlkJnSS9ZcFq1U+zblisO3esXh0aghBm3X7GE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Dh/vU215RfcMd2KkH4rG/2rLm/jIZ7EZdfuyqnP4eq9xMTDxqXvzQCSVwTC9tQFiw
         u9LY5T0uGj2QeM1I0o82X2wNBlW9MNYA+ROLYNuB1DzCuLa1YVQBRw9yDoao78pcde
         4YcVS1K7lji6lv88DrwLflWLjjvTeF8FPFTMYxAa31ZMy3l0e4x9uP5BLFCfs8YRG6
         PnFxwYmm6a6DCBsdf/nk5Wr29DIVIPRsUba8Rl2uUTeUkLrIYg62ztounl8c5gtmYq
         wQARy19WaM7342+SVX5Pw+HkT2MKJfm8WGQyFJC69NJeFRPvehl3i3mGJXQaqfLnaR
         Lskps/U2dqEnA==
Subject: Re: [PATCH 1/2] f2fs: add sysfs nodes to get discard information
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ee60f940-c1a6-e41d-a163-bf277290c231@kernel.org>
Date:   Thu, 19 Aug 2021 12:49:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 14:13, 李扬韬 wrote:
>>>>> I've added new sysfs nodes to show discard stat since mount, which
>>>>> will help us analyze whether the performance problem is related to
>>>>> discard.
>>>>>
>>>>> issued_discard  - Shows the number of issued discard
>>>>> queued_discard  - Shows the number of cached discard cmd count
>>>>> discard_cmd_cnt - Shows the number of cached discard cmd count
>>>>> undiscard_blks  - Shows the number of undiscard blocks
>>>>
>>>> We have exported them in debugfs, can you use that?
>>>>
>>>> Thanks,
>>>
>>> But now Android is forbidden to open debugfs, and in fact we have not
>>> opened this configuration for a long time.
>>
>> Weren't them be used for debug purpose? can you please explain more about
>> your use case?
> 
> During long-term aging test or normal use, sometimes there will be performance
> degradation problems. It may be caused by storage, or it may be caused by the
> filesystem. For example, the filesystem accumulates a large number of undiscard
>   blocks. Although there is some remaining space, the androidbench test will
> show performance degradation. Therefore, it is necessary to export information
> related to discard so that we can confirm this situation.

I have a solution for your case, however finally, we haven't used such discard
policy by default due to the policy needs to be designed more tunable for
devices with different characters.

See more details in below patches:

https://lkml.org/lkml/2018/8/10/219
https://lkml.org/lkml/2018/8/10/220

Thanks,

> 
> Thx,
> 
> 
