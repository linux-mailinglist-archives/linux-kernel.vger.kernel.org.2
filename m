Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268E379D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEKDTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:19:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2685 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:19:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfNN02q3Fz1BLB4;
        Tue, 11 May 2021 11:15:28 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 11:18:05 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] fsck.f2fs: fix memory leak caused by
 fsck_chk_orphan_node()
To:     Seung-Woo Kim <sw0312.kim@samsung.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <CGME20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba@epcas1p1.samsung.com>
 <20210510085726.12663-1-sw0312.kim@samsung.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9d2ea472-59c8-2a83-a7be-620635d00c4e@huawei.com>
Date:   Tue, 11 May 2021 11:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510085726.12663-1-sw0312.kim@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 16:57, Seung-Woo Kim wrote:
> With invalid node info from fsck_chk_orphan_node(), orphan_blk
> and new_blk are not freed. Fix memory leak in the path.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
