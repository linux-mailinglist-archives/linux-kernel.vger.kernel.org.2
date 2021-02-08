Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC30A3141F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhBHVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhBHUv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:51:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365DC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:51:05 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e18so19029367lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kTFr32bptu4tOZwE0ZuGkak5YWm4TyXH6EjCXCSCQOU=;
        b=fPkzJbfpY+rbqdzJyziCHL3LEul1WLLgf9TH3sO7UeY8/hZX3BuGEkSnMQTxrVxgmj
         ynhhO6rKYSPCXJzljB/G5dh6D/6Ab9HjYEOh0JNLDUnhL9Bikm3ewTtK18vfQq2JEyDk
         ZoW1LOAZ/DtcyppPbMaaXx48jvwDNvRjtHbftv8dLi2aOqVg0dhKdu5JcwKXY0Yfm8Wa
         3YV9RLPJldP9edDqzPioO0VvHZMQunOEaQW3flqc42qLTH3EUWMaagZsHCE/moBpwaxa
         3FBGgOlKrnB2Q2B7fz23YgzJDLywONpw9qFuo2JaPFyazzfndglQVbDBP++hmmXx2aqB
         7/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kTFr32bptu4tOZwE0ZuGkak5YWm4TyXH6EjCXCSCQOU=;
        b=ev0wanVQuVC0ndMqOzu6jyBncNooxkuotmVBV/Zitdvj2JCZ4+5btBqUfkfcT754qx
         5ckRqjrZjy/rDRUYAQFyr8NYcWDgSaemJW4M5BD68Dk70jbwykZLOJ8waXKcSxd8nQHM
         PgAf2G1G+CkCs3a8AztaLzcI74PS5TIoxhMJOREOukY106dY9MX+Ik0CbclMbvHKXSDk
         KbpPowtoXXWYQ6YGsNCENIbkTbn8PahiUROOfa/r91W7WmuNX52U97oaNkDet9ifYt4B
         +CQryGjL8bTpx5JHUYlfDZnb6ZkNKS5zOvYGgbAg9AaWOwVlzxiEEyhlLIz7Dyr1SWGJ
         dcCA==
X-Gm-Message-State: AOAM532GS4aHqyhe0GgTUi1ltT0oDFV9UUrhyUP6qYOwvaYB+cMoiw2V
        xU0B85Z9xr03LbMkMsue6jogafXRZMkEICvGnCRf9A==
X-Google-Smtp-Source: ABdhPJzyLwGZIsnnaLCIXwnTE+bBhjn+823+aLJKw6/rPEzO6bZdXDtpP894AzuNEnj/AFCYBAmeFM6AKDOaToIttGM=
X-Received: by 2002:a2e:8090:: with SMTP id i16mr12425346ljg.257.1612817463364;
 Mon, 08 Feb 2021 12:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20210206054748.378300-1-john.stultz@linaro.org>
 <20210206054748.378300-2-john.stultz@linaro.org> <YCENrGofdwVg2LMe@phenom.ffwll.local>
In-Reply-To: <YCENrGofdwVg2LMe@phenom.ffwll.local>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 8 Feb 2021 12:50:49 -0800
Message-ID: <CALAqxLV2Sikxnr3-k94nqcF5vz+jsekhhUrmXEKkwzwwu4up8g@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] dma-buf: heaps: Fix the name used when exporting
 dmabufs to be the actual heap name
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:08 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sat, Feb 06, 2021 at 05:47:48AM +0000, John Stultz wrote:
> > By default dma_buf_export() sets the exporter name to be
> > KBUILD_MODNAME. Unfortunately this may not be identical to the
> > string used as the heap name (ie: "system" vs "system_heap").
> >
> > This can cause some minor confusion with tooling, and there is
> > the future potential where multiple heap types may be exported
> > by the same module (but would all have the same name).
> >
> > So to avoid all this, set the exporter exp_name to the heap name.
> >
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
> > Cc: Laura Abbott <labbott@kernel.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Hridya Valsaraju <hridya@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Sandeep Patil <sspatil@google.com>
> > Cc: Daniel Mentz <danielmentz@google.com>
> > Cc: =C3=98rjan Eide <orjan.eide@arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Ezequiel Garcia <ezequiel@collabora.com>
> > Cc: Simon Ser <contact@emersion.fr>
> > Cc: James Jones <jajones@nvidia.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> Looks reasonable to me.
>
> I guess the main worry is "does this mean heap names become uapi", in
> which case I'm maybe not so sure anymore how this will tie into the
> overall gpu memory accounting story.
>
> Since for dma-buf heaps one name per buffer is perfectly fine, since
> dma-buf heaps aren't very dynamic. But on discrete gpu drivers buffers
> move, so baking in the assumption that "exporter name =3D resource usage =
for
> this buffer" is broken.

I suspect I'm missing a subtlety in what you're describing. My sense
of the exporter name doesn't account for a buffer's usage, it just
describes what code allocated it and implicitly which dmabuf_ops
handles it.  Maybe could you give a more specific example of what
you're hoping to avoid?

To me this patch is mostly just a consistency/least-surprise thing, so
the heaps exporter name matches the string used for the heap's chardev
device (the interface used to allocate it) in output like
debugfs/dma_buf/bufinfo.

thanks
-john
