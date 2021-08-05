Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F703E1501
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbhHEMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241470AbhHEMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D76F5601FC;
        Thu,  5 Aug 2021 12:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628167591;
        bh=Mn/G0KCkUMAJFwHK0RFSgD6IFurZnc/p5na5NyaXLjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulhTEQGa9uWD4LYg1sl9gveYCt+jx8wegvx7A0EOUFxsNBEpBvN9XDOiJBJxUPk42
         OAThkChfsiwV5Pg7XdQuVeHXwgkUTeKhlIknzl3iN6CKR7WS74VLx4x1Z7TDtn0fTS
         vwSZQvMcePdZMmdUOGRukAy8tA7bv8AswLhTaOxo=
Date:   Thu, 5 Aug 2021 14:46:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH 00/15] staging: r8188eu: remove core dir RT_TRACE calls
Message-ID: <YQvdpUzKztxFNlvb@kroah.com>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
 <YQvAyd2meIE8btpR@kroah.com>
 <CAA=Fs0mViTb_vys9t1DKhFW-1fXxhLRuJM8o=BWqT6MrY9BXsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0mViTb_vys9t1DKhFW-1fXxhLRuJM8o=BWqT6MrY9BXsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 01:37:06PM +0100, Phillip Potter wrote:
> On Thu, 5 Aug 2021 at 11:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Aug 01, 2021 at 08:04:22PM +0100, Phillip Potter wrote:
> > > This series removes all RT_TRACE calls from code within the core directory.
> > >
> > > Phillip Potter (15):
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
> > >   staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c
> >
> > I applied the patches here that I could, others conflicted with other
> > changes I have taken recently.  Can you rebase and resend the remaining
> > ones now?
> >
> > thanks,
> >
> > greg k-h
> 
> Dear Greg,
> 
> Many thanks, and of course - will be this evening though after work
> though (BST). Hope that's ok.

Sure, no rush, we have no deadlines here :)

thanks,

greg k-h
