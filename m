Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99C63D08E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhGUFuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233627AbhGUFuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD7FF61009;
        Wed, 21 Jul 2021 06:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626849045;
        bh=LMgiDG+AUmFohhoLx005Uu8y4csMp/qVbebolLVz2K4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aozV/IdCSbNc1QJH5GXe9w84mFC6pY+NBGw+/atE2J1+Pvn8rvD8kY71jTicR/2TA
         +sKBXwcwi4DCIMPLkEJZkMwtGuP92fXj0zDdQ7SMqLoH9hiGXRjjVAj50VgPdPyOom
         jK+JRJbA7hA4aq6WX9f6oROpQiUguCRJyKy0BC+kMM0MAjjTIjFeHStfulr6k+4qeC
         DQ8K1+CSMOfgGBljWriI1n8ddKyUuWomWaEzbN1sXkmWuoVesN+PQbDa5mm6sNfFM4
         QfAl7kSJIOLfXFrGWs9O74aiolyKawuck5eCwE2qa68fXvFRqz5Ym3VPsLWYHT6gIC
         D9s5CQVuO/gWg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Replace
 list_for_each_entry_safe() if using giveback
In-Reply-To: <fc346f3c-6e3d-b96c-d64a-2ae4cf4218d4@codeaurora.org>
References: <1620716636-12422-1-git-send-email-wcheng@codeaurora.org>
 <87tun9g01v.fsf@kernel.org>
 <2675db9e-0cab-06b5-2986-0b4456a1f040@codeaurora.org>
 <5156238d-c1d8-a0d3-47af-8b52467fd071@codeaurora.org>
 <fc346f3c-6e3d-b96c-d64a-2ae4cf4218d4@codeaurora.org>
Date:   Wed, 21 Jul 2021 09:30:36 +0300
Message-ID: <87v954xjoz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Wesley,

(first of all, sorry for the super long delay. This really fell through
the cracks)

Wesley Cheng <wcheng@codeaurora.org> writes:
> Hi Felipe,
>
> On 6/9/2021 1:57 PM, Wesley Cheng wrote:
>> Hi Felipe,
>>=20
>> On 5/19/2021 1:52 AM, Wesley Cheng wrote:
>>>
>>>
>>> On 5/11/2021 1:13 AM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>>> The list_for_each_entry_safe() macro saves the current item (n) and
>>>>> the item after (n+1), so that n can be safely removed without
>>>>> corrupting the list.  However, when traversing the list and removing
>>>>> items using gadget giveback, the DWC3 lock is briefly released,
>>>>> allowing other routines to execute.  There is a situation where, while
>>>>> items are being removed from the cancelled_list using
>>>>> dwc3_gadget_ep_cleanup_cancelled_requests(), the pullup disable
>>>>> routine is running in parallel (due to UDC unbind).  As the cleanup
>>>>> routine removes n, and the pullup disable removes n+1, once the
>>>>> cleanup retakes the DWC3 lock, it references a request who was already
>>>>> removed/handled.  With list debug enabled, this leads to a panic.
>>>>> Ensure all instances of the macro are replaced where gadget giveback
>>>>> is used.
>>>>>
>>>>> Example call stack:
>>>>>
>>>>> Thread#1:
>>>>> __dwc3_gadget_ep_set_halt() - CLEAR HALT
>>>>>   -> dwc3_gadget_ep_cleanup_cancelled_requests()
>>>>>     ->list_for_each_entry_safe()
>>>>>     ->dwc3_gadget_giveback(n)
>>>>>       ->dwc3_gadget_del_and_unmap_request()- n deleted[cancelled_list]
>>>>>       ->spin_unlock
>>>>>       ->Thread#2 executes
>>>>>       ...
>>>>>     ->dwc3_gadget_giveback(n+1)
>>>>>       ->Already removed!
>>>>>
>>>>> Thread#2:
>>>>> dwc3_gadget_pullup()
>>>>>   ->waiting for dwc3 spin_lock
>>>>>   ...
>>>>>   ->Thread#1 released lock
>>>>>   ->dwc3_stop_active_transfers()
>>>>>     ->dwc3_remove_requests()
>>>>>       ->fetches n+1 item from cancelled_list (n removed by Thread#1)
>>>>>       ->dwc3_gadget_giveback()
>>>>>         ->dwc3_gadget_del_and_unmap_request()- n+1 deleted[cancelled_=
list]
>>>>>         ->spin_unlock
>>>>>
>>>>> Fixes: d4f1afe5e896 ("usb: dwc3: gadget: move requests to cancelled_l=
ist")
>>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>>> Reviewed-by: Peter Chen <peter.chen@kernel.org>
>>>>> ---
>>>>> Changes in v2:
>>>>>  - Updated commit message with context call stack of an example scena=
rio
>>>>>    seen on device.
>>>>>
>>>>>  drivers/usb/dwc3/gadget.c | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>> index dd80e5c..efa939b 100644
>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>> @@ -1737,10 +1737,10 @@ static void dwc3_gadget_ep_skip_trbs(struct d=
wc3_ep *dep, struct dwc3_request *r
>>>>>  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep=
 *dep)
>>>>>  {
>>>>>  	struct dwc3_request		*req;
>>>>> -	struct dwc3_request		*tmp;
>>>>>  	struct dwc3			*dwc =3D dep->dwc;
>>>>>=20=20
>>>>> -	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
>>>>> +	while (!list_empty(&dep->cancelled_list)) {
>>>>> +		req =3D next_request(&dep->cancelled_list);
>>>>
>>>> couldn't this be solved list_replace_init() instead? Then we can keep
>>>> using the regular list_for_each_entry_safe() which has an added semant=
ic
>>>> meaning due to its name.
>>>>
>>>
>>> Hi Felipe,
>>>
>>> Sorry for the late response.  So I tried with a list_replace_init() to
>>> within the list_for_each_entry_safe() loop to update tmp w/ the
>>> cancelled_list list head, but the issue was still observed.  This is
>>> because we can't replace the reference the loop already has stored in
>>> tmp, which is simply updated as the current item on the next iteration.
>>>
>>> I believe this is what you were trying to achieve?
>>>
>> Was wondering if you had any further inputs on this change?  As
>> mentioned, I tried a few things with list_replace_init(), which did not
>> work.
>>=20
>
> Sorry for the ping.  Is this change OK to add as is?  We've been running
> into this instance pretty frequently during our testing, so just wanted
> to close on the proper changes being merged upstream.

The idea is this:

	struct list_head	local;

        spin_lock_irq(&lock);
        list_replace_init(&dwc->cancelled_list, &local);
        spin_unlock_irq(&lock);

	list_for_each_entry_safe(req, tmp, &local, list) {
        	/* ... */
	}

It looks to me this should work fine, no? You can also follow what
drivers/usb/core/hcd.c is doing in usb_giveback_urb_bh() and restarting
if dwc->cancelled_list is not empty after list_for_each_entry_safe().

Can you give that one a shot?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmD3vwwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUh8gAf8C4yEtZxAbGgVPHxn/ZCyJOgrbOXvuGX/
UoZg/65o8qKIFTwhP/+15Oyr59Bdnk2GJnTGRHhf2wOXLKUN5piybUxlXrqRK7Ey
ueD0PQz/1T/AuWS49pNz6L79qgj9Eab+meYl3usfT8C7HR8Nwh6OzTdBYC21delx
zW3eqkWI2czDParWXChpdP3n3prsv46hMM8yT8LEhKXPSjZkj+K2aRxOMqyDKsOL
+QfIAxwAGaYRFCH6inJo/bpYjZbR3wtugqu5JyoGwgiXgtJwNK4j3KbcP02wg3uJ
DLo1L1Xc+5V7egCl73SPhs7fjPxoPcE4SW/hawzKlTDaGgO7FK2Rqg==
=9pZO
-----END PGP SIGNATURE-----
--=-=-=--
