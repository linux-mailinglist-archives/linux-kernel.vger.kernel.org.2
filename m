Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29DE3275F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 02:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhCAB7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 20:59:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13097 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhCAB7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 20:59:41 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dpk0Z6Q5Hz165PD;
        Mon,  1 Mar 2021 09:57:18 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 1 Mar 2021
 09:58:54 +0800
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: remove unnecessary IS_SWAPFILE check
To:     Huang Jianan <huangjianan@oppo.com>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <zhangshiming@oppo.com>
References: <20210227120231.136559-1-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4b772e04-62fc-ed9a-a664-a908a464addd@huawei.com>
Date:   Mon, 1 Mar 2021 09:58:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210227120231.136559-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/27 20:02, Huang Jianan via Linux-f2fs-devel wrote:
> Now swapfile in f2fs directly submit IO to blockdev according to
> swapfile extents reported by f2fs when swapon, therefore there is
> no need to check IS_SWAPFILE when exec filesystem operation.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
