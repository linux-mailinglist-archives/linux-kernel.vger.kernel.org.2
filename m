Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EC33C3D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhGKOXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:23:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10465 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhGKOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:23:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GN88z5Ql5zcc62;
        Sun, 11 Jul 2021 22:16:51 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 11 Jul 2021 22:20:06 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 11
 Jul 2021 22:20:06 +0800
From:   Bin Wang <wangbin224@huawei.com>
To:     <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>, <wangbin224@huawei.com>,
        <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH v2] mm: hugetlb: add hwcrp_hugepages to record memory failure on hugetlbfs
Date:   Sun, 11 Jul 2021 22:20:01 +0800
Message-ID: <20210711142001.1780-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <20210629080835.GA427744@u2004>
References: <20210629080835.GA427744@u2004>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naoya,

> > Yes, splitting the huge pages and isolating a base page is ideal. And
> > we do this with dissolve_free_huge_page() when page_mapping() return
> > NULL. I think there is a reason(but I do not get it) why we don't split
> > huge pags in hugetlbfs_error_remove_page() or after. So I choose to 
> > add a new count.
> 
> Maybe the resource is the main reason of this incompleteness, I noticed this
> for years and continued to say "this is in my todo list", but still don't
> make it (really sorry about that...).  Anyway, if you can (I hope) solve
> your problem with "/proc/kpageflag" approach, which is a recommended solution.

I do not understand the exact meaning of the "resource". I have tried to call
dissolve_free_huge_page() after hugetlbfs_error_remove_page() and it worked.
In my opinion, the error huge page has been truncated from the hugetlbfs. It
cannot be accessed and allocated again. I think it is safe to split it.

I would appreciate it if you could point out what I overlooked. And I will
try to solve it.

Thanks,
Bin Wang
