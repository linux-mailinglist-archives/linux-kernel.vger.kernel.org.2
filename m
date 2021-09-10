Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966F1406574
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhIJBzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:55:14 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32992 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhIJBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:55:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Unqrd8t_1631238837;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Unqrd8t_1631238837)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 09:53:58 +0800
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Fix handle refcount leak in two
 exception handling paths
To:     Wengang Wang <wen.gang.wang@oracle.com>
Cc:     Chenyuan Mi <cymi20@fudan.edu.cn>,
        akpm <akpm@linux-foundation.org>, Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20210908102055.10168-1-cymi20@fudan.edu.cn>
 <06d9e055-29b9-731c-5a36-d888f2c83188@linux.alibaba.com>
 <6018AF95-3613-4D43-A3E6-7BAA0E0BE009@oracle.com>
 <c48fb54e-0dd9-42c7-f53d-2ea58fb97255@linux.alibaba.com>
 <CED0D2AD-7905-490E-8D36-50D192CD9BF1@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ee86ea1a-0348-e975-3c67-8d574eaadbe3@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 09:53:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CED0D2AD-7905-490E-8D36-50D192CD9BF1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/21 1:48 AM, Wengang Wang wrote:
> 
> 
> On Sep 9, 2021, at 4:07 AM, Joseph Qi <joseph.qi@linux.alibaba.com<mailto:joseph.qi@linux.alibaba.com>> wrote:
> 
> Hi Wengang,
> 
> On 9/9/21 1:12 AM, Wengang Wang wrote:
> Hi,
> 
> Sorry for late involving, but this doesn’t look right to me.
> 
> On Sep 8, 2021, at 3:51 AM, Joseph Qi <joseph.qi@linux.alibaba.com<mailto:joseph.qi@linux.alibaba.com>> wrote:
> 
> 
> 
> On 9/8/21 6:20 PM, Chenyuan Mi wrote:
> The reference counting issue happens in two exception handling paths
> of ocfs2_replay_truncate_records(). When executing these two exception
> handling paths, the function forgets to decrease the refcount of handle
> increased by ocfs2_start_trans(), causing a refcount leak.
> 
> Fix this issue by using ocfs2_commit_trans() to decrease the refcount
> of handle in two handling paths.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn<mailto:cymi20@fudan.edu.cn>>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn<mailto:xiyuyang19@fudan.edu.cn>>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com<mailto:tanxin.ctf@gmail.com>>
> 
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com<mailto:joseph.qi@linux.alibaba.com>>
> ---
> fs/ocfs2/alloc.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index f1cc8258d34a..b05fde7edc3a 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -5940,6 +5940,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
> status = ocfs2_journal_access_di(handle, INODE_CACHE(tl_inode), tl_bh,
>  OCFS2_JOURNAL_ACCESS_WRITE);
> if (status < 0) {
> + ocfs2_commit_trans(osb, handle);
> mlog_errno(status);
> goto bail;
> }
> @@ -5964,6 +5965,7 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
>      data_alloc_bh, start_blk,
>      num_clusters);
> if (status < 0) {
> + ocfs2_commit_trans(osb, handle);
> 
> As a transaction, stuff expected to be in the same handle should be treated as atomic.
> Here the stuff includes the tl_bh and other metadata block which will be modified in ocfs2_free_clusters().
> Coming here, some of related meta blocks may be in the handle but others are not due to the error happened.
> If you do a commit, partial meta blocks are committed to log. — that breaks the atomic idea, it will cause FS inconsistency.
> So what’s reason you want to commit the meta block changes, which is not all of expected, in this handle to journal log?
> 
> Do you really see a hit on the failure? or just you detected the refcount leak by code review?
> 
> You may want to look at ocfs2_journal_dirty() for the error handling part.
> 
> 
> For the first error handling, since we don't call ocfs2_journal_dirty()
> yet, so won't be a problem.
> For the second error handling, I think we don't have a better way. Look
> at other callers of ocfs2_free_clusters(), we simply ignore the error
> code.
> Anyway, we should commit transaction if starts, otherwise journal will
> be abnormal.
> 
> I don't think so. If error happened, we should fail ocfs2, rather than do a partial committing.
> 

Umm... not exactly...
Take ocfs2_free_clusters() for example, when it fails in case of EIO or
ENOMEM, we can't just abort journal in such cases, because it is not so
serious, only a bit blocks still occupied and they will recovery during
the next mount. 
That's why we have "errors=continue" in most filesystems, we should always
consider the business continuity first.
Also you can look at ext4_free_blocks() for reference.

Thanks,
Joseph
