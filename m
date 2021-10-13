Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF842BF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhJMLyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:54:04 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54879 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhJMLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:54:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UrgqRZm_1634125916;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UrgqRZm_1634125916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Oct 2021 19:51:57 +0800
Date:   Wed, 13 Oct 2021 19:51:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: fix the per-CPU buffer decompression for small
 output size
Message-ID: <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
References: <20211013092906.1434-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013092906.1434-1-zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Wed, Oct 13, 2021 at 05:29:05PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that z_erofs_lz4_decompress() will return a positive value if
> decompression succeeds. However, we do not copy_from_pcpubuf() due
> to !ret. Let's fix it.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Thanks for catching this. This is a valid issue, but it has no real
impact to the current kernels since such pcluster in practice will be
!inplace_io and trigger "if (nrpages_out == 1 && !rq->inplace_io) {"
above for upstream strategies.

Our customized lz4 implementation will return 0 if success instead, so
it has no issue to our previous products as well.

For such cases, how about updating z_erofs_lz4_decompress() to return
0 if success instead rather than outputsize. Since I'll return 0 if
success for LZMA as well.

Thanks,
Gao Xiang
