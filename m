Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF787393B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 04:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhE1CJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 22:09:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2068 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbhE1CJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 22:09:43 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frnz74bpKzWp7w;
        Fri, 28 May 2021 10:03:31 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 10:08:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: logging neatening
To:     Joe Perches <joe@perches.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <1703a46c87dff3dbfdab008f1d268fe0b24c7db1.camel@perches.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <86100529-fdb6-d06a-b002-454131415975@huawei.com>
Date:   Fri, 28 May 2021 10:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1703a46c87dff3dbfdab008f1d268fe0b24c7db1.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx703-chm.china.huawei.com (10.1.199.50) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/27 4:05, Joe Perches wrote:
> Update the logging uses that have unnecessary newlines as the f2fs_printk
> function and so its f2fs_<level> macro callers already adds one.
> 
> This allows searching single line logging entries with an easier grep and
> also avoids unnecessary blank lines in the logging.
> 
> Miscellanea:
> 
> o Coalesce formats
> o Align to open parenthesis
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
