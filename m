Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7722F314A52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBIIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBIIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:30:51 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B2C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:30:11 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e24so2096042ioc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD7Xj/h3myZPE11iClGnY0ITJjZw2WaNmh4Gs5ySEmU=;
        b=Z8/glXM4r2nvS+LxLw4u5mH2ajnyiNqMAp89KxvOsQ79QYUf+J9Uxi5WqPcaOfU9de
         0V8+b6akhQ45QuTYOPMxUyD9qmM8oScMqOS8Oj1e9r9VWtH5UVoa43jhATVtS5gBZMuR
         jtwW+wPVpUEXAjtRmVt/91CORyu68Fm8Gyuew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD7Xj/h3myZPE11iClGnY0ITJjZw2WaNmh4Gs5ySEmU=;
        b=h7tDX5GgGE7Q3YuBdlxq3JjDPCJE9rK2/X1L3yo5u+arPzWDnF4JZMQW/Z8Q5ANSvO
         +DIz92NP787eeKs1yljuCwFEZk6MEUiYSvgyuM2AUDDMnPFvpiOkT8p07cfG0CYeeMUu
         5QeQbnc94x3VqacKktHC6PysBs7RKGVt7gxTCGdgJEml7A4h8+aLgVkp6fVouBkNqw2b
         eIVQqGbtNUqOr34pBdILlBluVcHM22HK9HGaVerzRktcLPUmPPmPVjNZ1nTBbnEwUB2i
         VHhJfjqVwLVy0mqjsVhasioK2Q6sWYc5Nr+USU6wvuFTxb7O3GKT6OnoVALt8q+Yfz8Y
         K9+w==
X-Gm-Message-State: AOAM53109hKtGzlyUIZ4QD5rnFU/mftiTS3kjE8ndEn5YE3uN6rVJ1Is
        epGG45wGKhtSAIrThvxg7NziEpoTx0lL5g==
X-Google-Smtp-Source: ABdhPJwHT2HTvXu+dH+KY2wcvXL1pLbmpDWMaIO7RdDJW7a9hrswxgunzGAiDk/YkNLRfAHQfHradA==
X-Received: by 2002:a02:5148:: with SMTP id s69mr21906436jaa.8.1612859410860;
        Tue, 09 Feb 2021 00:30:10 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id x3sm10005310iof.21.2021.02.09.00.30.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 00:30:09 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id u20so17892580iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:30:09 -0800 (PST)
X-Received: by 2002:a5d:894d:: with SMTP id b13mr18083060iot.150.1612859408996;
 Tue, 09 Feb 2021 00:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de> <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com> <20210209082213.GA31902@lst.de>
In-Reply-To: <20210209082213.GA31902@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 9 Feb 2021 09:29:58 +0100
X-Gmail-Original-Message-ID: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
Message-ID: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Tue, Feb 9, 2021 at 9:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Feb 08, 2021 at 08:33:50PM +0900, Tomasz Figa wrote:
> > Sorry for the delay. The whole series looks very good to me. Thanks a lot.
> >
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>
> Thanks.
>
> Ricardo, do the uvcvideo changes look good to you?  I'd like to queue
> the series up for this merge window.

Let me test them in real hardware today.

Thanks!


-- 
Ricardo Ribalda
