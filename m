Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90FA3EEB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhHQKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhHQKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:41:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298DC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:41:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so4378648pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vakua7dB9MNN/4+EvWcg/tkA9unAO8MnqooNldYK9is=;
        b=hmjUn9cvLrKrl5cyT5UaVFMBlY0lf6tv5/vLf2NAvY8wiUtZSvCNhqhM3iVNdSkJHj
         msroeQrJpKML3icpKyaR4fWnXfqHwPrLF9UpdSdyftHVhpm/69XhUHZ1L4mXWtvHZebD
         WAlgTWptRnbCFx0sAzOS38GzE9W8pUmm3eKkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vakua7dB9MNN/4+EvWcg/tkA9unAO8MnqooNldYK9is=;
        b=SB7y265uMIz4PfKudlNZmOllfuklx1e1SIvRiI1+HFSwx3mn3QqvcEGNTn65JBZFqe
         j5VB+acbLTiYdbKq16PaAjHZK4qHIwp6KuikK/qWAeGJG5TSXyWWI3fA4BuCeP3pLAPb
         OhGLpmuVp1OQ9a+dUGgfox8MvoVYhWEZ5HPfuFmanRin1Uc9nlG9WFWmOnuNj19wvRu2
         Z1IWqQ3C/B1OpfPeCUKYacqqSYJZN6ebYgBW6zNrdVj/3XmKuRMLR+50fX34XrphT4Io
         4AMfjiDg9cyaka986crunCmnUUTfq0bJsvnZg2gy7CrmhjXCE5/tfm9/HVZPJOVcVRMb
         0vew==
X-Gm-Message-State: AOAM533X4YEujkYUaoQaipIJjZlif3ua0i6hiFVAy196kQBZDWdGCie4
        8Xasbzc4Er5J/lMfGEJHSKLNpQ==
X-Google-Smtp-Source: ABdhPJyH+sfgV7i5vCz2VdxYloXot1O+JjbDHyjtkdDNLEYbWsQa51i9g2aU06kZkv2Pex3TICmUOA==
X-Received: by 2002:a17:903:234e:b0:12d:ad8d:56c6 with SMTP id c14-20020a170903234e00b0012dad8d56c6mr2272743plh.23.1629196871081;
        Tue, 17 Aug 2021 03:41:11 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8aab:cb84:5fe8:99dd])
        by smtp.gmail.com with ESMTPSA id q68sm2775955pgq.5.2021.08.17.03.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:41:10 -0700 (PDT)
Date:   Tue, 17 Aug 2021 19:41:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/8] videobuf2: rework vb2_mem_ops API
Message-ID: <YRuSQMTcexYmFGub@google.com>
References: <20210727070517.443167-1-senozhatsky@chromium.org>
 <20210727070517.443167-2-senozhatsky@chromium.org>
 <3744c521-ce07-4ca9-5f57-fa42b917d53c@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3744c521-ce07-4ca9-5f57-fa42b917d53c@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/03 10:08), Hans Verkuil wrote:
> On 27/07/2021 09:05, Sergey Senozhatsky wrote:
> 
> Sprinkle a few more 'the's in the text:
> 
> > With new DMA API we need an extension of videobuf2 API. Previously,
> 
> With -> With the
> of -> of the
> 
> > videobuf2 core would set non-coherent DMA bit in vb2 queue dma_attr
> 
> videobuf2 -> the videobuf2
> set -> set the
> in vb2 queue dma_attr -> in the vb2_queue dma_attr field
> 
> > (if user-space would pass a corresponding memory hint); vb2 core
> 
> vb2 core -> the vb2 core
> 
> > then would pass the vb2 queue dma_attrs to the vb2 allocators.
> 
> vb2 queue -> vb2_queue
> 
> > vb2 allocator would use queue's dma_attr and DMA API would allocate
> 
> vb2 -> The vb2
> queue's -> the queue's
> DMA API -> the DMA API
> 
> > either coherent or non-coherent memory.
> > 
> > But we cannot do this anymore, since there is no corresponding DMA
> > attr flag and, hence, there is no way for the allocator to become
> > aware of what type of allocation user-space has requested. So we
> > need to pass more context from videobuf2 core to the allocators.
> > 
> > Fix this by changing call_ptr_memop() macro to pass vb2 pointer to
> 
> changing -> changing the
> vb2 pointer to -> the vb2 pointer to the

Ack... The Ack.
