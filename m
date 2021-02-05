Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90340310506
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhBEGl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:41:57 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3075 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBEGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:41:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601ce88b0001>; Thu, 04 Feb 2021 22:41:15 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 06:41:15 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
Date:   Thu, 4 Feb 2021 22:41:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBzkjh5nnuNiGb6Q@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612507275; bh=MVQPZX7CqWSAXEBpuiD9KIrZsqcSefGwB9+cJEmNR/U=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ZFByrRMHweXhGS7HmqX+9r2j16FGVfJ0523O0aw40mEjjCqf7K2AucMH+RRnQ27JC
         +LlmYuuFNwD9ITf7dCQVWk0MJcfymXZI6xLvtraTM9qeoSG1fANpW/kXnwNYUhdeIF
         r57DT+MF6BGpsPTF/EIBscJmobATGHQ4uHuGWmgksjIyUnrYYft9Xdt5jHNMMADFDD
         OYJKTv1uRf3YFls9HvTopvWDcCIVngeRbJtCtPd3279I7Gn94/XkSMsqxo/hgu+G+l
         +53SVmSbWrx4re2Zew/yDEHji6Fw2YYXxNPqL4+qJj+iFt07EtqXTy+Wz0CLKRXZ05
         ze5dYmvkPqx7A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 10:24 PM, Minchan Kim wrote:
> On Thu, Feb 04, 2021 at 09:49:54PM -0800, John Hubbard wrote:
>> On 2/4/21 9:17 PM, Minchan Kim wrote:
...
>> # cat vmstat | grep -i cma
>> nr_free_cma 261718
>>
>> # cat meminfo | grep -i cma
>> CmaTotal:        1048576 kB
>> CmaFree:         1046872 kB
>>
>> OK, given that CMA is already in those two locations, maybe we should put
>> this information in one or both of those, yes?
> 
> Do you suggest something liks this, for example?
> 
> 
> cat vmstat | grep -i cma
> cma_a_success	125
> cma_a_fail	25
> cma_b_success	130
> cma_b_fail	156
> ..
> cma_f_fail	xxx
> 

Yes, approximately. I was wondering if this would suffice at least as a baseline:

cma_alloc_success   125
cma_alloc_failure   25

...and then, to see if more is needed, some questions:

a)  Do you know of an upper bound on how many cma areas there can be
(I think Matthew also asked that)?

b) Is tracking the cma area really as valuable as other possibilities? We can put
"a few" to "several" items here, so really want to get your very favorite bits of
information in. If, for example, there can be *lots* of cma areas, then maybe tracking
by a range of allocation sizes is better...


thanks,
-- 
John Hubbard
NVIDIA
