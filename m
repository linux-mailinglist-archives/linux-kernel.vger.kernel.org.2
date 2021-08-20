Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC23F293F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHTJeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:34:03 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46656 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235313AbhHTJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:34:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UkJoTcw_1629452002;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UkJoTcw_1629452002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 20 Aug 2021 17:33:23 +0800
Date:   Fri, 20 Aug 2021 17:33:21 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: Re: [PATCH v2 2/2] erofs: support reading chunk-based uncompressed
 files
Message-ID: <YR924TIIgLzJx0Ok@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-2-hsiangkao@linux.alibaba.com>
 <aaf64137-02f9-db98-10d4-4757bc6f25ec@kernel.org>
 <YR9x7W4wObWdZdrx@B-P7TQMD6M-0146.local>
 <f501144f-f7fc-1150-0c41-4c1981bd0594@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f501144f-f7fc-1150-0c41-4c1981bd0594@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 05:29:36PM +0800, Chao Yu wrote:
> On 2021/8/20 17:12, Gao Xiang wrote:
> > Hi Chao,
> > 
> > On Fri, Aug 20, 2021 at 05:04:13PM +0800, Chao Yu wrote:
> > > On 2021/8/19 14:33, Gao Xiang wrote:
> > 
> > ...
> > 
> > > >    }
> > > > +static int erofs_map_blocks(struct inode *inode,
> > > > +			    struct erofs_map_blocks *map, int flags)
> > > > +{
> > > > +	struct super_block *sb = inode->i_sb;
> > > > +	struct erofs_inode *vi = EROFS_I(inode);
> > > > +	struct erofs_inode_chunk_index *idx;
> > > > +	struct page *page;
> > > > +	u64 chunknr;
> > > > +	unsigned int unit;
> > > > +	erofs_off_t pos;
> > > > +	int err = 0;
> > > > +
> > > > +	if (map->m_la >= inode->i_size) {
> > > > +		/* leave out-of-bound access unmapped */
> > > > +		map->m_flags = 0;
> > > > +		map->m_plen = 0;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> > > > +		return erofs_map_blocks_flatmode(inode, map, flags);
> > > > +
> > > > +	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
> > > > +		unit = sizeof(*idx);	/* chunk index */
> > > > +	else
> > > > +		unit = 4;		/* block map */
> > > 
> > > You mean sizeof(__le32)?
> > 
> > Yeah, sizeof(__le32) == 4, either way works for me.
> > 
> > If some tendency about this, I will update when applying.
> 
> Xiang,
> 
> Yeah, I preper:
> 
> #define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)
> 
> 	unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
> 
> to improve readablity, but unit = sizeof(__le32) is fine as well.

Ok, looks much better, let me revise v3 here.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > > 
> > > Otherwise it looks good to me.
> > > 
> > > Reviewed-by: Chao Yu <chao@kernel.org>
> > > 
> > 
> > Thanks for the review!
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > Thanks,
> > > 
