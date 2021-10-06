Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9B44239D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhJFIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhJFIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:36:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13572C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:34:25 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mY2NX-0006Oj-AJ; Wed, 06 Oct 2021 10:34:19 +0200
Date:   Wed, 6 Oct 2021 10:34:19 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] staging: r8188eu: support interface is always usb
Message-ID: <20211006083419.ei265w5cqpctg2yf@viti.kaiser.cx>
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-9-martin@kaiser.cx>
 <dd53513b-00c1-e915-712b-08b7cb7b5b34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd53513b-00c1-e915-712b-08b7cb7b5b34@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> On 10/5/21 22:08, Martin Kaiser wrote:
> > We set ODM_CMNINFO_INTERFACE to ODM_ITRF_USB as this driver supports
> > only usb. Therefore, dm_odm->SupportInterface is always ODM_ITRF_USB.

> > Simplify some if conditions accordingly. Remove/replace two empty
> > functions.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >   drivers/staging/r8188eu/hal/odm_HWConfig.c | 58 +++++++---------------
> >   1 file changed, 19 insertions(+), 39 deletions(-)


> <...>

> >   static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
> >   {
> > -	if ((dm_odm->SupportPlatform == ODM_MP) &&
> > -	    (dm_odm->SupportInterface != ODM_ITRF_PCIE) && /* USB & SDIO */
> > -	    (dm_odm->PatchID == 10))
> > -		return odm_sig_patch_netcore(dm_odm, CurrSig);
> > -	else if ((dm_odm->SupportPlatform == ODM_MP) &&
> > -		 (dm_odm->SupportInterface == ODM_ITRF_PCIE) &&
> > -		 (dm_odm->PatchID == 19))
> > -		return odm_sig_patch_lenove(dm_odm, CurrSig);
> > +	if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 10))
> > +		return 0;
> >   	else
> >   		return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
> >   }


> dm_odm->SupportPlatform is always ODM_CE, so this could be just:

> 	return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);

> And then it's just an unnecessary wrapper. ;)

I see. I'll send more patches to clean up this area as time permits.

Thanks,
Martin
