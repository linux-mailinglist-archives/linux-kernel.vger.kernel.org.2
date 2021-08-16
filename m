Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85C73ED863
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhHPOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhHPOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB97C0612AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:39 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a8so11020606vsl.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVKCYDMJormPExhpOghf50YWCKd/5uetFN/Swg1y9AE=;
        b=AyTHo3XictXYsNapssdIBh0yZzQanYstNQtAKZWNMZr6nzJYpiDcoZSWw3QJ6phR3B
         LCsQ5XarDg6jvY9Qca0DNKeAT/JoUVIymOTzBxla4hvWsZHUGoqoEPwkAoH7p9HqqwkD
         K2Z4njb+9ewyQjAcb83/noLlRAKiQMVTox4dNTjTppAALsBvMMv+QYvwvwl0s3FNsh3j
         qAEs37ER1l8+Rdr6EgVhQraNEuCKy0G2qU20p1Bk1kk8bGl5G75h0iGqVPx+7dCaxdT0
         97KEmeEn5ht68tETNjQovt5F/BPHifZuUaBs8V8Bpt+LJY4r7GMecWQRnGkmNCAnnwZq
         h0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVKCYDMJormPExhpOghf50YWCKd/5uetFN/Swg1y9AE=;
        b=WJDLEYlehFemrMx99iFfDX885mvqWE95rE0JcZVGZxeelFVwgQr9o0YbauBYBtr3DW
         +5/PeTlYp3dy/gHhz+FFcV1KXXCjjYWn563ob5LZB828c4rXzVxTlhGvDPNqWMOgcJDf
         lYT/v9Dv/argJ1wl/++BBc7uWIdFjT16l6IkEUFdDEOmrke6xMrRqsNy6Zewoa0YLWQ0
         aK2O7jzicVXJHhYTWTQNfXQOqOb3O4jvE95n0tNmswnaL+xUoCDCgh9x+4fJENtr2WQl
         AEV7XkI8sPoYT0/6Y6KexF+flOKtHa2L/UUZMD22a3nXZULy3WyVoQdQ8RfqG1eHQ4CG
         1Tmg==
X-Gm-Message-State: AOAM530hKTC0Vs9yiOPwJ3+bElExNX9k8hgLUivY61meqvVwQTqurcBC
        tpJMg6GkxxswCrzsZtlLwL6cl51OlmGWWirzAKMrEw==
X-Google-Smtp-Source: ABdhPJxH03LCvwF3n7FLPSRhMFmFSVUxkYQal+sImI6ahGhwHnNg4T2E1pse6fPH6Zhe8c/gCWm9o+F4tyfzci6Gr/w=
X-Received: by 2002:a67:3212:: with SMTP id y18mr9746202vsy.19.1629122378196;
 Mon, 16 Aug 2021 06:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <1627534001-17256-2-git-send-email-sartgarg@codeaurora.org> <1628232901-30897-1-git-send-email-sartgarg@codeaurora.org>
In-Reply-To: <1628232901-30897-1-git-send-email-sartgarg@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:02 +0200
Message-ID: <CAPDyKFoxCuKcOtS=J2adqpuXK6ucx5CqYvi5RbAKNr-CjFkcYA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Introduce max_timeout_count in sdhci_host for
 vendor needs
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 at 08:55, Sarthak Garg <sartgarg@codeaurora.org> wrote:
>
> Introduce max_timeout_count in sdhci_host_struct to let vendor's modify
> the max timeout value as per their needs.
>
> Sahitya Tummala (1):
>   mmc: sdhci-msm: Use maximum possible data timeout value
>
> Sarthak Garg (1):
>   mmc: sdhci: Introduce max_timeout_count variable in sdhci_host
>
>  drivers/mmc/host/sdhci-msm.c |  3 +++
>  drivers/mmc/host/sdhci.c     | 16 +++++++++-------
>  drivers/mmc/host/sdhci.h     |  1 +
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
