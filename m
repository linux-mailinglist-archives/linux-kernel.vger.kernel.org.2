Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAA3A09FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhFICZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:25:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8098 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhFICZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:25:12 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G09n73zMdzYrnF;
        Wed,  9 Jun 2021 10:20:27 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 10:23:17 +0800
Received: from huawei.com (10.174.179.206) by dggema753-chm.china.huawei.com
 (10.1.198.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 10:23:16 +0800
From:   wangbin <wangbin224@huawei.com>
To:     <naoya.horiguchi@nec.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mike.kravetz@oracle.com>,
        <nao.horiguchi@gmail.com>, <wangbin224@huawei.com>,
        <wuxu.wu@huawei.com>
Subject: Re: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory failure on hugetlbfs
Date:   Wed, 9 Jun 2021 10:23:11 +0800
Message-ID: <20210609022311.2102-1-wangbin224@huawei.com>
X-Mailer: git-send-email 2.29.2.windows.3
In-Reply-To: <20210608091352.GA943097@hori.linux.bs1.fc.nec.co.jp>
References: <20210608091352.GA943097@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.206]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you can use root privilege in your use-case, an easy way to get the
> number of corrupted hugepages is to use page-types.c (which reads
> /proc/kpageflags) like below:
> 
>     $ page-types -b huge,hwpoison=huge,hwpoison
>                  flags      page-count       MB  symbolic-flags                     long-symbolic-flags
>     0x00000000000a8000               1        0  _______________H_G_X_______________________        compound_head,huge,hwpoison
>                  total               1        0
> 
> But I guess that many usecases do not permit access to this interface,
> where some new accounting interface for corrupted hugepages could be
> helpful as you suggest.

Thanks for your suggestion very much. This approach is helpful to me.
But as you say, root privilege is not permitted in most cases. And I
also want to know the number of corrupted hugepages per node.

--
Bin Wang
