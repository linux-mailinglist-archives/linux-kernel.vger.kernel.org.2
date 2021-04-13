Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2049235DFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhDMNZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhDMNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:24:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035E7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:24:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v6so24621440ejo.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fpmataO6y6J5iqfwR2qd4Wivtgq/Ar9WsoWwLjvHy0c=;
        b=mNKYVtFGVLLXwE9Omr3M9RfH65jYaxtIcovHMYS75vwg5DtsqE0ANHMMNMXuU9D1C6
         5vFZr4vbdzaN5euprooz/ytbGt6b1w+IQLv4QycvwO+NvZO0Wg5uenGd30qOJTGbBwFT
         Tnk7f71jgBqHDvFhsybf966K1L4fJooXpcfv4jLTAzLK9jWoExePErAj7cSGeU/xZDkT
         e5ZfZGcV7iax+F4kZYVqh+8CdbaYWxHiDH4WYmOWfnOFSrr5ByOyRN/W0pgNNjRsSFDQ
         vCuVKlngJfe4cHt39zvRY51J1d50fIHYc+sQVmwrc6RS4koH6YBJHroh12jnX7o33A7Y
         eYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fpmataO6y6J5iqfwR2qd4Wivtgq/Ar9WsoWwLjvHy0c=;
        b=HK6JrrmoeDxkKg9mDohh9W7TB+0bj66qyHBpaD0njLhJWDePTcHtCXTAOOaObH0K+w
         YsjCUQUbGEXYGlwI1XAA26sS7vb/UVY7doX1t8njoJoCreZg8KL+DLeSJ8i2GqFex0eC
         WVXk6PSCmZPa+tr10KJxwfQJHIUFhTUWcwAPZhbn8LI47XIPLfU60pYQFQBhzBv3TG/G
         jm9rGQkHhWNrssPeZ17vPSjuj67UxJ9GXSg1jTsTpCASHfD0427axGJwQc7qZlfcgqP7
         OrD3/p/h9td4PJM/sfEnmO4neTNPG2faNxTNQjIsoyiiAQOjTwMIBW9SEoZ7i51MSNmn
         Z+IA==
X-Gm-Message-State: AOAM533gvJDTcDACcaSBTFmQEWfB1LkPcOIp9P2O8k3oDBS5OgzuaUYQ
        ddbCpOdYjbIRXe+cu5CDDo4=
X-Google-Smtp-Source: ABdhPJxcR9pnUMn135tSaoAu7qjl2wbM9MRaXOguJWNr5L6QMefpdJ0jufcHkjqmMXXHloOrthoUVg==
X-Received: by 2002:a17:906:3385:: with SMTP id v5mr32201707eja.539.1618320272670;
        Tue, 13 Apr 2021 06:24:32 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id y21sm9195860edv.31.2021.04.13.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:24:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: ieee80211: Replaced strncpy() with strscpy()
Date:   Tue, 13 Apr 2021 15:24:31 +0200
Message-ID: <5414987.Cp2PYjnBm2@linux.local>
In-Reply-To: <YHWZoY6B8sOiflwy@kroah.com>
References: <20210413123041.24260-1-fmdefrancesco@gmail.com> <4666289.4L6Ep8XSK1@linux.local> <YHWZoY6B8sOiflwy@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 3:16:17 PM CEST Greg Kroah-Hartman wrote:
> On Tue, Apr 13, 2021 at 03:12:02PM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, April 13, 2021 2:59:29 PM CEST Greg Kroah-Hartman wrote:
> > > On Tue, Apr 13, 2021 at 02:30:41PM +0200, Fabio M. De Francesco=20
wrote:
> > > > Replaced strncpy() with strscpy() because of compilation time
> > > > warnings
> > > > about possible truncation of output [-Wstringop-truncation].
> > >=20
> > > build warnings?  What build warnings?
> >=20
> > drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:1388:5: warning:
> > =E2=80=98strncpy=E2=80=99 output may be truncated copying 32 bytes from=
 a string of
> > length 32 [-Wstringop-truncation]
> >=20
> >  1388 |     strncpy(tmp_ssid, ieee->current_network.ssid,
> >=20
> > IW_ESSID_MAX_SIZE);
>=20
> That's implying that there is a real bug here, not that just replacing
> it with a different call is going to solve this, right?
>=20
> And how do you see that, I can't see that in my builds.
>
I see that with flag W=3D1 like in=20
make -j8 drivers/staging/rtl8192u/ W=3D1

However I also think it's not a real issue in this context.
Just that strscpy() is preferred and get rid of warnings.
You only can judge if a patch is worth.
I just thought that gcc is (mostly) right in pointing out warnings like=20
that.

Thanks,

=46abio
>=20
> > > > Furthermore, according to the Linux official documentation,
> > > > strscpy()
> > > > is
> > > > preferred to strncpy.
> > > >=20
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >=20
> > > >  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > > > b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c index
> > > > 25ea8e1b6b65..aa58eedf5e86 100644
> > > > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > > > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> > > > @@ -1385,12 +1385,12 @@ inline void
> > > > ieee80211_softmac_new_net(struct
> > > > ieee80211_device *ieee, struct ieee>
> > > >=20
> > > >  			 * essid provided by the user.
> > > >  			 */
> > > >  		=09
> > > >  			if (!ssidbroad) {
> > > >=20
> > > > -				strncpy(tmp_ssid, ieee-
> > >
> > >current_network.ssid, IW_ESSID_MAX_SIZE);
> > >
> > > > +				strscpy(tmp_ssid, ieee-
> > >
> > >current_network.ssid, IW_ESSID_MAX_SIZE);
> > >
> > > Are you sure you can just replace this like this?
> >=20
> > I surely was... but now I'm not anymore, since your review :)
> >=20
> > Maybe you mean I have to check possible return of -E2BIG?
> > Did you mean something else?
> > May you please elaborate further?
>=20
> If it was as simple as search/replace, we would have already done that
> on the whole codebase at once.  It's not that simple :)
>=20
> thanks,
>=20
> greg k-h




