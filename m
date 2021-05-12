Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7292737B376
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhELB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:29:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2425 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:29:34 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ffxtw3sgSz5yyY;
        Wed, 12 May 2021 09:25:44 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 12 May 2021 09:28:24 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid swapon failure by giving a warning
 first
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     kernel test robot <oliver.sang@intel.com>
References: <20210511214337.2857522-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <925bff47-de32-76b8-041d-0aad4fec0d54@huawei.com>
Date:   Wed, 12 May 2021 09:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210511214337.2857522-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/12 5:43, Jaegeuk Kim wrote:
> The final solution can be migrating blocks to form a section-aligned file
> internally. Meanwhile, let's ask users to do that when preparing the swap
> file initially like:
> 1) create()
> 2) ioctl(F2FS_IOC_SET_PIN_FILE)
> 3) fallocate()

Let me take a look how to migrate unaligned swapfile during swapon(). :)

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 36e4d95891ed ("f2fs: check if swapfile is section-alligned")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
