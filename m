Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82308375420
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhEFMwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhEFMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:52:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E3DC061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:51:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v5so6867252ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leGIz44I+FDaJitpl6Hc4zICX3i8IZYPExD5nafIx0I=;
        b=DX3KA16LeSsMsghPZH82/XQtNlVzAV9W69bzaPNrsqbVgiv1x4Zll52FF33UWdCqmx
         v61tH7eAe02qtR/+yfjvmAMhlpDhREKXiZAhMUuPkwQJSKa9P5MtAeCkSK1Uc7IwONt1
         odhHvegaJCLPAsU+pJvsoUUxD5HjOHNAqTwmAPunac40efQGQrqLxmVG48bEFXmE94rW
         oHZCKurLE6RHJ+h/+FBacZzZ1CLvgVdyhs+D3f6lLo+ggKwt5TEeF/ImX+Jm/NRK1Fko
         4sNelfCaGh6qDCKy7HdaHxVn9LvJdUFQixA5BPwe9Gm0/jyPJHkg+j8Au7I2ZHcpcWKo
         z/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leGIz44I+FDaJitpl6Hc4zICX3i8IZYPExD5nafIx0I=;
        b=m+BDyfEHO4RJKMoz/2Te9opP4xz/ID8pxhf55okBfRqjCKZ5ljpzVpSfSSX5hA8MBv
         pgU8HJRaD2D1RD4XaDpuAeG/wWtJjNG7mzHp8i4DVQbV4aiEowmebrl8I0HuM/9KnZm/
         7PnZh6bnDvT33Ide9nwX7KkbbxYTJJA7bdNUYDDnU08YQzsL6LGyVZ3UrNulou3Z8MGE
         6bpiANFVpf+Rh0hyzlKTNtdOc8mwzPf8el8NckngOoiEGmpQK6/ierCm65gwmzuyCiPR
         CFQsKao5t9/hWUp8KbTjV/RSx3zNYGYpOhpJGUayaiFhiUhl8b/X78/F9YpT44kNs5zK
         Fd2g==
X-Gm-Message-State: AOAM532O7TxL4k04h2tah5VxoWh3rptY/4gV08A8Ga2mr0XK4+w9XpRb
        G9Nwn1Bno6P0arsxFTYPCtkQAYvZXiWAJS/t44H94g==
X-Google-Smtp-Source: ABdhPJwMpyg958RS71r2sEro18tQ0KNQqZLWBMMdyKHnmvXWnfmEhJ4zFsnA6TFQW0FHx+ilUWptjsL9/CwbB0ZZ0Fk=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr3250389ljn.326.1620305507437;
 Thu, 06 May 2021 05:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-3-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-3-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:51:35 +0200
Message-ID: <CACRpkdYf+ak=4S0FFQ2zKRTXd7rWMPcvPnrrdtdpVnEJHuiTYQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY
 for eMMC HPI commands
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In mmc_send_hpi_cmd() the host->max_busy_timeout is being validated towards
> the timeout for the eMMC HPI command, as to decide whether an R1 or R1B
> response should be used.
>
> Although, it has turned out the some host can't cope with that conversion,
> but needs R1B, which means MMC_CAP_NEED_RSP_BUSY is set for them. Let's
> take this into account, via using the common mmc_prepare_busy_cmd() when
> doing the validation, which also avoids some open coding.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
