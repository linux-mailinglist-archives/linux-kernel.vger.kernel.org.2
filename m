Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE75367BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhDVIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhDVIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:09:56 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:09:22 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id p9so4537025vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dRorhBRBupMWkMDP6EM60xNwydzzEGxlsnLVQTun1o=;
        b=RKB9f2ND+hV1bVeWMFqToe8bfMl5YMyzveLvQmSlXyRMS2pF1qUGDwkdaUlR+e2fpC
         ZCnQUfL8tFbgH/yU/BM+choqMgeqKMPw4Mnqo4+NVASEN4mnwsEVZNt2Xg6fIZhwlE+v
         F5ULFXQuuIHD/pAP7tC47GnzL6cwYUB8Iz14hmW4D0f4fsL/nnGXORY61B5HImZytQ2A
         9tOVh5XukLFRBfoOJxs7eRvWRuPXfvR0Kfuk7XtT0IHvmf2HoMfw20dUOaDTT9XCHho1
         PJ6IFKO9weBySiSiHNk/gVD0HI8QPreWAc0l8qff5SU/B++mD4WclwIPA/SLsnqVzyzh
         oX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dRorhBRBupMWkMDP6EM60xNwydzzEGxlsnLVQTun1o=;
        b=UjeCGCQ3R175IydDDJv8ShDPFOI4FpzXeynOWQt9IMOp93oA6pTQMm7FTOr+EdbyIY
         QabG2WtJ4DzD1oR1aPoNr0AH87gPcS7Mh1abui4Z9XYcudAPVKP5el2TWVf9MFMR86lv
         ZjV6zTu3PzDlHB6LOSz8U5Ed8tALYHsoUzQSE8P4EVTXv4u44xzSML0ftjNe13aLQunB
         NJ1BSonOfPaiWsr+BuqCcYZmu1XKPL74jAZax+zVTJWDfq9yp6WVhuil3iynr7c+/9+0
         SH1r2+ka7aQ/+EF9awbCYcQ6M2eQ2Z2fPvUj/v/oX/bvTEMC0LRljmQhjywPMl5fV4MF
         3AoA==
X-Gm-Message-State: AOAM533wgej6009DqtkLNBCuFfMxgkvHLckVp/3QVuRXCSHFIpkB3CGw
        eLaLE//M4MbjhDgF6N0/FtLEolMPkqLEhV0nWFHrXlYJSN8d/zIE
X-Google-Smtp-Source: ABdhPJweWXoCZkeP0+4gsuqmjj0DIy4CoXLzHnIviCuR3+gxIA1pRIXTY3itSnlMB8bthMFbb+iUgsI5zwM/CtGI6Wo=
X-Received: by 2002:a1f:7344:: with SMTP id o65mr1480343vkc.15.1619078961688;
 Thu, 22 Apr 2021 01:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org> <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
In-Reply-To: <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Apr 2021 10:08:45 +0200
Message-ID: <CAPDyKFr9EgTJAujJnQd4USuLZyYbedjZBwLZRh1Cxz+87CharA@mail.gmail.com>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for spi_sync_locked"
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 at 15:19, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Greg,
>
> Thank you for the patch.
>
> On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 611025983b7976df0183390a63a2166411d177f1.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I don't spot an obvious issue with the original patch though.
>
> > ---
> >  drivers/mmc/host/mmc_spi.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> > index 02f4fd26e76a..cc40b050e302 100644
> > --- a/drivers/mmc/host/mmc_spi.c
> > +++ b/drivers/mmc/host/mmc_spi.c
> > @@ -800,10 +800,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
> >       }
> >
> >       status = spi_sync_locked(spi, &host->m);
> > -     if (status < 0) {
> > -             dev_dbg(&spi->dev, "read error %d\n", status);
> > -             return status;
> > -     }

Returning here means we never give back the ownership of the buffer to
the CPU. Can that be considered as vulnerability?

If that is that a problem, I can point out that there is already one
more case in this file, where this pattern is repeated. See
mmc_spi_writeblock(). This code has been there since 2007.

> >
> >       if (host->dma_dev) {
> >               dma_sync_single_for_cpu(host->dma_dev,
>
> --
> Regards,
>
> Laurent Pinchart

Kind regards
Uffe
