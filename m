Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7E3F12AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhHSFPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:15:41 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57853 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhHSFPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:15:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjyVVjp_1629350099;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UjyVVjp_1629350099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 13:15:00 +0800
Date:   Thu, 19 Aug 2021 13:14:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: support reading chunk-based uncompressed files
Message-ID: <YR3o0qjHCR7DE7kO@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818070713.4437-2-hsiangkao@linux.alibaba.com>
 <2c833d7e-9f82-f1f7-a576-b9fc50e0cb15@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c833d7e-9f82-f1f7-a576-b9fc50e0cb15@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Thu, Aug 19, 2021 at 11:46:11AM +0800, Chao Yu wrote:
> On 2021/8/18 15:07, Gao Xiang wrote:
> > +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> > +			/* fill chunked inode summary info */
> > +			vi->chunkformat = __le16_to_cpu(die->i_u.c.format);
> 
> le16_to_cpu(),

Thanks for the review and catching this, I didn't meant to use that.
Will send out the next version soon.

Thanks,
Gao Xiang

> 
> >   		kfree(copied);
> >   		break;
> >   	case EROFS_INODE_LAYOUT_COMPACT:
> > @@ -160,6 +163,8 @@ static struct page *erofs_read_inode(struct inode *inode,
> >   		inode->i_size = le32_to_cpu(dic->i_size);
> >   		if (erofs_inode_is_data_compressed(vi->datalayout))
> >   			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
> > +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> > +			vi->chunkformat = __le16_to_cpu(dic->i_u.c.format);
> 
> Ditto.
> 
> Thanks,
