Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A070321336
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBVJg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:36:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12633 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhBVJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:35:39 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DkcS06Gl3z16BRl;
        Mon, 22 Feb 2021 17:33:20 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 22 Feb
 2021 17:34:52 +0800
Subject: Re: [f2fs-dev] [PATCH] Documentation/ABI/testing: Fix a spelling
 error
To:     Yehan Xu <yehanxu1@gmail.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     xuyehan <xuyehan@xiaomi.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <1613963083-29332-1-git-send-email-yehanxu1@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7e9adfa1-b72f-7e97-84e9-f5aa9542b690@huawei.com>
Date:   Mon, 22 Feb 2021 17:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1613963083-29332-1-git-send-email-yehanxu1@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/22 11:04, Yehan Xu wrote:
> From: xuyehan <xuyehan@xiaomi.com>
> 
> Delete the letter 'e' before 'number'

The patch title should be: "f2fs: fix a spelling error"

> 
> Signed-off-by: xuyehan <xuyehan@xiaomi.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
