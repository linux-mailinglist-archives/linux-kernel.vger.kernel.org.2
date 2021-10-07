Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE354424D45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhJGGbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:31:15 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17471 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232418AbhJGGbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:31:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UqoCT-J_1633588156;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UqoCT-J_1633588156)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Oct 2021 14:29:19 +0800
Date:   Thu, 7 Oct 2021 14:29:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Yan Song <imeoer@linux.alibaba.com>,
        Changwei Ge <chge@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v3 1/2] erofs: decouple basic mount options from
 fs_context
Message-ID: <YV6TvAPGYOMGxenU@B-P7TQMD6M-0146.local>
References: <20211006194453.130447-1-hsiangkao@linux.alibaba.com>
 <20211007061048.GA84859@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007061048.GA84859@rsjd01523.et2sqa>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Thu, Oct 07, 2021 at 02:10:48PM +0800, Liu Bo wrote:
> On Thu, Oct 07, 2021 at 03:44:52AM +0800, Gao Xiang wrote:
> > Previously, EROFS mount options are all in the basic types, so
> > erofs_fs_context can be directly copied with assignment. However,
> > when the multiple device feature is introduced, it's hard to handle
> > multiple device information like the other basic mount options.
> > 
> > There is no need to allocate the whole sb info in advance, instead,
> > let's separate the basic mount options from fs_context, thus
> > multiple device information can be handled gracefully then.
> 
> This is a bit confusing, IIRC, currently erofs does not allocate the whole
> sb info in advance, does it?

No, it doesn't. I just mentioned there are 2 ways to pass fs private
contexts to fs_context:
 1) allocate sbi in advance by using fc->s_fs_info;
 2) allocate/pass a fs private fs_context by using fc->fs_private;

erofs uses the second way.... Actually I'm fine with getting rid of
such expression to avoid confusion for the next version...

Thanks,
Gao Xiang

> 
> thanks,
> liubo
