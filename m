Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1801641AE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhI1MHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:07:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35466 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240410AbhI1MHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:07:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UpwTFLo_1632830722;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UpwTFLo_1632830722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Sep 2021 20:05:23 +0800
Subject: Re: [PATCH] ocfs2: mount fails with buffer overflow in strlen
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <00850aed-2027-a0ab-e801-c6498a5a49f8@linux.alibaba.com>
Date:   Tue, 28 Sep 2021 20:05:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927154459.15976-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 11:44 PM, Valentin Vidic wrote:
> Starting with kernel v5.11 mouting an ocfs2 filesystem with either o2cb
> or pcmk cluster stack fails with the trace below. Problem seems to be
> that strings for cluster stack and cluster name are not guaranteed to be
> null terminated in the disk representation, while strlcpy assumes that
> the source string is always null terminated. This causes a read outside
> of the source string triggering the buffer overflow detection.
> 

strlcpy in ocfs2_initialize_super() is introduced 8 years ago, so I
don't understand why you've mentioned that the issues starts from
v5.11.

osb->osb_cluster_stack and osb->osb_cluster_name is always larger by
1 than which in ocfs2_cluster_info, and the input size of strlcpy does
the same, so I don't see how it overflows.

Thanks,
Joseph

> detected buffer overflow in strlen
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1149!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 1 PID: 910 Comm: mount.ocfs2 Not tainted 5.14.0-1-amd64 #1
>   Debian 5.14.6-2
> RIP: 0010:fortify_panic+0xf/0x11
> ...
> Call Trace:
>  ocfs2_initialize_super.isra.0.cold+0xc/0x18 [ocfs2]
>  ocfs2_fill_super+0x359/0x19b0 [ocfs2]
>  mount_bdev+0x185/0x1b0
>  ? ocfs2_remount+0x440/0x440 [ocfs2]
>  legacy_get_tree+0x27/0x40
>  vfs_get_tree+0x25/0xb0
>  path_mount+0x454/0xa20
>  __x64_sys_mount+0x103/0x140
>  do_syscall_64+0x3b/0xc0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  fs/ocfs2/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index c86bd4e60e20..1dea535224df 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -2169,9 +2169,10 @@ static int ocfs2_initialize_super(struct super_block *sb,
>  	if (ocfs2_clusterinfo_valid(osb)) {
>  		osb->osb_stackflags =
>  			OCFS2_RAW_SB(di)->s_cluster_info.ci_stackflags;
> -		strlcpy(osb->osb_cluster_stack,
> +		memcpy(osb->osb_cluster_stack,
>  		       OCFS2_RAW_SB(di)->s_cluster_info.ci_stack,
> -		       OCFS2_STACK_LABEL_LEN + 1);
> +		       OCFS2_STACK_LABEL_LEN);
> +		osb->osb_cluster_stack[OCFS2_STACK_LABEL_LEN] = '\0';
>  		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
>  			mlog(ML_ERROR,
>  			     "couldn't mount because of an invalid "
> @@ -2180,9 +2181,10 @@ static int ocfs2_initialize_super(struct super_block *sb,
>  			status = -EINVAL;
>  			goto bail;
>  		}
> -		strlcpy(osb->osb_cluster_name,
> +		memcpy(osb->osb_cluster_name,
>  			OCFS2_RAW_SB(di)->s_cluster_info.ci_cluster,
> -			OCFS2_CLUSTER_NAME_LEN + 1);
> +			OCFS2_CLUSTER_NAME_LEN);
> +		osb->osb_cluster_name[OCFS2_CLUSTER_NAME_LEN] = '\0';
>  	} else {
>  		/* The empty string is identical with classic tools that
>  		 * don't know about s_cluster_info. */
> 
