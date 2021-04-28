Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071CB36DFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhD1TvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhD1TvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 15:51:16 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35BEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:50:29 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k19so19392443vsg.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGs3Xn4h7d3KwRkcztrCcHHpShGB58oYg5f2pA6W7K8=;
        b=gCNQA1zWtRpqyw7aHxQutTv3O6Hc6CnaSdbi6P7k1HTlSfZ7OsE1R9lGPCaZtG163u
         3YZByw9iW0ZHM0OoZ5IXn4HZqG6WYu+aOtcq7sLzSlbnhgqGTHgOPcvhyfBSRTyhXAtO
         TzcFMD0KoElGNwHp7iaApPYAuEAv184a8O6bRQYB/5t1FMOpecB9Q5WAMhQJeGFChSr+
         +Fnz1aJYaXNvWWZgWTxW3WcRyrlBZ1wqN6g8Wn++bJgSI5v8jdGY4rzGBUgK5VflSjn1
         J6WaGofhvHxvtqQaYPH0ujJeZISiCSqbW2DB32wOCIjqmCV1hwM/vDrk2XADF6ldMDY5
         yAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGs3Xn4h7d3KwRkcztrCcHHpShGB58oYg5f2pA6W7K8=;
        b=TurVZlLHEXDvL4g3Ea2dEW3J7Wn9yzEfqF4vhWIzDno9NLutisbgLNZKHrlBgTTpmA
         Hyc3AqsCN/oju3m5NkS0dFmCZsSirrwhXoDAX+OnqD/IlWZoryxB18NHrGeG0UFdvNvz
         0j2YDQugYHG4iRpI1oYB30wiw+WC4O1favN0FvTEbYjVrXUl4dsL//odyUUTAaR9FCI/
         NCs5KIVKEXVUJ0u1h0us8cX6gsVWi8zA9Qp5IoyoUa7LJKtoznZ41TU6fo0y2AzRAWZ4
         4F2AWxAz4zspmOogpZ201HprijO2M0fJdnDI7ScdKUgfgDAAqVkQdAOKMGxrHlhFY0+p
         yC1Q==
X-Gm-Message-State: AOAM531vRj2chEug3a3S2pODB2wdPTsDnP6gYwfh26NYZy3KxNaUs5x0
        eAPyEnShLpsRAHuW6SlVQFnGLx4++7LQKgt3C5A=
X-Google-Smtp-Source: ABdhPJytbj+ReKQzomXZ89rU/+Dll3fJXFqucKN4RiLw+s0ueUOViXemYQ0gdAX1KyKUrEKf+9dde0NOmzjqSQ7IPtM=
X-Received: by 2002:a67:cb0c:: with SMTP id b12mr27093572vsl.16.1619639428948;
 Wed, 28 Apr 2021 12:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-169-gregkh@linuxfoundation.org> <YIglHlva+jlFmItZ@kroah.com>
 <20210428105004.GA21092@shell.armlinux.org.uk>
In-Reply-To: <20210428105004.GA21092@shell.armlinux.org.uk>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 28 Apr 2021 12:50:16 -0700
Message-ID: <CAKdAkRRw9RVCpasnB7hzAjW7gKQOuud-YWXgj281zrO0ri=AyQ@mail.gmail.com>
Subject: Re: [PATCH 168/190] Revert "net: marvell: fix a missing check of acpi_match_device"
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 6:47 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Apr 27, 2021 at 04:52:14PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 03:00:43PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 92ee77d148bf06d8c52664be4d1b862583fd5c0e.
> > >
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > >
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > >
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > index 1767c60056c5..f1a70b37227f 100644
> > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > @@ -7328,8 +7328,6 @@ static int mvpp2_probe(struct platform_device *pdev)
> > >     if (has_acpi_companion(&pdev->dev)) {
> > >             acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > >                                         &pdev->dev);
> > > -           if (!acpi_id)
> > > -                   return -EINVAL;
> > >             priv->hw_version = (unsigned long)acpi_id->driver_data;
> > >     } else {
> > >             priv->hw_version =
> > > --
> > > 2.31.1
> > >
> >
> > The original commit here looks correct, so I'll drop this revert.
>
> Agreed, the original patch looks fine to me and the revert is
> unnecessary.

I wonder how useful these kinds of patches/checks are. If we are
dealing with ACPI platform device we must have matched on ACPI node
before getting into the probe, so we would match here as well. The
exception would be someone playing with "driver_override" device
attribute, but that someone must be root as therefore have many
options of shooting themselves into foot. So I guess the question is:
do we need to bloat the code with such checks?

Thanks.

-- 
Dmitry
