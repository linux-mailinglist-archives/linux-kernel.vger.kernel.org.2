Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28E63A1762
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbhFIOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237622AbhFIOhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 867766139A;
        Wed,  9 Jun 2021 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623249347;
        bh=YzF2yEukArZPBNz+f4q5sfBw+esz/4m/ijdFg7xOkhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lVFmT5nPfKGX7gDHV3MQ4XS0LhqO1ZaxRiCmqb/WdbIjSf2hVNK51oxznG1S38lnt
         W+aAqZBD0GKbtn1dCPXA6GbpnddaFj/KrYVuZcLty700tRcNaAiCptPd4pT2XLpOuV
         Kmkf4GF5k5jKLrW0hsruA0Wh7125N19chRnDOSmDp/MIECX36nxWhDaHLmqcnmSjjb
         rICqEYU64zjGPHqgxiI67p8xGus/yTmQaJbcLttinLWyX1Zrj71Qt1T7iWMib0c/le
         AEPrlzg/0UeOl9RKx0rYasIvpqubWCLFtQ3RCvTWwMZGKLN8aQZdvuzkGXmvQhXMNl
         kpc0b/58km91A==
Date:   Wed, 9 Jun 2021 23:35:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        guoren@kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 1/5] kprobes: Do not use local variable when creating
 debugfs file
Message-Id: <20210609233543.e846251ccaa227317de26b11@kernel.org>
In-Reply-To: <20210609105019.3626677-2-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
        <20210609105019.3626677-2-punitagrawal@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 19:50:15 +0900
Punit Agrawal <punitagrawal@gmail.com> wrote:

> debugfs_create_file() takes a pointer argument that can be used during
> file operation callbacks (accessible via i_private in the inode
> structure). An obvious requirement is for the pointer to refer to
> valid memory when used.
> 
> When creating the debugfs file to dynamically enable / disable
> kprobes, a pointer to local variable is passed to
> debugfs_create_file(); which will go out of scope when the init
> function returns. The reason this hasn't triggered random memory
> corruption is because the pointer is not accessed during the debugfs
> file callbacks.
> 
> Fix the incorrect (and unnecessary) usage of local variable during
> debugfs_file_create() by passing NULL instead.
> 

Good catch! Since the enabled state is managed by the kprobes_all_disabled
global variable, it is not needed.

Fixes: bf8f6e5b3e51 ("Kprobes: The ON/OFF knob thru debugfs")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> ---
>  kernel/kprobes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..fdb1ea2e963b 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2816,13 +2816,12 @@ static const struct file_operations fops_kp = {
>  static int __init debugfs_kprobe_init(void)
>  {
>  	struct dentry *dir;
> -	unsigned int value = 1;
>  
>  	dir = debugfs_create_dir("kprobes", NULL);
>  
>  	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
>  
> -	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
> +	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
>  
>  	debugfs_create_file("blacklist", 0400, dir, NULL,
>  			    &kprobe_blacklist_fops);
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
