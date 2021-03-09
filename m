Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB04332627
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhCINHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhCINHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:07:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FC126526C;
        Tue,  9 Mar 2021 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615295265;
        bh=SJxEiOx3TaNKk34uWUt1NVcxB+r8JCI6QUSyzU5W+QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGm+kH/FxClHY9fcS3ayyQmvgxq9moor4xfQXUYJIQnkhsyBxF5TU/2yCfOEEmn80
         QS2Z5zfGnXOP+mkYpcGw1artbPXbb4fEi7S3w0JAtVkejxTvRMxg7ELgG7bOL7t41+
         iY5HhTuZ/Z7myr64EgeGgge3DoMYE3it7WRXv6Is=
Date:   Tue, 9 Mar 2021 14:07:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <musamaanjum@gmail.com>
Subject: Re: [PATCH] staging: wfx: remove unused included header files
Message-ID: <YEdzHxR2VOwS8Fr/@kroah.com>
References: <20210211143637.GA177425@LEGION>
 <1722736.fQpYkz0vEs@pc-42>
 <5120192.kWiexivLR2@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5120192.kWiexivLR2@pc-42>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:43:45AM +0100, Jérôme Pouiller wrote:
> Hello Greg,
> 
> On Tuesday 2 March 2021 16:01:25 CET Jérôme Pouiller wrote:
> > Hello Muhammad,
> > 
> > Sorry, I am a bit late for the review of this patch. Thank you for your 
> > contribution.
> > 
> > On Thursday 11 February 2021 15:36:37 CET Muhammad Usama Anjum wrote:
> > > 
> > > Many header files have been included, but never used. Those header
> > > files have been removed.
> > > 
> > > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > > ---
> > >  drivers/staging/wfx/bh.c              | 1 -
> > >  drivers/staging/wfx/bh.h              | 4 ----
> > >  drivers/staging/wfx/bus.h             | 3 ---
> > >  drivers/staging/wfx/bus_sdio.c        | 6 ------
> > >  drivers/staging/wfx/bus_spi.c         | 7 -------
> > >  drivers/staging/wfx/data_rx.c         | 5 -----
> > >  drivers/staging/wfx/data_tx.c         | 5 -----
> > >  drivers/staging/wfx/data_tx.h         | 3 ---
> > >  drivers/staging/wfx/debug.c           | 6 ------
> > >  drivers/staging/wfx/fwio.c            | 2 --
> > >  drivers/staging/wfx/hif_api_cmd.h     | 4 ----
> > >  drivers/staging/wfx/hif_api_general.h | 9 ---------
> > >  drivers/staging/wfx/hif_tx.c          | 4 ----
> > >  drivers/staging/wfx/hif_tx_mib.c      | 5 -----
> > >  drivers/staging/wfx/hwio.c            | 3 ---
> > >  drivers/staging/wfx/hwio.h            | 2 --
> > >  drivers/staging/wfx/key.c             | 2 --
> > >  drivers/staging/wfx/key.h             | 2 --
> > >  drivers/staging/wfx/main.c            | 7 -------
> > >  drivers/staging/wfx/main.h            | 3 ---
> > >  drivers/staging/wfx/queue.c           | 4 ----
> > >  drivers/staging/wfx/queue.h           | 3 ---
> > >  drivers/staging/wfx/scan.h            | 2 --
> > >  drivers/staging/wfx/sta.c             | 6 ------
> > >  drivers/staging/wfx/sta.h             | 2 --
> > >  drivers/staging/wfx/traces.h          | 3 ---
> > >  drivers/staging/wfx/wfx.h             | 3 ---
> > >  27 files changed, 106 deletions(-)
> > > 
> > > diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
> > > index ed53d0b45592..cd6bcfdfbe9a 100644
> > > --- a/drivers/staging/wfx/bh.c
> > > +++ b/drivers/staging/wfx/bh.c
> > > @@ -5,7 +5,6 @@
> > >   * Copyright (c) 2017-2020, Silicon Laboratories, Inc.
> > >   * Copyright (c) 2010, ST-Ericsson
> > >   */
> > > -#include <linux/gpio/consumer.h>
> > >  #include <net/mac80211.h>
> > 
> > Though bh.c refers to gpiod_set_value_cansleep()
> > 
> > 
> > >  #include "bh.h"
> > > diff --git a/drivers/staging/wfx/bh.h b/drivers/staging/wfx/bh.h
> > > index 78c49329e22a..92ef3298d4ac 100644
> > > --- a/drivers/staging/wfx/bh.h
> > > +++ b/drivers/staging/wfx/bh.h
> > > @@ -8,10 +8,6 @@
> > >  #ifndef WFX_BH_H
> > >  #define WFX_BH_H
> > > 
> > > -#include <linux/atomic.h>
> > > -#include <linux/wait.h>
> > > -#include <linux/workqueue.h>
> > > -
> > >  struct wfx_dev;
> > > 
> > >  struct wfx_hif {
> > 
> > Ditto, bh.h refers to atomic_t, struct work_struct and struct 
> > completion. If you try to compile bh.h alone (with something like
> > gcc -xc .../bh.h) it won't work.
> > 
> > Maybe it works now because we are lucky in the order the headers are 
> > included, but I think it is not sufficient.
> > 
> > [... same problem repeats multiple times in the following ...]
> > 
> 
> Greg, if nobody has any opinion on that, I think that this patch should
> be reverted.

Nothing is breaking, why should it be reverted?

You never build a .h file alone :)

Anyway, sure, I'll revert it, what is the commit id?

thanks,

greg k-h
