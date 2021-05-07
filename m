Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A2376539
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhEGMfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhEGMfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00A1D61104;
        Fri,  7 May 2021 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620390850;
        bh=JrcMI2f4Tj4TxExUPvmZWwxaXcGDSJeyC2cMxeJPAng=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lqij/gsAQ1D9D+5gsUEB3jPJbw/lPF+A/2aUI4P3NhQAuYSTQeHo8TvnkX0aQMAGF
         FrrIsHpJhsN4xZ32q4cSS0YAekrLyKTNvz5sSs+ofyPmx9q3ctX+zPBgY9opLIOVS0
         dWKzMHe3SBA4d7CqAaI9Kw2TkgB6SB8kFkJ/VPBM/+fLwsJ/3GsNXg/Hh0H+H17OR9
         SePjbONoJD6XdoijSqZ7DfwV/LkClFM//jD4DqpZz6/P1Xdp3ObZcuy2VyFEU6ciOv
         pmFSDRFohLX4q+l94YrCUUmgRfc0sGxQGR1Q6UyvxGilF5PY32fcgOIV/iA4joyaQe
         q6oBZSB5lSFfg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thinh.Nguyen@synopsys.com, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Return success always for kick
 transfer in ep queue
In-Reply-To: <1620369287-27492-1-git-send-email-wcheng@codeaurora.org>
References: <1620369287-27492-1-git-send-email-wcheng@codeaurora.org>
Date:   Fri, 07 May 2021 15:34:01 +0300
Message-ID: <87bl9mhgee.fsf@kernel.org>
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
> returning an error for kick transfer during EP queue, to remove
> duplicate cleanup operations on the request being queued.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

do you want to add a Fixes here? :-)

We should probably Cc stable too.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCVM7kRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhs2ggAiNJFgmRQXAKL9JddnhzWB4frz0QBAmFf
RM4C0JMkiYr6X55/KsCsLIImJ+9nFDOWdMvbpzro7HsTfNnAjLd/QGoQ7zVKIxYF
4o6RA4RFB0UEQU2xi5Urz8AJzKJjxv7gJxsIljWhlVo5NKB/x0TwIuZL7xf4eb4l
/g1YqHVaOKNjV9lB91OFPHVX7O9Liuzlew1ODC5SOMHG6ehS9qVV+W3sOTYCRTDi
kALb4gRDTiYBUepmbfFPoAEw0KtVdYsdjrDk2cSghD9nGvon6n/fCokUcCs0oSR3
ASyinmSrGJ0aMUh6cLXtCVbpcs6gmO/DQunAL5sZspyB+3J/Fknv5Q==
=6uLJ
-----END PGP SIGNATURE-----
--=-=-=--
