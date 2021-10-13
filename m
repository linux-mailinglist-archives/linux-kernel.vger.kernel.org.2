Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE17342C107
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhJMNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:12:34 -0400
Received: from m12-13.163.com ([220.181.12.13]:45508 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhJMNM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=oxuvT
        bpMllyE1Tkou68v6Yx0582iwlUjkPcpZ5zOztM=; b=ZI/h2sLzGGOyn4QxR0j3m
        gZTyeXE6Vh7njERwFppc6lZ8qAowC7prfniF4v21Y8+kulQsYmp6ZZo0lgStRUII
        moZCqm1CuIRTQ3AZgA7YZVm10CDWEsM6f2Uf5bAlwq7x088+tQBiiwWL51Ihguqu
        ABm6OJXatakj32Xql9pKeQ=
Received: from rockpi4b (unknown [112.20.67.224])
        by smtp9 (Coremail) with SMTP id DcCowACnrqqu2mZh37buIw--.48564S2;
        Wed, 13 Oct 2021 21:10:07 +0800 (CST)
Date:   Wed, 13 Oct 2021 21:10:05 +0800
From:   Yue Hu <zbestahu@163.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] erofs: fix the per-CPU buffer decompression for small
 output size
Message-ID: <20211013211005.7bd9fc08.zbestahu@163.com>
In-Reply-To: <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
References: <20211013092906.1434-1-zbestahu@gmail.com>
        <YWbIWydks+wpuNij@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowACnrqqu2mZh37buIw--.48564S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrWrWkGr45Kw43uw4fAFb_yoWkWFg_Wr
        Z2vrZ7KrZ8Xr1xGr1DGFs5uFyYgFWkGr4kG3y5ZrW5CFyrW3W8Jr4DGr45Ga17GrZav3yU
        Krnak343Kr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjLFx5UUUUU==
X-Originating-IP: [112.20.67.224]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbitAwrEVSInMxNzAAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On Wed, 13 Oct 2021 19:51:55 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Wed, Oct 13, 2021 at 05:29:05PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Note that z_erofs_lz4_decompress() will return a positive value if
> > decompression succeeds. However, we do not copy_from_pcpubuf() due
> > to !ret. Let's fix it.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Thanks for catching this. This is a valid issue, but it has no real
> impact to the current kernels since such pcluster in practice will be
> !inplace_io and trigger "if (nrpages_out == 1 && !rq->inplace_io) {"
> above for upstream strategies.
> 
> Our customized lz4 implementation will return 0 if success instead, so
> it has no issue to our previous products as well.

Yes, i just find the issue when i try to implement a new feature of
tail-packing inline compressed data. No problem in my current version.

Thanks.

> 
> For such cases, how about updating z_erofs_lz4_decompress() to return
> 0 if success instead rather than outputsize. Since I'll return 0 if
> success for LZMA as well.
> 
> Thanks,
> Gao Xiang


