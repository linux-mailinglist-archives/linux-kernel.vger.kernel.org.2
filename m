Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3272932E4A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhCEJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229573AbhCEJUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614936034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewds+wRWOHNMJpjK0L8o8oTPixozR81HX+R2nb+Ucf8=;
        b=HMu8blPwMjL22NxH7nGTyOARfialVUfHVWCAOv0ukWP7gZSDW/kLvK6I4fJtjZwj2VEmWP
        ruB9anIhGZ+H8b8gC4q+vKW0tIjNRzki4S5ECYItcQ5vi4l/7w63tsZiiOajICcRSV89qG
        FFKhhOFCz/Ogne6oeBwE/e9MSeHhRe8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-rZvt9DZgOKiWXDvxAayLdA-1; Fri, 05 Mar 2021 04:20:32 -0500
X-MC-Unique: rZvt9DZgOKiWXDvxAayLdA-1
Received: by mail-pj1-f70.google.com with SMTP id f2so1058482pjt.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ewds+wRWOHNMJpjK0L8o8oTPixozR81HX+R2nb+Ucf8=;
        b=IVjKqmKkxxpTLQ5fe7ctsDoDxT91CxZGEvEb6thb++IVoWwMUYLxFpvlHQuuu5BLBn
         tqUWSdCv82PtVVBWOSZTEmvUizBRc3ZvGM9TG+r8Ni7TMziaRF0IdbtuStooHxtcF/ZJ
         XV8rIdY4B6u8D646dr3V3ae+I6YsevV5bt2OmCTv9RKwSgqax/h6VxnKA1Y8oFLjtt7I
         SpqmcS7gpxSnNialY2MAuP7yDXFFYWk6KYvfqBSMId7CVKIbcAne9rbSxOuTISwCfiy5
         vThZHWsrqxMkO2G0nHKhzcPzP+88cv18I7VRXc/PeoNHFoFZcbCCYhrGcfR4De58Vz6M
         noHg==
X-Gm-Message-State: AOAM533TMTUa8xIpT1+8o+UKF2Hwo/xSWFxmdnba2WnlnpQyDF/5eizI
        fYWSmaTeBb6McnAKbqCoZ8xsFdsftlN7csdwYlll1ERI+67eega+GU8eHVJObjpJr8nXOctyI/T
        KZ1Z22FWi4TIkVk0lK/5rxjC+
X-Received: by 2002:a62:68c1:0:b029:1ee:5dfa:860b with SMTP id d184-20020a6268c10000b02901ee5dfa860bmr7896210pfc.35.1614936031791;
        Fri, 05 Mar 2021 01:20:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyX/b4S9nIkSL816d/s6Hnx8UDwFDfXcwyK4iFy3n6vw5MVFSuJXC1lGHsfdwOqX68fN/8BA==
X-Received: by 2002:a62:68c1:0:b029:1ee:5dfa:860b with SMTP id d184-20020a6268c10000b02901ee5dfa860bmr7896199pfc.35.1614936031598;
        Fri, 05 Mar 2021 01:20:31 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w17sm1841709pgg.41.2021.03.05.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:20:30 -0800 (PST)
Date:   Fri, 5 Mar 2021 17:20:20 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH v4 2/2] erofs: decompress in endio if possible
Message-ID: <20210305092020.GA3114893@xiangao.remote.csb>
References: <20210305082142.877265-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305082142.877265-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:21:42PM +0800, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the atomic
> context, for example, when dm-verity is turned on. In this scenario,
> data can be decompressed directly to get rid of additional kworker
> scheduling overhead. Also, it makes no sense to apply synchronous
> decompression for such case.

Could you resend the whole patchset [v4 RESEND] as a whole? Or you
can use --in-reply-to to attach the original version.

Yet I'd suggest you could resend them all this time...

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>  fs/erofs/internal.h |  3 +++
>  fs/erofs/super.c    |  4 ++++
>  fs/erofs/zdata.c    | 16 +++++++++++++---
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..b817cb85d67b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -70,6 +70,9 @@ struct erofs_sb_info {
>  
>  	/* pseudo inode to manage cached pages */
>  	struct inode *managed_cache;
> +
> +	/* decide whether to decompress synchronously */
> +	bool readahead_sync_decompress;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
>  	u32 blocks;
>  	u32 meta_blkaddr;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d5a6b9b888a5..77819efe9b15 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -175,6 +175,10 @@ static int erofs_read_superblock(struct super_block *sb)
>  	sbi->root_nid = le16_to_cpu(dsb->root_nid);
>  	sbi->inos = le64_to_cpu(dsb->inos);
>  
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	sbi->readahead_sync_decompress = false;
> +#endif

How about moving this stuff to erofs_default_options() as what we
did for max_sync_decompress_pages?

Thanks,
Gao Xiang

