Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AE433EA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCQGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:46:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13949 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhCQGp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:45:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0gcS6v2fzkb8C;
        Wed, 17 Mar 2021 14:44:24 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 17 Mar
 2021 14:45:53 +0800
Subject: Re: [PATCH 2/2] erofs: use sync decompression for atomic contexts
 only
To:     Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, <guoweichao@oppo.com>,
        <zhangshiming@oppo.com>
References: <20210317035448.13921-1-huangjianan@oppo.com>
 <20210317035448.13921-3-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <62153424-198c-807e-cced-33dd90279174@huawei.com>
Date:   Wed, 17 Mar 2021 14:45:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210317035448.13921-3-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/17 11:54, Huang Jianan via Linux-erofs wrote:
> Sync decompression was introduced to get rid of additional kworker
> scheduling overhead. But there is no such overhead in non-atomic
> contexts. Therefore, it should be better to turn off sync decompression
> to avoid the current thread waiting in z_erofs_runqueue.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
