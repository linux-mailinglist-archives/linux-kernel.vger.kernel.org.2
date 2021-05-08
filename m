Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E437701C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEHGcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:32:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17482 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:32:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FccpD5q5dzkX9C;
        Sat,  8 May 2021 14:28:36 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 8 May 2021
 14:31:12 +0800
Subject: Re: [f2fs-dev] [RESEND][PATCH 2/2] mkfs.f2fs: fix memory leak in not
 enough segments error path
To:     Seung-Woo Kim <sw0312.kim@samsung.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <20210507111224.29887-1-sw0312.kim@samsung.com>
 <CGME20210507110917epcas1p4a2d7ebd7e2fd8cc630fdf627ad73a003@epcas1p4.samsung.com>
 <20210507111224.29887-2-sw0312.kim@samsung.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <37005c84-d93e-fd0b-af16-ce9f1260c0f2@huawei.com>
Date:   Sat, 8 May 2021 14:31:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210507111224.29887-2-sw0312.kim@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/7 19:12, Seung-Woo Kim wrote:
> In not enough segements error path of f2fs_write_check_point_pack(),
> cp_payload is not freed. Fix the error path.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
