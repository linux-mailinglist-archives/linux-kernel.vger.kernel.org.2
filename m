Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E735DFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbhDMNM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbhDMNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:12:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66800C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:12:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so19337113edv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgdFlcjKU9PU1av9/ApHGEGIWSg0KENF/Em1dnUWYKA=;
        b=OJLF5WhrD/4VIOG76yBUebbn3H0fOwnYI0rMe8tkdMX28ZiUwh7j6/242zpXDxxbWi
         HNR378B3E0FEEBK320AujAfmXL+NxAQWBHfD+wYOl4y1hXQP2KQN6Vb4s1wsIEB6W0sC
         H3uQ/OvY9PuOEYVX6WnACc6RuO8pkgpWaJ4g/hFAMVIoazf5tzlrohf+jh660et0q0BH
         TaIpLxUHPJJoratG/3CzPBHSc7yqBLaCkcE+icUwbLg/Q/8C2OjbZ5cLq1L+fxk+Ha5m
         lfiJNZnK8LTQ+E1gCMmhEUobEZmeNW/sKZrxqs+jZ983J2SkimAbl+H040slCR0b2Miq
         eTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgdFlcjKU9PU1av9/ApHGEGIWSg0KENF/Em1dnUWYKA=;
        b=n74hXxaMISw/UTfQBw3Bjfy++iWCfVzdEKOYAQOTvElz/IfRZYJUv+juA7R9FM009+
         2K7sfzjTrTDYhSa/WSXhW05VW2qXCmN/drTqg4/k+pCv3Bjlm0j3YYOqzOFmN4MT/WqS
         zwpxhJ4z1yj+5fbyXtOKsXhdTkv8BEMBAM4VSbTLCbmDzDt6kF1CeQHRoiNqcDlDcBcU
         kqa5sTYFFdoNEfVYeJkLtRV1BfObQl6ZclXe8WbHiiu/Khp2fOTePO5gko87tAA3jM3P
         eE7mTKtAuCh+DnKVkBTjEsm9XpJZK19++41Ud154rJQFcvyo/nhZoLxU0Trfl9h+j0TW
         B1yw==
X-Gm-Message-State: AOAM533VQ9vu8De6l46wZ+torYoJRN4DykTqbKvjpgXlJtssVCSbgWSN
        D6fQoi0w8sF+GuDrnnVPJoc=
X-Google-Smtp-Source: ABdhPJyH+SpOOo0GQ1Svz6FgNJziJxDyrEqAFB2235ohGId9mNVMErtOJZdxkG0DfDCAhJ/PuPTZdw==
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr34370981edb.97.1618319524139;
        Tue, 13 Apr 2021 06:12:04 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id hs26sm3655477ejc.23.2021.04.13.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:12:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: ieee80211: Replaced strncpy() with strscpy()
Date:   Tue, 13 Apr 2021 15:12:02 +0200
Message-ID: <4666289.4L6Ep8XSK1@linux.local>
In-Reply-To: <YHWVsahY4nfo9xF/@kroah.com>
References: <20210413123041.24260-1-fmdefrancesco@gmail.com> <YHWVsahY4nfo9xF/@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 2:59:29 PM CEST Greg Kroah-Hartman wrote:
> On Tue, Apr 13, 2021 at 02:30:41PM +0200, Fabio M. De Francesco wrote:
> > Replaced strncpy() with strscpy() because of compilation time warnings
> > about possible truncation of output [-Wstringop-truncation].
>=20
> build warnings?  What build warnings?
>
drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1388:5: warning:=20
=E2=80=98strncpy=E2=80=99 output may be truncated copying 32 bytes from a s=
tring of length=20
32 [-Wstringop-truncation]
 1388 |     strncpy(tmp_ssid, ieee->current_network.ssid,=20
IW_ESSID_MAX_SIZE);
>=20
> > Furthermore, according to the Linux official documentation, strscpy()
> > is
> > preferred to strncpy.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> >  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c index
> > 25ea8e1b6b65..aa58eedf5e86 100644
> > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > @@ -1385,12 +1385,12 @@ inline void ieee80211_softmac_new_net(struct
> > ieee80211_device *ieee, struct ieee>=20
> >  			 * essid provided by the user.
> >  			 */
> >  		=09
> >  			if (!ssidbroad) {
> >=20
> > -				strncpy(tmp_ssid, ieee-
>current_network.ssid, IW_ESSID_MAX_SIZE);
> > +				strscpy(tmp_ssid, ieee-
>current_network.ssid, IW_ESSID_MAX_SIZE);
>=20
> Are you sure you can just replace this like this?
>
I surely was... but now I'm not anymore, since your review :)

Maybe you mean I have to check possible return of -E2BIG?
Did you mean something else?
May you please elaborate further?

Thanks,

=46abio
>=20
> >  				tmp_ssid_len =3D ieee-
>current_network.ssid_len;
> >  		=09
> >  			}
> >  			memcpy(&ieee->current_network, net,=20
sizeof(struct
> >  			ieee80211_network));
> >=20
> > -			strncpy(ieee->current_network.ssid,=20
tmp_ssid, IW_ESSID_MAX_SIZE);
> > +			strscpy(ieee->current_network.ssid,=20
tmp_ssid, IW_ESSID_MAX_SIZE);
>=20
> Same here, are you sure?
>=20
> thanks,
>=20
> greg k-h




