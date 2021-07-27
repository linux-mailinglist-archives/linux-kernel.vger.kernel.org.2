Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F13D758B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhG0NFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236320AbhG0NFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 131CA61A2A;
        Tue, 27 Jul 2021 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627391113;
        bh=1GB5YmclR9G6ZS/AJEhyX4f1OTKseHBcaAqfPu/U780=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOO5DtD7SXA6zR3H5dqExSdhcxd3slCh+dw5QaJncJOb1efmwE7k/8ZIJTux6d7gi
         Kn02ob5K7+hvQq2dR02thzzkNYvH1L4mzLrY4CZtAEhkYnAp3soghkQbce5jxc+ygp
         sB0YFhDrglw8iam4dzvZ1Ju6k3keznYcLX5n2DBg=
Date:   Tue, 27 Jul 2021 15:05:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: remove braces from single line if
 blocks
Message-ID: <YQAEhxABM8ZFszCF@kroah.com>
References: <20210726092129.30334-1-straube.linux@gmail.com>
 <a4eb0dea-a34b-8dd9-03c6-aa0d87e68986@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4eb0dea-a34b-8dd9-03c6-aa0d87e68986@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:09:51AM -0500, Larry Finger wrote:
> On 7/26/21 4:21 AM, Michael Straube wrote:
> > Remove braces from single line if blocks to clear checkpatch warnings.
> > WARNING: braces {} are not necessary for single statement blocks
> > 
> > Signed-off-by: Michael Straube <straube.linux@gmail.com>
> > ---
> >   drivers/staging/rtl8188eu/core/rtw_cmd.c          | 3 +--
> >   drivers/staging/rtl8188eu/core/rtw_mlme.c         | 3 +--
> >   drivers/staging/rtl8188eu/core/rtw_xmit.c         | 3 +--
> >   drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 3 +--
> >   drivers/staging/rtl8188eu/hal/usb_halinit.c       | 6 ++----
> >   5 files changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
> > index eb89a52aa4e3..56ece839c9ca 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
> > @@ -1159,9 +1159,8 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
> >   		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
> >   		if (!psta) {
> >   			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
> > -			if (!psta) {
> > +			if (!psta)
> >   				goto createbss_cmd_fail;
> > -			}
> >   		}
> >   		rtw_indicate_connect(padapter);
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > index 71d205f3d73d..0d334aba9a3f 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > @@ -953,9 +953,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
> >   			}
> >   			/* s4. indicate connect */
> > -			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> > +			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> >   				rtw_indicate_connect(adapter);
> > -			}
> >   			/* s5. Cancel assoc_timer */
> >   			del_timer_sync(&pmlmepriv->assoc_timer);
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > index d5fc59417ec6..c77ebd18f40c 100644
> > --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > @@ -1124,9 +1124,8 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
> >   		list_del_init(&pxmitbuf->list);
> >   		pxmitpriv->free_xmitbuf_cnt--;
> >   		pxmitbuf->priv_data = NULL;
> > -		if (pxmitbuf->sctx) {
> > +		if (pxmitbuf->sctx)
> >   			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
> > -		}
> >   	}
> >   	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irql);
> > diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> > index 6cf87312bc36..a67615708745 100644
> > --- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> > +++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
> > @@ -510,7 +510,6 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
> >   	else
> >   		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
> > -	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
> > +	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail)
> >   		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
> > -	}
> >   }
> > diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> > index 1d7d5037ce89..3e8f7315d377 100644
> > --- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
> > +++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
> > @@ -641,9 +641,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
> >   	}
> >   	status = rtw_hal_power_on(Adapter);
> > -	if (status == _FAIL) {
> > +	if (status == _FAIL)
> >   		goto exit;
> > -	}
> >   	/*  Save target channel */
> >   	haldata->CurrentChannel = 6;/* default set to 6 */
> > @@ -696,9 +695,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
> >   	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
> >   	status =  InitLLTTable(Adapter, txpktbuf_bndy);
> > -	if (status == _FAIL) {
> > +	if (status == _FAIL)
> >   		goto exit;
> > -	}
> >   	/*  Get Rx PHY status in order to report RSSI and others. */
> >   	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
> > 
> 
> Michael,
> 
> You might as well stop looking at drivers/staging/rtl8188eu. There is a
> pending patch that blows away that directory and replaces it with a new
> version from the GitHub repo. The new one will be in
> drivers/staging/r8188eu.

Until that happens, no reason people can't still get practice cleaning
up this file.  So I'll keep taking these changes until then.

thanks,

greg k-h
