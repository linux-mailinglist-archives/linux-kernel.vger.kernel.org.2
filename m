Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C4382C51
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhEQMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbhEQMiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621255018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHlK98Ao3DLOvD2nyPautPpOLYvpdR8q62o9VJysv4M=;
        b=YawzjuGmVXOtZptnG2nm8U2pP5R8f9sYw8eN5+0yivWJgWViM0yZChPNZUbTNsPGDqUCp8
        piQF+rPouZ+5OabOliY8yVgqakRFnXF7WbFfsyS7/wpUJfwBD+xx6vq+9TlPsX8PI/RQtz
        SbPU1wWvXGQouOsCcv68fAmjMgAy+i8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-viY-a_6LPvuBxD8gbtfK0w-1; Mon, 17 May 2021 08:36:55 -0400
X-MC-Unique: viY-a_6LPvuBxD8gbtfK0w-1
Received: by mail-ej1-f72.google.com with SMTP id gt39-20020a1709072da7b02903a8f7736a08so993269ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=DHlK98Ao3DLOvD2nyPautPpOLYvpdR8q62o9VJysv4M=;
        b=fCrvs4tftIzkg5RWJgq/n75FsjPT/u5Y+qVXz0vzGJYtF3QJ/TqjtiBEz0QjG1sqg0
         kgxhSM6cVT1AsUtCOg55llhySAdnzkEf1F7OR7lU2kJDqd689TCf6rjEjQI0IaXGQTDR
         yz1ONoJ9Hnt2rY1C40yMK2agf+H1kGECL1PZzIQXDBTVSnsr/JIjzeEmPKKbY16/e3Wn
         x2hbVxoFBo26dHLyLolOMZwsrgGvgiaPFFf7J41463xnJyiNBw/RgI632WKLNRRqmOEq
         FXdOc72B9L2kXKko1FMrQimABdq0qYlWdABzbjpSqiO1B0QGarQEDRBpWis8Ki7ImFab
         WS0w==
X-Gm-Message-State: AOAM533mMPOWx9VsAJJ0fyZXojtv1sFLrDVg5f+6kHd5unwo+dAJmZ7Z
        jjzvNG6X0iu51n1l0o/djDgGt3fT5Yshzzz91pGJKGQkuMizAxv3kWtC0h5FR05d6GtRS9+XNs2
        snShIbKYym3M8tLucga7yVcC7
X-Received: by 2002:a17:906:2bc5:: with SMTP id n5mr27668644ejg.531.1621255014531;
        Mon, 17 May 2021 05:36:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtk5O7DT7cmfpEYhrYYtyj4H3WyWQKK5dpzgfHIynoSsKsUJqJQIwZu2WtZwcsOOBp8mSZBg==
X-Received: by 2002:a17:906:2bc5:: with SMTP id n5mr27668627ejg.531.1621255014363;
        Mon, 17 May 2021 05:36:54 -0700 (PDT)
Received: from ?IPv6:2003:c4:3708:c62:df9e:1d52:9709:a209? (p200300c437080c62df9e1d529709a209.dip0.t-ipconnect.de. [2003:c4:3708:c62:df9e:1d52:9709:a209])
        by smtp.gmail.com with ESMTPSA id b19sm10733710edd.66.2021.05.17.05.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:36:53 -0700 (PDT)
Message-ID: <eebb4180ca4aa6d9f9dc488d7d91199de5731b5c.camel@redhat.com>
Subject: Re: [PATCH] usb: typec: ucsi: Clear pending after acking connector
 change
From:   Benjamin Berg <bberg@redhat.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 May 2021 14:36:50 +0200
In-Reply-To: <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
References: <20210516040953.622409-1-bjorn.andersson@linaro.org>
         <YKI/XT8qpZDjDuqs@kuha.fi.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VzXmzjqYSVJOfJgFmYWm"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VzXmzjqYSVJOfJgFmYWm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-05-17 at 13:03 +0300, Heikki Krogerus wrote:
> On Sat, May 15, 2021 at 09:09:53PM -0700, Bjorn Andersson wrote:
> > It's possible that the interrupt handler for the UCSI driver
> > signals a
> > connector changes after the handler clears the PENDING bit, but
> > before
> > it has sent the acknowledge request. The result is that the handler
> > is
> > invoked yet again, to ack the same connector change.
> >=20
> > At least some versions of the Qualcomm UCSI firmware will not
> > handle the
> > second - "spurious" - acknowledgment gracefully. So make sure to
> > not
> > clear the pending flag untuntil the changeil the change is
> > acknowledged.
> >=20
> > Any connector changes coming in after the acknowledgment, that
> > would
> > have the pending flag incorrectly cleared, would afaict be covered
> > by
> > the subsequent connector status check.
> >=20
> > Fixes: 217504a05532 ("usb: typec: ucsi: Work around PPM losing
> > change information")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> I'm OK with this if Bejamin does not see any problems with it. I'll
> wait for his comments before giving my reviewed-by tag.

Interesting problem. I wonder if we can detect this situation and
restart the worker instead of sending the ACK.

As for the patch, I do believe it is safe. I agree with the assessment
in the commit message, that the subsequent connector check will detect
any race condition and recovers from it.

Acked-By: Benjamin Berg <bberg@redhat.com>

Benjamin

> That workaround (commit 217504a05532) is unfortunately too fragile.
> I'm going to now separate the processing of the connector state from
> the event handler (interrupt handler). That way we should be fairly
> sure we don't loose any of the connector states even if an event is
> generated while we are still in the middle of processing the previous
> one(s), and at the same time be sure that we also don't confuse the
> firmware.
> So the event handler shall after that only read the connector status,
> schedule the unique job where it's processed and ACK the event.
> Nothing else.
>=20
> > ---
> > =C2=A0drivers/usb/typec/ucsi/ucsi.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c
> > b/drivers/usb/typec/ucsi/ucsi.c
> > index 282c3c825c13..f451ce0132a9 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -694,8 +694,8 @@ static void ucsi_handle_connector_change(struct
> > work_struct *work)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ucsi_send_command(con->=
ucsi, command, NULL, 0);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* 3. ACK connector cha=
nge */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clear_bit(EVENT_PENDING, &uc=
si->flags);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ucsi_acknowledg=
e_connector_change(ucsi);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clear_bit(EVENT_PENDING, &uc=
si->flags);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(ucsi->dev, "%s: ACK failed (%d)", __func=
__,
> > ret);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out_unlock;
> > --=20
> > 2.29.2
>=20
> thanks,
>=20


--=-VzXmzjqYSVJOfJgFmYWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmCiY2IACgkQq6ZWhpmF
Y3BAPQ//ZABRXpjcFB9x/Z3GiFyO+PHGDqyRi1FfVJh+7DZABPkC2zsWvXCqF0CR
EmS3YllK7h1IIPh3CChElO6yO2GdbJl+cf+rW6nlgWT9GK1yHIbddbigAlyy8gtd
gBauXkN9nYHvL7VsOnYoFdM/morETSHCsvN71QVbRYz8Lvtr50KkCHxRiFFRiTb/
V7KtEfPTfh0UNssQJVf47SzBpVPfxu+k/IhLe+GCAFwRg4s9HQEQ+v3q3YGxHogl
CV6uAxEmMuAazD+YIVSSr4TwNH/nX5w6q+/LiehiYxH2PbQfsRWm73WsQR2ZQA/N
W634QmgCx18ZKg/qvbXynOyuCku/fd7W3ZTwDMmN2P1ZgYx4FJ5jl6IZwo4rpmFc
+2y2wPmZ6SHvbqHXc+lNiYuzAleHawHJ00zEG64Gg7zrNyvLEvuL6Y3dLraRwa+I
342e4ZIWi99Xbga2R2mqs05UqQeY+d92tX4mFq3yD/N+WwjviFBsjLSgaPoix/8q
JpdTi18Pzt5t55ls5vi9G0jwDNw8TllJ9HFkrEiIsMEqwRcMvvoAKuS1vG7EN8Kr
4Ykzid+/l4zo/QKxBh1HfTdL3/ogY4j1GOcbCYI3oEoLRt9SgnIzHMDeATpmMk/U
1HhbBzLx72t1QmkBxxobt0f1+Gp6yNrLAzqzwfH1SwqZr19w5rI=
=B0Yk
-----END PGP SIGNATURE-----

--=-VzXmzjqYSVJOfJgFmYWm--

