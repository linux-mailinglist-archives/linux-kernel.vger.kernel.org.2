Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A90377018
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEHGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:31:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17157 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:31:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FccmH0kzvzncHs;
        Sat,  8 May 2021 14:26:55 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 8 May 2021
 14:30:08 +0800
Subject: Re: [f2fs-dev] [RESEND][PATCH 1/2] resize.f2fs: fix memory leak
 caused by migrate_nat()
To:     Seung-Woo Kim <sw0312.kim@samsung.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <CGME20210507110917epcas1p13e027d5e0319629c255524c8c6f6461b@epcas1p1.samsung.com>
 <20210507111224.29887-1-sw0312.kim@samsung.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <62135167-c553-259e-0228-8059cf238576@huawei.com>
Date:   Sat, 8 May 2021 14:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210507111224.29887-1-sw0312.kim@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/7 19:12, Seung-Woo Kim wrote:
> Alloced nat_block doesn't freed from migrate_nat(). Fix to free
> nat_block.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
