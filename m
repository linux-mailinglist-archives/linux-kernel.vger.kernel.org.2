Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B941D128
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbhI3B4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:56:30 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54944 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233941AbhI3B43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:56:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uq41Vho_1632966885;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Uq41Vho_1632966885)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Sep 2021 09:54:46 +0800
Subject: Re: [PATCH v2] ocfs2: mount fails with buffer overflow in strlen
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        akpm <akpm@linux-foundation.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1ab61ba3-8c9b-092c-7843-9c45b58e3987@linux.alibaba.com>
 <20210929180654.32460-1-vvidic@valentin-vidic.from.hr>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <a1bea8f5-91bc-66c2-0262-cb091b15b4d5@linux.alibaba.com>
Date:   Thu, 30 Sep 2021 09:54:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929180654.32460-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/21 2:06 AM, Valentin Vidic wrote:
> Starting with kernel 5.11 built with CONFIG_FORTIFY_SOURCE mouting an
> ocfs2 filesystem with either o2cb or pcmk cluster stack fails with the
> trace below. Problem seems to be that strings for cluster stack and
> cluster name are not guaranteed to be null terminated in the disk
> representation, while strlcpy assumes that the source string is always
> null terminated. This causes a read outside of the source string
> triggering the buffer overflow detection.
> 
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

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> v2: update description, add comment, drop null termination
> 
>  fs/ocfs2/super.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index c86bd4e60e20..5c914ce9b3ac 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -2167,11 +2167,17 @@ static int ocfs2_initialize_super(struct super_block *sb,
>  	}
>  
>  	if (ocfs2_clusterinfo_valid(osb)) {
> +		/*
> +		 * ci_stack and ci_cluster in ocfs2_cluster_info may not be null
> +		 * terminated, so make sure no overflow happens here by using
> +		 * memcpy. Destination strings will always be null terminated
> +		 * because osb is allocated using kzalloc.
> +		 */
>  		osb->osb_stackflags =
>  			OCFS2_RAW_SB(di)->s_cluster_info.ci_stackflags;
> -		strlcpy(osb->osb_cluster_stack,
> +		memcpy(osb->osb_cluster_stack,
>  		       OCFS2_RAW_SB(di)->s_cluster_info.ci_stack,
> -		       OCFS2_STACK_LABEL_LEN + 1);
> +		       OCFS2_STACK_LABEL_LEN);
>  		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
>  			mlog(ML_ERROR,
>  			     "couldn't mount because of an invalid "
> @@ -2180,9 +2186,9 @@ static int ocfs2_initialize_super(struct super_block *sb,
>  			status = -EINVAL;
>  			goto bail;
>  		}
> -		strlcpy(osb->osb_cluster_name,
> +		memcpy(osb->osb_cluster_name,
>  			OCFS2_RAW_SB(di)->s_cluster_info.ci_cluster,
> -			OCFS2_CLUSTER_NAME_LEN + 1);
> +			OCFS2_CLUSTER_NAME_LEN);
>  	} else {
>  		/* The empty string is identical with classic tools that
>  		 * don't know about s_cluster_info. */
> 
