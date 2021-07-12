Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD13C5B50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhGLLNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhGLLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:13:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1FC0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:10:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 37so17865936pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOkBIZLIeAFbFCMFR/viBqHY84MUzJTBfuuK1u/iBTY=;
        b=yWo6g9kq4FtQt5BFXBVAv6l81+P0WtMWep5RJ49fykxTBmL+1nfy2nSUNO8c08Hksl
         8AsvQaUQwH5kl3PHJjb3+HirKXGjpHBkPEUZTjl0rpYqJafV+rrSouhm12vGLCEI5BYq
         aaEB8hgwcwXX7Hatwz9TLW72LTyPdqHv5PuZHkq697fJ4mfBS1HmWOClb/lUBYPgpGRj
         VcBm/k+IbWTGZsSDyF7eKUYi+viUh8phbUmEJUGVGxH/Nb9c/nI/eYOLLPXZvB7o/mWW
         +cSsb7DMbsQ2CFrQRO4c/JmFms7CVExM4H2hsfI8kOB5qiRV5GNSDJsy7TIhtYDs8l9U
         pxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOkBIZLIeAFbFCMFR/viBqHY84MUzJTBfuuK1u/iBTY=;
        b=f0rRn+KfOj/2kuNFyPd65NVBx97z5hoOBjnLUh3/XTPvBfZSfGvFjo/0fUcZuFTyE9
         kLh6B+AWQQ+tTl9dIY/B6FlSEZBEGa/9a983bcJuyhMgaHWptqQdk/GxqJ2y6GBkfpVM
         FmW7LQqdQgWMfD5y5tJZ8yAWnssvmH7YQ8uCOETuKtg9YWx65hOcJo8AJv9m6wgVqfTC
         wWBoH3oDPum2vhhPvGMY35QOY5ggUIDmLH4mY0dE9WIfuMLLZ+fc2R3ljsTA51IpU05l
         ge9Oek7vALZUjgaF9g8bDaj202hNc8alIXChjSrwsMgeJZzJhNCufClo40+JvnN+Oboi
         mN3Q==
X-Gm-Message-State: AOAM530rCXj8z7ho8ioUCVM3XJOwT6g/RGsvJFRJBQDfK3f7yuC+4qNY
        iSdMag4/eNr6e/2exOP88YhlUA==
X-Google-Smtp-Source: ABdhPJwo9OUfj5vfhm9oKgftct1A0S8rMDCPBIwMSm1BjNLOM0PUqGq4oY3OLpyzHtR0LgzMz+vsfg==
X-Received: by 2002:a65:5648:: with SMTP id m8mr53749684pgs.93.1626088219352;
        Mon, 12 Jul 2021 04:10:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id h11sm2008521pjv.57.2021.07.12.04.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:10:18 -0700 (PDT)
Date:   Mon, 12 Jul 2021 19:10:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: tmc-etr: Correct memory sync ranges in SG
 mode
Message-ID: <20210712111014.GC704210@leoy-ThinkPad-X240s>
References: <20210710070206.462875-1-leo.yan@linaro.org>
 <3038eb59-155c-5c3d-18e3-e45e56b52523@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3038eb59-155c-5c3d-18e3-e45e56b52523@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 11:25:54AM +0100, Suzuki Kuruppassery Poulose wrote:
> Hi Leo,
> 
> On 10/07/2021 08:02, Leo Yan wrote:
> > Current code syncs the buffer range is [offset, offset+len), it doesn't
> > consider the case when the trace data is wrapped around, in this case
> > 'offset+len' is bigger than 'etr_buf->size'.  Thus it syncs buffer out
> > of the memory buffer, and it also misses to sync buffer from the start
> > of the memory.
> > 
> 
> I doubt this claim is valid. We do the sync properly, taking the page
> corresponding to the "offset" wrapping it around in "page" index.
> 
> Here is the code :
> 
> 
> 
> void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
>                                   u64 offset, u64 size)
> {
>         int i, index, start;
>         int npages = DIV_ROUND_UP(size, PAGE_SIZE);
>         struct device *real_dev = table->dev->parent;
>         struct tmc_pages *data = &table->data_pages;
> 
>         start = offset >> PAGE_SHIFT;
>         for (i = start; i < (start + npages); i++) {
>                 index = i % data->nr_pages;
>                 dma_sync_single_for_cpu(real_dev, data->daddrs[index],
>                                         PAGE_SIZE, DMA_FROM_DEVICE);
>         }
> }
> 
> 
> See that the npages accounts for the "size" requested and we wrap the
> "index" by the total number of pages in the buffer and pick the right
> page.
> 
> So, I think this fix is not needed.

Ouch, you are right :)  Let's drop these two patches.

Thanks,
Leo
