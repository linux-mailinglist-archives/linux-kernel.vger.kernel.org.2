Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21D32D949
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhCDSKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhCDSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:09:57 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45BC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:09:17 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id p123so15068162vsp.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wm+y856/FEFQ1e35KnxFw2YAIiTFgOMKJrDML+IDxE=;
        b=Di0tAVlQ3YEt8EKPx7Hgz0fG1B3NVCfjPp4ZvTH2wlFQC2s8ry+u2bOdn5Vdm3Apov
         kEAjpYqM5S8agUmR1KrTEauU+sLsPgTN3dgp84qz8xHeKH8aJAyT0LEaUe2Ig3VwBB/A
         tfWeEPsGf5B2lFmnrZzhcInieZszJweqAZCt8jHSYl01dFbF0v1uBeY2UIcvhUgDoAcA
         UgJF94/hzwVHSDeT8lw5iU4DGPCgQ/ydJpdADjG+lHCmBRIoNV8YpLjdz/5+W+IpPkqR
         xyAVmihHVikQr27YiCEXryuM9mbG9Ei4iaMD6yK3FvIBmwbc4wGYQl8YCaEyMKgnSnpu
         b4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wm+y856/FEFQ1e35KnxFw2YAIiTFgOMKJrDML+IDxE=;
        b=pTOvdzZkgP7q8mb3RJj+HmFf6CnZjrvazH2peDlfFBXrDzXHEGHuDNpDBT/ijcW0tP
         Is/mzztUq3KW9evJo/oywkQbEwP+gTHfpEZztC7lGXSbFfkmgE3XZQMSRt0ujm6XYY81
         I7KE4D20YLpZSzXO8VMSvow7ubYmVcK5RFkSZytR2im47zWkc0W6KF0bFWYKI0qjtCR0
         3TJBNPiINugS2mPBGTYIX3y3/iKYDOsfCLdQAgOJyGsffWAV7KHRRKeO3BGu3CiFKE5N
         CUBsv70ysU5q1sFyxle6jN9vPCShiVexqr424Hp6pxUxLy8W/zQHXsTp/D+KhxUiUDcb
         gy5w==
X-Gm-Message-State: AOAM532XSHYGoLXtUlwmNktjKc0b5fo2B5sDioLAhhLZxr7b6hs0f68i
        LsDIRW13RcZLNxbcTMlUThZV6AWbwaNo0AbcOUASTw==
X-Google-Smtp-Source: ABdhPJyWGWmkBQ2Jx35VWGQm63T9M353cU7X+gHZzwBZ1z3mxrW+bkrVPrdQM4lbq0CH29K67mcKZZsSRElyafGrRxk=
X-Received: by 2002:a67:c787:: with SMTP id t7mr3952276vsk.48.1614881356015;
 Thu, 04 Mar 2021 10:09:16 -0800 (PST)
MIME-Version: 1.0
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com> <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
In-Reply-To: <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 19:08:39 +0100
Message-ID: <CAPDyKFrTHiZyVAsP5TR5evOdbSi4dS_c+k5u6rdA4UwhAc6YuA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
To:     Pradeep P V K <pragalla@codeaurora.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 16:16, <pragalla@codeaurora.org> wrote:
>
> On 2021-03-04 19:19, Ulf Hansson wrote:
> > On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com>
> > wrote:
> >>
> >> From: Pradeep P V K <pragalla@codeaurora.org>
> >>
> >> For data read commands, SDHC may initiate data transfers even before
> >> it
> >> completely process the command response. In case command itself fails,
> >> driver un-maps the memory associated with data transfer but this
> >> memory
> >> can still be accessed by SDHC for the already initiated data transfer.
> >> This scenario can lead to un-mapped memory access error.
> >>
> >> To avoid this scenario, reset SDHC (when command fails) prior to
> >> un-mapping memory. Resetting SDHC ensures that all in-flight data
> >> transfers are either aborted or completed. So we don't run into this
> >> scenario.
> >>
> >> Swap the reset, un-map steps sequence in sdhci_request_done().
> >>
> >> Changes since V1:
> >> - Added an empty line and fixed the comment style.
> >> - Retained the Acked-by signoff.
> >>
> >> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Hi Uffe,
> >
> > Seems like it might be a good idea to tag this for stable? I did that,
> > but awaiting for your confirmation.
> >
> Yes, this fix is applicable for all stable starting from 4.9 (n/a for
> 4.4).
> Kindly go ahead.
>
> > So, applied for next, thanks!
> >
> > Kind regards
> > Uffe
> >
> Thanks and Regards,
> Pradeep

Thanks for confirming, I have updated the stable tag.

Kind regards
Uffe

>
> >
> >> ---
> >>  drivers/mmc/host/sdhci.c | 60
> >> +++++++++++++++++++++++++-----------------------
> >>  1 file changed, 31 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 646823d..130fd2d 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct
> >> sdhci_host *host)
> >>         }
> >>
> >>         /*
> >> +        * The controller needs a reset of internal state machines
> >> +        * upon error conditions.
> >> +        */
> >> +       if (sdhci_needs_reset(host, mrq)) {
> >> +               /*
> >> +                * Do not finish until command and data lines are
> >> available for
> >> +                * reset. Note there can only be one other mrq, so it
> >> cannot
> >> +                * also be in mrqs_done, otherwise host->cmd and
> >> host->data_cmd
> >> +                * would both be null.
> >> +                */
> >> +               if (host->cmd || host->data_cmd) {
> >> +                       spin_unlock_irqrestore(&host->lock, flags);
> >> +                       return true;
> >> +               }
> >> +
> >> +               /* Some controllers need this kick or reset won't work
> >> here */
> >> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> >> +                       /* This is to force an update */
> >> +                       host->ops->set_clock(host, host->clock);
> >> +
> >> +               /*
> >> +                * Spec says we should do both at the same time, but
> >> Ricoh
> >> +                * controllers do not like that.
> >> +                */
> >> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
> >> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
> >> +
> >> +               host->pending_reset = false;
> >> +       }
> >> +
> >> +       /*
> >>          * Always unmap the data buffers if they were mapped by
> >>          * sdhci_prepare_data() whenever we finish with a request.
> >>          * This avoids leaking DMA mappings on error.
> >> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct
> >> sdhci_host *host)
> >>                 }
> >>         }
> >>
> >> -       /*
> >> -        * The controller needs a reset of internal state machines
> >> -        * upon error conditions.
> >> -        */
> >> -       if (sdhci_needs_reset(host, mrq)) {
> >> -               /*
> >> -                * Do not finish until command and data lines are
> >> available for
> >> -                * reset. Note there can only be one other mrq, so it
> >> cannot
> >> -                * also be in mrqs_done, otherwise host->cmd and
> >> host->data_cmd
> >> -                * would both be null.
> >> -                */
> >> -               if (host->cmd || host->data_cmd) {
> >> -                       spin_unlock_irqrestore(&host->lock, flags);
> >> -                       return true;
> >> -               }
> >> -
> >> -               /* Some controllers need this kick or reset won't work
> >> here */
> >> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> >> -                       /* This is to force an update */
> >> -                       host->ops->set_clock(host, host->clock);
> >> -
> >> -               /* Spec says we should do both at the same time, but
> >> Ricoh
> >> -                  controllers do not like that. */
> >> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
> >> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
> >> -
> >> -               host->pending_reset = false;
> >> -       }
> >> -
> >>         host->mrqs_done[i] = NULL;
> >>
> >>         spin_unlock_irqrestore(&host->lock, flags);
> >> --
> >> 2.7.4
> >>
