Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3F5375130
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhEFJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233686AbhEFJBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:01:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B72611AD;
        Thu,  6 May 2021 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620291623;
        bh=OErfeXtGgRd6vlDJ0sykxPf2X5MihrzXhkcnaJ5fi20=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XrcFl3DIOg3uCrNONYcIX0XmsKmAF67eGPOu46igYouDTwE81Z99GKuRivxZDi0s1
         TBuOdO3DJn+PXYFGeJ5XtIDDxL+O6ftvTQgURVltR8CNg0Dc2Rn36jMKsUHg/EGL7+
         JSZ8xaUxlV97fUxPh3pOrCENBNU7wiGTAyzenhXvpPFwP4xyXWPEEmUDQAY4BsMKMG
         AboPxfL9z1qAcyulVPqH8tWQGDMzc972ZJ2f972d+JbNwcDyHHhy64yGUktGwfLBeR
         KBbgnk8j/1SoTw00Q9RkXaIP+Z2qfT+whoSIzr12Ed+FKLKWCqL9iFbcF9s3kophZz
         tTihGM3wpSCoA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
In-Reply-To: <49c5e3eb-7c2b-a83b-2406-a620d91b827a@codeaurora.org>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org>
 <49c5e3eb-7c2b-a83b-2406-a620d91b827a@codeaurora.org>
Date:   Thu, 06 May 2021 12:00:15 +0300
Message-ID: <87r1ikgrts.fsf@kernel.org>
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

Wesley Cheng <wcheng@codeaurora.org> writes:
>> If I understood the whole thing correctly, we want everything except the
>> current request (the one that failed START or UPDATE transfer) to go
>> through giveback(). This really tells me that we're not handling error
>> case in kick_transfer and/or prepare_trbs() correctly.
>>=20
>
> We don't want the request passed in usb_ep_queue() to be calling
> giveback() IF DONE IN the usb_ep_queue() context only.

right, that's how this should behave.

>> I also don't want to pass another argument to kick_transfer because it
>> should be unnecessary: the current request should *always* be the last
>> one in the list. Therefore we should rely on something like
>> list_last_entry() followed by list_for_each_entry_safe_reverse() to
>> handle this without a special case.
>>=20
>> ret =3D dwc3_send_gadget_ep_cmd();
>> if (ret < 0) {
>> 	current =3D list_last_entry();
>>=20
>> 	unmap(current);
>>         for_each_trb_in(current) {
>>         	clear_HWO(trb);
>>         }
>>=20
>> 	list_for_entry_safe_reverse() {
>>         	move_cancelled();
>>         }
>> }
>>
> Nice, thanks for the suggestion and info!  Problem we have is that kick
> transfer is being used elsewhere, for example, during the TRB complete pa=
th:
>
> static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
> 		const struct dwc3_event_depevt *event, int status)
> {
> ...
> 	else if (dwc3_gadget_ep_should_continue(dep))
> 		if (__dwc3_gadget_kick_transfer(dep) =3D=3D 0)
> 			no_started_trb =3D false;
>
> So in these types of calls, we would still want ALL requests to be
> cancelled w/ giveback() called, so that the completion() callbacks can
> cleanup/free those requests accordingly.
>
> If we went and only unmapped the last entry (and removed it from any
> list), then no one would clean it up as it is outside of the
> usb_ep_queue() context, and not within any of the DWC3 lists.

oh, I see what you mean. At the moment we want kick_transfer to behave
in two different manners and that's probably where the bug is
originating from.

It sounds like it's time to split kick_transfer into
kick_queued_transfer() and e.g. continue_pending_transfers()

The thing is that if we continue to sprinkle special cases all over the
place, soon enough it'll be super hard to maintain the driver.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCTsB8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUikyQf+KPUf53NYTq5BWQIu+PodlU8bh2X4Cwel
XeSYuLO6yJsrV+vj4j0x0diNhbBrH2W6m/0TI8CEPWaqgV+RYl3lN4wuZrSoKxHN
+eEzSNdALLemT31vnYefbH0fWqWCwdoG+YLCaiN0Rro4iOH1F6gZctnNfLNu32So
yIOp/JznC0xUqoiczvPSQpOszaYRo4CN6ak2H3JruLCX7hFrHO+wFK//jYAxIISH
8LJQX90cwN0FwseZdIUucOsu3pspPvjOFSCyEnWQfhH5VQRhSspREHd9YKbS6oyZ
pIpE+2OkX6gDBLZ/kD7feJ4hhSndt75lVWiw3xWRQ/cMg+YN+EFqKg==
=jrUs
-----END PGP SIGNATURE-----
--=-=-=--
