Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509A32A3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378985AbhCBJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:33:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13833 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837891AbhCBJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:09:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DqW3y4QwFz7s3j;
        Tue,  2 Mar 2021 16:47:58 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 2 Mar 2021
 16:49:36 +0800
Subject: Re: [PATCH] f2fs: fix compile warning
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210302084458.15077-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b7a214b4-5d51-5a47-79a1-1592063552d7@huawei.com>
Date:   Tue, 2 Mar 2021 16:49:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210302084458.15077-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/2 16:44, Chao Yu wrote:
> node.c:2750:13: note: in expansion of macro ‘min’
>     nrpages = min(last_offset - i, BIO_MAX_PAGES);

Oh, after I rebase to last dev branch, compile warning is gone as
we changed to use bio_max_segs() rather than min().

Please ignore this patch.

Thanks,
