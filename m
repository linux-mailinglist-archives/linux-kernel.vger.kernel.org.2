Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1740696B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhIJKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhIJKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:02:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A69C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 03:01:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t6so246977edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 03:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAz0PRehc9psyfyZMa6l+L0qrVAxjGHmAKvCjO5mIfI=;
        b=VtpLDTlPj53qzEVmIiHQDF5veditbzC39li94eqwuxd0HpaSIqPsAS/tQmL7JyNaAy
         kCLvp84CinhsbF+SEaIENJ7jJwTkg4gw/ViHABydmoRPncxnY1Hlj4njBDO8lUHzRPKy
         KbVZKOe7xo2FuWt4jwBV6zHZj6vCC7ltokGyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAz0PRehc9psyfyZMa6l+L0qrVAxjGHmAKvCjO5mIfI=;
        b=phgairp8t7GRt9b4BQ16slLh8Hcrw9FimQYlNnDV8iKxQG/k4P0dC8br/iyTprkNKC
         RPBah5A3mVNCSiLYeZWO3n+06G+4ZJlvRyAgfHSebcA8AaLpCNbcW0wUFLvjXzl6EzqQ
         sKj8OpXSLpIElQvJ87PwpuTaW/SEbJ+CLRAcWQK0GvQRQF55wQJdUJLZN9uaAki/WCnk
         W9CAEtkU5OFdtJvm6d/je79HTY6ODWLsFdo2KNrtq1LdIJ5LfAENPDrCE0RuXmch0eN2
         oQ7yaaoGrvfGAH2/5DHv0nIBc//g9O0yFnN1gamZxgWQ/rdIB+EzNVu2e3+mKra33MjH
         GGAg==
X-Gm-Message-State: AOAM530uDaoUGEF2SVk4uIPAuQapeaRDv1xAS68u2CnqAN5g0wHET2gF
        ea9l19IfGNAROJqpcLQjuQuR1fcCSN3bMQ==
X-Google-Smtp-Source: ABdhPJx2C94jL5CDa6eTAfUYQZEvu7qUu7lUjuo5ePftkroCUn3FwF4XHiZwcnTbZX7LQ+VFR9hdrQ==
X-Received: by 2002:a50:ed06:: with SMTP id j6mr8288097eds.148.1631268070104;
        Fri, 10 Sep 2021 03:01:10 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id y20sm2139372eje.113.2021.09.10.03.01.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 03:01:09 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id v10so1808384wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 03:01:09 -0700 (PDT)
X-Received: by 2002:adf:ea90:: with SMTP id s16mr8772371wrm.235.1631268068593;
 Fri, 10 Sep 2021 03:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210909112430.61243-1-senozhatsky@chromium.org>
In-Reply-To: <20210909112430.61243-1-senozhatsky@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 10 Sep 2021 19:00:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D9fgq7WGydXR344fscHSgKMCgwpotSMRszR_v2kX8q0A@mail.gmail.com>
Message-ID: <CAAFQd5D9fgq7WGydXR344fscHSgKMCgwpotSMRszR_v2kX8q0A@mail.gmail.com>
Subject: Re: [PATCHv6 0/8] videobuf2: support new noncontiguous DMA API
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Sep 9, 2021 at 8:24 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hello,
>
>         The series adds support for noncontiguous DMA API and
> V4L2_MEMORY_FLAG_NON_COHERENT UAPI.
>
> v5:
>
> https://lore.kernel.org/lkml/20210823122235.116189-1-senozhatsky@chromium.org/
>
> -- addressed feedback (Tomasz)
> -- reworked prepare/finish functions (Tomasz)
>
> Sergey Senozhatsky (8):
>   videobuf2: rework vb2_mem_ops API
>   videobuf2: inverse buffer cache_hints flags
>   videobuf2: split buffer cache_hints initialisation
>   videobuf2: move cache_hints handling to allocators
>   videobuf2: add V4L2_MEMORY_FLAG_NON_COHERENT flag
>   videobuf2: add queue memory coherency parameter
>   videobuf2: handle V4L2_MEMORY_FLAG_NON_COHERENT flag
>   videobuf2: handle non-contiguous DMA allocations
>
>  .../userspace-api/media/v4l/buffer.rst        |  40 +++-
>  .../media/v4l/vidioc-create-bufs.rst          |   7 +-
>  .../media/v4l/vidioc-reqbufs.rst              |  16 +-
>  .../media/common/videobuf2/videobuf2-core.c   | 126 +++++++----
>  .../common/videobuf2/videobuf2-dma-contig.c   | 195 ++++++++++++++----
>  .../media/common/videobuf2/videobuf2-dma-sg.c |  39 ++--
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  59 +++---
>  .../common/videobuf2/videobuf2-vmalloc.c      |  30 +--
>  drivers/media/dvb-core/dvb_vb2.c              |   2 +-
>  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   9 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   4 +-
>  include/media/videobuf2-core.h                |  59 +++---
>  include/uapi/linux/videodev2.h                |  11 +-
>  13 files changed, 411 insertions(+), 186 deletions(-)

Thanks a lot for working on this. This version looks good to me.

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
