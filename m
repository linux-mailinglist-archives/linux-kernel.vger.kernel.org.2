Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37A934B5B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhC0JfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 05:35:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15356 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhC0JfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:35:02 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6ttL12Csz8vRN;
        Sat, 27 Mar 2021 17:32:58 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 27 Mar
 2021 17:34:55 +0800
Subject: Re: [PATCH 3/4] erofs: introduce on-disk lz4 fs configurations
To:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-4-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f804a6b5-184a-0f14-c4e8-50409d53b3af@huawei.com>
Date:   Sat, 27 Mar 2021 17:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210327034936.12537-4-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/27 11:49, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Introduce z_erofs_lz4_cfgs to store all lz4 configurations.
> Currently it's only max_distance, but will be used for new
> features later.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
