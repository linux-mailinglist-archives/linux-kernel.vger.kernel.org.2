Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6243E8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJ1SzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJ1SzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:55:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C43C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:52:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso10325262wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+2Ro5WiaxdU6F81hXFf+PEN6KfpVQcZNINfMQcb7Xo=;
        b=FU4x2wrgrYdYwv9cND7PXSB1uY0sQDnXx91yOSWQzHIL0IhMqrHEPt3WYCnwsoHBVX
         e/HSJ5ul0zmAGwq3ysQqyUS/QesKcZmpHcIqWehwuPLCThBOgidSYCNDf37vbXqzChY+
         ejElGG/9qcZMeqxP5LeIK6cLztdmb0d2U2WlQc0U8OLjI2T7xoQ8iJw7M+1OVRejKKGg
         T+emZyfvR+XdSmYqvEx5EKgy5qO1llTsgk0dxlyTvq/hwjZXf0wcM34ELwmVMH3T6IpD
         xA2QUVTr23GgI+amCHLtVMjLvnKe4bQFRikJFuRab+rSviLSz99xjv+AG6+xGshChJr9
         YfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+2Ro5WiaxdU6F81hXFf+PEN6KfpVQcZNINfMQcb7Xo=;
        b=FHxj2ZIQ3kzlV6/+QGSp3gKpCrFp4DS7Or5KQwogmVek6zkfc+zYsq/oQwcs+D4Cev
         pbUCbd4uPfD18raIyt/Xfm6Wsxuwu1GcoQHv5o16G8YpCO6D+O2I/wX1rXqiUyNJcpxW
         6wuoP62UX5ZxSq6AVDXX3tQbZr3YO6utbowXidxytZzY1Aftg3cVi0ebiHueXka0QlBr
         go4I565+4qChE4yzVW1SFAXRKb8k42Mepz/1dkRgvYgMwOPUowD0wzZqeErT70uj2xLe
         D8YvatVDK57HUD7sarWH9L17P0FhFWT9B/kz+IIdraeHgRN8oFU+1Gzk5bbItL074n3m
         M9Vw==
X-Gm-Message-State: AOAM531XaLDMxw05k41FlPSV804UfUp58kLhPDon8ooyvSIEH7L3mOU7
        mCVm9NkF7+acY8F1IgRPsRn8Y8TKRJ+2rGnvlt0yMw==
X-Google-Smtp-Source: ABdhPJysUVwO6PwrXdxEyJkcGXuZ79xYuIE7gqCCaodfcHZHdA6HGzt8HMSB69ZpgJ5CQGXQL37RjyY1pbzie4+cX3M=
X-Received: by 2002:a1c:2386:: with SMTP id j128mr3853019wmj.8.1635447158349;
 Thu, 28 Oct 2021 11:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211023115209.19115-1-colin.i.king@gmail.com> <CAFA6WYMJkEPOCUMeF1EL7G1q7akBc-os5GF33Dkh6nok8fANZw@mail.gmail.com>
In-Reply-To: <CAFA6WYMJkEPOCUMeF1EL7G1q7akBc-os5GF33Dkh6nok8fANZw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 28 Oct 2021 20:52:27 +0200
Message-ID: <CAHUa44H++gHiiWMssT_G+tR1z1FnDjn7j+-5xC6rXCZHbWd7=g@mail.gmail.com>
Subject: Re: [PATCH][next] optee: Fix spelling mistake "reclain" -> "reclaim"
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Colin Ian King <colin.i.king@googlemail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Sat, 23 Oct 2021 at 17:22, Colin Ian King
> <colin.i.king@googlemail.com> wrote:
> >
> > There are spelling mistakes in pr_err error messages. Fix them.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens
