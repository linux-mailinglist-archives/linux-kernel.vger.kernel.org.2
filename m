Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15F34D10B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC2NSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:18:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15383 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC2NS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:18:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8ClY19r6zlVrV;
        Mon, 29 Mar 2021 21:16:41 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 21:18:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [Question] Is there a race window between swapoff vs synchronous
 swap_readpage
To:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>
Message-ID: <364d7ce9-ccb7-fa04-7067-44a96be87060@huawei.com>
Date:   Mon, 29 Mar 2021 21:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am investigating the swap code, and I found the below possible race window:

CPU 1							CPU 2
-----							-----
do_swap_page
  skip swapcache case (synchronous swap_readpage)
    alloc_page_vma
							swapoff
							  release swap_file, bdev, or ...
      swap_readpage
	check sis->flags is ok
	  access swap_file, bdev or ...[oops!]
							    si->flags = 0

The swapcache case is ok because swapoff will wait on the page_lock of swapcache page.
Is this will really happen or Am I miss something ?
Any reply would be really grateful. Thanks! :)
