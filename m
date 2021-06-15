Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64D3A79D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFOJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:10:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7271 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhFOJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:10:41 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G42RX0qWMz1BMYF;
        Tue, 15 Jun 2021 17:03:36 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:08:35 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:08:35 +0800
Subject: Re: [PATCH 0/6] Fix deadlock in ftl formating on mtd
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210613113035.2329421-1-chengzhihao1@huawei.com>
 <20210613171208.64395d32@xps13>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <13b42e51-d176-ad54-e3a1-353284bb2d2e@huawei.com>
Date:   Tue, 15 Jun 2021 17:08:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210613171208.64395d32@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/6/13 23:12, Miquel Raynal 写道:
> Hi Zhihao,
> 
> Zhihao Cheng <chengzhihao1@huawei.com> wrote on Sun, 13 Jun 2021
> 19:30:29 +0800:
> 

> 
> I understand that some fixes need to revert a couple of patches, but
> isn't reverting 6 commits from the v2.6.32 kernel a bit odd for that?
> At least, can you justify this choice? Are all these commits useless
> and buggy?

Hi Miquel,

This series of revert patches came from history commits which related 
with "mtd: allow to unload the mtdtrans module if its block devices 
aren't open". I admin it's a weird method and let's forget it.
After some local tests, I think we'd better reserve "mtd: allow to 
unload the mtdtrans module if its block devices aren't open" to support 
removing mtdblock module if no one takes it. But we may move get|put 
mtd_device into add|del_mtd_blktrans to solve deadlock problem, maybe we 
don't have to get_mtd_device each time open mtd block device in 
blktrans_open if we have called get_mtd_device() in 
add_mtd_blktrans_dev(). See v2 "mtd: mtd_blkdevs: Get|Put mtd_device in 
add|del_mtd_blktrans".

>>
> 
> Thanks,
> Miquèl
> .
> 

