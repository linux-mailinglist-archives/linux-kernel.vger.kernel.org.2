Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8B394B31
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2JNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 05:13:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2090 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2JNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 05:13:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsbK806lnzWnlT;
        Sat, 29 May 2021 17:06:52 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 17:11:29 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 17:11:29 +0800
Subject: Re: [PATCH 0/2] cleanup patches for PM reference leak
To:     <emma@anholt.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210517081438.1562410-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <173999eb-7e2d-107d-8602-a1a88e9f2d5a@huawei.com>
Date:   Sat, 29 May 2021 17:11:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210517081438.1562410-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ...

On 2021/05/17 16:14, Yu Kuai wrote:
> Yu Kuai (2):
>    drm/v3d: Fix PM reference leak in v3d_get_param_ioctl()
>    drm/v3d: Fix PM reference leak in v3d_v3d_debugfs_ident()
> 
>   drivers/gpu/drm/v3d/v3d_debugfs.c | 4 ++--
>   drivers/gpu/drm/v3d/v3d_drv.c     | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
