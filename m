Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF74F341861
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCSJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:32:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40043 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhCSJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:31:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0USZnNdI_1616146280;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0USZnNdI_1616146280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Mar 2021 17:31:21 +0800
Subject: Re: [PATCH v1 14/14] mm: multigenerational lru: documentation
To:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-15-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cfef5a43-8be1-3890-e04b-eaac433f59c2@linux.alibaba.com>
Date:   Fri, 19 Mar 2021 17:31:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210313075747.3781593-15-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/3/13 下午3:57, Yu Zhao 写道:
> +Recipes
> +-------
> +:Android on ARMv8.1+: ``X=4``, ``N=0``
> +
> +:Android on pre-ARMv8.1 CPUs: Not recommended due to the lack of
> + ``ARM64_HW_AFDBM``
> +
> +:Laptops running Chrome on x86_64: ``X=7``, ``N=2``
> +
> +:Working set estimation: Write ``+ memcg_id node_id gen [swappiness]``
> + to ``/sys/kernel/debug/lru_gen`` to account referenced pages to
> + generation ``max_gen`` and create the next generation ``max_gen+1``.
> + ``gen`` must be equal to ``max_gen`` in order to avoid races. A swap
> + file and a non-zero swappiness value are required to scan anon pages.
> + If swapping is not desired, set ``vm.swappiness`` to ``0`` and
> + overwrite it with a non-zero ``swappiness``.
> +
> +:Proactive reclaim: Write ``- memcg_id node_id gen [swappiness]
> + [nr_to_reclaim]`` to ``/sys/kernel/debug/lru_gen`` to evict
> + generations less than or equal to ``gen``. ``gen`` must be less than
> + ``max_gen-1`` as ``max_gen`` and ``max_gen-1`` are active generations
> + and therefore protected from the eviction. ``nr_to_reclaim`` can be
> + used to limit the number of pages to be evicted. Multiple command
> + lines are supported, so does concatenation with delimiters ``,`` and
> + ``;``.
> +


These are difficult options for users, especially for 'races' involving.
Is it possible to simplify them for end users?

Thanks
Alex
