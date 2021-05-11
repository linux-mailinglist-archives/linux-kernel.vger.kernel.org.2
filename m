Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C890137A72C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhEKM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:56:03 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51867 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhEKM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:56:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UYYCUtP_1620737693;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UYYCUtP_1620737693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 May 2021 20:54:54 +0800
Subject: Re: [PATCH] ocfs2: fix snprintf() checking
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <YJovRPdOiaU6I+JK@mwanda>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <bd7ddc22-11c4-3e88-120a-d68f153f573d@linux.alibaba.com>
Date:   Tue, 11 May 2021 20:54:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJovRPdOiaU6I+JK@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/21 3:16 PM, Dan Carpenter wrote:
> The snprintf() function returns the number of bytes which would have
> been printed if the buffer was large enough.  In other words it can
> return ">= remain" but this code assumes it returns "== remain".
> 
> The run time impact of this bug is not very severe.  The next iteration
> through the loop would trigger a WARN() when we pass a negative limit
> to snprintf().  We would then return success instead of -E2BIG.
> 
> The kernel implementation of snprintf() will never return negatives so
> there is no need to check and I have deleted that dead code.
> 
> Fixes: a860f6eb4c6a ("ocfs2: sysfile interfaces for online file check")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good. But the last 2 sections are introduced by:
74ae4e104dfc ocfs2: Create stack glue sysfs files.

With 'Fixes' tag updated,
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/filecheck.c | 6 +-----
>  fs/ocfs2/stackglue.c | 8 ++------
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
> index 90b8d300c1ee..de56e6231af8 100644
> --- a/fs/ocfs2/filecheck.c
> +++ b/fs/ocfs2/filecheck.c
> @@ -326,11 +326,7 @@ static ssize_t ocfs2_filecheck_attr_show(struct kobject *kobj,
>  		ret = snprintf(buf + total, remain, "%lu\t\t%u\t%s\n",
>  			       p->fe_ino, p->fe_done,
>  			       ocfs2_filecheck_error(p->fe_status));
> -		if (ret < 0) {
> -			total = ret;
> -			break;
> -		}
> -		if (ret == remain) {
> +		if (ret >= remain) {
>  			/* snprintf() didn't fit */
>  			total = -E2BIG;
>  			break;
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index d50e8b8dfea4..16f1bfc407f2 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -500,11 +500,7 @@ static ssize_t ocfs2_loaded_cluster_plugins_show(struct kobject *kobj,
>  	list_for_each_entry(p, &ocfs2_stack_list, sp_list) {
>  		ret = snprintf(buf, remain, "%s\n",
>  			       p->sp_name);
> -		if (ret < 0) {
> -			total = ret;
> -			break;
> -		}
> -		if (ret == remain) {
> +		if (ret >= remain) {
>  			/* snprintf() didn't fit */
>  			total = -E2BIG;
>  			break;
> @@ -531,7 +527,7 @@ static ssize_t ocfs2_active_cluster_plugin_show(struct kobject *kobj,
>  	if (active_stack) {
>  		ret = snprintf(buf, PAGE_SIZE, "%s\n",
>  			       active_stack->sp_name);
> -		if (ret == PAGE_SIZE)
> +		if (ret >= PAGE_SIZE)
>  			ret = -E2BIG;
>  	}
>  	spin_unlock(&ocfs2_stack_lock);
> 
