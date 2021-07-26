Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6898A3D523D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 06:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhGZDam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 23:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhGZDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 23:30:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387E9C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:11:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso12019875pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6pXQ274+tm0xEUoPst1AwOmm3LyiPdeK2tCknxdY/8=;
        b=PTMlvlj4IXXZoeYutqxMswKdE9Lamr3rwEIKMHHlvdzTkFcjtfUOx8IDHAhFT2KuA8
         GvXPhaJz+4L3n4hSQjZlLNEjicQAvE+KySBwwdoDBe1uquHlTdsuQDlOTGgUO97z+3hp
         Sk3AejYKD3id3iQZB8ECQT5qQxGYGfL/tPsg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6pXQ274+tm0xEUoPst1AwOmm3LyiPdeK2tCknxdY/8=;
        b=eCFv+JcRprM3am8eAcLzk9nlio1RUB5itcPxlg2WawSpVjuQzjAcrzpc3Zc1ejcNvp
         gWh4UhvRZvswbza8dULLTxuIjTznFt0iFm9Sm8E0Z6Wcj2Ak15BqmIbnWO32uchY7fVi
         4iah+3+sayFBwkvXfSPOtv5zmfZVT+in1cAT/OfI2HYP1ZM5NG1rgk6Oq9h+hyMvaqsu
         Q2f8VdbgUl4LKzna+HMEJTBqWj9v4mqh5rdJjE45txV94dwFFjwYKx9Zy2dQx3Y7/9T5
         6dvDhp1bYTr9jvfqwlbh85h35tabNNceF9H6SpT8MV0ortNP/RJcYEPfarxY7o2u21Vx
         D9GA==
X-Gm-Message-State: AOAM531ioJaaGHBfafP79vMrgtgCgqIESYR+PYb61T7EyJsMMa9JL1LV
        sBdRCTnZoFInIyziOlhfsHgQ4w==
X-Google-Smtp-Source: ABdhPJzLHxyOsoB3lyDZ0bUuL8EPe88cSCE3RuGlECE6gOfG3iSF0pOqhCg4yS99qn5RgV4P2s4MJA==
X-Received: by 2002:a17:90a:bd98:: with SMTP id z24mr2676573pjr.99.1627272661385;
        Sun, 25 Jul 2021 21:11:01 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:d699:4331:827:4150])
        by smtp.gmail.com with ESMTPSA id g19sm11815718pjl.25.2021.07.25.21.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:11:01 -0700 (PDT)
Date:   Mon, 26 Jul 2021 13:10:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCHv3 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <YP41zzARXEXESEXE@google.com>
References: <20210709092027.1050834-1-senozhatsky@chromium.org>
 <20210709092027.1050834-9-senozhatsky@chromium.org>
 <3c80786a-7422-3736-7261-8605260eb99f@collabora.com>
 <YP4zHRh+jHJGbNHz@google.com>
 <CAAFQd5D6hSoLJaBMdV-fpzn43Y6qRULR4ckejrJp_89Qpe6Xnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5D6hSoLJaBMdV-fpzn43Y6qRULR4ckejrJp_89Qpe6Xnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/26 13:04), Tomasz Figa wrote:
> On Mon, Jul 26, 2021 at 12:59 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (21/07/22 19:26), Dafna Hirschfeld wrote:
> > > Also, the 'cookie' cb returns buf->dma_addr which is not initialized for
> > > the noncontiguous api. So it is not clear how drivers should use the new api.
> > > Many drivers call vb2_dma_contig_plane_dma_addr which returns the cookie.
> >
> > Hmm, that's a good find. Is ->dma_addr the same as what we have in
> > sgt.sgl->dma_address for non-contig?
> 
> Yes. As per [1]:
> 
> "The return sg_table is guaranteed to have 1 single DMA mapped segment
> as indicated by sgt->nents, but it might have multiple CPU side
> segments as indicated by sgt->orig_nents."

Thanks. So the fix can look as follows:

---

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

+        buf->dma_addr = sg_dma_address(buf->dma_sgt->sgl);

---
