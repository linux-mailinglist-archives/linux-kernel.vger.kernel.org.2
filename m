Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE83439EBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFHC0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:26:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFHC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:26:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzYsW5LyvzYlPR;
        Tue,  8 Jun 2021 10:22:07 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:24:56 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 10:24:55 +0800
From:   wangbin <wangbin224@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <nao.horiguchi@gmail.com>,
        <wangbin224@huawei.com>, <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory failure on hugetlbfs
Date:   Tue, 8 Jun 2021 10:24:50 +0800
Message-ID: <20210608022450.2044-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
References: <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
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

> What specific problem are you trying to solve?  Are trying to see how
> many huge pages were hit by memory errors?

Yes, I'd like to know how many huge pages are not available because of
the memory errors. Just like HardwareCorrupted in the /proc/meminfo.
But the HardwareCorrupted only adds one page size when a huge page is
hit by memory errors, and mixes with normal pages. So I think we should
add a new counts to track the memory errors on hugetlbfs. 
--
Bin Wang
