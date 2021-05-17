Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23D38227F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhEQBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:20:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2981 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhEQBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:20:23 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fk1Qz3C1RzQpQh;
        Mon, 17 May 2021 09:15:39 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 09:19:06 +0800
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 09:19:06 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: return success if there is no work to do
To:     <trix@redhat.com>, <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210515180941.1751362-1-trix@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <567d4fcd-6e02-d80e-33cb-3a6810bf833a@huawei.com>
Date:   Mon, 17 May 2021 09:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210515180941.1751362-1-trix@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/16 2:09, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> file.c:3206:2: warning: Undefined or garbage value returned to caller
>          return err;
>          ^~~~~~~~~~
> 
> err is only set if there is some work to do.  Because the loop returns
> immediately on an error, if all the work was done, a 0 would be returned.
> Instead of checking the unlikely case that there was no work to do,
> change the return of err to 0.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
