Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6117B3C5B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhGLLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhGLLML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:12:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F0AC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:09:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 17so16077339pfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6lUy469xn93hCfPaZmGpgx+R1HMy/dgOdulccySigII=;
        b=wASbzIwqLYXl8KSzuf55+l20joE47Hs8wXna1poxH1tL14MmrWD5C2hZvvCQVYKfEa
         1yL8XystJAYPw2Nm0URlpDZk04jF5XTzcTpVJIxjKsKBI9eH0KOWilg+KnujNa89E5Fj
         W8iBssqkx2RcyTSnHaLP6wFfTxmPL8kC9ncYsnLd0/q/POM5ORPwh9umqyLMs1KhIemX
         jGzPi/EXwLAb0FnX/mvb9DEwUi4m2LMlHoyUx040XueVWufn1FElyyZLXkX7ykfmDGjd
         d8kUAJfFbqzPSc77FNKp0KVjk5RjwzrhXRlRmoEI5ENSeUU9XVLsdIPz2CP20QbfhVGR
         X56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6lUy469xn93hCfPaZmGpgx+R1HMy/dgOdulccySigII=;
        b=ZCuHPx7E1zg1AUyQARgNE1pnf96aBjlDQXjznqf716j9hzyZI6eI79MCsel7WYjKo3
         OWQ+peIZwbwHwhzR15d87dH0j7lQkbKhozvDVPGY6OSALi8JHy78XFGgwvImNYgv96VD
         VnYJVREawot+ASNLwgLD3KqkOIRNtT3id6KLyySnJ9TjqaW90wNofoUFLrj4RpM78+Pd
         aSw5gk7ccUCCoS4covWQFbaCO4CVRDl6OkGhYfLlDxLE5wHvglR42pYoXKtLKbNjbvPg
         0iaMWfKzF7A9KgVoYf7RLonCB8jz0SDIo1vV/S1toc9K73JsdI3Axobwxvtv4J3/pZk6
         fRNA==
X-Gm-Message-State: AOAM531kfYbz2h3ZqEP+s1QWEB6cw9ywMP+tl4hGMmAHs3tu9js+GzhV
        gasoQBgFsWChwj/MJpr0bdZ4Mg==
X-Google-Smtp-Source: ABdhPJwceYGKhorIjk3Ec8U2rp2c/7zJyhpZg/ZvIvowfOvlu2KczPGOZkBQnrGzASEYvFxL0zeptA==
X-Received: by 2002:a65:614d:: with SMTP id o13mr52781496pgv.351.1626088162760;
        Mon, 12 Jul 2021 04:09:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id f3sm1169549pjt.19.2021.07.12.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:09:22 -0700 (PDT)
Date:   Mon, 12 Jul 2021 19:09:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: tmc-etr: Speed up for bounce buffer in
 flat mode
Message-ID: <20210712110916.GB704210@leoy-ThinkPad-X240s>
References: <20210710070115.462674-1-leo.yan@linaro.org>
 <f17065d6-5083-74c9-d9ca-a467b640aed3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17065d6-5083-74c9-d9ca-a467b640aed3@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Jul 12, 2021 at 10:55:32AM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> >   static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> >   {
> > +	struct etr_flat_buf *flat_buf = etr_buf->private;
> > +	struct device *real_dev = flat_buf->dev->parent;
> > +
> >   	/*
> >   	 * Adjust the buffer to point to the beginning of the trace data
> >   	 * and update the available trace data.
> > @@ -648,6 +668,28 @@ static void tmc_etr_sync_flat_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
> >   		etr_buf->len = etr_buf->size;
> >   	else
> >   		etr_buf->len = rwp - rrp;
> > +
> > +	if (etr_buf->offset + etr_buf->len > etr_buf->size) {
> > +		int len1, len2;
> > +
> > +		/*
> > +		 * If trace data is wrapped around, sync AUX bounce buffer
> > +		 * for two chunks: "len1" is for the trace date length at
> > +		 * the tail of bounce buffer, and "len2" is the length from
> > +		 * the start of the buffer after wrapping around.
> > +		 */
> > +		len1 = etr_buf->size - etr_buf->offset;
> > +		len2 = etr_buf->len - len1;
> > +		dma_sync_single_for_cpu(real_dev,
> > +					flat_buf->daddr + etr_buf->offset,
> > +					len1, DMA_FROM_DEVICE);
> > +		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
> > +					len2, DMA_FROM_DEVICE);
> 
> We always start tracing at the beginning of the buffer and the only reason
> why we would get a wrap around, is when the buffer is full.
> So you could as well sync the entire buffer in one go
> 
> 		dma_sync_single_for_cpu(real_dev, flat_buf->daddr,
> 					etr_buf->len, DMA_FROM_DEVICE);

I am doubt why you conclude "always start tracing at the beginning of
the buffer"?  I read the driver but cannot find any code in the driver
to reset rrp and rwp after fetching the trace data, or there have any
implict operation to reset pointers?

Just want to double check for this, in case I miss anything.  Thanks
for the review.

Leo
