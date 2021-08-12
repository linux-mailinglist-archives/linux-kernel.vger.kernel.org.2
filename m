Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E883EA091
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhHLI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233921AbhHLI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 644CF60ED5;
        Thu, 12 Aug 2021 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628756946;
        bh=JmDhK/O0WarpMdFoht/4Q7QRw6nH4T8doZNtHTkGDII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KePAO3vSr++lNFtSFxYmEx9Xu2pzuQg0wZlmgOlDFURmV0Cpm6tduqx6ACqkqt982
         3yGNoOlrGN907s1aDrH191CnlTxBLT1c9K+h6NA1FTIb88GCtzDWJN8F95+855xGpx
         H/ePx6G4bWj5Dgt5MkZbGsvut77AHRWJQNP+I4s0=
Date:   Thu, 12 Aug 2021 10:29:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: Remove all 5GHz network types
Message-ID: <YRTb0PaPY8BpQ4JO@kroah.com>
References: <20210812002519.23678-1-fmdefrancesco@gmail.com>
 <20210812002519.23678-2-fmdefrancesco@gmail.com>
 <13cdcd41-20f6-3b8e-0515-5066b1fdb49c@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13cdcd41-20f6-3b8e-0515-5066b1fdb49c@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 09:09:49PM -0500, Larry Finger wrote:
> On 8/11/21 7:25 PM, Fabio M. De Francesco wrote:
> > Remove all 5Ghz network types. r8188eu works on
> > 802.11bgn standards and on 2.4Ghz band.
> > 
> > Signed-off-by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_ap.c         | 13 ++---------
> >   drivers/staging/r8188eu/core/rtw_ieee80211.c  | 19 +++------------
> >   drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
> >   drivers/staging/r8188eu/core/rtw_mlme.c       | 10 --------
> >   drivers/staging/r8188eu/core/rtw_p2p.c        |  2 +-
> >   drivers/staging/r8188eu/core/rtw_wlan_util.c  | 15 ++----------
> >   drivers/staging/r8188eu/hal/odm.c             |  1 -
> >   drivers/staging/r8188eu/include/ieee80211.h   | 23 ++-----------------
> >   drivers/staging/r8188eu/include/wifi.h        |  2 +-
> >   drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
> >   10 files changed, 13 insertions(+), 76 deletions(-)
> 
> Fabio,
> 
> This patch is fine, but it does conflict with my series fixing the smatch
> warnings. Whichever set Greg takes first will apply cleanly, but the second
> will fail. This problem is due to many people working at the same time.
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

I worked it out and took both series, git is good at handling merge
issues like this :)

thanks,

greg k-h
