Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242EA33B117
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCOL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhCOL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615807733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/i+8wDEvbmjTfeLtLR4DtORse2gYPTQ1pHIrK7qNYU=;
        b=duNPgY7Sj3HxqYqoVoqh4Ws4ILjtOZkh/QMGs3TTykVK3ycc+MsmljCyFfUNxH/gFcm9NR
        j4CrH3TvxAfnq3FvODIYh7c0I8jBwxtlk6wHhM46UGH4bWeKPH2lhv3puI1DsDmnUDjQ8O
        2vuDRAuiHTC7xg1X6jmPd+51DvNbqAc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-DHZfKrCnOJqko6-W41IAhA-1; Mon, 15 Mar 2021 07:28:50 -0400
X-MC-Unique: DHZfKrCnOJqko6-W41IAhA-1
Received: by mail-pg1-f200.google.com with SMTP id o9so2658125pgm.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/i+8wDEvbmjTfeLtLR4DtORse2gYPTQ1pHIrK7qNYU=;
        b=nA/AH56Zpq+8vRbIMqdFUoqm98J/nAYw9jxHubHZPBUbmqASNy+ZHDomeJhP6Q4yrd
         mfD2duC37U+hes2d56/9rrIckgJdekuHQiJZHq5i6yolS8e7sycfAxOYBoGGdBclR8Uq
         dCmkDf6MDcVe05ZcJmhQbgsCACS+11wdO2kB4QduALhMhfOZX+yuhHEpl3XaD3GFWhOJ
         /iW/Yk1SqUOFLa6I2pFADVhWIX3SY08Wmm0UMxb9Iqur7NgOhFLTNqQA79m89tpvI5t/
         jbF8yowDrtLnh4Q2IdrlhYLk/CARjW1THZCi1SQXGKgZt4qJVHTt5A6JPHtnF5eR/ovr
         VKUg==
X-Gm-Message-State: AOAM5308FmpLl+jDNerEZqUOG3ZDkLKYWUB6Lg4LNQAvfn2CYDEfa8nk
        HLZHDzuDXTRrsrjHxikOvlAzM08r98TBKL1wfMNiPi/hglrFQzC9ibD5rsLMt6vIVozrUFU5R7Y
        k3ddqnEMhIxlJMzj/8t2zxz0W
X-Received: by 2002:a17:902:aa87:b029:e5:e1fc:be6 with SMTP id d7-20020a170902aa87b02900e5e1fc0be6mr11730374plr.4.1615807729835;
        Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmWpZTgaL3v2Mj5LM9VDdAu+NKLqarMrzFd4GFRQwFyf4fK7sC/SmQFyQwrbfXAQORInKilg==
X-Received: by 2002:a17:902:aa87:b029:e5:e1fc:be6 with SMTP id d7-20020a170902aa87b02900e5e1fc0be6mr11730362plr.4.1615807729632;
        Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t22sm11605800pjw.54.2021.03.15.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:28:49 -0700 (PDT)
Date:   Mon, 15 Mar 2021 19:28:38 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     zhangshiming@oppo.com, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] erofs: decompress in endio if possible
Message-ID: <20210315112838.GB838000@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
 <20210305095840.31025-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305095840.31025-2-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:58:40PM +0800, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the atomic
> context, for example, when dm-verity is turned on. In this scenario,
> data can be decompressed directly to get rid of additional kworker
> scheduling overhead. Also, it makes no sense to apply synchronous
> decompression for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/super.c    |  1 +
>  fs/erofs/zdata.c    | 16 +++++++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..e325da7be237 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -53,6 +53,8 @@ struct erofs_fs_context {
>  
>  	/* threshold for decompression synchronously */
>  	unsigned int max_sync_decompress_pages;
> +	/* decide whether to decompress synchronously */
> +	bool readahead_sync_decompress;

I updated this as below:

 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
+	/* strategy of sync decompression (false - auto, true - force on) */
+	bool readahead_sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;

>  #endif
>  	unsigned int mount_opt;
>  };

...

> @@ -720,8 +723,14 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>  		return;
>  	}
>  
> -	if (!atomic_add_return(bios, &io->pending_bios))
> -		queue_work(z_erofs_workqueue, &io->u.work);
> +	if (!atomic_add_return(bios, &io->pending_bios)) {
> +		if (in_atomic() || irqs_disabled()) {
> +			queue_work(z_erofs_workqueue, &io->u.work);
> +			sbi->ctx.readahead_sync_decompress = true;
> +		} else {
> +			z_erofs_decompressqueue_work(&io->u.work);
> +		}
> +	}

Also updated this as below to return as early as possible:

-	if (!atomic_add_return(bios, &io->pending_bios))
+	if (atomic_add_return(bios, &io->pending_bios))
+		return;
+	/* Use workqueue and sync decompression for atomic contexts only */
+	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
+		sbi->ctx.readahead_sync_decompress = true;
+		return;
+	}
+	z_erofs_decompressqueue_work(&io->u.work);
 }

Otherwise, it looks good to me. I've applied to dev-test
for preliminary testing.

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Thanks,
Gao Xiang

