Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219A83525F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhDBEJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:09:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53029 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhDBEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 00:08:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UUC7cQt_1617336536;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UUC7cQt_1617336536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Apr 2021 12:08:56 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH 0/4] mm/page_reporting: Some knobs and fixes
To:     Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <e022da6b-4bc1-759e-ab81-dd3270a9ddde@linux.alibaba.com>
Date:   Fri, 2 Apr 2021 12:08:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 5:44 PM, Xunlei Pang wrote:
> Add the following knobs in PATCH 1~3:
>  /sys/kernel/mm/page_reporting/reported_kbytes
>  /sys/kernel/mm/page_reporting/refault_kbytes
>  /sys/kernel/mm/page_reporting/reporting_factor
> 
> Fix unexpected user OOM in PATCH 4.
> 
> Xunlei Pang (4):
>   mm/page_reporting: Introduce free page reported counters
>   mm/page_reporting: Introduce free page reporting factor
>   mm/page_reporting: Introduce "page_reporting_factor=" boot parameter
>   mm/page_reporting: Fix possible user allocation failure
> 
>  Documentation/admin-guide/kernel-parameters.txt |   3 +
>  include/linux/mmzone.h                          |   3 +
>  mm/page_alloc.c                                 |   6 +-
>  mm/page_reporting.c                             | 268 ++++++++++++++++++++++--
>  4 files changed, 260 insertions(+), 20 deletions(-)
> 

Hi guys,

Looks "Alexander Duyck <alexander.h.duyck@linux.intel.com>" was not
available, so Cced more, any comment?

Thanks!
