Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA136958F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242768AbhDWPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhDWPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:05:42 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02968C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:05:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id m16so35945860qtx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVfcpr7bRZ6s3YruMjp8qVrxCIDgGdMtl+A9Aczl7R4=;
        b=OmkoAWs02RMbBHLvV9IRy4MYyPogzVzCe/IRTZBe8Q8RQor+AxWdLtkaXkkm4yrXYF
         yGeG9sWF2Ccr+0PFhaZ4Mh24QEurXCZ2iWDjymdhirsl2s05BCzWjakOwWgzHz0B3Alv
         lFv4NZEY+l3uzW+HSGZ8PZOJcYNSDhfomjBjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVfcpr7bRZ6s3YruMjp8qVrxCIDgGdMtl+A9Aczl7R4=;
        b=spEUK34Sgf8TgN6Hwk5ZH11wAh2sJNltEoyYAvAuH8DNNOosszn82i4Bwck25pnqxa
         d09FgETzZtPg5pUTrDjPkR987fy7MV5DTg3DwwU+GPaZbtfr4SEsrq3TpI7LN2Q13Jee
         PoXn2LYyiVuUS2AxoYkGLP9/csd7VoS11R/GD4QS6rOJoaYHcWuRzTk0SQOvh6HkQhgp
         +X2P7rYH0YSwKcnFRf8gCE3edx72rH5EpskUFj4qLu2805EdYS6EwAXurpVUcNMc1j7A
         +ni9MN8wCfNccXejHIFwOyrp6tAAXqw099D7UIbiV/EL2KtXnR15JV5C26qT+sNQzGvC
         BN2A==
X-Gm-Message-State: AOAM530kcJ05OlK50GFlaU9BZYJFLCgr7VYbnay/ilGcTC8xJI6by6+G
        neS/m6ajlvvMBkuruy+FdddUShrXZrdl7w==
X-Google-Smtp-Source: ABdhPJzwC5S09vqUxOnAHyzhHbVRGSFp2QRsAAtywyXpFqQW8b2y6Gc2YTqUKG9IrQx4oI9GBWMi+g==
X-Received: by 2002:a05:622a:2cd:: with SMTP id a13mr4303915qtx.226.1619190303118;
        Fri, 23 Apr 2021 08:05:03 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y9sm4352555qkm.19.2021.04.23.08.05.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 08:05:02 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y2so53888775ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 08:05:02 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr6500819ybb.257.1619190302321;
 Fri, 23 Apr 2021 08:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <1619161503-8784-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1619161503-8784-1-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Apr 2021 08:04:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VN+iP85D6dkEDE=C7Z9rX_-mQXU-u-Jo_5=s46tZcq0Q@mail.gmail.com>
Message-ID: <CAD=FV=VN+iP85D6dkEDE=C7Z9rX_-mQXU-u-Jo_5=s46tZcq0Q@mail.gmail.com>
Subject: Re: [PATCH] nvmem: qfprom: minor nit fixes, no functional change
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 23, 2021 at 12:05 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Fix a missed newline, and update a comment which is stale
> after the merge of '5a1bea2a: nvmem: qfprom: Add support for fuse
> blowing on sc7280'
> No other functional change in this patch.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> Sending a follow-up patch for these nits since they came in after
> the previous patch was already pulled in
> https://lore.kernel.org/patchwork/patch/1401964/
>
>  drivers/nvmem/qfprom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index d6d3f24..b7d2060 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -122,6 +122,7 @@ static const struct qfprom_soc_compatible_data sc7280_qfprom = {
>         .keepout = sc7280_qfprom_keepout,
>         .nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
>  };
> +
>  /**
>   * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
>   * @priv: Our driver data.
> @@ -195,7 +196,7 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
>         }
>
>         /*
> -        * Hardware requires 1.8V min for fuse blowing; this may be
> +        * Hardware requires a min voltage for fuse blowing; this may be
>          * a rail shared do don't specify a max--regulator constraints
>          * will handle.
>          */

Thanks for sending these! Is there a reason you didn't do the "else
if" change too?

-Doug
