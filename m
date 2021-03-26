Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF25349E70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCZBJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:09:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13703 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCZBJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:09:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F63hT458LznWV1;
        Fri, 26 Mar 2021 09:06:33 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 26 Mar
 2021 09:08:59 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: fix a typo in inode.c
To:     Ruiqi Gong <gongruiqi1@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210325063811.6486-1-gongruiqi1@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c151c786-4649-7d30-e7e0-a30c15cbae9e@huawei.com>
Date:   Fri, 26 Mar 2021 09:08:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210325063811.6486-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 14:38, Ruiqi Gong wrote:
> Do a trivial typo fix.
> s/runing/running
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
