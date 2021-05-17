Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539A0382CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhEQM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235186AbhEQM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621256256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4fkr/kgCoLUjvcA1+48mSF4OQZMtmXw8qCHdHSfrbI=;
        b=CSVQVLzZTuXr6+9alPtnVvvAzE+FMkHMipbv0ar54ee7tJV7+79pM6DViXL2kuZeuYuYbL
        AdjR1gGesepX5kkYF+Da78WqeOMBKihIYkBRcIA+ICsetyjxTTFlQTXXngwL3gUc8qDuQc
        JYC/OwmIEBMQJDRnRqmcB2zeySJhnPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-3ZVPVXzfOnSfHE13Wwv_yw-1; Mon, 17 May 2021 08:57:32 -0400
X-MC-Unique: 3ZVPVXzfOnSfHE13Wwv_yw-1
Received: by mail-wr1-f69.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so3790510wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=I4fkr/kgCoLUjvcA1+48mSF4OQZMtmXw8qCHdHSfrbI=;
        b=dV1YkEbLfNGYc/DtFYLWhIxbw+LpilRm787NqTjtRWZJyebOgGVE9UVDFm2K9dzQbZ
         yF0Dp4WY+3ihXwbg9sosm6ZGfFNtvrTRduEJmi7xphsHnoeSPLTUuZbQ4oMvUHbcv1Sm
         wpgUy/FTdO+v1jM8nPB12XWj7OvYPglQZjHpz/LuQKJgbw7NU7DbBg6a7ESk5mbKW5Fi
         S9eljuAA1dn6hkph5xhIGFvloaQYsxCaC+lsYG0j45DMHa1OGqjwLsbhKGrLJhNvnHK5
         kxVasgitxqN7dgC7puNWDNeS0x0Ej1UYMTxlVeiGRNCgfsnW0ymdDB4XugZzibQkL9yA
         0TXQ==
X-Gm-Message-State: AOAM531PSJZIulP2umYbXgbKeOBskzPPB1PKe/w/wEdnLTH8SUGWE/gO
        N8o6mEJedCfGntJ2wQll0qHwoFD4tZ+UFpNox5R96j7o1idukgtFjwBnePLEpGqgnsnGiPNIK2u
        hcHTMNLD6uBiElbfaxkHG1xKo
X-Received: by 2002:a5d:59a1:: with SMTP id p1mr74441254wrr.332.1621256251369;
        Mon, 17 May 2021 05:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8iA9XZiPIFiiGR3QV9S1BCPX/F1TuVdgccRKT2kdanps57BwlAT8fxhIOYJX37kSxF0p+VQ==
X-Received: by 2002:a5d:59a1:: with SMTP id p1mr74441236wrr.332.1621256251229;
        Mon, 17 May 2021 05:57:31 -0700 (PDT)
Received: from ?IPv6:2003:c4:3708:c62:df9e:1d52:9709:a209? (p200300c437080c62df9e1d529709a209.dip0.t-ipconnect.de. [2003:c4:3708:c62:df9e:1d52:9709:a209])
        by smtp.gmail.com with ESMTPSA id 1sm9899655wmj.23.2021.05.17.05.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:57:30 -0700 (PDT)
Message-ID: <cd62e9a6d317e106db5e5d6b5f36170524ed7ad9.camel@redhat.com>
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
From:   Benjamin Berg <bberg@redhat.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 May 2021 14:57:28 +0200
In-Reply-To: <YKJeYzIgvL/soGgw@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
         <YKI/XT8qpZDjDuqs@kuha.fi.intel.com> <YKJeYzIgvL/soGgw@kuha.fi.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nvdWtIGDTaPoTjHWCKJp"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nvdWtIGDTaPoTjHWCKJp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heikki,


On Mon, 2021-05-17 at 15:15 +0300, Heikki Krogerus wrote:
> On Mon, May 17, 2021 at 01:03:12PM +0300, Heikki Krogerus wrote:
> > On Sat, May 15, 2021 at 09:09:53PM -0700, Bjorn Andersson wrote:
> > > It's possible that the interrupt handler for the UCSI driver
> > > signals a
> > > connector changes after the handler clears the PENDING bit, but
> > > before
> > > it has sent the acknowledge request. The result is that the handler
> > > is
> > > invoked yet again, to ack the same connector change.
> > >=20
> > > At least some versions of the Qualcomm UCSI firmware will not
> > > handle the
> > > second - "spurious" - acknowledgment gracefully. So make sure to
> > > not
> > > clear the pending flag until the change is acknowledged.
> > >=20
> > > Any connector changes coming in after the acknowledgment, that
> > > would
> > > have the pending flag incorrectly cleared, would afaict be covered
> > > by
> > > the subsequent connector status check.
> > >=20
> > > Fixes: 217504a05532 ("usb: typec: ucsi: Work around PPM losing
> > > change information")
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >=20
> > I'm OK with this if Bejamin does not see any problems with it. I'll
> > wait for his comments before giving my reviewed-by tag.
> >=20
> > That workaround (commit 217504a05532) is unfortunately too fragile.
> > I'm going to now separate the processing of the connector state from
> > the event handler (interrupt handler). That way we should be fairly
> > sure we don't loose any of the connector states even if an event is
> > generated while we are still in the middle of processing the previous
> > one(s), and at the same time be sure that we also don't confuse the
> > firmware.
> >=20
> > So the event handler shall after that only read the connector status,
> > schedule the unique job where it's processed and ACK the event.
> > Nothing else.
>=20
> Seems to be straightforward to implement. I'm attaching the patch I
> made for that. I think it should actually also remove the problem you
> are seeing. Can you test it?

Hmm, I am happy to try the patch tomorrow in the scenario where I
observed my race condition.

Unfortunately, I don't feel it'll work. The problem that I was seeing
looked like a race condition in the PPM itself, where the window is the
time between the UCSI_GET_CONNECTOR_STATUS command and the subsequent
ACK.
For such a firmware level bug in the PPM, we need a way to detect the
race condition when it happens (or get a fix for the firmware).

Note that there was also some code to always sent a
UCSI_GET_CAM_SUPPORTED command "to ensure the PPM does not get stuck in
case it assumes we do". I have no idea where this came from or what
PPMs might require this workaround. But I doubt it is a good idea to
drop it.

Benjamin

--=-nvdWtIGDTaPoTjHWCKJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmCiaDgACgkQq6ZWhpmF
Y3DXFBAAo/Z3Iirv+WTHm2lKAxlRUpdT0ZLoSEp3ztryytfW3pYOYgSpD7/coeSr
hIjWT0bUTO1VkfNOu38qsSYXJ57hR5Rp2QK6nQks9vWn6YcJWyx7yObwQcRAeoSZ
ss8lF2gUbX8mC85QiIuhyP7yaHX8s/Ip1nNq3tB/qu22pcLJa+mhotds76wQNAMV
MAtSGWmEmt1X8Xz+lROwQNJ5lMxHBemRcU/OQaM4cOlPp7sFQF0pD5wexyefGyJ/
ybQOGvDfbHXoXg7gLeZUTKq8R3RRcbLBuo5OX0VRBM1p3bdDhUaFG4XtKYvniWl4
VPw1A79ApALUNHg/4f+YAgFrnN+rNn72iaN5HN1ejHoViRgiRjL6WgDYLEOFvv11
mkJWRMtlIJbFzt2OYnXxWi6q14eQ+2VdOY/S6CNwHh7LTft3j56/XAL+24VKX0/T
3FVuDjHharbInaZp2bMioFDc9RuGcXig6Ee/pzwIwgoQIPw7vAyS8zc6ttzgEGOy
AA6hOdXofayEUZJr4MxJctWRnkusvyFrXg34ijoW65dtC/m0WHuIzL1rBsHj+Z3s
M8mud8SeK9xs8vtoevJ4UUTL/U+ps2TvQvtdcxguYi5ECJcbYsNrQzhjgfLUmcVx
vtBvD3APpdT4RXVw57QkQh/vAcuFxQ2ovFxgmOrraZ37TmoTNs4=
=dqmz
-----END PGP SIGNATURE-----

--=-nvdWtIGDTaPoTjHWCKJp--

