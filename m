Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136FC3F48AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhHWKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhHWKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:30:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D6DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:29:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so1015174pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOLTokCzMJhrS4yVrsvWA7I6iBUF0+poQl+b02sEUsU=;
        b=d9NEFEsJvNYuoSyxsZify90/61cU0ZWsqGqoaLu3c/SUinZZoaJcAChNdiUafs14Nv
         N3KqQ1KblO+pmVxCokfC7ZdftZMq7xlJGPht149Gw9/q+RpW+bM9wjB87l8ayQVeFADe
         BFKdmTC2z4eDlJw0XWNRyVZ1bTu3DpAHkrhwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOLTokCzMJhrS4yVrsvWA7I6iBUF0+poQl+b02sEUsU=;
        b=sJgK4Nb5N2oSHJhF3oJt+CpxLpZGhGMFmaHQt9m00tTgS2Mlf5jXVhsJ32c7TmS7aO
         yc0jyFh0pPdLiIE3aKM19QGbD3urp60yQvt7VYB+wm2TNaf7qF6UZLpPYFl03XV3+6RW
         ehr5UBX9+vHiQwMPnKLXIWfEQt8A/FMbN05SNrgpSBIiuOfaHRkftwUwCevUJ2DjKNWm
         0XHGaeTywxzXWtdlXWrkVsxYP2rAlbBOFv+jE3i+Qyo/VV0LK+TjiolKxqK/Dlv3YUff
         Lf6A8ddsTMVwRDOPpxymAeUFg8yKPV6whQIBt/bV7pdtVMk0HhJ1wVryhPCyBpp+EDzq
         Vq7Q==
X-Gm-Message-State: AOAM531b0RzwpnHLohbCGXJHW08oLJDtcnYGXn6I+M6+miUfFh/h+EXZ
        +QSPqFBIzlq+rzmy4O5iZqus9g==
X-Google-Smtp-Source: ABdhPJwinUyVdRudwqM9L+o/iJXQT+DwNhl+fEJx9YyCPD1iQFkfLjFX8pEzBY8SNHQBcPV/LthnDA==
X-Received: by 2002:a17:90a:cc8:: with SMTP id 8mr19829798pjt.194.1629714591769;
        Mon, 23 Aug 2021 03:29:51 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8821:8b2f:2912:f9e4])
        by smtp.gmail.com with ESMTPSA id z11sm15397918pfn.69.2021.08.23.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:29:51 -0700 (PDT)
Date:   Mon, 23 Aug 2021 19:29:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YSN4ms1VoJO2CWNp@google.com>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
 <20210727070517.443167-9-senozhatsky@chromium.org>
 <fd1e8bbe-4cbe-9586-7c8f-0896af043d4a@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1e8bbe-4cbe-9586-7c8f-0896af043d4a@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 12:15), Hans Verkuil wrote:
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
> > +	if (!buf->coherent_mem)
> > +		buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size,
> > +						    buf->dma_sgt);
> >  	return buf->vaddr;
> >  }
> 
> This function really needs a bunch of comments.
> 
> What I want to see here specifically is under which circumstances this function
> can return NULL.
> 
> - dma_buf_vmap returns an error
> - for non-coherent memory dma_vmap_noncontiguous returns an error
> - coherent memory with DMA_ATTR_NO_KERNEL_MAPPING set.

Done.
