Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82573602F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhDOHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhDOHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:09:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FFC061574;
        Thu, 15 Apr 2021 00:08:54 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so21741436otn.1;
        Thu, 15 Apr 2021 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvv9Z+5IWRSsuwqqnBpx+MZMoeQomd87AFJ4WvcFBio=;
        b=fELtbrT9MMPajwbDhgBIp13s7ytuo9ZP436u5bHiLqI96pnWwNG5zhIfjL9Dw171m9
         fgJQDkAnw4nnD67piz3+EUgSD97l2fMIi2PAliv47JT18EwJeet92Tk6/rxCnCh7x0vV
         7A7B5sBCJKb+eCKX60HGUvjQraaDuXEGIqle1953TFREiTFvvUsoqfJTZRlpQlAF+gKE
         db8+fYW/SYMcJLsYG9M+aWLLBz/Ptng/B/iZjwwpjXsXR2q6XjFKU3GqS2C9dZv194e/
         77ZLOqxbOwrdA0Tl3lLF+WkUukRsQSMj8ryC+DoRJYTD+gNGZv7WIqo43RV9sKg3s/Sx
         LFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvv9Z+5IWRSsuwqqnBpx+MZMoeQomd87AFJ4WvcFBio=;
        b=S3dd5PSQTmo0Y+pcMEtDHpfVgScFNkoAeOnNS9k74z5lfCGlHp1pIiTXKPvxD6FXGe
         AdXFk4jkPyGq4eX+QB33iLWcmcH1CutDHbd0Ca6E2WfzPEV6aNSM/9aTcStHDhfOWzlM
         L3xE2Gawoo07nSfmla0xh7yiSiG8Pb0alGA7b3mVBKwz9jQQIZQFkqGZ1/X7QctLxODu
         jDRLwGV0CQoUp69JKj8ITbx8wECl0R4zn2bZixflShKSLT4HZgI4i02xYgSdQjdgtwWe
         4jxtu24SxrWJ4luKmUurSDG1FxpZl98D9hmCS4QBKiuLLhiMFXU2J73Ibn30MJmOL6e5
         z+9Q==
X-Gm-Message-State: AOAM530XqGIkox0r1usmuRvTdGZHxRetlKoDtMkMjKgTfr0tLQ1Sa27W
        NQjf3bZkvmtWNVV/LM3/K10TUfqNL5MQ1C8CnXh/xfg7ejX76Q==
X-Google-Smtp-Source: ABdhPJyS9hsAmAbnFATfr51nALqPsm1RRwEbtQKsklRn8JfEb5jRAgLViDjfoMM3N8DgpnbsDPhmyxSQLK5BbaQ8tig=
X-Received: by 2002:a9d:ecf:: with SMTP id 73mr1587984otj.339.1618470533770;
 Thu, 15 Apr 2021 00:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210412161012.1628202-1-colin.king@canonical.com> <CAK8P3a2pSRu0OKDNrNJSdviRgcv8Lw1mwZr5opv=UbtHLps2oQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2pSRu0OKDNrNJSdviRgcv8Lw1mwZr5opv=UbtHLps2oQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 15 Apr 2021 10:08:26 +0300
Message-ID: <CAFCwf10S8WhEZtpwD=2AgbgopMahxHofp-yXvsZ4GWkrctPRAQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs/gaudi: Fix uninitialized return code rc
 when read size is zero
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 12, 2021 at 6:11 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > In the case where size is zero the while loop never assigns rc and the
> > return value is uninitialized. Fix this by initializing rc to zero.
> >
> > Addresses-Coverity: ("Uninitialized scalar variable")
> > Fixes: 639781dcab82 ("habanalabs/gaudi: add debugfs to DMA from the device")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > index 8730b691ec61..b751652f80a8 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -6252,7 +6252,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
> >         dma_addr_t dma_addr;
> >         void *kernel_addr;
> >         bool is_eng_idle;
> > -       int rc, dma_id;
> > +       int rc = 0, dma_id;
> >
> >         kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
> >                                                 hdev, SZ_2M,
>
>
> In general, I don't like adding initializations during the declaration as that
> tends to hide warnings for the cases where a later initialization is
> missing. In this case it looks correct though.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I don't mind taking this patch for eliminating the warning but fyi,
the caller function (hl_dma_size_write) checks that the size is not
zero. If the size is zero, we never reach this function.

Greg, do you mind applying it directly to your -next branch ? I don't
have anything pending and I'm too lazy sending a pull request on a
single patch ;)

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Thanks,
Oded
