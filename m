Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3C355FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbhDFXyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235884AbhDFXyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617753255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9Bynhk5jx9PpUNdN9ForbiWm+KTPR+Iguq3N1bBzvE=;
        b=LIfIZlJ0vM4Y1GCnu+5yxXjOHsvRgpKxBwtHmI0rAnNT2qYOTtZLPAQthpiWTQtAt/Rtzz
        Xb6LLRbGn5dQoeR2cOWRpynVhb+867hihk1D3wgx3ShJrcMEGSUTOK2LaYmoM+MR0ANdvl
        n5yxovtL7AJYKcnBzA1CPV3OsUmK+cE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-LZw-UFpdNb6d5Rt7Sl_n1A-1; Tue, 06 Apr 2021 19:54:14 -0400
X-MC-Unique: LZw-UFpdNb6d5Rt7Sl_n1A-1
Received: by mail-pf1-f197.google.com with SMTP id x4so11619732pfa.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 16:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9Bynhk5jx9PpUNdN9ForbiWm+KTPR+Iguq3N1bBzvE=;
        b=eWMoXhw9JGw8N+kYQB5033l1DL8s265tqGuI4kRngqSp4BHjUnVlEV41f7d66Gr9DB
         xRYHkE/hgO4WfPKv1Dr9BcTnYxkoKWwGUkTWeAYuIW8jCWe4kfN7T2v2nWh/vR0Sb3e/
         zaUGkS2a7vzqOWxE8QEUQCBxC31bYlH1+jvVbcxWqrnkXdlPnpOREefahRT28cVuuvDe
         hfdHRxnwUvh/SGJjqrrcMeHUVTBk2HQ2AqgyihEwLDNdxiGs6PRXzTkbgEVLA817fy3i
         7ebG40z6bM92CHp8hgE1h5nQ+f4FTZtK5Ryb2uHtgsj7SqBa1egLbcgS6187Qao632ZL
         dH2Q==
X-Gm-Message-State: AOAM533P6x2F19LIVc3g2FtFnlW9SVLuSyf2wbMtpMSIb8Reob/OR6S3
        E5lhSt0X+HBhE0/mQaHIp5dQQ0drLDf/tcIXDyCjhzmlMSsvZ8e+XVbxk6yW20mWFECwDj2Gm7G
        yDx/dxMo75vFPfj82AQVZGLhX
X-Received: by 2002:a17:90a:8907:: with SMTP id u7mr607117pjn.114.1617753253129;
        Tue, 06 Apr 2021 16:54:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvaMBT8JgaLEReC0ssyotJOmen93GjLT0Sh1CDVdMUhYnY+Tzw3Y4/zdNqq/R55VEG7Om6rw==
X-Received: by 2002:a17:90a:8907:: with SMTP id u7mr607098pjn.114.1617753252878;
        Tue, 06 Apr 2021 16:54:12 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u17sm3263331pjx.10.2021.04.06.16.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 16:54:12 -0700 (PDT)
Date:   Wed, 7 Apr 2021 07:54:01 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] erofs: fix uninitialized variable i used in a
 while-loop
Message-ID: <20210406235401.GA210667@xiangao.remote.csb>
References: <20210406162718.429852-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406162718.429852-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Tue, Apr 06, 2021 at 05:27:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The while-loop iterates until src is non-null or i is 3, however, the
> loop counter i is not intinitialied to zero, causing incorrect iteration
> counts.  Fix this by initializing it to zero.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 1aa5f2e2feed ("erofs: support decompress big pcluster for lz4 backend")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you very much for catching this! It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(btw, may I fold this into the original patchset? since such big pcluster
 patchset is just applied to for-next for further integration testing, and
 the commit id is not stable yet..)

Thanks,
Gao Xiang

> ---
>  fs/erofs/decompressor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index fe46a9c34923..8687ff81406b 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -154,6 +154,7 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
>  	}
>  	kunmap_atomic(inpage);
>  	might_sleep();
> +	i = 0;
>  	while (1) {
>  		src = vm_map_ram(rq->in, nrpages_in, -1);
>  		/* retry two more times (totally 3 times) */
> -- 
> 2.30.2
> 

