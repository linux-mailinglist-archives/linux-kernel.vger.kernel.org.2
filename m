Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C5430A07C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBADPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:15:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhBADPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:15:47 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTY1n0tQ6z162GY;
        Mon,  1 Feb 2021 11:13:49 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 1 Feb 2021
 11:15:01 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary initialization in
 xattr.c
To:     Liu Song <fishland@aliyun.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <liu.song11@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210131122605.3296-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5cbe4b42-9aaa-c05c-b46a-46dc3c6c14f3@huawei.com>
Date:   Mon, 1 Feb 2021 11:15:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210131122605.3296-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/31 20:26, Liu Song via Linux-f2fs-devel wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> These variables will be explicitly assigned before use,
> so there is no need to initialize.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
