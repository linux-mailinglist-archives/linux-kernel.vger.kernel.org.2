Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054913E22AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhHFEh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhHFEh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:37:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC19161131;
        Fri,  6 Aug 2021 04:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628224662;
        bh=mLzrJ27pG8lgA1YXqE7EYR2S72SZNKkog355x8Z3b8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmpN4uYko91orhbwrCPwQ6h401ec0d7gNlTotevYAly9P7zjkZkdY9yN0mFforWRM
         235nIkAf6+pA79jo97/kCqC3mvhUyyn+S+wUhaaHXiHxzs9NuU1X5iG7xSFL7hzT+s
         0TjQphWI4bpGicqX6CbaTs5z1WH9Jnh9kv8uDg9U=
Date:   Fri, 6 Aug 2021 06:37:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Michael Straube <straube.linux@gmail.com>, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: replace custom macros with
 is_broadcast_ether_addr
Message-ID: <YQy8kyafVi/T312y@kroah.com>
References: <20210805205010.31192-1-straube.linux@gmail.com>
 <32466d30-6259-4752-281b-875158ad307a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32466d30-6259-4752-281b-875158ad307a@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 06:47:26PM -0500, Larry Finger wrote:
> On 8/5/21 3:50 PM, Michael Straube wrote:
> > Replace usage of custom macros with is_broadcast_ether_addr. All buffers
> > are properly aligned. Remove the now unsued macros MacAddr_isBcst and
> > IS_MAC_ADDRESS_BROADCAST.
> > 
> > Signed-off-by: Michael Straube <straube.linux@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 13 +++----------
> >   drivers/staging/r8188eu/core/rtw_recv.c      |  2 +-
> >   drivers/staging/r8188eu/include/wifi.h       |  7 -------
> >   3 files changed, 4 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > index 3e2add5409cc..c354f720310c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> > @@ -13,13 +13,6 @@
> >   extern void indicate_wx_scan_complete_event(struct adapter *padapter);
> > -#define IS_MAC_ADDRESS_BROADCAST(addr) \
> > -(\
> > -	((addr[0] == 0xff) && (addr[1] == 0xff) && \
> > -		(addr[2] == 0xff) && (addr[3] == 0xff) && \
> > -		(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
> > -)
> > -
> >   u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
> >   {
> >   	u8	 i;
> > @@ -656,8 +649,8 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
> >   		}
> >   		/*  check BSSID */
> > -		if (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == true) {
> > -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MacAddr_isBcst(key->BSSID)\n"));
> > +		if (is_broadcast_ether_addr(key->BSSID)) {
> > +			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("is_broadcast_ether_addr(key->BSSID)\n"));
> >   			ret = false;
> >   			goto exit;
> >   		}
> > @@ -744,7 +737,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
> >   				 padapter->securitypriv.dot118021XGrpPrivacy, key->KeyLength));
> >   		}
> > -		if ((check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) == true) && (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == false)) {
> > +		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) && !is_broadcast_ether_addr(key->BSSID)) {
> >   			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
> >   				 (" IBSS but BSSID is not Broadcast Address.\n"));
> >   			ret = _FAIL;
> > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> > index aef32f029537..afab951d87fd 100644
> > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > @@ -694,7 +694,7 @@ static void count_rx_stats(struct adapter *padapter, struct recv_frame *prframe,
> >   	padapter->mlmepriv.LinkDetectInfo.NumRxOkInPeriod++;
> > -	if ((!MacAddr_isBcst(pattrib->dst)) && (!IS_MCAST(pattrib->dst)))
> > +	if (!is_broadcast_ether_addr(pattrib->dst) && !IS_MCAST(pattrib->dst))
> >   		padapter->mlmepriv.LinkDetectInfo.NumRxUnicastOkInPeriod++;
> >   	if (sta)
> > diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> > index 2c56d1d70d03..65fc677bf4eb 100644
> > --- a/drivers/staging/r8188eu/include/wifi.h
> > +++ b/drivers/staging/r8188eu/include/wifi.h
> > @@ -368,13 +368,6 @@ enum WIFI_REG_DOMAIN {
> >   #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
> > -#define MacAddr_isBcst(addr) \
> > -	( \
> > -	((addr[0] == 0xff) && (addr[1] == 0xff) && \
> > -	(addr[2] == 0xff) && (addr[3] == 0xff) && \
> > -	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
> > -)
> > -
> >   static inline int IS_MCAST(unsigned char *da)
> >   {
> >   	if ((*da) & 0x01)
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger,net>

Odd ',' use here :)


