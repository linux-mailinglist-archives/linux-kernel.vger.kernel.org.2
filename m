Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59D03AAE1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFQH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFQH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:58:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:56:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x19so2501045pln.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdiMUTIyPJj8g1PDcfcn82Go3ufrdVKwIXswDiKJXKo=;
        b=OvuTaEokEl9rKO7QnpAerU5cGgTd2y46wi+4kK3tVRt9qo+Vv5OURDuwuKNSm+avWC
         wh2pSZ2HKaAcsLEg70xDFEmNwkJ1Wg/nj3jWaPs20yDp/g75EDkD6TZ3/NYq+JfXVkX4
         Xdd9YzK4TCZu9Yc9hSH3YK5CC2NXveOPuQ+sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdiMUTIyPJj8g1PDcfcn82Go3ufrdVKwIXswDiKJXKo=;
        b=Ux1hAFgPnrjuLV0rGzGXVMr4liSFeqjm03vL0IWgvOCx23GionKCS8j47KeCQ5cS/p
         FMrm3H+nSnQuv1h/gosU3e3xIgLN/VJ+M4UZcSnOaThbpB66g/4cDRkph2fhLOmFvJPy
         d2QPCK3EqJVQPcabnRpj/ZihTysY8UQhYD0sNL5jgE+p9Pla85n9q7XxFYIXxwKqyyS0
         ld8OEj2d1Gs+1HoVqYLGLGcDqUjXwuo/mnbhQc2xygGn+lcG6EAKyv3EQOUm0Dg8ReNP
         mNPz4pSK/XYGZXw/CYjQjlGqjDQNQaTjtOAtYTMyiEfdN0kvG3OByatPXgT+OaQq0Mz8
         /psA==
X-Gm-Message-State: AOAM532cdkzVXPYP+5noyZvHxkbwiEN/CuxoeNrUGCaH01g7J8UtiQ2v
        6fbcVUD5pH9ZMq8C5JMWQFJy7w==
X-Google-Smtp-Source: ABdhPJx5dzmBapOrX5N9Bqqu48BExWv5NIvWw/wsDPG3r+vNYvaXUMTgM2vdXE4F4nGAZ7TfgB+bsQ==
X-Received: by 2002:a17:90a:d18f:: with SMTP id fu15mr4239392pjb.78.1623916582471;
        Thu, 17 Jun 2021 00:56:22 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:32ae:4292:bec1:e4])
        by smtp.gmail.com with ESMTPSA id o16sm3998163pfu.75.2021.06.17.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:56:21 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:56:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YMsAIVs7G2hUDR2F@google.com>
References: <20210427131344.139443-1-senozhatsky@chromium.org>
 <20210427131344.139443-9-senozhatsky@chromium.org>
 <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/03 13:59), Hans Verkuil wrote:
[[.]
> >  static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
> >  {
> >  	struct vb2_dc_buf *buf = buf_priv;
> > -	struct dma_buf_map map;
> > -	int ret;
> >  
> > -	if (!buf->vaddr && buf->db_attach) {
> > -		ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
> > -		buf->vaddr = ret ? NULL : map.vaddr;
> > +	if (buf->vaddr)
> > +		return buf->vaddr;
> > +
> > +	if (buf->db_attach) {
> > +		struct dma_buf_map map;
> > +
> > +		if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> > +			buf->vaddr = map.vaddr;
> > +
> > +		return buf->vaddr;
> >  	}
> >  
> > +	/* Non-coherent memory */
> > +	buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size, buf->dma_sgt);
> > +
> 
> This function can use some comments. What is happening AFAICS is that
> buf->vaddr is either set in vb2_dc_alloc_coherent (unless
> DMA_ATTR_NO_KERNEL_MAPPING was set), it is obtained through dma_buf_vmap()
> if the buffer was attached to a dma_buf, or it is allocated via
> dma_vmap_noncontiguous() for non-coherent memory.

Yeah, it's complicated. Maybe we can make things more symmetrical.

> But this leaves coherent memory with DMA_ATTR_NO_KERNEL_MAPPING set, what
> is vaddr in that case? I think it will call dma_vmap_noncontiguous()
> incorrectly in that case, shouldn't there be a check for !buf->coherent_mem
> before the call to dma_vmap_noncontiguous()?

Thanks a lot for looking into it.

So vb2_dc_vaddr() can look like this:

static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
{
        struct vb2_dc_buf *buf = buf_priv;

        if (buf->vaddr)
                return buf->vaddr;

        if (buf->db_attach) {
                struct dma_buf_map map;

                if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
                        buf->vaddr = map.vaddr;

                return buf->vaddr;
        }

        if (!buf->coherent_mem)
                buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size,
                                                    buf->dma_sgt);
        return buf->vaddr;
}

And in vb2_dc_alloc functions set vaddr for !DMA_ATTR_NO_KERNEL_MAPPING
in both coherent and non-coherent. So that we probably can have less
branches when ->vaddr is NULL for one type of allocations, and is not
NULL for another.

static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
{
        struct vb2_queue *q = buf->vb->vb2_queue;

        buf->cookie = dma_alloc_attrs(buf->dev,
                                      buf->size,
                                      &buf->dma_addr,
                                      GFP_KERNEL | q->gfp_flags,
                                      buf->attrs);
        if (!buf->cookie)
                return -ENOMEM;

        if (q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
                return 0;

        buf->vaddr = buf->cookie;
        return 0;
}

static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
{
        struct vb2_queue *q = buf->vb->vb2_queue;

        buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
                                               buf->size,
                                               buf->dma_dir,
                                               GFP_KERNEL | q->gfp_flags,
                                               buf->attrs);
        if (!buf->dma_sgt)
                return -ENOMEM;

        if (q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
                return 0;

        buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size, buf->dma_sgt);
        if (!buf->vaddr) {
                dma_free_noncontiguous(buf->dev, buf->size,
                                       buf->dma_sgt, buf->dma_addr);
                return -ENOMEM;
        }
        return 0;
}
