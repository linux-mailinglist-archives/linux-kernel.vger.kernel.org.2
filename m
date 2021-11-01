Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449DC44156C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKAIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:41:30 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47899 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhKAIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:41:29 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211101083855epoutp04c5b1e3886783a7b6ae52e98d78c74454~zX1s2ar7V1528815288epoutp04V
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211101083855epoutp04c5b1e3886783a7b6ae52e98d78c74454~zX1s2ar7V1528815288epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635755935;
        bh=TrIUMzWOCdbzh+oXYZ4o1j8ckiPGqO30nSSC7qA6BSg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=leezz+2YCDkL/wcbofC/tuoIly9e2h+6j04tutvJZab4MK04FmmKQLxnnC6c2cU+X
         H9jxcOVp3YSbZ3oqvVuvtWosh81G+7tPe5fCLv7USarJCO/JHA0AwNzevHhm5sLjRj
         PCsuInSMYSKyzmLGyEuGLrdsxAJl1R4t+pXePt3s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211101083854epcas1p146216bfc3ed4c53a35ce5ae5faefc46b~zX1se7q3j0702107021epcas1p1V;
        Mon,  1 Nov 2021 08:38:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.243]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HjRJr0jKZz4x9Pt; Mon,  1 Nov
        2021 08:38:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.94.09592.A97AF716; Mon,  1 Nov 2021 17:38:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211101083850epcas1p3751548ab062341c85e8fa5bfbaaf3f46~zX1oTZpIZ0909609096epcas1p3r;
        Mon,  1 Nov 2021 08:38:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211101083850epsmtrp14b562c32498581db0777e7d359970943~zX1oSZvZu2747327473epsmtrp1m;
        Mon,  1 Nov 2021 08:38:50 +0000 (GMT)
X-AuditID: b6c32a39-be45aa8000002578-09-617fa79a56a1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.75.29871.997AF716; Mon,  1 Nov 2021 17:38:50 +0900 (KST)
Received: from hj514 (unknown [10.253.100.146]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211101083849epsmtip1447c860dc10d7121118d6f369caa2224~zX1oJLKMQ0498904989epsmtip1b;
        Mon,  1 Nov 2021 08:38:49 +0000 (GMT)
Message-ID: <b51b743463f9f9220a6407d54b406a2c402b931d.camel@samsung.com>
Subject: Re: [PATCH] F2FS: invalidate META_MAPPING before IPU/DIO write
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Nov 2021 17:38:49 +0900
In-Reply-To: <e1903d27-ff8e-adb2-ac64-5af662b99d1f@kernel.org>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmru6s5fWJBq82S1qcnnqWyWJ6x0E2
        iyfrZzFbXFrkbnF51xw2B1aPTas62Tx2L/jM5NG3ZRWjx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGScPv2YseKpT8er7a7YG
        xt/SXYycHBICJhK9Ky4ydjFycQgJ7GCU2Pn9BQtIQkjgE6NE33UniMQ3RompN2YywXTsa30D
        1bGXUeLo8+fMEM4TRok7/zaCVfEKeEic37MIbJSwgLvEo/ftrCA2m4COxIdZKxlBbBEBe4nO
        b0vAbGag+saO72A1LAKqEnPWNzOD2JwCdhKtN3rA4qICahKvVj5ihZgvKHFy5hMWiF55ie1v
        54AdISFwj13i1739zBCnukhs2NTEAmELS7w6voUdwpaSeNnfBmXXSxy/8okVormFUeLx0ldA
        F3EAOfYS7y9ZgJjMApoS63fpQ5QrSuz8PRfqZj6Jd19BbgOp5pXoaBOCKFGW2Hz3MBuELSnx
        dNFfRgjbQ+L+pvuskLBawSxx8MNExgmMCrOQvDMLyTuzEDYvYGRexSiWWlCcm55abFhgCo/h
        5PzcTYzgZKhluYNx+tsPeocYmTgYDzFKcDArifBGXKhJFOJNSaysSi3Kjy8qzUktPsRoCgzg
        icxSosn5wHScVxJvaGJpYGJmZGJhbGlspiTO+0WuMFFIID2xJDU7NbUgtQimj4mDU6qByVRs
        TdqSHRM1D21ebaPj26Zw/UKX5/pHDTYfj3m7F+au/imTO8d+2c7y1y/eTHV/4Rd2/QzrVEbx
        U24Xi91vCBu/CnrEsu6UuNpcT6nlt1XqlO+xBR+OX2N0c5HkkoTUp+f3/7T/v1nUNX9/Xe7e
        aUwSBUrhpWlvFoppT/mu9FvcpiLxW/GLmz/3i7+QO5qz21FOqFLoxffj5WKlXzbECIWta2E/
        53G8+Atjvdq3l3FXjyqctC0QMr15THHfjH1qoRq/jy04efzAyR+Tn7HHqQqJPlNa6cRjdVOv
        5/tp0zf/+P6dP6Jo+WD21EBTn7NbC+8o15xqvLJjH0db4+T6X+bd737rzm+fNNX280kZd2kl
        luKMREMt5qLiRAA2EI7WDwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSnO6s5fWJBi1nmSxOTwUS0zsOslk8
        WT+L2eLSIneLy7vmsDmwemxa1cnmsXvBZyaPvi2rGD0+b5ILYInisklJzcksSy3St0vgyjh5
        +DVjwVOdilffX7M1MP6W7mLk5JAQMJHY1/qGEcQWEtjNKPFsjW8XIwdQXFJi3vpyCFNY4vDh
        4i5GLqCKR4wSXZfaWEHKeQU8JM7vWcQCYgsLuEs8et8OFmcT0JH4MGsl2EgRAXuJzm9LwGxm
        oPrGju9gNSwCqhJz1jczg9icAnYSrTd6WCEWbGSWOH5yDTNEg6ZE6/bf7CC2qICaxKuVj6AW
        C0qcnPmEBaJGXmL72znMExgFZyFpmYWkbBaSsgWMzKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYJDXEtzB+P2VR/0DjEycTAeYpTgYFYS4Y24UJMoxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9O230Iab/8tknae72R6rb750f4r81vY+f/9
        Mt5gJXnfledx2s7W3JKNF2Zs+vy6I7X1b0l71KubG7b3NTUf3C86R7d/V7Jb5KQSnl/LZhVk
        9bxmr7m1bv/6KrGo9dVCHl5GPNmTPx7REfxxX6NsyasPW88smpwSbrCspbtO41XQvDKrR6mK
        57fvknM1sH5b3rjt26ZLafuP+K3m1Pu80aS4tevS9L/FC6LfvWeQMg1SM3vrnengt6Ptg75D
        RememNr8hh6W28HfjOSMtLIZQsKevDnv8+aYgWGQswoHz+flaVV7zKXP9Tb/t6jxurnTZOXe
        W4uuPrTavi9vN2/rphq/ut+6m5X+y1Zb963gjlNiKc5INNRiLipOBAD/GYgF4AIAAA==
X-CMS-MailID: 20211101083850epcas1p3751548ab062341c85e8fa5bfbaaf3f46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211101054217epcas1p3c695f37ab925f47156bd45e3adb5ed94
References: <CGME20211101054217epcas1p3c695f37ab925f47156bd45e3adb5ed94@epcas1p3.samsung.com>
        <20211101054214.24456-1-hj514.kim@samsung.com>
        <d1929b64-15a3-feaf-5401-1552b2eb2461@kernel.org>
        <9a0360922130485f4252970de4bb535667cc26e9.camel@samsung.com>
        <75c52307-7bfd-2408-d067-26d1fca7bb73@kernel.org>
        <02ffe8465f514102f5278e97bf3854c520fae91d.camel@samsung.com>
        <e1903d27-ff8e-adb2-ac64-5af662b99d1f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 16:11 +0800, Chao Yu wrote:
> On 2021/11/1 15:23, Hyeong-Jun Kim wrote:
> > On Mon, 2021-11-01 at 15:12 +0800, Chao Yu wrote:
> > > On 2021/11/1 15:09, Hyeong-Jun Kim wrote:
> > > > On Mon, 2021-11-01 at 14:28 +0800, Chao Yu wrote:
> > > > > On 2021/11/1 13:42, Hyeong-Jun Kim wrote:
> > > > > > Encrypted pages during GC are read and cached in
> > > > > > META_MAPPING.
> > > > > > However, due to cached pages in META_MAPPING, there is an
> > > > > > issue
> > > > > > where
> > > > > > newly written pages are lost by IPU or DIO writes.
> > > > > > 
> > > > > > Thread A                              Thread B
> > > > > > - f2fs_gc(): blk 0x10 -> 0x20 (a)
> > > > > >                                          - IPU or DIO write
> > > > > > on
> > > > > > blk
> > > > > > 0x20 (b)
> > > > > > - f2fs_gc(): blk 0x20 -> 0x30 (c)
> > > > > > 
> > > > > > (a) page for blk 0x20 is cached in META_MAPPING and page
> > > > > > for
> > > > > > blk
> > > > > > 0x10
> > > > > >        is invalidated from META_MAPPING.
> > > > > > (b) write new data to blk 0x200 using IPU or DIO, but
> > > > > > outdated
> > > > > > data
> > > > > >        still remains in META_MAPPING.
> > > > > > (c) f2fs_gc() try to move blk from 0x20 to 0x30 using
> > > > > > cached
> > > > > > page
> > > > > > in
> > > > > >        META_MAPPING. In conclusion, the newly written data
> > > > > > in
> > > > > > (b) is
> > > > > > lost.
> > > > > 
> > > > > In c), f2fs_gc() will readahead encrypted block from disk via
> > > > > ra_data_block() anyway,
> > > > > not matter cached encrypted page of meta inode is uptodate or
> > > > > not, so
> > > > > it's safe, right?
> > > > 
> > > > Right,
> > > > However, if DIO write is performed between phase 3 and phase 4
> > > > of
> > > > f2fs_gc(),
> > > > the cached page of meta_mapping will be out-dated, though it
> > > > read
> > > > data
> > > > from
> > > > disk via ra_data_block() in phase 3.
> > > > 
> > > > What do you think?
> > > 
> > > Due to i_gc_rwsem lock coverage, the race condition should not
> > > happen
> > > right now?
> > > 
> > 
> > - Thread A                                       - Thread B
> > /* phase 3 */
> > down_write(i_gc_rwsem)
> > ra_data_block()
> > up_write(i_gc_rwsem)
> >                                                         
> >   f2fs_direct_IO() :
> >                                                         
> >   down_read(i_gc_rwsem)
> >                                                         
> >   __blockdev_direct_IO()
> >                                                             ...
> >                                                           
> >   get_ddata_block_dio_write()
> >                                                             ...
> >                                                           
> >   f2fs_dio_submit_bio()
> >                                                         
> >   up_read(i_gc_rwsem)
> > /* phase 4 */
> > down_write(i_gc_rwsem)
> > move_data_block()
> > up_write(i_gc_rwsem)
> > 
> > It looks, i_gc_rwsem could not protect page update between phase 3
> > and
> > 4.
> > 
> > Am I missing anything?
> 
> It looks you're right, there is a hole in between readahead and
> movepage functions...
> 
> Could you please update the race condition description? and add a tag
> as below to fix
> stable kernel as well:
> 
> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
> 
> Thanks,
Thank for your comment.
I will send Patch v2 with new description.

Thanks,
> 
> > Thanks
> > 
> > > Thanks,
> > > 
> > > > Thanks,
> > > > > Am I missing anything?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > To address this issue, invalidating pages in META_MAPPING
> > > > > > before
> > > > > > IPU or
> > > > > > DIO write.
> > > > > > 
> > > > > > Signed-off-by: Hyeong-Jun Kim <
> > > > > > hj514.kim@samsung.com
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > ---
> > > > > >     fs/f2fs/data.c    | 2 ++
> > > > > >     fs/f2fs/segment.c | 3 +++
> > > > > >     2 files changed, 5 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > index 74e1a350c1d8..9f754aaef558 100644
> > > > > > --- a/fs/f2fs/data.c
> > > > > > +++ b/fs/f2fs/data.c
> > > > > > @@ -1708,6 +1708,8 @@ int f2fs_map_blocks(struct inode
> > > > > > *inode,
> > > > > > struct f2fs_map_blocks *map,
> > > > > >     		 */
> > > > > >     		f2fs_wait_on_block_writeback_range(inod
> > > > > > e,
> > > > > >     						map-
> > > > > > >m_pblk,
> > > > > > map-
> > > > > > > m_len);
> > > > > > 
> > > > > > +		invalidate_mapping_pages(META_MAPPING(sbi),
> > > > > > +						map->m_pblk,
> > > > > > map-
> > > > > > > m_pblk);
> > > > > > 
> > > > > >     
> > > > > >     		if (map->m_multidev_dio) {
> > > > > >     			block_t blk_addr = map->m_pblk;
> > > > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > > > index 526423fe84ce..f57c55190f9e 100644
> > > > > > --- a/fs/f2fs/segment.c
> > > > > > +++ b/fs/f2fs/segment.c
> > > > > > @@ -3652,6 +3652,9 @@ int f2fs_inplace_write_data(struct
> > > > > > f2fs_io_info *fio)
> > > > > >     		goto drop_bio;
> > > > > >     	}
> > > > > >     
> > > > > > +	invalidate_mapping_pages(META_MAPPING(fio->sbi),
> > > > > > +				fio->new_blkaddr, fio-
> > > > > > > new_blkaddr);
> > > > > > 
> > > > > > +
> > > > > >     	stat_inc_inplace_blocks(fio->sbi);
> > > > > >     
> > > > > >     	if (fio->bio && !(SM_I(sbi)->ipu_policy & (1 <<
> > > > > > F2FS_IPU_NOCACHE)))
> > > > > > 
> > > > > 
> > > > > 
> > > 
> > > 
> 
> 

