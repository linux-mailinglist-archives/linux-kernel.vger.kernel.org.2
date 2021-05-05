Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606DF373BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEEMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 08:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhEEMvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 08:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92671610EA;
        Wed,  5 May 2021 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620219013;
        bh=sS2EWrJSZB8YsJDnWDzAW4+tA3sc6RkQybnIsSbBtCE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jvmhs0cmUAizIkLY+dSU/NICFXdzaCK89evwr+e5IK3KEgiVSuHZcs44UHmqYDWuP
         5hnizXx02lwLbEWwkJEXtNTRPySysLmVaPzYJerJXGME8AHsb4/4ir8viMQ/3WWbb2
         cWQIzQe8xwd50ui0TC8QwonrQVMONyejaylufeXqsAMjdP2mEAE6NTphgkZY0v7KDC
         nz/4815vxxqS+OX8bESagQOaM6dSvwMjKD/tqM48nOQY0o52bp61wn126SFMVP7WTk
         2vL9+P982zQlQhzB/TuapHh8waNAbXDwOB19+ZtRlkaj+kgVkL2gVOsqJpbfTB8Zjo
         jnSPuRkgWSWQw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
In-Reply-To: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
Date:   Wed, 05 May 2021 15:50:04 +0300
Message-ID: <875yzxibur.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wesley Cheng <wcheng@codeaurora.org> writes:

> If an error is received when issuing a start or update transfer
> command, the error handler will stop all active requests (including
> the current USB request), and call dwc3_gadget_giveback() to notify
> function drivers of the requests which have been stopped.  Avoid
> having to cancel the current request which is trying to be queued, as
> the function driver will handle the EP queue error accordingly.
> Simply unmap the request as it was done before, and allow previously
> started transfers to be cleaned up.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
> Changes in v2:
>  - Addressed feedback received by making sure the logic only applies to a=
 req
>    which is being queued, decrementing the enqueue pointer, and only clea=
ring
>    the HWO bit.
>
>  drivers/usb/dwc3/gadget.c | 75 +++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 66 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index dd80e5c..c8ddbe1 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -140,6 +140,29 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enu=
m dwc3_link_state state)
>  }
>=20=20
>  /**
> + * dwc3_ep_dec_trb - decrement a trb index.
> + * @index: Pointer to the TRB index to increment.
> + *
> + * The index should never point to the link TRB. After decrementing,
> + * if index is zero, wrap around to the TRB before the link TRB.
> + */
> +static void dwc3_ep_dec_trb(u8 *index)
> +{
> +	(*index)--;
> +	if (*index < 0)
> +		*index =3D DWC3_TRB_NUM - 1;
> +}
> +
> +/**
> + * dwc3_ep_dec_enq - decrement endpoint's enqueue pointer
> + * @dep: The endpoint whose enqueue pointer we're decrementing
> + */
> +static void dwc3_ep_dec_enq(struct dwc3_ep *dep)
> +{
> +	dwc3_ep_dec_trb(&dep->trb_enqueue);
> +}
> +
> +/**
>   * dwc3_ep_inc_trb - increment a trb index.
>   * @index: Pointer to the TRB index to increment.
>   *

it looks like moving these helpers isn't part of $subject and could be
split to a patch of its own.

> @@ -1352,7 +1375,26 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
>=20=20
>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *de=
p);
>=20=20
> -static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
> +static void dwc3_gadget_ep_revert_trbs(struct dwc3_ep *dep, struct dwc3_=
request *req)
> +{
> +	int i;
> +
> +	if (!req->trb)
> +		return;
> +
> +	for (i =3D 0; i < req->num_trbs; i++) {
> +		struct dwc3_trb *trb;
> +
> +		trb =3D &dep->trb_pool[dep->trb_enqueue];

wait, enqueue or dequeue?

> @@ -1410,8 +1452,23 @@ static int __dwc3_gadget_kick_transfer(struct dwc3=
_ep *dep)
>=20=20
>  		dwc3_stop_active_transfer(dep, true, true);
>=20=20
> -		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
> -			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
> +		/*
> +		 * In order to ensure the logic is applied to a request being
> +		 * queued by dwc3_gadget_ep_queue(), it needs to explicitly
> +		 * check that req is the same as queued_req (request being
> +		 * queued).  If so, then just unmap and decrement the enqueue
> +		 * pointer, as the usb_ep_queue() error handler in the function
> +		 * driver will handle cleaning up the USB request.
> +		 */
> +		list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
> +			if (req =3D=3D queued_req) {
> +				dwc3_gadget_ep_revert_trbs(dep, req);
> +				dwc3_gadget_del_and_unmap_request(dep, req, ret);
> +			} else {
> +				dwc3_gadget_move_cancelled_request(req,
> +								   DWC3_REQUEST_STATUS_DEQUEUED);

we don't line up the arguments like that in dwc3.

> @@ -1546,7 +1603,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3=
_ep *dep)
>  	dep->start_cmd_status =3D 0;
>  	dep->combo_num =3D 0;
>=20=20
> -	return __dwc3_gadget_kick_transfer(dep);
> +	return __dwc3_gadget_kick_transfer(dep, NULL);

I would rather not have this extra special case for kick transfer,
instead you can treat the special case in the only location where it can
happen, i.e. ep_queue(). So, instead of patching kick_transfer itself,
you can make sure that kick transfer does *NOT* touch the current
request and only cancel all the previous, then ep_queue is responsible
for treating failed kick transfer for the current request. Either that,
or make sure dwc3_prepare_trbs() knows how to handle this special case inte=
rnally.

The current method seems wrong, IMO. It really seems like the problem is
elsewhere. Perhaps there's some other part of the driver that's not
cleaning up after itself.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCSlHwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUihuAgArTdqhqF043rxq6AcIv/bE4bvDX6zNYZ4
jVDeumqdsmpDU0ZJ6K5pK1UwiX4XCkhGi9puXB7GU+YB5Ve8H6/R62MmfE7q+WSu
IviI/SjjkCOC6FeMMzcNXglbKhr152QhupMkcUoen2PVNrGl4i2azAnAeVMcRwRB
EqKPNGTNcRBPfpJHKDBSILSpD3TbZR4lTI/Mp/zO1tid7WdDrg7b3/2Vok4YK6VV
YQRwSz8vzE0XzoJw5opHmBMkOL+N3tEoYFfVXF7LN7uCreDxBZBXoP3VbcKKN9AN
ItluSlC1rMZKvlp2t+hq4h4iqPW10u09BvEWbeL5b+wuRAp1x1gL6g==
=BVgz
-----END PGP SIGNATURE-----
--=-=-=--
