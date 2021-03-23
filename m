Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE0345862
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCWHOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhCWHNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:13:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4737619AB;
        Tue, 23 Mar 2021 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616483621;
        bh=oRzZKD3qP85na+2EJ4div7Gjl1JNgZQcRQ9FT53/JKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RV4c6Cv9Z1KhJpnKhJzPHE1a/iCxAf7jdDO7Dn41YnHZkGc46Kd11aR2mvgs6wadt
         EWNm4cAh9tVKboSMdDxFsdKBNP/fQBxeMRQS+pqF60H00oyWOjYZxG40hKyvWFtM6F
         rNroCQSB57mKft3+wPaEF1bn8P+8SX2+sGOkxAik=
Date:   Tue, 23 Mar 2021 08:13:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: rtl8723bs: moved function prototype out
 of core/rtw_ioctl_set.c and core/rtw_mlme.c
Message-ID: <YFmVIvVz87nJFw0O@kroah.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <81ccf18df5ca0acab5bb8da2b675a03626ef57ac.1616422773.git.fabioaiuto83@gmail.com>
 <YFjBHNkQFlFzZKpV@kroah.com>
 <20210322182840.GC1443@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322182840.GC1443@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:28:42PM +0100, Fabio Aiuto wrote:
> On Mon, Mar 22, 2021 at 05:09:00PM +0100, Greg KH wrote:
> > On Mon, Mar 22, 2021 at 03:31:41PM +0100, Fabio Aiuto wrote:
> > > fix the following checkpatch issues:
> > > 
> > > WARNING: externs should be avoided in .c files
> > > 40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
> > > +u8 rtw_do_join(struct adapter *padapter);
> > > 
> > > WARNING: externs should be avoided in .c files
> > > 15: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:15:
> > > +extern u8 rtw_do_join(struct adapter *padapter);
> > > 
> > > moved function prototype in include/rtw_ioctl_set.h
> > > 
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 1 -
> > >  drivers/staging/rtl8723bs/core/rtw_mlme.c         | 2 --
> > >  drivers/staging/rtl8723bs/include/rtw_ioctl_set.h | 2 ++
> > >  3 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > > index cb14855742f7..7d858cae2395 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > > @@ -37,7 +37,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
> > >  	return ret;
> > >  }
> > >  
> > > -u8 rtw_do_join(struct adapter *padapter);
> > >  u8 rtw_do_join(struct adapter *padapter)
> > >  {
> > >  	struct list_head	*plist, *phead;
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > > index 95cfef118a94..1ee86ec2dee7 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > > @@ -12,8 +12,6 @@
> > >  #include <hal_btcoex.h>
> > >  #include <linux/jiffies.h>
> > >  
> > > -extern u8 rtw_do_join(struct adapter *padapter);
> > > -
> > >  int	rtw_init_mlme_priv(struct adapter *padapter)
> > >  {
> > >  	int	i;
> > > diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > > index 4b929b84040a..55722c1366aa 100644
> > > --- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > > +++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> > > @@ -28,6 +28,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
> > >  u8 rtw_validate_bssid(u8 *bssid);
> > >  u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
> > >  
> > > +u8 rtw_do_join(struct adapter *padapter);
> > > +
> > 
> > This is already in drivers/staging/rtl8188eu/include/hal_intf.h, why
> > declare it again?
> 
> I didn't check the rtl8188eu for that's not a module rtl8723bs depends on

Ugh, you are right, my fault, sorry for the noise.

greg k-h
