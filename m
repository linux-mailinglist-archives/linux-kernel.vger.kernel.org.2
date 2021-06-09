Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E503A178F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhFIOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238058AbhFIOj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:39:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D776139A;
        Wed,  9 Jun 2021 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623249483;
        bh=c/d7qioHGhsgcbStmtLsnhXN4JCw3TjbgwcNTkOimok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p8q4nqOEs5Bz4At1/Tb+00/sLBPvbeQqMdtKJamCNuFVLlPmc8dcWP8SLu0l3WdGc
         Uaw2x8wzbuUVoDw8VZISJMOg42S/kOMhwnWHHwuoCPT4KM95dZmkc5peVVimUxQumL
         7qOpPpR9knUlcb89y7gwd+tWvgg43oKzTBolIW36j/eCja18r4qYaImNpxZw5wwAjt
         LKHez411fulmWl43OxpdHnM4vgnJbVXAs2Y4IP7boiyYLxLPzyCt2APi/1BKdaSw0T
         7IsJt7DqP930irRXOJ791PMUDfUt2ektGkGSCrv5ToDAA72HB/jeglsS/IciQGbBBe
         lUApDJJG0CGFA==
Date:   Wed, 9 Jun 2021 23:37:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] kprobes: Use helper to parse boolean input from
 userspace
Message-Id: <20210609233759.f89ac48532832ac373bb2d02@kernel.org>
In-Reply-To: <20210609105019.3626677-3-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-3-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 19:50:16 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> The "enabled" file provides a debugfs interface to arm / disarm
> kprobes in the kernel. In order to parse the buffer containing the
> values written from userspace, the callback manually parses the user
> input to convert it to a boolean value.
> 
> As taking a string value from userspace and converting it to boolean
> is a common operation, a helper kstrtobool_from_user() is already
> available in the kernel. Update the callback to use the common helper
> to parse the write buffer from userspace.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  kernel/kprobes.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index fdb1ea2e963b..1a11d3c411bf 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2777,30 +2777,14 @@ static ssize_t read_enabled_file_bool(struct file *file,
>  static ssize_t write_enabled_file_bool(struct file *file,
>  	       const char __user *user_buf, size_t count, loff_t *ppos)
>  {
> -	char buf[32];
> -	size_t buf_size;
> -	int ret = 0;
> -
> -	buf_size = min(count, (sizeof(buf)-1));
> -	if (copy_from_user(buf, user_buf, buf_size))
> -		return -EFAULT;
> +	bool enable;
> +	int ret;
>  
> -	buf[buf_size] = '\0';
> -	switch (buf[0]) {
> -	case 'y':
> -	case 'Y':
> -	case '1':
> -		ret = arm_all_kprobes();
> -		break;
> -	case 'n':
> -	case 'N':
> -	case '0':
> -		ret = disarm_all_kprobes();
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	ret = kstrtobool_from_user(user_buf, count, &enable);
> +	if (ret)
> +		return ret;
>  
> +	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
