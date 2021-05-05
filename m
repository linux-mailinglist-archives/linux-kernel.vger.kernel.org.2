Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39760373BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhEENAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231899AbhEENAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:00:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC546610E6;
        Wed,  5 May 2021 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620219575;
        bh=fivLajvDreKf59fm8zLN5oleFj4enAQJk96PmnS+VFM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UJAoNiS/suCyoQ+yFp9z39TMZwGVIJSSAGLsC8OZKju6RqWsVDsZHT+t6SaQCSbDR
         dimbcQbbgxNxyhQNRa6tkxxwC0t5MVje+s33f703/Xo7t6rY5QO3G87/52/oTayTz4
         wtVhWwKHh9PWTXsjijubjU3CvRjTjUv/UZURWiaaGK2AjzNAYX289o6bC+5QmkATIW
         Uv0bQ1p3k+jvj/oHLN7+vOIxRMG90AkFKSS01Um03C5D0dU/1ClMSxmfeF21XybHzI
         G/rvUXDD/PrzuA74zoxYeYuRgAscz6hBGZ1rJFiN+ogm23Uv86617K/qlfMrVWGHFp
         IfyYksKgJAjBw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
In-Reply-To: <aca00596-11db-398f-e0c3-4a4d50efbed5@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <e12fc396-76e6-9506-31c8-cfdee3fb7577@synopsys.com>
 <7ef627cf-3f8f-8a52-52c4-ac67ab48b87d@codeaurora.org>
 <5c06dc0a-4274-b6f0-3844-bd8afa1a59f9@synopsys.com>
 <be826457-bcd5-3dc3-0f71-faa3ac60ac63@codeaurora.org>
 <aca00596-11db-398f-e0c3-4a4d50efbed5@synopsys.com>
Date:   Wed, 05 May 2021 15:59:27 +0300
Message-ID: <87zgx9gwuo.fsf@kernel.org>
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

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>>>> allocate io_data (ffs)
>>>>>>  --> usb_ep_queue()
>>>>>>    --> __dwc3_gadget_kick_transfer()
>>>>>>    --> dwc3_send_gadget_ep_cmd(EINVAL)
>>>>>>    --> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>>>    --> dwc3_gadget_giveback(ECONNRESET)
>>>>>> ffs completion callback
>>>>>> queue work item within io_data
>>>>>>  --> usb_ep_queue returns EINVAL
>>>>>> ffs frees io_data
>>>>>> ...
>>>>>>
>>>>>> work scheduled
>>>>>>  --> NULL pointer/memory fault as io_data is freed
>>>>
>>>> Hi Thinh,
>>>>
>>>>>
>>>>> sounds like a race issue.
>>>>>
>>>>
>>>> It'll always happen if usb_ep_queue() fails with an error. Sorry for n=
ot
>>>> clarifying, but the "..." represents executing in a different context
>>>> :). Anything above the "..." is in the same context.
>>>>>>
>>>>>>> BTW, what kinds of command and error do you see in your setup and f=
or
>>>>>>> what type endpoint? I'm thinking of letting the function driver to
>>>>>>> dequeue the requests instead of letting dwc3 automatically
>>>>>>> ending/cancelling the queued requests. However, it's a bit tricky t=
o do
>>>>>>> that if the error is -ETIMEDOUT since we're not sure if the control=
ler
>>>>>>> had already cached the TRBs.
>>>>>>>
>>>>>>
>>>>>> Happens on bulk EPs so far, but I think it wouldn't matter as long as
>>>>>> its over the FFS interface. (and using async IO transfers)
>>>>>
>>>>> Do you know which command and error code? It's strange if
>>>>> UPDATE_TRANSFER command failed.
>>>>>
>>>>
>>>> Sorry for missing that part of the question.  It is a no xfer resource
>>>> error on a start transfer command.  So far this happens on low system
>>>> memory test cases, so there may be some sequences that were missed,
>>>> which led to this particular command error.
>>>>
>>>> Thanks
>>>> Wesley Cheng
>>=20
>> Hi Thinh,
>>=20
>>>
>>> No xfer resource usually means that the driver attempted to send
>>> START_TRANSFER without waiting for END_TRANSFER command to complete.
>>> This may be a dwc3 driver issue. Did you check this?
>>>
>>> Thanks,
>>> Thinh
>>>
>>>
>>=20
>> Yes, we know the reason why this happens, and its due to one of the
>> downstream changes we had that led to the scenario above.  Although,
>> that has been fixed, I still believe the error path is a potential
>> scenario we'd still want to address.
>>=20
>> I think the returning success always on dwc3_gadget_ep_queue(), and
>> allowing the error in the completion handler/giveback at the function
>> driver level to do the cleanup is a feasible solution.  Doesn't change
>> the flow of the DWC3 gadget, and so far all function drivers we've used
>> handle this in the correct manner.
>>=20
>> Thanks
>> Wesley Cheng
>
> Right. I think for now we should do that (return success always except
> for cases of disconnect or already in-flight etc). This helps keeping it

no, let's not lie to our users ;-)

> simple and avoid some pitfalls dealing with giving back the request.
> Currently we return the error status to dwc3_gadget_ep_queue if we
> failed to send a command that may not even related to the same request
> being queued.

I think the fix should be simple, but we're trying to patch it in the
wrong way. Can y'all comment on my suggestion on the other subthread?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCSlq8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUiKywf+Kf6+pp3/TXCFlwOeZsJ9yrd9oTCv/wYu
N1Q02wXnbRRuDioIRMYYBcRrpC7KV7/I5bieDSEoZuNvMl0lZ0HJ3dYjMpKzX9gE
XsLDFFChrs13HCs8ETPNOtbMAAPF9ljnRvlMns4y4jLRntUwzRUxLxpc8acI1ufa
A3ss5cDbbmXig6SHOeyHysCOWAndGSN0zPjT2zrTKdmOBKjZkB5hhkE9ZMiMm0ng
mL24HmTtRk6sa544/+VQtbtwCT+COiLH/LLxQxsI/LPgcZSuQ+o7ow7w52pbeLHN
slo5zwkDTttCCFVYYmAY1DmTB5UEX0ctjFXL7uGvpRPvTAWYOX8zjQ==
=RbDY
-----END PGP SIGNATURE-----
--=-=-=--
