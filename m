Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1332DF00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhCEBT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:19:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13058 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:19:58 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ds8x31fxdzMjGY;
        Fri,  5 Mar 2021 09:17:43 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 5 Mar 2021
 09:19:48 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix a redundant call to f2fs_balance_fs
 if an error occurs
To:     Colin King <colin.king@canonical.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210304092118.2279879-1-colin.king@canonical.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a67cbd86-0e44-490a-95fa-cf300e005d2e@huawei.com>
Date:   Fri, 5 Mar 2021 09:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210304092118.2279879-1-colin.king@canonical.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/4 17:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The  uninitialized variable dn.node_changed does not get set when a
> call to f2fs_get_node_page fails.  This uninitialized value gets used
> in the call to f2fs_balance_fs() that may or not may not balances
> dirty node and dentry pages depending on the uninitialized state of
> the variable. Fix this by only calling f2fs_balance_fs if err is
> not set.
> 
> Thanks to Jaegeuk Kim for suggesting an appropriate fix.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 2a3407607028 ("f2fs: call f2fs_balance_fs only when node was changed")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
