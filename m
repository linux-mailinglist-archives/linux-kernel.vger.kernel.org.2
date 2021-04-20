Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBA364FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhDTBJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhDTBJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:09:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B234461363;
        Tue, 20 Apr 2021 01:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618880935;
        bh=yOhwTEEdJ51D9ecoqLz/L5DtMsNDmzT+3Upf6xsRNeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/Ne2h/fSACpMFCfIwqYN1hyJyZqXWEdgsSs+1KNrKm4sbkVsfhyAQCKScJusXruS
         5Jv2/oeSSrP5D7ZgcLuzVQZTds4oOJpqTxlldTZqGxHH1g6xDTJpzKypYcR2Dm8obr
         z4W2PtSYU97GdwocE87uThsWpJKqJE2JR6eP7mu2TnjUJqBt8J7lfrkJ3bm6R3TT4x
         WfMGrRMFBOq2i6xMo24ANJ80+s4HMEuOL6q/PhWwVoCdCDnPdz/LOKHJaEwSXmJ6qN
         gBypnW2sB+D+AMGqa1bwwvDDZAIwyBqxDjfUBagZ4WTG6zUusF9b57oAexuLS6rnCX
         TKN26rQOd+slA==
Date:   Tue, 20 Apr 2021 09:08:47 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, jbrunet@baylibre.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH 1/2] usb: gadget: f_uac2: Stop endpoint before enabling
 it.
Message-ID: <20210420010846.GA6408@nchen>
References: <20210419075053.28467-1-pawell@gli-login.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419075053.28467-1-pawell@gli-login.cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-19 09:50:53, Pawel Laszczak wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 
> Patch adds disabling endpoint before enabling it during changing
> alternate setting. Lack of this functionality causes that in some
> cases uac2 queue the same request multiple time.
> Such situation can occur when host send set interface with
> alternate setting 1 twice.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/gadget/function/f_uac2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 9cc5c512a5cd..7d20a9d8a1b4 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -890,17 +890,17 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>  	if (intf == uac2->as_out_intf) {
>  		uac2->as_out_alt = alt;
>  
> +		u_audio_stop_capture(&uac2->g_audio);
> +
>  		if (alt)
>  			ret = u_audio_start_capture(&uac2->g_audio);
> -		else
> -			u_audio_stop_capture(&uac2->g_audio);
>  	} else if (intf == uac2->as_in_intf) {
>  		uac2->as_in_alt = alt;
>  
> +		u_audio_stop_playback(&uac2->g_audio);
> +
>  		if (alt)
>  			ret = u_audio_start_playback(&uac2->g_audio);
> -		else
> -			u_audio_stop_playback(&uac2->g_audio);
>  	} else {
>  		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>  		return -EINVAL;

To avoid this, you may use prm->ep_enabled to judge if the endpoint has
already enabled.

-- 

Thanks,
Peter Chen

