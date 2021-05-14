Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5A3813CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhENWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 18:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhENWdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 18:33:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B04613F7;
        Fri, 14 May 2021 22:32:39 +0000 (UTC)
Date:   Fri, 14 May 2021 18:32:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tools/bootconfig: Fix error return code in
 apply_xbc()
Message-ID: <20210514183238.07b96338@gandalf.local.home>
In-Reply-To: <20210508034216.2277-1-thunder.leizhen@huawei.com>
References: <20210508034216.2277-1-thunder.leizhen@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 11:42:16 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure correctly")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Masami, care to ack this?

-- Steve

> ---
>  tools/bootconfig/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7362bef1a368..6cd6080cac04 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -399,6 +399,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	}
>  	/* TODO: Ensure the @path is initramfs/initrd image */
>  	if (fstat(fd, &stat) < 0) {
> +		ret = -errno;
>  		pr_err("Failed to get the size of %s\n", path);
>  		goto out;
>  	}

