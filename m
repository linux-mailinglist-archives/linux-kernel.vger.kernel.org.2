Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE362442747
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhKBGwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:52:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17002 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:52:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211102064955epoutp037e005724f62c41c4c4a8b7229c0b5d22~zp-0-RF8T3269932699epoutp03e
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:49:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211102064955epoutp037e005724f62c41c4c4a8b7229c0b5d22~zp-0-RF8T3269932699epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635835795;
        bh=zgM2b8+0LKviyC5vqLo6nP4ouKf1LS77+fCxHEjk83I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lVP2NdNwHoX+80yKrkbH0ONfAveLzlpdg4W9t3t0+LmfFI+jhxYbrSe+nnPV/e/AA
         Nukrclh69bKpTmXmI8AY+zwt3WFXXr9Bs1BSw1DBuEisaiwNxn+3J8Lb06OpZdx0/9
         kIvyX8VeovED6NXE5J+3q5S/0pipujnxDpCXA3Mc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211102064955epcas1p47fd28e73c6cb813f6354dc59a82781d8~zp-0uWP1H0701107011epcas1p4-;
        Tue,  2 Nov 2021 06:49:55 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Hk0rd3wdDz4x9Qg; Tue,  2 Nov
        2021 06:49:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.54.21932.19FD0816; Tue,  2 Nov 2021 15:49:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211102064953epcas1p323280abeb4ef9468531d19e9f7c913fd~zp-yjFCyT2122721227epcas1p3L;
        Tue,  2 Nov 2021 06:49:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211102064953epsmtrp1745603b60111f1d562138d5ba49990db~zp-yideCQ2023320233epsmtrp1Y;
        Tue,  2 Nov 2021 06:49:53 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-20-6180df91e517
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.4E.08738.19FD0816; Tue,  2 Nov 2021 15:49:53 +0900 (KST)
Received: from hj514 (unknown [10.253.100.146]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211102064953epsmtip11c907b86f65a51c236268a9ea8bf770e~zp-yZOTgB0396103961epsmtip1G;
        Tue,  2 Nov 2021 06:49:53 +0000 (GMT)
Message-ID: <cc63ca8752da7932b57769d58fce68dea5d9a8bc.camel@samsung.com>
Subject: Re: [PATCH v3] F2FS: invalidate META_MAPPING before IPU/DIO write
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     sj1557.seo@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Nov 2021 15:49:52 +0900
In-Reply-To: <9ee5741f-35f8-c0b9-f045-fb70aa49f6de@kernel.org>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmge7E+w2JBg275S1OTz3LZDG94yCb
        xZP1s5gtLi1yt7i8aw6bxZZ/R1gd2Dw2repk89i94DOTR9+WVYwenzfJBbBEZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BSYFegVJ+YWl+al6+WlllgZGhgYmQIVJmRnLP53lL1ggmRF
        S88d5gbGr4JdjJwcEgImEr8er2btYuTiEBLYwShx+k0TE4TziVFi16wNUM5nRokzr56ywLTM
        7/8D1bKLUWL7t+lsEM4TRokHN/ewdzFycPAKeEjsmOUGYgoLeElsOc4E0ssmoCPxYdZKRhBb
        RMBeovPbEjCbWSBJYsXP12A2i4CqxJ5/O5hAWjkF7CS+dhiBhEUF1CRerXzECmLzCghKnJz5
        hAWiVV5i+9s5zCAXSAi8ZZd49/AuO8SdLhIPuicyQtjCEq+Ob4GKS0m87G+Dsusljl/5xArR
        3MIo8XjpK0aQxRJAx72/ZAFiMgtoSqzfpQ9Rriix8/dcqJP5JN597WGFqOaV6GgTgihRlth8
        9zAbhC0p8XTRX6gLPCR+v+uABtQhRonNx66xTGBUmIXknVlI3pmFsHkBI/MqRrHUguLc9NRi
        wwITePwm5+duYgSnRC2LHYxz337QO8TIxMEINJyDWUmEl/loQ6IQb0piZVVqUX58UWlOavEh
        RlNg+E5klhJNzgcm5bySeEMTSwMTMyMTC2NLYzMlcd7PcoWJQgLpiSWp2ampBalFMH1MHJxS
        DUxZbNIrv6s+DtAzPLJ0bqgG14+PW7guMvMpJBQ3f56gduysiGJirKjIS4OSKdv/fZu4pEXv
        tnHDsZn9mofe21yU4XvZ6XHG1TaF6/hCs5wfYnpbxD2kXmxK+JF+//3OEia71U4HCieI3lUp
        +Hz5kvaMA5Pen9CcYS7FcjDGW+TO6cuHm12nPDh5RWZK+VqhWYeqL4h9m5lW68G5+c295akv
        Zz3mZnp1wXq5TPVBkcbpV58ntFgt1PvzOUVA3MRFpplNxmmValAR87MvkVObCx4lfts1+2uj
        zu/7VzfN/mLQpbxEzj9+Qu7C4OCnsjrX/71YaJLcE1siP/tOvPw3p2PhjaazDwVP29HD5rn5
        6qXpSizFGYmGWsxFxYkAKcCOBBIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnO7E+w2JBvt3sFucnnqWyWJ6x0E2
        iyfrZzFbXFrkbnF51xw2iy3/jrA6sHlsWtXJ5rF7wWcmj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4MpY/O8oe8EEyYqWnjvMDYxfBbsYOTkkBEwk5vf/Ye1i5OIQEtjBKPFm1S0ghwMoISkx
        b305hCkscfhwMUTJI0aJ699XMoPEeQU8JHbMcgMxhQW8JLYcZwKZyCagI/Fh1kpGEFtEwF6i
        89sSMJtZIFli7ob17CA2i4CqxJ5/O5hAWjkF7CS+dhiBhIUEjjNK3FlZA1GuKdG6/TdYuaiA
        msSrlY9YQWxeAUGJkzOfsEDUyEtsfzuHeQKj4CwkLbOQlM1CUraAkXkVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZwmGtp7WDcs+qD3iFGJg7GQ4wSHMxKIrzMRxsShXhTEiurUovy
        44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBqfF241H3D5gW6knu+XDGd
        /PnA3dnnz3IVLkoPPO3p2V598jan0d8vZR8OpJ//VOu/+1zc4oIOzTs+78X+Pt8tea7mRp5u
        84zvAltWvmU/zBDivEL3VbNk+PmXoivCnMybDnguL5rNFc66SCetXvSOv9qCSX1GsbfCjrd6
        1fK1P8pp8p5Q0lM5PX2bT4bnou+vtn4S/Wejf3CjqMeD5baZzddipn0scCz4MId7r1zfn021
        D6o36DVsfLbg8bo1Uzb+9c/ftd5sq0vMsg+3/ThSmV2SFrQcj15QMkU3mPtZ8vf5q08fPy2l
        oD+B117n9kk16dWbRO9+0TocsPRzX8ObS5qT/7Uy7F0VKlswKcHHQImlOCPRUIu5qDgRABDy
        eObiAgAA
X-CMS-MailID: 20211102064953epcas1p323280abeb4ef9468531d19e9f7c913fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211102045952epcas1p44cb6fd41baa76a19e0924c4b6b3cf1e6
References: <CGME20211102045952epcas1p44cb6fd41baa76a19e0924c4b6b3cf1e6@epcas1p4.samsung.com>
        <20211102045949.63530-1-hj514.kim@samsung.com>
        <9ee5741f-35f8-c0b9-f045-fb70aa49f6de@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-02 at 14:47 +0800, Chao Yu wrote:
> On 2021/11/2 12:59, Hyeong-Jun Kim wrote:
> > Encrypted pages during GC are read and cached in META_MAPPING.
> > However, due to cached pages in META_MAPPING, there is an issue
> > where
> > newly written pages are lost by IPU or DIO writes.
> > 
> > Thread A - f2fs_gc()            Thread B
> > /* phase 3 */
> > down_write(i_gc_rwsem)
> > ra_data_block()       ---- (a)
> > up_write(i_gc_rwsem)
> >                                  f2fs_direct_IO() :
> >                                   - down_read(i_gc_rwsem)
> >                                   - __blockdev_direct_io()
> >                                   - get_data_block_dio_write()
> >                                   - f2fs_dio_submit_bio()  ---- (b)
> >                                   - up_read(i_gc_rwsem)
> > /* phase 4 */
> > down_write(i_gc_rwsem)
> > move_data_block()     ---- (c)
> > up_write(i_gc_rwsem)
> > 
> > (a) In phase 3 of f2fs_gc(), up-to-date page is read from storage
> > and
> >      cached in META_MAPPING.
> > (b) In thread B, writing new data by IPU or DIO write on same
> > blkaddr as
> >      read in (a). cached page in META_MAPPING become out-dated.
> > (c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is
> > copied to
> >      new blkaddr. In conclusion, the newly written data in (b) is
> > lost.
> > 
> > To address this issue, invalidating pages in META_MAPPING before
> > IPU or
> > DIO write.
> > 
> > ---
> > v3:
> >   - Use sbi instead of fio->sbi in f2fs_inplace_write_data()
> > v2:
> >   - Update patch description with race condition
> 
> 
> 
> > Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
> > Signed-off-by: Hyeong-Jun Kim <
> > hj514.kim@samsung.com
> > >
> > ---
> 
> Change log should be attached here, otherwise Fixes & Signed-off-by
> tag will be lost
> after applying this patch.
> 
> Thanks,
> 
Thanks for your comment.
Should I re-send this patch?

Thanks,
> >   fs/f2fs/data.c    | 2 ++
> >   fs/f2fs/segment.c | 3 +++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 74e1a350c1d8..9f754aaef558 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode *inode,
> > struct f2fs_map_blocks *map,
> >   		 */
> >   		f2fs_wait_on_block_writeback_range(inode,
> >   						map->m_pblk, map-
> > >m_len);
> > +		invalidate_mapping_pages(META_MAPPING(sbi),
> > +						map->m_pblk, map-
> > >m_pblk);
> >   
> >   		if (map->m_multidev_dio) {
> >   			block_t blk_addr = map->m_pblk;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 526423fe84ce..df9ed75f0b7a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct
> > f2fs_io_info *fio)
> >   		goto drop_bio;
> >   	}
> >   
> > +	invalidate_mapping_pages(META_MAPPING(sbi),
> > +				fio->new_blkaddr, fio->new_blkaddr);
> > +
> >   	stat_inc_inplace_blocks(fio->sbi);
> >   
> >   	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 <<
> > F2FS_IPU_NOCACHE)))
> > 
> 
> 

