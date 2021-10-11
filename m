Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18142850F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhJKCPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:15:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46330 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231578AbhJKCPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:15:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UrJKsBw_1633918399;
Received: from 30.21.164.80(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UrJKsBw_1633918399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 10:13:20 +0800
Subject: Re: [PATCH] hugetlb: Support node specified when using cma for
 gigantic hugepages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mike.kravetz@oracle.com, mhocko@kernel.org, guro@fb.com,
        corbet@lwn.net, yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
 <20211010135507.f2d1c6bcaeecc82d6d025604@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <d0d09382-c6ea-bf60-efbd-11a57a09263d@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 10:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211010135507.f2d1c6bcaeecc82d6d025604@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/11 4:55, Andrew Morton wrote:
> On Sun, 10 Oct 2021 13:24:08 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Now the size of CMA area for gigantic hugepages runtime allocation is
>> balanced for all online nodes, but we also want to specify the size of
>> CMA per-node, or only one node in some cases, which are similar with
> 
> Please describe in full detail why "we want to" do this.  In other
> words, what is the benefit to our users?  What are the use-cases, etc?

Sure. On some multi-nodes systems, each node's memory can be different, 
allocating the same size of CMA for each node is not suitable for the 
low-memory nodes. Meanwhile some workloads like DPDK mentioned by 
Zhenguo only need hugepages in one node.

On the other hand, we have some machines with multiple types of memory, 
like DRAM and PMEM (persistent memory). On this system, we may want to 
specify all the hugepages on DRAM node, or specify the proportion of 
DRAM node and PMEM node, to tuning the performance of the workloads.
