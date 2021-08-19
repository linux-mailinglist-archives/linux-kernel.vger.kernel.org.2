Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7C3F0FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHSBAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:00:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55820 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235658AbhHSBAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:00:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjtBNTL_1629334764;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UjtBNTL_1629334764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 08:59:26 +0800
Date:   Thu, 19 Aug 2021 08:59:24 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: introduce chunk-based file on-disk format
Message-ID: <YR2s7Gj7RDl7TaVn@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818222804.GA73193@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818222804.GA73193@rsjd01523.et2sqa>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Thu, Aug 19, 2021 at 06:28:04AM +0800, Liu Bo wrote:
> On Wed, Aug 18, 2021 at 03:07:12PM +0800, Gao Xiang wrote:

...

> > +	EROFS_INODE_CHUNK_BASED			= 4,
> >  	EROFS_INODE_DATALAYOUT_MAX
> >  };
> >  
> > @@ -90,6 +96,19 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
> >  #define EROFS_I_ALL	\
> >  	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
> >  
> > +/* indicate chunk blkbits, thus `chunksize = blocksize << chunk blkbits' */
> 
> A typo in the quotation marks.  (`chunksize = ) should be ('chunksize =)

Such usage is like below:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e389028ad75412ff624b304913bba14f8d46ec4
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78128fabd022240852859c0b253972147593690b
I'm fine in either way. I'll update it in the next version or when
submitting.

> 
> Otherwise it looks good.
> 
> Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

Thanks for the review!

Thanks,
Gao Xiang

> 
> thanks,
> liubo
> 
