Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21EF421A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhJDWpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhJDWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:45:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947AC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:43:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h3so7328935pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bz7HA1WjVk7ZZMMeQxKKx7bsY4ryX5E67hvZXTJeARc=;
        b=oFCTLuXcFBODepFae4kwJDmSGEmfU+1+ZbELVm55/E9TRc1K/dDV2Aoa96zZN3/UWn
         VeNKCiJt7dst1ko2pQIhjjsciCeA5GmOkHj25FXOb49Pc0QCLYyPeFa1wdSohP2gY5Nz
         rVyxUE5fEdWgiKpJz2MT5o+tQnxEBsXrucbLgUCq3jTozc7mraok0zbgrXC19mUN0xRD
         G5ArNJGv+8UuLv2trOSA/lZbYlxLWRQ7sL9M++DyySvkSbIUO1opsoY6KhKjLYxdMGFQ
         H/RBIg6LeEGE4ccgEoyLIwIynC/C/4LjQY+e1BF1u4Mj2AUO7WFBGSeSIjusDkE0RpFT
         K+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bz7HA1WjVk7ZZMMeQxKKx7bsY4ryX5E67hvZXTJeARc=;
        b=3RzgZc5x052EUh4LDiCDgYcDig9Otc+Q33s+ckapurxvt/GeVhNP++A4NEupqrW61w
         EUk5dLGUHnoTi6sYOsorWAkVox4sCibx4qWntcaflN7iyp2L9/8JB5X9eNFpvOdR1T77
         QbKNVwZZ5Y5WO8ZS+RbLUDMsdmZpStkyrc55auooPdab3nPz1+iJXPMy7W+EhRdxCnns
         +pGt0iM2lAAd5GlvJLjsF0AsjX4fZFECYbu/EI4RHQb6NJUdBQEUhDgjYR/MyuTstzt4
         KuUL8VthBOA1i1uVIcNJbzFGiSGYvYM5/YYTQAAzBLnfLEqo5XVdAhDEHnyrNnWRW4ig
         QWOA==
X-Gm-Message-State: AOAM530p8Byag2qQ5QV/B9lJhloIlDGBpJKGyB5vRoR2Jrrsevo7rwOL
        vPT4frgs6xSnRnYlV/jGdX0lsb52/bXosKYUL2LXDQ==
X-Google-Smtp-Source: ABdhPJw7QmjP9qqzm5o5jsptBeeD/mo72caoQezW/0QcRGr4VyICDDcZSjuhBV1WwcQvXDGeKrMjky6FM7stCthHQvg=
X-Received: by 2002:a63:4c1f:: with SMTP id z31mr12996592pga.50.1633387402397;
 Mon, 04 Oct 2021 15:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com> <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
In-Reply-To: <YVVLxi/on9x6nfCZ@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 4 Oct 2021 15:42:46 -0700
Message-ID: <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as removable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dtor@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Dmitry Torokhov

Hi Greg, Oliver,

Thanks for taking a look.

On Wed, Sep 29, 2021 at 10:31 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 29, 2021 at 03:48:23PM -0700, Rajat Jain wrote:
> > If a usb device sits below a removable hub, mark the device also as
> > removable. This helps with devices inserted on a standard removable hub or
> > also thunderbold docks, to be shown as removable.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/usb/core/hub.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
>
> Combined with the previous patch, you are now marking all devices that
> happen to be attached to a root hub that is on a thunderbolt controller
> as removable.  So all USB devices inside of a docking station are now
> removable?

With this patch, yes that was my intent. I think what we are debating
here is should the "removable" attribute imply possibility of removal
from "the system" or just the "local immediate box" (e.g. thunderbolt
dock). In my mind, the removable property was analogous to imply an
"external device", i.e a device that may be removed from the system,
perhaps as a result of its parent devices being removed from the
system. I guess this definition doesn't match what you believe it
should be?

[Oliver says]
> frankly, why? You are needlessly throwing away information about where
> in the tree
> removal can happen.

I believe you are referring to multi level USB hubs and feel that
"removable" should be set only for devices that hang off a port, and
not for children of such device. I wouldn't necessarily disagree,
pending the discussion above (although I think it applies to this
patch only, I think the previous patch still provides value without
throwing away any info).

As a data point, I notice that with my USB hub, the USB device
representing the hub is correctly marked as "removable", however a USB
device I insert into the USB hub, is shown as "unknown". I don't know
if this is the behavior with all USB hubs or just because my USB hub
has a bug. But my patch helps solve this issue and makes the device
show up as "removable".

Thanks

Rajat

>
> What type of devices did you test this series out with?  And again, what
> problem are you trying to solve?



>
> thanks,
>
> greg k-h
