Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6733218B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCIJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCIJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:02:38 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5295C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 01:02:37 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id q1so3449845vsq.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mOjqeg59DhCO1NJGI6CFwmiKdDTe7R83FJmZUTJAeo=;
        b=w5apAR8EPMmNag6YyvemjSWjfJ/hnuEzTl5B8SExhz9x6nxXaAWGmiD64JgsQWoumy
         7JG3vyMhDaVAkSG4PBYKCkG6cO7GC9bc+BF6DHF6IFMom7Gkfaho+c5V6sOrSxw9nMTQ
         n63L0ZeZvPLCW66Ey23loYenxIA9d36dFgeJ1IGVMUgzPbCIpk7DsjVJG+4RCtx/aLOj
         YmYfjCIEm5SsqTClmZ2ScoSC1xXv3zpf+yfUHtelpqyQquK0cvB+gmpjfGxqi1YlwoPs
         eSlypjinXfyskMIRp19oz+CDBPJLFhUgvt25l1cqNHHYEchSk3bWrCKOu17iljE4Kmkm
         TO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mOjqeg59DhCO1NJGI6CFwmiKdDTe7R83FJmZUTJAeo=;
        b=RKDNDWg+iIlJ1vNxPsxSUOQK3yxNR1BHAUaRofFhhvdd2LNyrbEkxDmskY9YmLTFUP
         V0Zs9UDF9mLRuTZGZmy3DIyuBg4piI+HlEtfwjX12ntl33r/5Hhzri9hwP3IC+nZIejC
         qupCo2O63UaAZZo0kel0QzMCR1/pr56nkMtlv2dj82+5d35eWv/wvln/JQeAUBxBkMQt
         V326f9CV1GKIEOaxuQgBg98l9NImGWqbXCikjmQz/xDRzIkrjiniFFd020IdzWwG13LY
         6Kjn8IVEkemC6vqOZuD3kdzuCQSL0IaTiixdzzbablOie64DPwLuoxMOVrUKB5/WlUOt
         s53w==
X-Gm-Message-State: AOAM530cuoAAeRCJZiLaQFm6reNpy1ZMxaf3R3/VLo8kQdM8yWdJnf4d
        wGo8Wg6ElWIKrsiSa2rtA1Ia2sxD8GKLwUq1e+JZOg==
X-Google-Smtp-Source: ABdhPJxGQF7CijfR+scQTuoiyx2kIjHkpuuT+rY7LqsLLG1Lih/s8D2YCemUQD/gJValy8R3oo67L2NoZH3QLfIAV3g=
X-Received: by 2002:a67:6942:: with SMTP id e63mr3815959vsc.48.1615280557135;
 Tue, 09 Mar 2021 01:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1615272478-52458-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1615272478-52458-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:02:00 +0100
Message-ID: <CAPDyKFp67w=vT2VHmtsjc1++HtEfZNyKSo-N1gmdJtB-d62m6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: remove unneeded variable 'ret'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 at 07:48, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/mmc/host/via-sdmmc.c:1274:5-8: Unneeded variable: "ret".
> Return "0" on line 1295
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 4f4c081..a1d0985 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1271,7 +1271,6 @@ static int __maybe_unused via_sd_suspend(struct device *dev)
>  static int __maybe_unused via_sd_resume(struct device *dev)
>  {
>         struct via_crdr_mmc_host *sdhost;
> -       int ret = 0;
>         u8 gatt;
>
>         sdhost = dev_get_drvdata(dev);
> @@ -1292,7 +1291,7 @@ static int __maybe_unused via_sd_resume(struct device *dev)
>         via_restore_pcictrlreg(sdhost);
>         via_init_sdc_pm(sdhost);
>
> -       return ret;
> +       return 0;
>  }
>
>  static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
> --
> 1.8.3.1
>
