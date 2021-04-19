Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B49E363B55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhDSGQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:16:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17372 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhDSGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:16:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FNxNF501jzlYvR;
        Mon, 19 Apr 2021 14:14:05 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 19 Apr
 2021 14:15:57 +0800
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: Remove unnecessary struct
 declaration
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <kael_w@yeah.net>
References: <20210419022003.34172-1-wanjiabing@vivo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <58457717-a795-d33a-d771-f75fe05b1069@huawei.com>
Date:   Mon, 19 Apr 2021 14:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210419022003.34172-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/19 10:20, Wan Jiabing wrote:
> struct dnode_of_data is defined at 897th line.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

