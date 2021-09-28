Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6A41AA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhI1HzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbhI1HzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:55:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28933C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:53:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so89111820lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii9qLWgitq2lwVS5qa82b5LU5SvJwtKKJcHVt8hkGzs=;
        b=DBqRHD9HQvd6fYoRv8zX0pl+lhqTmHdIrYxcgnAPAjRiaVMPA8zlN4WOk6NvRNf/BD
         AfgU7bcRpq/NwpK7GtLR66NyuhdDaGNDlZHmD2RGePs+Y3NRFxCnWxO4Zm9otgifKvAo
         FKhxqJQfBrEPUJFvCPWPOKJbF8tXqSMGqA7eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii9qLWgitq2lwVS5qa82b5LU5SvJwtKKJcHVt8hkGzs=;
        b=P8EXMkp317EmdC8MFCmyCnMDOxEb41UJsJ1A5OMxHLzf1ExaMJaJOt8VcHvJ+o60kv
         9bcLyqaBPV5pXwT33z66cj/tCJfzYk+Q3xFypmZ3bVjtCAESpbr9ZA2lByfDUTTI44DP
         Wde1lU9Ufq2rxfcor89ba0MR+GHidSPTiPS5yS//iKudnyL08vPWkqqXSTUInT6zcHmq
         hC38axaFNF20TF83YtnoMhxkyeJMW/ScSmviXA5fcva98wuXYX8c5Q32AS9rgGpNANAc
         ZaiPFoh8S7v7iqN+UxTwEJuSTEFJ1ZeTLS4zATXRiNa7UcILmIt56z34btKA3lH8DY9g
         vIRQ==
X-Gm-Message-State: AOAM5306dHFnDlFzW1UyoAyL8c3Wij6q5hWnCqJiqoovOQQLDtn9OiSu
        zX5n7gvlusXD3q2Q96VILRKpJL5bzAY7NCbStHoQVINgWWF6LA==
X-Google-Smtp-Source: ABdhPJzWnm2L7IxEjLI8zb38BjNviOGp+t6lkt2c66XagFyi2eN7OLh5PhhiMSLvNV5kaS0Y/u7rYQP8nh7yUQ1Wj6A=
X-Received: by 2002:a05:651c:1790:: with SMTP id bn16mr4344323ljb.457.1632815605494;
 Tue, 28 Sep 2021 00:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210928034634.333785-1-senozhatsky@chromium.org> <CAGXv+5HaZcf-RwGGb7phfKcoTnaeiN2H6b_BvR+qdcRYys=nzA@mail.gmail.com>
In-Reply-To: <CAGXv+5HaZcf-RwGGb7phfKcoTnaeiN2H6b_BvR+qdcRYys=nzA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Sep 2021 15:53:14 +0800
Message-ID: <CAGXv+5G16fZWyyFDHTeaqJG02cYhVm20u47ZXJb+HdHmFc8HSw@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: always set buffer vb2 pointer
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 2:24 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Tue, Sep 28, 2021 at 2:16 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > We need to always link allocated vb2_dc_buf back to vb2_buffer because
> > we dereference vb2 in prepare() and finish() callbacks.
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> This fixes the breakage from the "videobuf2: support new noncontiguous DMA
> API" series on the RK3399 Scarlet if the ChromeOS patch that changes
> min_buffers_needed to 0 [1] is not applied.
>
> Since there are other in-tree drivers that have min_buffers_needed=0,
> I would recommend getting some more testing.

Seems I had a stale kernel when testing the min_buffers_needed=0 case.

Everythings works now.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
