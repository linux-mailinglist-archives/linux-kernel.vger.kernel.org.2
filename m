Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAA32D498
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbhCDNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbhCDNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:51:13 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5503FC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 05:50:33 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z65so12247739vsz.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuj7PrrpTUGz6W6b+3LSWHrJMrhRSHgCKv4axOnp68A=;
        b=zkoV0/hJBCXr3hS9sIJVhnnxQzzfcseN453Du+BSX3NKMq/sEQUel/sgBOZUAnXoIL
         gJiyeeziPYCIxJQlyWGlgycgsb6PxUZpWYwvxGFCioOfZgYbnqzbgUyboNPWBSssbbWw
         ny33lLNgZO+oRrt9h1ss29rjEVoo0A2/u6UtF9KGFp73rdEGWnZugdgT+s2ckLlqBa2P
         8YHzjD16VDVcTl58m1+GyAM4YUSPXR8c02dVIrEw/7ZAbdYB6TBWyrEbVIU95UJvxf3t
         I+7wEflKW+olGkIyBnENPAVqQERQATH95QvIMh8QdNkAtqMWLejv/8EOlqw1sL5rw+Lx
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuj7PrrpTUGz6W6b+3LSWHrJMrhRSHgCKv4axOnp68A=;
        b=kyi9dy1MolZ5hRgN7A0GfdQivfmE9Tt+vjRL0yfAV+3vlH4IJHAZpp78YgjQVZ3n9w
         /KgGrR5qbJE77Dq5wk3kcpbfHsUg3mWQS5BXQa7TzpBJjZcBgerNaFJS13R5jlvBmH4m
         B/E6WbgFJYcbSDTpE9GLIAz4wpfr1sxDF4bmyNGAtLsIT+sg36vdIldNXuU4lypJmPHD
         QqoHMV9HhVcml8dFoFAgOAhIAKejubPFVS0vax+7HaX58yixqZvhSZl3X4KDSooyCZYB
         /C1J2z/0BfRUTVC/V2OZ3Z1fjh7PXhooMhVMmZ+KPhyk6Tm8HHUr49Zf4qYwUOC46NbJ
         GLqQ==
X-Gm-Message-State: AOAM5338LyrN6sHlpWpcPlpFn2unuL+uxsX0yK3yKEyWD4XbjOtU/Xqd
        6SLOCcjhstIa4cAkAisFmf1skRnU3azLbQXE1c3dDA==
X-Google-Smtp-Source: ABdhPJwAc1wO/KSW/CPaJgowVTMaXIAiHRBU7RsSYpC0VdVPy1G60E9AZZMaeX+wsYX2NmTRbAq8x9H/MV6CDweQt3k=
X-Received: by 2002:a67:c787:: with SMTP id t7mr2666358vsk.48.1614865832499;
 Thu, 04 Mar 2021 05:50:32 -0800 (PST)
MIME-Version: 1.0
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
In-Reply-To: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 14:49:55 +0100
Message-ID: <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
To:     Pradeep P V K <pragalla@qti.qualcomm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <pragalla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com> wrote:
>
> From: Pradeep P V K <pragalla@codeaurora.org>
>
> For data read commands, SDHC may initiate data transfers even before it
> completely process the command response. In case command itself fails,
> driver un-maps the memory associated with data transfer but this memory
> can still be accessed by SDHC for the already initiated data transfer.
> This scenario can lead to un-mapped memory access error.
>
> To avoid this scenario, reset SDHC (when command fails) prior to
> un-mapping memory. Resetting SDHC ensures that all in-flight data
> transfers are either aborted or completed. So we don't run into this
> scenario.
>
> Swap the reset, un-map steps sequence in sdhci_request_done().
>
> Changes since V1:
> - Added an empty line and fixed the comment style.
> - Retained the Acked-by signoff.
>
> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Seems like it might be a good idea to tag this for stable? I did that,
but awaiting for your confirmation.

So, applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 60 +++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 646823d..130fd2d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct sdhci_host *host)
>         }
>
>         /*
> +        * The controller needs a reset of internal state machines
> +        * upon error conditions.
> +        */
> +       if (sdhci_needs_reset(host, mrq)) {
> +               /*
> +                * Do not finish until command and data lines are available for
> +                * reset. Note there can only be one other mrq, so it cannot
> +                * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> +                * would both be null.
> +                */
> +               if (host->cmd || host->data_cmd) {
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       return true;
> +               }
> +
> +               /* Some controllers need this kick or reset won't work here */
> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> +                       /* This is to force an update */
> +                       host->ops->set_clock(host, host->clock);
> +
> +               /*
> +                * Spec says we should do both at the same time, but Ricoh
> +                * controllers do not like that.
> +                */
> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
> +
> +               host->pending_reset = false;
> +       }
> +
> +       /*
>          * Always unmap the data buffers if they were mapped by
>          * sdhci_prepare_data() whenever we finish with a request.
>          * This avoids leaking DMA mappings on error.
> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
>                 }
>         }
>
> -       /*
> -        * The controller needs a reset of internal state machines
> -        * upon error conditions.
> -        */
> -       if (sdhci_needs_reset(host, mrq)) {
> -               /*
> -                * Do not finish until command and data lines are available for
> -                * reset. Note there can only be one other mrq, so it cannot
> -                * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> -                * would both be null.
> -                */
> -               if (host->cmd || host->data_cmd) {
> -                       spin_unlock_irqrestore(&host->lock, flags);
> -                       return true;
> -               }
> -
> -               /* Some controllers need this kick or reset won't work here */
> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> -                       /* This is to force an update */
> -                       host->ops->set_clock(host, host->clock);
> -
> -               /* Spec says we should do both at the same time, but Ricoh
> -                  controllers do not like that. */
> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> -               host->pending_reset = false;
> -       }
> -
>         host->mrqs_done[i] = NULL;
>
>         spin_unlock_irqrestore(&host->lock, flags);
> --
> 2.7.4
>
