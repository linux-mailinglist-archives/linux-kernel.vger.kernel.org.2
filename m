Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6839D3FAF14
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhH2XTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 19:19:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:18:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso13426310wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtP9/zqwMm5tTi+7Rao14dM7+IS9AMZy0vyNq2TuYYg=;
        b=i82vexUq47GpjKiBP1yTgSBfqEswshCxCsLfDix784nRKpCiGif/YqkuNI5Dn6TBOM
         x1HsTZjZlptPJu/37VbeZ5Ht7WYhRLHEsBt6eSIxbeDpxkmpVEP9JcBTmwqnNJxcsf9s
         3B2jCu0NpADQpZApfW/VVAPiQgwrEdI4GSNBw2dlXIsbzT5IMbZjhDaNt/C/MRXPrITr
         thyEOBxlT1h9AqM8aoTBMpSQWqXHZC/tuoZjbPCwxaLGZM4bfAA4BkN/gCJ9Qm3szVrn
         WL/EIKeOZol7V8p0SY1n3FSen5G4SsDMn1lo37LwbDVG2EGdnudsGV+Zg5WlKAs6Dyrp
         6GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtP9/zqwMm5tTi+7Rao14dM7+IS9AMZy0vyNq2TuYYg=;
        b=fjbhWDp69m+QcrjyrLU0sXKRXa/c/Y5g80zAyOliwzHvwiRQdyg+mQ4MPMb0utZdU4
         ekX5YNIcYEtV13Folewr89vCbhGTZftuRbyFh2kNd1pgt+t97UaXOA9HNhV4W/nNrTmd
         jg9q3ULarrZY9E+liP/JF93VJel+ZYiAaL44fyFNychrx0lLYbQ1vPLGTUja38UJjYc6
         TQ/kpotZrxdvJxI9bknwPSSiJTfgaLZgQfa6TJ/1icbYuuC0yD9KHvQMpMEqldxiMWp4
         WYlmYjPMCGxHfqfo3c2Mn7lUQqCefwyzrXoEoHlAy7qtZr7Ac+uvnCsM6HbxiJ8L6neL
         L8KQ==
X-Gm-Message-State: AOAM533/ZuMcWTYjlR0YwjtgTl14UI3cxD3SjbTsD22OpDQC3RNH0nMY
        izxZguoaE1gBaSEIkDV6LL9DKOWw4/pUzQ==
X-Google-Smtp-Source: ABdhPJwtPAQZpsaldUXKdEeFQGoUq30/MRNwOnkvqhrgAZdCqeCG1vfVgjMn/HMiUMkaJIOPyOnlng==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr18747339wmh.66.1630279107175;
        Sun, 29 Aug 2021 16:18:27 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y11sm16515082wru.0.2021.08.29.16.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 16:18:26 -0700 (PDT)
Date:   Mon, 30 Aug 2021 00:18:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
Message-ID: <YSwVwKdJaj3EcW5V@equinox>
References: <20210828212453.898-1-phil@philpotter.co.uk>
 <20210828212453.898-3-phil@philpotter.co.uk>
 <19b08be7-964e-fdbc-93c8-825ad41e1ade@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b08be7-964e-fdbc-93c8-825ad41e1ade@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 02:54:14PM +0300, Pavel Skripkin wrote:
> On 8/29/21 12:24 AM, Phillip Potter wrote:
> > Simplify c2h_evt_hdl function by removing majority of its code. The
> > function always returns _FAIL anyway, due to the wrapper function it
> > calls always returning _FAIL. For this reason, it is better to just
> > return _FAIL directly.
> > 
> > Leave the call to c2h_evt_read in place, as without it, event handling
> > semantics of the driver would be changed, despite nothing actually being
> > done with the event.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++------------------
> >   1 file changed, 3 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index ce73ac7cf973..b520c6b43c03 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -1854,27 +1854,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
> >   static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
> >   {
> > -	s32 ret = _FAIL;
> >   	u8 buf[16];
> > -	if (!c2h_evt) {
> > -		/* No c2h event in cmd_obj, read c2h event before handling*/
> > -		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
> > -			c2h_evt = (struct c2h_evt_hdr *)buf;
> > +	if (!c2h_evt)
> > +		c2h_evt_read(adapter, buf);
> > -			if (filter && !filter(c2h_evt->id))
> > -				goto exit;
> > -
> > -			ret = rtw_hal_c2h_handler(adapter, c2h_evt);
> > -		}
> > -	} else {
> > -		if (filter && !filter(c2h_evt->id))
> > -			goto exit;
> > -
> > -		ret = rtw_hal_c2h_handler(adapter, c2h_evt);
> > -	}
> > -exit:
> > -	return ret;
> > +	return _FAIL;
> 
> 
> Hi, Phillip!
> 
> 
> Do we really need to return _FAIL every time? The only one caller of
> c2h_evt_hdl() does not rely on it's return value. Shouldn't we make this
> function return void to simplify the code?

Dear Pavel,

Thanks for the review. Good point on the return type, I'll publish a v2
series.

> 
> 
> BTW, this function does nothing now, as I understand. It reads to local
> buffer and returns. I think, it can be removed
> 
> 
> 
> >   }
> >   static void c2h_wk_callback(struct work_struct *work)
> > 

Not sure if you're referring to c2h_wk_callback or c2h_evt_hdl, but
either way, they both call (indirectly or otherwise) c2h_evt_read and
c2h_evt_clear as well as rtw_c2h_wk_cmd in the case of c2h_wk_callback.
To just delete them wholesale therefore would be unsafe I think, due to
the effect on event semantics.

Certainly, it is possible to handle this c2h stuff by just reading from
register and ignoring though - another series is a better place for that
though I think. Admittedly, I may be talking nonsense here :-)

Regards,
Phil
