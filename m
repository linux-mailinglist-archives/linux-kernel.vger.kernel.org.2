Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A872637A177
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhEKIPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhEKIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:15:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B567D613C0;
        Tue, 11 May 2021 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620720838;
        bh=lagjRk7XHfYTuOSoD5kLTBMV/hIssg297p7SALdjRDI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pWC1iZ5451KjPomnd1SQWabUPwucJQICG6j2DLvB0sQQWaVoZ6Es4bozSUKifd8yD
         rP9B7xTEYRIPp6uIjY1nFpaV/ua6aCEKINJZiTrJcMlS3cPXNHFxYrvbLy+5x3cpUi
         EzbOqD2I9hIaghWCoW5uPSFet3qllQoc4XrxrG1x0UCTGpBzgoN3FdUy27anRvtCiL
         zdXEfWvFGuEo5Pd8DGnmtnxltHiTaUdVsObmdSoYiuChLxrQA3H6OOls0ywD/W8nZF
         8FuOabmGqR+uwx25D9Sn5WADTfWSLSoG0m9UGi97UyecNWKPOWC683DM33R1ibFwOc
         BsoFEZVB6/s4w==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Replace
 list_for_each_entry_safe() if using giveback
In-Reply-To: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
References: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
Date:   Tue, 11 May 2021 11:13:48 +0300
Message-ID: <87tun9g01v.fsf@kernel.org>
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
> The list_for_each_entry_safe() macro saves the current item (n) and
> the item after (n+1), so that n can be safely removed without
> corrupting the list.  However, when traversing the list and removing
> items using gadget giveback, the DWC3 lock is briefly released,
> allowing other routines to execute.  There is a situation where, while
> items are being removed from the cancelled_list using
> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
> routine is running in parallel (due to UDC unbind).  As the cleanup
> routine removes n, and the pullup disable removes n+1, once the
> cleanup retakes the DWC3 lock, it references a request who was already
> removed/handled.  With list debug enabled, this leads to a panic.
> Ensure all instances of the macro are replaced where gadget giveback
> is used.
>
> Example call stack:
>
> Thread#1:
> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>     ->list_for_each_entry_safe()
>     ->dwc3_gadget_giveback(n)
>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>       ->spin_unlock
>       ->Thread#2 executes
>       ...
>     ->dwc3_gadget_giveback(n+1)
>       ->Already removed!
>
> Thread#2:
> dwc3_gadget_pullup()
>   ->waiting for dwc3 spin_lock
>   ...
>   ->Thread#1 released lock
>   ->dwc3_stop_active_transfers()
>     ->dwc3_remove_requests()
>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>       ->dwc3_gadget_giveback()
>         ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_list]
>         ->spin_unlock
>
> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_list")
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> Reviewed-by: Peter Chen <peter.chen@kernel.org>
> ---
> Changes in v2:
>  - Updated commit message with context call stack of an example scenario
>    seen on device.
>
>  drivers/usb/dwc3/gadget.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index dd80e5c..efa939b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_=
ep *dep, struct dwc3_request *r
>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *de=
p)
>  {
>  	struct dwc3_request		*req;
> -	struct dwc3_request		*tmp;
>  	struct dwc3			*dwc =3D dep->dwc;
>=20=20
> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
> +	while (!list_empty(&dep->cancelled_list)) {
> +		req =3D next_request(&dep->cancelled_list);

couldn't this be solved list_replace_init() instead? Then we can keep
using the regular list_for_each_entry_safe() which has an added semantic
meaning due to its name.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCaPLwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUg8+Af+Kaqjllefd0NFPCAIWF3wonEqqn79RqpM
KNiONGML4FhR6hKy6f5kkcIFvMrRGCVg4E7EQ5d3qrcSAgWCF2Ee6IZvUTTp/XWV
0HyOyID2MugKO0XEFHPunuT8i4XywCz8BLIaS7irJoz9oCYPXWcsY95wAPLPxa0C
Zm2PtZ1x5ig7ggz8LkaVRrk7+WsbD8GTb/qnxcvtJ6jZMlrYY03h0GVMuBhUttLW
gYedJOEr2Sfy+6guyIdkz77rqMX2FDuuLo7bHri3vQ0b7dmVYLnhgQpW3FuYkHBo
OtI7BD2USop4ZYcW4l4vw4q6Cv8KRQGwYvQ4cnQlKNm0KrA0tHK0+Q==
=Q9N8
-----END PGP SIGNATURE-----
--=-=-=--
