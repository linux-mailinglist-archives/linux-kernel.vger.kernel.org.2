Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCFD36A464
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhDYD3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDYD3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82B4761154;
        Sun, 25 Apr 2021 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619321337;
        bh=rnzq7hymD1yyqndLzmlHZWhdSR/iXxuNvtGqJkDhxxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rli9kLKMPfWi6nnOMsXMojc7Cl6RLJGWTSM7j8AsfWZ2MfE+Pyj1KUCFkaVcCWwHj
         nIwS7EDsolGFXYDa1N8ZhmsVTL4g9QZ/bnXdm8AYVdF9+S51sBmcFoPS2a2FvSRkXT
         tiU+o/flMUuLG+LyCXhYXJyzBrx+8U0u3G1jhf6I4FUVnqEO4xOBLm0PG+qK89AFym
         BmpcVrGC6VN2KGWBmSldaD8FA4yVXOys+CVqLXhXAaHySJCJJioR8SyM1z+lfUjDhI
         BVPlGLr0j+g0cvZOc7igYhDwEz9+EzsLIoj3mGsUNKNfjlGgKkTA0/xGc+TPr7smJX
         Tucm8B0rCbU6w==
Date:   Sun, 25 Apr 2021 11:28:52 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH 1/2] usb: gadget: f_uac2: Stop endpoint before enabling
 it.
Message-ID: <20210425032852.GA10463@nchen>
References: <20210419075053.28467-1-pawell@gli-login.cadence.com>
 <20210420010846.GA6408@nchen>
 <BYAPR07MB5381F9748155F73732090E87DD489@BYAPR07MB5381.namprd07.prod.outlook.com>
 <20210423104914.GA6448@nchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423104914.GA6448@nchen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-23 18:49:14, Peter Chen wrote:
> On 21-04-20 03:56:25, Pawel Laszczak wrote:
> > >On 21-04-19 09:50:53, Pawel Laszczak wrote:
> > >> From: Pawel Laszczak <pawell@cadence.com>
> > >>
> > >> Patch adds disabling endpoint before enabling it during changing
> > >> alternate setting. Lack of this functionality causes that in some
> > >> cases uac2 queue the same request multiple time.
> > >> Such situation can occur when host send set interface with
> > >> alternate setting 1 twice.
> > >>
> > >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > >> ---
> > >>  drivers/usb/gadget/function/f_uac2.c | 8 ++++----
> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> > >> index 9cc5c512a5cd..7d20a9d8a1b4 100644
> > >> --- a/drivers/usb/gadget/function/f_uac2.c
> > >> +++ b/drivers/usb/gadget/function/f_uac2.c
> > >> @@ -890,17 +890,17 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
> > >>  	if (intf == uac2->as_out_intf) {
> > >>  		uac2->as_out_alt = alt;
> > >>
> > >> +		u_audio_stop_capture(&uac2->g_audio);
> > >> +
> > >>  		if (alt)
> > >>  			ret = u_audio_start_capture(&uac2->g_audio);
> > >> -		else
> > >> -			u_audio_stop_capture(&uac2->g_audio);
> > >>  	} else if (intf == uac2->as_in_intf) {
> > >>  		uac2->as_in_alt = alt;
> > >>
> > >> +		u_audio_stop_playback(&uac2->g_audio);
> > >> +
> > >>  		if (alt)
> > >>  			ret = u_audio_start_playback(&uac2->g_audio);
> > >> -		else
> > >> -			u_audio_stop_playback(&uac2->g_audio);
> > >>  	} else {
> > >>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
> > >>  		return -EINVAL;
> > >
> > >To avoid this, you may use prm->ep_enabled to judge if the endpoint has
> > >already enabled.
> > 
> > Such condition is as first instruction inside u_audio_stop_playback->free_ep  function,
> > so we don't need duplicate it here.
> > 
> 
> Get your points, you may add more explanations both the code your change
> and the commit log.
> 

After thinking more, I think it is better add judge code at
u_audio_start_playback/capture, but not change code here. The reader may
not understand the code your change at the first glance.

-- 

Thanks,
Peter Chen

