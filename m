Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86B43AC143
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFRDYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhFRDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:23:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:21:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d7so6672070edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aJ7JLNwP8uQqbzACgqcuvU9N5foWZsWndyEyLlqRCY=;
        b=Bs1lVn/Fv7HQ1gsS939rabvK+bgf5OnBx3+M7rkEyVztWkpe3oLTsa8T3TpZ6VCOil
         FuB2/gbtM56yMReJ5wFMl/eXIAK1Vx5BOp+s8bekj51rQ47Dgv4UOa8M8/pgCG/wCdpG
         ndNqRM2AFGTW82VnxFJdle/ZOI8IF+k6V6D10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aJ7JLNwP8uQqbzACgqcuvU9N5foWZsWndyEyLlqRCY=;
        b=t9O4gP4gbV3oGIPm0IYup/8q/k6YhbDjDFtDkYjAnUwLPGVNP7c0A3lwxqKzrh0k0G
         OfLEyQLIHfwVv8PoTZ6YFeBpjfim3jus+p3gFpfYX7XnGI8TKTNeJSs/RDlLgiOIMWP5
         2r4kfsCqk/5CaWTR6ZQMZ+dzcvdiMbo1rd7YIkIDceeU8wZhACBRewWx7Xqk2U65Hc25
         5K5wFfpQzvxdlUiJeqZuB5kKV1O3bGEQMLbGTfEWHEUXzrSah6Rswm0hRVGaynoCOn1U
         dIIq5NptLHRK0+mLJ61lKb6qtsjkKewvOssG1+b85aZxl3vSh1udLBjNt1DSeFbaVc7D
         H8qQ==
X-Gm-Message-State: AOAM5305Q0fBN8m7NRr+o7gywVzyoSAoShqaH9bZM6zYajJNiR4h4PWo
        notub+ms0jl8yUOiMHQXvNGqhttE8BeNJA==
X-Google-Smtp-Source: ABdhPJxOt2Roemk8rhlfEx+IL5e34l9U1VpHhroyK80ckhm9ePvZ1PpH7OBsXyYSt1Elvq2HQYmP2g==
X-Received: by 2002:aa7:dd5a:: with SMTP id o26mr1968657edw.277.1623986506698;
        Thu, 17 Jun 2021 20:21:46 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id d22sm443845ejj.47.2021.06.17.20.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 20:21:46 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id c5so9002121wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:21:45 -0700 (PDT)
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr9725940wru.197.1623986505267;
 Thu, 17 Jun 2021 20:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210427131344.139443-1-senozhatsky@chromium.org>
 <20210427131344.139443-9-senozhatsky@chromium.org> <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
 <YMsAIVs7G2hUDR2F@google.com> <20210617080107.GA1422@lst.de>
 <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
 <20210617085233.GA4702@lst.de> <CAAFQd5DqK2gSTGjfo-vahXwMzzO9gv26cY=vV6urn3viDLPE7g@mail.gmail.com>
 <20210617100656.GA11107@lst.de>
In-Reply-To: <20210617100656.GA11107@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 18 Jun 2021 12:21:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CgLDkJ3t1aU2PRcGu6cGFjLXOnvMqDg62Z7Zuc8ABVHg@mail.gmail.com>
Message-ID: <CAAFQd5CgLDkJ3t1aU2PRcGu6cGFjLXOnvMqDg62Z7Zuc8ABVHg@mail.gmail.com>
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jun 17, 2021 at 06:40:58PM +0900, Tomasz Figa wrote:
> > Sorry, I meant dma_alloc_attrs() and yes, it's indeed a misnomer. Our
> > use case basically has no need for the additional coherent mapping, so
> > creation of it can be skipped to save some vmalloc space. (Yes, it
> > probably only matters for 32-bit architectures.)
>
> Yes, that is the normal use case, and it is solved by using
> dma_alloc_noncoherent or dma_alloc_noncontigous without the vmap
> step.

True, silly me. Probably not enough coffee at the time I was looking at it.

With that, wouldn't it be possible to completely get rid of
dma_alloc_{coherent,attrs}() and use dma_alloc_noncontiguous() +
optional kernel and/or userspace mapping helper everywhere? (Possibly
renaming it to something as simple as dma_alloc().
