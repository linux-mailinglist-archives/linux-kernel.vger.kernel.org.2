Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32BB3A2914
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhFJKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC7EE61184;
        Thu, 10 Jun 2021 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623319911;
        bh=Li5h7gAN6SkiNXdFPfRuFav/iBGrnBV+vWpPj8iqHjw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VtYEHv4uHH9pqFlj/1pMAVoF2+01G3tSwYM6JWXMMwHJyxzBZmnGy6K/2xTP4ijlG
         FHcxE114Zyad4EDxVneVSUXi6/uh3n0+stKWPsplHbffMxIb+qeF/Ez9H9dGx3Ubhv
         jbjDDy018iSOYgquDg7te8npJ6ATZWLOqMYNdWPbktJ60/hMC2dqkxluSM+KK6tZ/E
         lRcwRfJSLsEvtc2M7hflKh+qLHinaSDfiInA+PuxV9Hi9wgzNMGdHA9ieVp6CzlCwn
         1/fePN9W3wbFeyjFbcFR5g+0ChOB5Pk6vmPSLoLk+ZxEo1hUIOkIOqbhanoNVLfk0D
         b20ahfroBwpUg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        sanm@codeaurora.org
Subject: Re: [BUG] usb: dwc3: Kernel NULL pointer dereference in dwc3_remove()
In-Reply-To: <20210607180023.GA23045@jackp-linux.qualcomm.com>
References: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
 <87r1hjcvf6.fsf@kernel.org> <70be179c-d36b-de6f-6efc-2888055b1312@arm.com>
 <YLi/u9J5f+nQO4Cm@kroah.com>
 <8272121c-ac8a-1565-a047-e3a16dcf13b0@arm.com> <877djbc8xq.fsf@kernel.org>
 <20210603173632.GA25299@jackp-linux.qualcomm.com>
 <87mts6avnn.fsf@kernel.org>
 <20210607180023.GA23045@jackp-linux.qualcomm.com>
Date:   Thu, 10 Jun 2021 13:11:42 +0300
Message-ID: <87sg1q1129.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Jack Pham <jackp@codeaurora.org> writes:
> On Fri, Jun 04, 2021 at 11:20:12AM +0300, Felipe Balbi wrote:
>> Jack Pham <jackp@codeaurora.org> writes:
>> >> >>>> Alexandru Elisei <alexandru.elisei@arm.com> writes:
>> >> >>>>> I've been able to bisect the panic and the offending commit is =
568262bf5492 ("usb:
>> >> >>>>> dwc3: core: Add shutdown callback for dwc3"). I can provide mor=
e diagnostic
>> >> >>>>> information if needed and I can help test the fix.
>> >> >>>> if you simply revert that commit in HEAD, does the problem reall=
y go
>> >> >>>> away?
>> >> >>> Kernel built from commit 324c92e5e0ee, which is the kernel tip to=
day, the panic is
>> >> >>> there. Reverting the offending commit, 568262bf5492, makes the pa=
nic disappear.
>> >> >> Want to send a revert so I can take it now?
>> >> >
>> >> > I can send a revert, but Felipe was asking Sandeep (the commit auth=
or) for a fix,
>> >> > so I'll leave it up to Felipe to decide how to proceed.
>> >>=20
>> >> I'm okay with a revert. Feel free to add my Acked-by: Felipe Balbi
>> >> <balbi@kernel.org> or it.
>> >>=20
>> >> Sandeep, please send a new version that doesn't encounter the same
>> >> issue. Make sure to test by reloading the driver in a tight loop for
>> >> several iterations.
>> >
>> > This would probably be tricky to test on other "glue" drivers as the
>> > problem appears to be specific only to dwc3_of_simple.  It looks like
>> > both dwc3_of_simple and the dwc3 core now (due to 568262bf5492) each
>> > implement respective .shutdown callbacks. The latter is simply a wrapp=
er
>> > around dwc3_remove(). And from the panic call stack above we see that
>> > dwc3_of_simple_shutdown() calls of_platform_depopulate() which will=20
>> > again call dwc3_remove() resulting in the double remove.
>> >
>> > So would an alternative approach be to protect against dwc3_remove()
>> > getting called multiple times? IMO it'd be a bit messy to have to add
>>=20
>> no, I  don't think so. That sounds like a workaround. We should be able
>> to guarantee that ->remove() doesn't get called twice using the driver
>> model properly.
>
> Completely fair.  So then having a .shutdown callback that directly calls
> dwc3_remove() is probably not the right thing to do as it completely
> bypasses the driver model so if and when the driver core does later
> release the device from the driver that's how we end up with the double
> remove.

yeah, I would agree with that.

>> > additional checks there to know if it had already been called. So maybe
>> > avoid it altogether--should dwc3_of_simple_shutdown() just skip calling
>> > of_platform_depopulate()?
>>=20
>> I don't know what the idiomatic is nowadays, but at least early on, we
>> had to call depopulate.
>
> So any suggestions on how to fix the original issue Sandeep was trying
> to fix with 568262bf5492? Maybe implement .shutdown in dwc3_qcom and have
> it follow what dwc3_of_simple does with of_platform_depopulate()? But
> then wouldn't other "glues" want/need to follow suit?

I think we can implement shutdown in core, but we need to careful with
it. Instead of just blindly calling remove, let's extract the common
parts to another internal function that both remove and shutdown
call. debugfs removal should not be part of that generic method :-)

Anything in that generic method should, probably, be idempotent.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDB5V4RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUg9Ewf+NproMS9BtlaBnZq0EMVqyl8gHjrytzkc
nnc//13H/V63dPFSZUjvUx35eVZj227lpFaX8+kjBO45BrhnzrBwIvE3xryPYS5S
pvE9PZHMwCr+Ic4lt0g+hx8+bp4pePULCLzZnCnfL3BH4KWg9NOg2k4/DgHfmPC3
GRu/MqivsR30ErtiM91ILkS144AIYVlxtQEIz9ghbHM4srMaMgW5MPegMO1BFZwz
PVOKcSZ30FJkK733eX1Kxz55gv50wBsCgeZorsaoFP/ruMeCWBe5thkyBJfYi34Y
MKkzst3/zGDomIkN6ReZbfJFXMw3xB3Wkzx9231riSWS4sonSN0L3g==
=/AIV
-----END PGP SIGNATURE-----
--=-=-=--
