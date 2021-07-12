Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F473C5D62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhGLNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:39:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14069 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGLNjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:39:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GNl8b5dTjzYrTf;
        Mon, 12 Jul 2021 21:33:35 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 21:36:50 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 12 Jul 2021 21:36:49 +0800
Subject: Re: [PATCH v2] mtd: mtd_blkdevs: Get|Put mtd_device in
 add|del_mtd_blktrans
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <computersforpeace@gmail.com>, <maximlevitsky@gmail.com>,
        <David.Woodhouse@intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210615091302.3428611-1-chengzhihao1@huawei.com>
 <13509562-158e-f883-5a70-094126dca993@nokia.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2641a9cb-e3d4-53a0-ecaa-dfd9091848b7@huawei.com>
Date:   Mon, 12 Jul 2021 21:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <13509562-158e-f883-5a70-094126dca993@nokia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/6/15 17:27, Alexander Sverdlin 写道:
> Hello!
>
> On 15/06/2021 11:13, Zhihao Cheng wrote:
>> There are two reasons to move mtd_device get|put operations into mtd
>> blktrans adding/deleting:
> ...
>
>> Fixes: 073db4a51ee43c ("mtd: fix: avoid race condition when ...")
>> Fixes: 008c751ec78587 ("mtd: allow to unload the mtdtrans module if ...")
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
friendly ping


