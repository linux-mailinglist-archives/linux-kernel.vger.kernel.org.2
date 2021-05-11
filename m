Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1237A539
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEKK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:57:58 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB22C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:52 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id i5so6206270uap.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1uNin7KdMToK7k5qzR9dcDANP4zzvkct1xdccaJQws=;
        b=Q+zrTlsHYPpOEFR/1lxEQ1xDjGMHj/jHorL6odYvL/qu3iFZfK2dpRHu0G5WcNX5RK
         j3s9a7RHPljllfITPX7T7CcnNcZ7Vms3knS3IpG7Cp4YSIgTuRTxbJ1x6ZlpDfsw1ixw
         AiQZLZa27GTuFKLsWnR6yxFRrozKJv9y7sRnbg+5ouXeE14DdccjtIvHWc4FZr4cAXU9
         +dP32wOJsNd+/1shyrN4pyKTw8gLynAhuHxufYdsua1MUBtbTY7bszfcd+OxtylWOao2
         2AxD69artZaYniDzneJG2qyuZQKknwqGMk1gHJLVjDDFsIc7g2+b2O9hAZhNbN/FLnj9
         KtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1uNin7KdMToK7k5qzR9dcDANP4zzvkct1xdccaJQws=;
        b=Zzw0r5OHQJmjwXwF46yszkr7x+OyQcMCtpp8vdkYVyKR8MOj8Sd8f2+56jkjmrDMpu
         sXlAwcdpae7ThlJkblLPduB8n2RVlJObzCByTT0DRDgl+SoT7HI7WF1MuLocmaLAIq9d
         2NdYIomlmcBRIBQHpNASyGo3Bqssz6ouN1w6PdnlhT9uh6ckv1666gz4ZTKBXYuaHjAV
         R8dYKP3yAFwWHEXukleYwAFoByI6YxZC00Qocbmea9y5MY/ps7uTTAx1rS1pJC3bFKZv
         oX2lC49wIN8AWHsmf9fLvnV3AYNJ6wrG9cVASWtT8kWTBnERY1ystNd3u0x7/muqYNl1
         QboA==
X-Gm-Message-State: AOAM532V5xMzjZ+XdCmSBjyt9N4ngYjrQX//p+ApKGC9s7TOZ44jXl/H
        HRVDcxdxZq6+Blq96rlCEpsrey5Eun0awL/lLXor7w==
X-Google-Smtp-Source: ABdhPJzwusLl8Z0aiFBl2Lqp8RrtcLMyHfRb5ku4ea5ClE3f0h3GFfNnJiYu75fDrZlUzfkMBv2nhhZe1xi57xQY20s=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr24423126uak.19.1620730611370;
 Tue, 11 May 2021 03:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210426175559.3110575-1-narmstrong@baylibre.com>
In-Reply-To: <20210426175559.3110575-1-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:13 +0200
Message-ID: <CAPDyKFrJMFX5ztz6wiWVmwvVF+pms23_+qw8Ey_1pzrHqQ9vRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx: make replace WARN_ONCE with
 dev_warn_once about scatterlist offset alignment
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 at 19:56, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Some drivers like ath10k can sometimg give an sg buffer with an offset whose alignment
> is not compatible with the Amlogic DMA descriptor engine requirements.
>
> Simply replace with dev_warn_once() to inform user this should be fixed to avoid
> degraded performance.
>
> This should be ultimately fixed in ath10k, but since it's only a performance issue
> the warning should be removed.
>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b8b771b643cc..1c61f0f24c09 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -258,7 +258,9 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>         for_each_sg(data->sg, sg, data->sg_len, i) {
>                 /* check for 8 byte alignment */
>                 if (sg->offset % 8) {
> -                       WARN_ONCE(1, "unaligned scatterlist buffer\n");
> +                       dev_warn_once(mmc_dev(mmc),
> +                                     "unaligned sg offset %u, disabling descriptor DMA for transfer\n",
> +                                     sg->offset);
>                         return;
>                 }
>         }
> --
> 2.25.1
>
