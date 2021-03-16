Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4333CEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhCPHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:39:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13624 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhCPHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:39:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F04qq5C2vz16D9L;
        Tue, 16 Mar 2021 15:37:11 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 16 Mar
 2021 15:38:59 +0800
Subject: Re: [PATCH v6 1/2] erofs: avoid memory allocation failure during
 rolling decompression
To:     Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, <guoweichao@oppo.com>,
        <zhangshiming@oppo.com>
References: <20210316031515.90954-1-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3c54be1f-7807-9398-7e75-0c521403d2e0@huawei.com>
Date:   Tue, 16 Mar 2021 15:38:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210316031515.90954-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/16 11:15, Huang Jianan via Linux-erofs wrote:
> Currently, err would be treated as io error. Therefore, it'd be
> better to ensure memory allocation during rolling decompression
> to avoid such io error.
> 
> In the long term, we might consider adding another !Uptodate case
> for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
