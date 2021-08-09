Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9873E3E18
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhHIDGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:06:47 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40919 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhHIDGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:06:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UiLXKxy_1628478382;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UiLXKxy_1628478382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Aug 2021 11:06:23 +0800
Date:   Mon, 9 Aug 2021 11:06:22 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "weiyongjun (A)" <weiyongjun1@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Huang Jianan <huangjianan@oppo.com>,
        Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
Message-ID: <YRCbrtHZjo9oZfol@B-P7TQMD6M-0146.local>
References: <20210808063343.255817-1-weiyongjun1@huawei.com>
 <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
 <4ddfb962-97fc-28b0-0006-197574a1ec00@kernel.org>
 <82bae76e-8811-22d4-0b75-f58df1153def@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82bae76e-8811-22d4-0b75-f58df1153def@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:49:31AM +0800, weiyongjun (A) wrote:
> 
> 在 2021/8/9 7:56, Chao Yu 写道:
> > On 2021/8/8 21:19, Gao Xiang wrote:
> > > On Sun, Aug 08, 2021 at 06:33:43AM +0000, Wei Yongjun wrote:
> > > > The sparse tool complains as follows:
> > > > 
> > > > fs/erofs/data.c:150:24: warning:
> > > >   symbol 'erofs_iomap_ops' was not declared. Should it be static?
> > > > 
> > > > This symbol is not used outside of data.c, so marks it static.
> > 
> > Thanks for the patch, I guess it will be better to fix in original patch
> > if you don't mind.
> 
> 
> Yes, better to fix in original patch.

Ok, I'll merge this into the original patch this tomorrow.
(Anyway, thanks for the report!)

Thanks,
Gao Xiang

> 
> Regards.
