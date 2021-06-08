Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E039FDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhFHRgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFHRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:36:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8B3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:34:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z26so16247521pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLvKoBEvfY2Ptqya3hzaWF4xLVwI7EHKO0HHIAZbjlk=;
        b=i0MmDl8Ps0IZQmWQ2ViKg1qX561L8Orz5iYseHhCKEYr93sUci8K/7wS9nivt46/z8
         myDrRIqzCtf6XZHgB/yp7wRZxT3r6mBuocIx00CTkorpFU3db3YRdvOAXbfrnieGxlgx
         LCLQNEC2KqG1w+FfuXKHUpQh2dflywFCwrjhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLvKoBEvfY2Ptqya3hzaWF4xLVwI7EHKO0HHIAZbjlk=;
        b=DyZRVQ13pL1uOvhCFY+4E9m9VH/DYrKsSOmdWjspsdieig3HzQVMMm3etE8BMyUb45
         2mOoe9t77viKOpriJjGQM6/UGkJHSxaQ1PKC310alluBFkblOIjBE8bOm6nWFeHVzp4x
         s+nDfEuc2IZfCgWp0GfPVkEc9Hz3SFIrLXggbIUCR7G2pGv5QPe5kVPnCD3g1mCGgQiy
         +6DLF2p7yyFl3YI/gp5MXWADgzwJH3uBBw+pXP+FZa0uBvgbMtucLL3HDuY0Ak1tCWGI
         42H0tvX1XfM7g4Jfkf8tnlhwODLb2gviyBJe1LV+E6NHnWD+LnC5/EsyfTXJW62m9nkd
         fsVg==
X-Gm-Message-State: AOAM530NI8UTDi3UtvrxyNNrebJSLQcfyRJgCIciJKpEATNWcRjRBpvv
        kVG0ow3uKXvNnQNyiwHkQUcq/A==
X-Google-Smtp-Source: ABdhPJw9cte543iNlOqM4Zf8WDgZK8UQ3GrQhbOt80HpmTn122EUoVoTmcwVaheYzTeFl8F9id315w==
X-Received: by 2002:aa7:8114:0:b029:2e9:ae2b:7ff with SMTP id b20-20020aa781140000b02902e9ae2b07ffmr1055597pfi.48.1623173670797;
        Tue, 08 Jun 2021 10:34:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u19sm6420346pfi.127.2021.06.08.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:34:29 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:34:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark pstore-blk as broken
Message-ID: <202106081033.F59D7A4@keescook>
References: <20210608161327.1537919-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608161327.1537919-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 06:13:27PM +0200, Christoph Hellwig wrote:
> pstore-blk just pokes directly into the pagecache for the block
> device without going through the file operations for that by faking
> up it's own file operations that do not match the block device ones.
> 
> As this breaks the control of the block layer of it's page cache,
> and even now just works by accident only the best thing is to just
> disable this driver.
> 
> Fixes: 17639f67c1d6 ("pstore/blk: Introduce backend for block devices")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 8adabde685f1..328da35da390 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -173,6 +173,7 @@ config PSTORE_BLK
>  	tristate "Log panic/oops to a block device"
>  	depends on PSTORE
>  	depends on BLOCK
> +	depends on BROKEN
>  	select PSTORE_ZONE
>  	default n
>  	help
> -- 
> 2.30.2
> 

NAK, please answer my concerns about your patches instead:
https://lore.kernel.org/lkml/202012011149.5650B9796@keescook/

-- 
Kees Cook
