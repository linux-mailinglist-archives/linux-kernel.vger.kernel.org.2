Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA3373BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhEEM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 08:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhEEM6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 08:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5068661027;
        Wed,  5 May 2021 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620219431;
        bh=j2vJcsDv7kNoCB+SgESqW/P8QQFEM7o8//oQA+hxUGk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MqHurwLsyFmpVl43cvHNExhSxkY4iPtm7HJyKcvmtSSNBJr6uNHzrSBbPI/IAMliJ
         RShCS5qbTe5GymdAY1+V6PvgQy3zLYJiVqxAipt27VLSJdNtC6LV6tfS1UPZr13NCi
         r9F3a3B31bA3ZZiJ7Vf5a5vZcVpw1TQB/6Ae0m6gQaNSRTkK50n7HFxtFGsBIS4Nqg
         uk6wDxbQ975LNu2iL6PiQBeKQxYWbHPzjSe1GClnJTutonZvwxhxsCx9uZom5mh1hX
         EJmIw69uZPOzluqns/26L6RkD+6kEsU246OGTqmQc50My9ca4lF3shvXZm8RagghDf
         SomCsDZ9yjSGQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
In-Reply-To: <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
Date:   Wed, 05 May 2021 15:57:03 +0300
Message-ID: <8735v1ibj4.fsf@kernel.org>
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
> On 5/3/2021 7:20 PM, Thinh Nguyen wrote:
>> Hi,
>>=20
>> Wesley Cheng wrote:
>>> If an error is received when issuing a start or update transfer
>>> command, the error handler will stop all active requests (including
>>> the current USB request), and call dwc3_gadget_giveback() to notify
>>> function drivers of the requests which have been stopped.  Avoid
>>> having to cancel the current request which is trying to be queued, as
>>> the function driver will handle the EP queue error accordingly.
>>> Simply unmap the request as it was done before, and allow previously
>>> started transfers to be cleaned up.
>>>
>
> Hi Thinh,
>
>>=20
>> It looks like you're still letting dwc3 stopping and cancelling all the
>> active requests instead letting the function driver doing the dequeue.
>>=20
>
> Yeah, main issue isn't due to the function driver doing dequeue, but
> having cleanup (ie USB request free) if there is an error during
> usb_ep_queue().
>
> The function driver in question at the moment is the f_fs driver in AIO
> mode.  When async IO is enabled in the FFS driver, every time it queues
> a packet, it will allocate a io_data struct beforehand.  If the
> usb_ep_queue() fails it will free this io_data memory.  Problem is that,
> since the DWC3 gadget calls the completion with -ECONNRESET, the FFS
> driver will also schedule a work item (within io_data struct) to handle
> the completion.  So you end up with a flow like below
>
> allocate io_data (ffs)
>  --> usb_ep_queue()
>    --> __dwc3_gadget_kick_transfer()
>    --> dwc3_send_gadget_ep_cmd(EINVAL)
>    --> dwc3_gadget_ep_cleanup_cancelled_requests()
>    --> dwc3_gadget_giveback(ECONNRESET)
> ffs completion callback
> queue work item within io_data
>  --> usb_ep_queue returns EINVAL
> ffs frees io_data
> ...
>
> work scheduled
>  --> NULL pointer/memory fault as io_data is freed

I have some vague memory of discussing (something like) this with Alan
Stern long ago and the conclusion was that the gadget driver should
handle cases such as this. OTOH, we're returning failure during
usb_ep_queue() which tells me there's something with dwc3 (perhaps not
exclusively, but that's yet to be shown).

If I understood the whole thing correctly, we want everything except the
current request (the one that failed START or UPDATE transfer) to go
through giveback(). This really tells me that we're not handling error
case in kick_transfer and/or prepare_trbs() correctly.

I also don't want to pass another argument to kick_transfer because it
should be unnecessary: the current request should *always* be the last
one in the list. Therefore we should rely on something like
list_last_entry() followed by list_for_each_entry_safe_reverse() to
handle this without a special case.

ret =3D dwc3_send_gadget_ep_cmd();
if (ret < 0) {
	current =3D list_last_entry();

	unmap(current);
        for_each_trb_in(current) {
        	clear_HWO(trb);
        }

	list_for_entry_safe_reverse() {
        	move_cancelled();
        }
}

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCSlh8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUiPMQf+OzEmWNuQmTR2O1d5b9l5CL4ZB2meItFi
59QXBVeDQyCAiC2ZzDR4JvM29npuHXCbVuT40Nj2H7ZKMbM99M1iIX8kSx79kViI
CSFtLxxQ6uRR8rV1X2TdG3Kn0+a+Qt0m04vGea0T9U5RYFFBvGAsRtcvv8+8ur0n
MIkvy4DQw1Zf2LGXIb6Wa4Wl04B0r+uVIVxsUUhW/bhBj6oWOaOgPsjaRNi4PZfh
j6uTZTRaJn6mHZhoU8V9VPtvGaBE5hkDN5+g4vPIMVbffu1ZXE9EH6/gFtpQyK6t
ltLbbihZb49nVZkvDCrCFt/Sr77pU6x9HWjBnjaSV93XrRQn53WJ1Q==
=0h80
-----END PGP SIGNATURE-----
--=-=-=--
