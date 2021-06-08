Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607B73A0195
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhFHSyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhFHSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:48:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EDC0613A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 11:44:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w33so33742095lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/n2yUEViCmlCbkWm7ppXR+v3Z2ScShTqfIirUWpY1w=;
        b=mLCpYalDrr2ldQuGpiD7Sk5Ev+roCMUQzBDH9k1sCaBG4ns9Zt+U59vwoH2VEorGY0
         8wnyrLqyvBbCjYqmA9WFzkzpekG8X1V1UhrVgHKMS5mbcDNyQbsX+seDVRfrOeiDdzh+
         sZ8Mp68/HAcUyIo4UOdCmSxShl3eRDvmZcP5xCSiCoBOcy0+SJLNdkg/1WE941hoFjPF
         dZ8LLQNrZ4SnyV26dAK5FLgwRgBcUpLxcMGCmxYn+k6vwjdT5Hgl0de8QbQ6i3Mv7w+y
         E8OIXDkweJa1pW+15b/YvGnDpEKZMzsPhqRsRQuxUM1lzRuv78nrTj4VAeQ9s9kvdKv0
         qBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/n2yUEViCmlCbkWm7ppXR+v3Z2ScShTqfIirUWpY1w=;
        b=Rkg8kxYn9h0BEl9F0Zzl3/RvUKY+9YMtqJ55+GvlzT2NCh926b0V/Q+X9wpPHJerwJ
         G1UTAScG3s37YEfMf/hgDmyX3nxs2tAmfsngHlUMkOPDcGzu9e3CfyOI68CNUX7vZ49b
         2IrRgj0Wr5ChpBkGDmLJylcXmygcwiu+raX9jO5s4if5tNoaY4/ZcJ7n2rUs9Ynm47Uf
         6Nfb8TOKjVM3rwT4uIypGO8zfPpONgrzhRGTvj+DaK95AKvQM3jy/6nlzEBrQwFbDtMA
         w0+DE+oA2dBrEvtiJc85mD2JO/+t3g02a/RGxvVX8sk/gGGOKJUBZdAhcfnD2/+RYwtG
         mO5w==
X-Gm-Message-State: AOAM533OK1ecca8/MtNU+sbxAPbFYyXm4oIYHzVVNzDNDlBz29aA118F
        EvB4xfwgX3IBiaAwpysxRRZAgvn/uUgnFxgYq3WD9w==
X-Google-Smtp-Source: ABdhPJzzUMTXD37rDyfCeVVjDfNo9L8b3GXFxmE5KXMmeYUOMVEgqghT+XbIvoP4GqZRDLP3p61C99Bob8MFnwmvJZg=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr9020454lfb.297.1623177867232;
 Tue, 08 Jun 2021 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <1623145017-104752-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1623145017-104752-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jun 2021 11:44:16 -0700
Message-ID: <CAKwvOdkhQrnunYDtGPvyfMcjW-yMihQQZY_8VYLbD3+Y5pHryA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hyun.kwon@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dmaengine@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 2:38 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in xilinx/xilinx_dpdma.c kernel-doc comment
> to remove a warning found by clang(make W=1 LLVM=1).
>
> drivers/dma/xilinx/xilinx_dpdma.c:935: warning: expecting prototype for
> xilinx_dpdma_chan_no_ostand(). Prototype was for
> xilinx_dpdma_chan_notify_no_ostand() instead.

xilinx_dpdma_chan_notify_no_ostand has static linkage, clang shouldn't
be emitting such a warning for this function.  Which tree was Abaci
run on? Do you have the original report? This warning doesn't look
right to me.

Again, the diff seems fine, but the commit message does not.

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 70b29bd..0c8739a 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -915,7 +915,7 @@ static u32 xilinx_dpdma_chan_ostand(struct xilinx_dpdma_chan *chan)
>  }
>
>  /**
> - * xilinx_dpdma_chan_no_ostand - Notify no outstanding transaction event
> + * xilinx_dpdma_chan_notify_no_ostand - Notify no outstanding transaction event
>   * @chan: DPDMA channel
>   *
>   * Notify waiters for no outstanding event, so waiters can stop the channel
> --
> 1.8.3.1
>


-- 
Thanks,
~Nick Desaulniers
