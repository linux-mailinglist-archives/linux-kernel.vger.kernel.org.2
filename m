Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6648145FD92
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353185AbhK0JZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 04:25:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31915 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbhK0JW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 04:22:59 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J1Qzv4ZsxzcbSf;
        Sat, 27 Nov 2021 17:19:39 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (7.193.23.29) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:19:43 +0800
Received: from [10.174.185.187] (10.174.185.187) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:19:42 +0800
Message-ID: <8ddeff27-267b-bc87-1061-9e7946fe9b42@huawei.com>
Date:   Sat, 27 Nov 2021 17:19:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
From:   Peng Liang <liangpeng10@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hughd@google.com>,
        <akpm@linux-foundation.org>,
        xiexiangyou 00584000 <xiexiangyou@huawei.com>,
        zhengchuan <zhengchuan@huawei.com>, <wanghao232@huawei.com>,
        chenwandun 00417970 <chenwandun@huawei.com>
Subject: Questions about page fault of memfd/shmem
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.187]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a user-space developer and I want to use memfd to share some memory
between parent and child processes.

For the demo, it works well.  However, I fount that the RSS of the
process using memfd will grow up faster than that using anonymous
mappings.  Dig some memfd/shmem code and I find that memfd/shmem will
allocate a page for a read page fault.

For my use case, the process may allocate tens or even hundreds of GiB
memory using memfd.  So allocating all memory just because of reading it
will has a great impact.

Could memfd/shmem map to the global zero page instead of allocating a
page for a read page fault?

Thanks,
Peng
