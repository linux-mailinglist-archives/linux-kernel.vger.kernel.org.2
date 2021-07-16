Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEB3CB03C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhGPBDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:03:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11321 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhGPBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:03:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQt8f67j3z7tTX;
        Fri, 16 Jul 2021 08:56:02 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:00:33 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 09:00:32 +0800
From:   Bin Wang <wangbin224@huawei.com>
To:     <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <naoya.horiguchi@nec.com>,
        <wangbin224@huawei.com>, <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH] mm/hwpoison: dissolve error hugepages of file mapping
Date:   Fri, 16 Jul 2021 09:00:28 +0800
Message-ID: <20210716010028.1720-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <YPBSwEdagjXjx2jO@casper.infradead.org>
References: <YPBSwEdagjXjx2jO@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, 15 Jul 2021 at 16:22:40 +0100, Matthew Wilcox wrote:
> How is that safe?  If you're going to dissolve the huge page, you
> need to figure out which subpage needs to have the HWPoison flag set.

Thanks for your review. The p that we pass to the __page_handle_poison()
is the error subpage. And we will move the HWPoison flag to subpage in
the dissolve_free_huge_page():

if (PageHWPoison(head) && page != head) {
	SetPageHWPoison(page);
	ClearPageHWPoison(head);
}

Thanks,
Bin Wang
