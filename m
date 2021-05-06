Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A261375139
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhEFJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233765AbhEFJFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:05:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2BBA611EE;
        Thu,  6 May 2021 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620291893;
        bh=ekAsxhnE7xFy9zV3T0+7d+SC3mrkjXptEC+AKaEkLHY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NSsVG+wiMqV6AwtPDhTYkG+H0lPn7BlhSxzxl1p7r4tAT1IkOCke4tTRKLos85jiq
         Mpspkrg0L4pXtfxPv9k3eDXP0aomykSHKivkrQgBvFJ4rCpKgmQYZw2Qpfynb6mTtM
         8tPFiS466t1GBH6Mj5wEQj3si/SVaLh1IOw9lQ36E9INJjd5aCA6qIVkkoUtQv3GZa
         rZuvGlmtKiJqbyFyuQ+FmRrP6wFQYuogXim8MKis03Zny3iJpjgn0zKS3E13D3aYZM
         lfrbtYuTiCjMjRl/4++pzloY4jJwIOwuM7enwqsU3qe2N7IpcmL2UWLTgPchbkSEn+
         vppfASSnLk2/g==
From:   Felipe Balbi <balbi@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Avoid canceling current request
 for queuing error
In-Reply-To: <400b174e-3a09-c172-462a-fdc8a5e24873@synopsys.com>
References: <1620091264-418-1-git-send-email-wcheng@codeaurora.org>
 <5b46e4a1-93ef-2d17-048b-5b4ceba358ae@synopsys.com>
 <513e6c16-9586-c78e-881b-08e0a73c50a8@codeaurora.org>
 <8735v1ibj4.fsf@kernel.org> <20210505151915.GA696631@rowland.harvard.edu>
 <400b174e-3a09-c172-462a-fdc8a5e24873@synopsys.com>
Date:   Thu, 06 May 2021 12:04:43 +0300
Message-ID: <87o8dogrmc.fsf@kernel.org>
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
> Alan Stern wrote:
>> On Wed, May 05, 2021 at 03:57:03PM +0300, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>> On 5/3/2021 7:20 PM, Thinh Nguyen wrote:
>>>>> Hi,
>>>>>
>>>>> Wesley Cheng wrote:
>>>>>> If an error is received when issuing a start or update transfer
>>>>>> command, the error handler will stop all active requests (including
>>>>>> the current USB request), and call dwc3_gadget_giveback() to notify
>>>>>> function drivers of the requests which have been stopped.  Avoid
>>>>>> having to cancel the current request which is trying to be queued, as
>>>>>> the function driver will handle the EP queue error accordingly.
>>>>>> Simply unmap the request as it was done before, and allow previously
>>>>>> started transfers to be cleaned up.
>>>>>>
>>>>
>>>> Hi Thinh,
>>>>
>>>>>
>>>>> It looks like you're still letting dwc3 stopping and cancelling all t=
he
>>>>> active requests instead letting the function driver doing the dequeue.
>>>>>
>>>>
>>>> Yeah, main issue isn't due to the function driver doing dequeue, but
>>>> having cleanup (ie USB request free) if there is an error during
>>>> usb_ep_queue().
>>>>
>>>> The function driver in question at the moment is the f_fs driver in AIO
>>>> mode.  When async IO is enabled in the FFS driver, every time it queues
>>>> a packet, it will allocate a io_data struct beforehand.  If the
>>>> usb_ep_queue() fails it will free this io_data memory.  Problem is tha=
t,
>>>> since the DWC3 gadget calls the completion with -ECONNRESET, the FFS
>>>> driver will also schedule a work item (within io_data struct) to handle
>>>> the completion.  So you end up with a flow like below
>>>>
>>>> allocate io_data (ffs)
>>>>  --> usb_ep_queue()
>>>>    --> __dwc3_gadget_kick_transfer()
>>>>    --> dwc3_send_gadget_ep_cmd(EINVAL)
>>>>    --> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>    --> dwc3_gadget_giveback(ECONNRESET)
>>>> ffs completion callback
>>>> queue work item within io_data
>>>>  --> usb_ep_queue returns EINVAL
>>>> ffs frees io_data
>>>> ...
>>>>
>>>> work scheduled
>>>>  --> NULL pointer/memory fault as io_data is freed
>>=20
>> Am I reading this correctly?  It looks like usb_ep_queue() returns a=20
>> -EINVAL error, but then the completion callback gets invoked with a=20
>> status of -ECONNRESET.
>>=20
>>> I have some vague memory of discussing (something like) this with Alan
>>> Stern long ago and the conclusion was that the gadget driver should
>>> handle cases such as this.=20
>>=20
>> Indeed, this predates the creation of the Gadget API; the same design=20
>> principle applies to the host-side API.  It's a very simple idea:
>>=20
>> 	If an URB or usb_request submission succeeds, it is guaranteed
>> 	that the completion routine will be called when the transfer is
>> 	finished, cancelled, aborted, or whatever (note that this may=20
>> 	happen before the submission call returns).
>>=20
>> 	If an URB or usb_request submission fails, it is guaranteed that
>> 	the completion routine will not be called.
>>=20
>> So if dwc3 behaves as described above (usb_ep_queue() fails _and_ the=20
>> completion handler is called), this is a bug.
>>=20
>> Alan Stern
>>=20
>
>
> Hi Alan,
>
> Yes, it's a bug, no question about that. The concern here is how should
> we fix it.
>
> In dwc3, when the usb_ep_queue() is called, it does 3 main things:
> 1) Put the request in a pending list to be processed
> 2) Process any started but partially processed request and any
> outstanding request from the pending list and map them to TRBs
> 3) Send a command to the controller telling it to cache and process
> these new TRBs
>
> Currently, if step 3) fails, then usb_ep_queue() returns an error status
> and we stop the controller from processing TRBs and return any request
> related to those outstanding TRBs. This is a bug.
>
> My suggestion here is don't immediately return an error code and let the
> completion interrupt inform of a transfer failure. The reasons are:
>
> a) Step 3) happened when the request is already (arguably) queued.
> b) If the error from step 3) is due to command timed out, the controller
> may have partially cached/processed some of these TRBs. We can't simply
> give back the request immediately without stopping the transfer and fail
> all the in-flight request.
> c) It adds unnecessary complexity to the driver and there are a few
> pitfalls that we have to watch out for when handling giving back the
> request.
> d) Except the case where the device is disconnected or that the request
> is already in-flight, step 1) and 2) are always done after
> usb_ep_queue(). The controller driver already owns these requests and
> can be considered "queued".

Oh, I see. Indeed this sounds like the best minimal fix for the -rc and
backporting to stables. We may still want to get back to this at some
point and, potentially, split kick_transfer() into two parts that can
make assumptions about the context where they can be called.

Also, we may want to move the request to the pending list only if the
command succeeds. There should be no race condition as kick_transfer is
always called with interrupts disabled.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmCTsSsRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUjYvQf9G6DFLxLPiV4z1LtRgDehwGNoEj0AE13J
Oj7xKfh+6zhzHQtQhNCc49bgR/vekx/lJp+D43Bj5qtcjkmBI9Rllw+2sRGjbnuK
UoQESaXBpUOCzsqJhZ2ZeYZzSUkFqdggzeouY3oQO6D2KkpApZ4JhSUpIbq9uwrT
vuS1ZoU83DsrTBssFhEz7neusETTwrkZeeRxCeYEbEpU1cBPjRrnw9uX8iJWZ3s0
9Q+YxePSUWuKAXgEaLogqONqHfLnswpCds8G9E2SOlC912Orxrt+O17gMyQLXNfT
J2LUEQKbM531M+Td3X0OdnYwkaXkAbL55GjCEWnnGAIBNw3Nn6KxJw==
=0gdO
-----END PGP SIGNATURE-----
--=-=-=--
