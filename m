Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF63E5578
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbhHJIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:33:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50504 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238416AbhHJIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:32:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UiZoa1k_1628584314;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UiZoa1k_1628584314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Aug 2021 16:31:56 +0800
Date:   Tue, 10 Aug 2021 16:31:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: remove the mapping parameter from
 erofs_try_to_free_cached_page()
Message-ID: <YRI5es3gTSbqEqq1@B-P7TQMD6M-0146.local>
References: <20210810072416.1392-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810072416.1392-1-zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:24:16PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> The mapping is not used at all, remove it and update related code.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
