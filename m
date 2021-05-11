Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056ED379C38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEKBox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:44:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5097 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKBov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:44:51 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfLHK23zFzYY1p;
        Tue, 11 May 2021 09:41:17 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 09:43:43 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support iflag change given the mask
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
 <YJlGU+STYD5geyIc@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d052e04f-9b3c-8766-9b47-b4ea1daf6990@huawei.com>
Date:   Tue, 11 May 2021 09:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJlGU+STYD5geyIc@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 22:42, Jaegeuk Kim wrote:
> In f2fs_fileattr_set(),
> 
> 	if (!fa->flags_valid)
> 		mask &= FS_COMMON_FL;
> 
> In this case, we can set supported flags by mask only instead of BUG_ON.
> 
> /* Flags shared betwen flags/xflags */
> 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> 	 FS_PROJINHERIT_FL)
> 
> Fixes: 4c5b47997521 ("vfs: add fileattr ops")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Except fixes line issue pointed out by Eric, other part looks good
to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
