Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59313E3A60
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhHHNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 09:19:38 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52169 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhHHNTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 09:19:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UiIy9u2_1628428741;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UiIy9u2_1628428741)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 21:19:03 +0800
Date:   Sun, 8 Aug 2021 21:19:01 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Huang Jianan <huangjianan@oppo.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
Message-ID: <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
References: <20210808063343.255817-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210808063343.255817-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 06:33:43AM +0000, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> fs/erofs/data.c:150:24: warning:
>  symbol 'erofs_iomap_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of data.c, so marks it static.
> 
> Fixes: 3e9ce908c114 ("erofs: iomap support for non-tailpacking DIO")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
