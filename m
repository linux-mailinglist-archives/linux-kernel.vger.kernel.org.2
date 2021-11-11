Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3244DBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhKKTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:00:22 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:56652 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKKTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:00:21 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mlFGD-0000Gt-OE; Thu, 11 Nov 2021 18:57:26 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mlFG9-006GKL-Cn; Thu, 11 Nov 2021 18:57:20 +0000
Subject: Re: [PATCH] hostfs: Fix writeback of dirty pages
To:     Sjoerd Simons <sjoerd@collabora.com>, linux-um@lists.infradead.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
References: <20211105081052.2353801-1-sjoerd@collabora.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <42c70832-9fbe-5aa8-5f42-1db8aebb4362@cambridgegreys.com>
Date:   Thu, 11 Nov 2021 18:57:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211105081052.2353801-1-sjoerd@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 08:10, Sjoerd Simons wrote:
> Hostfs was not setting up the backing device information, which means it
> uses the noop bdi. The noop bdi does not have the writeback capability
> enabled, which in turns means  dirty pages never got written back to
> storage.
> 
> In other words programs using mmap to write to files on  hostfs never
> actually got their data written out...
> 
> Fix this by simply setting up the bdi with default settings as all the
> required code for writeback is already in place.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
>   fs/hostfs/hostfs_kern.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index d5c9d886cd9f..ef481c3d9019 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
>   	sb->s_op = &hostfs_sbops;
>   	sb->s_d_op = &simple_dentry_operations;
>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	err = super_setup_bdi(sb);
> +	if (err)
> +		goto out;
>   
>   	/* NULL is printed as '(null)' by printf(): avoid that. */
>   	if (req_root == NULL)
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
