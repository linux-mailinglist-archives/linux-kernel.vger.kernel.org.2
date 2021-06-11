Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26D3A3D03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFKHZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhFKHZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59DBB613AE;
        Fri, 11 Jun 2021 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623396231;
        bh=7i7gJQUHNqqXBUiJEAnQsQmRrrTsF9/fDsbVGth+hak=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pb2MI9h8QnMlXdZJT+ifYgYeQnBaNEI3KkXFlWhAZlO43Y4mXxFwF5iKTE3X+YyfZ
         a3NxcSwLtzrlY7fs5nor8lDtMrsuTnDM8eYK8ISMQ1h2D83lHTmjT2vLOWvCzhFtpm
         pJSqVZlfMtExU4XKZ0DNo3nF66fX+f61XavTDSuTcfyyyIFi2UV9uxg5ROwNX88kUL
         QqZbGnkDi9gshHewunj8iCpId1pgJAF6DL59rW91c2TVzDtzObzAX8B79UNI8T2GVS
         XSG0fm7SgmyCtaiMrwb7DhL3rQSOIDrq8QiUVikER0KJwAABeMNXHFCONlugRfn0HR
         TLDZ7IZi5Z0iQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup
 disable
In-Reply-To: <a59a81c1-367f-b4b0-b6bf-dbe91ab3613d@codeaurora.org>
References: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
 <87h7i60ye8.fsf@kernel.org>
 <724ba69a-8c67-4b4b-3e6a-a5834b09e6e1@codeaurora.org>
 <a59a81c1-367f-b4b0-b6bf-dbe91ab3613d@codeaurora.org>
Date:   Fri, 11 Jun 2021 10:23:43 +0300
Message-ID: <87wnr0zwxs.fsf@kernel.org>
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

> On 6/10/2021 11:21 AM, Wesley Cheng wrote:
>>=20
>>=20
>> On 6/10/2021 4:09 AM, Felipe Balbi wrote:
>>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>>
>>>> Current sequence utilizes dwc3_gadget_disable_irq() alongside
>>>> synchronize_irq() to ensure that no further DWC3 events are generated.
>>>> However, the dwc3_gadget_disable_irq() API only disables device
>>>> specific events.  Endpoint events can still be generated.  Briefly
>>>> disable the interrupt line, so that the cleanup code can run to
>>>> prevent device and endpoint events. (i.e. __dwc3_gadget_stop() and
>>>> dwc3_stop_active_transfers() respectively)
>>>>
>>>> Without doing so, it can lead to both the interrupt handler and the
>>>> pullup disable routine both writing to the GEVNTCOUNT register, which
>>>> will cause an incorrect count being read from future interrupts.
>>>>
>>>> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting =
the controller")
>>>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>>>> ---
>>>>  drivers/usb/dwc3/gadget.c | 11 +++++------
>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 49ca5da..89aa9ac 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -2260,13 +2260,10 @@ static int dwc3_gadget_pullup(struct usb_gadge=
t *g, int is_on)
>>>>  	}
>>>>=20=20
>>>>  	/*
>>>> -	 * Synchronize any pending event handling before executing the contr=
oller
>>>> -	 * halt routine.
>>>> +	 * Synchronize and disable any further event handling while controll=
er
>>>> +	 * is being enabled/disabled.
>>>>  	 */
>>>> -	if (!is_on) {
>>>> -		dwc3_gadget_disable_irq(dwc);
>>>> -		synchronize_irq(dwc->irq_gadget);
>>>> -	}
>>>> +	disable_irq(dwc->irq_gadget);
>>>>=20=20
>>>>  	spin_lock_irqsave(&dwc->lock, flags);
>>>
>>> spin_lock_irqsave() is already disabling interrupt, right? Why do we
>>> need another call to disable_irq()?
>>>
>>=20
>> Hi Felipe,
>>=20
>> Yes, I remember you brought up that point as well before.  So when I
>> checked the logs (USB and scheduler ftrace) for this issue, I clearly
>> saw that we were handling a soft disconnect on CPU3 and then an DWC3 IRQ
>> being scheduled into CPU0.  Last time we discussed, I mentioned that
>> spin_lock_irqsave() only disables interrupts on that particular CPU the
>> thread is running on.
>>=20
> Hi Felipe,
>
> Let me share the ftrace snippets as well:
>
> USB FTRACE:
>
> <idle>-0    [002]   304.567900:  dwc3_gadget_ep_cmd name=3Dep0out cmd=3D1=
030  param0=3D0  param1=3D4026523648  param2=3D0  cmd_status=3D0
> <idle>-0    [004]   304.583225:  dwc3_gadget_ep_cmd name=3Dep1out cmd=3D1=
34152  param0=3D0  param1=3D0  param2=3D0  cmd_status=3D0
>
> //We don't have any logging in pullup disable, but this is when that
> occurs, as we start to see -ESHUTDOWN statuses due to stop active
> transfer.

argh, maybe we should add :-)

I noticed that the logs here look different. Did you modify dwc3 trace
events or is it a special tracer (just curious)? Anyway...

> <idle>-0    [004]   304.583237:  dwc3_gadget_giveback name=3Dep1out req=
=3D1243650560  actual=3D0  length=3D16384  status=3D4294967188  zero=3D0 sh=
ort_not_ok=3D0  no_interrupt=3D0
> <idle>-0    [004]   304.583275:  dwc3_gadget_giveback name=3Dep1out req=
=3D1243645440  actual=3D0  length=3D16384  status=3D4294967188  zero=3D0 sh=
ort_not_ok=3D0  no_interrupt=3D0
> <idle>-0    [004]   304.583282:  dwc3_gadget_giveback name=3Dep1out req=
=3D1243648256  actual=3D0  length=3D16384  status=3D4294967188  zero=3D0 sh=
ort_not_ok=3D0  no_interrupt=3D0
> <idle>-0    [004]   304.583312:  dwc3_gadget_giveback name=3Dep1out req=
=3D4075146240  actual=3D0  length=3D16384  status=3D4294967188  zero=3D0 sh=
ort_not_ok=3D0  no_interrupt=3D0
> ...
> //USB gadget disconnect is printed AFTER the pullup(0) routine is complet=
e.
> <idle>-0    [004]   304.584240:  usb_gadget_disconnect   speed=3D3 max_sp=
eed=3D6  state=3D7  mA=3D500  sg_supported=3D1  is_otg=3D0 is_a_peripheral=
=3D0  b_hnp_enable=3D0  a_hnp_support=3D0 hnp_polling_support=3D0  host_req=
uest_flag=3D0  quirk_ep_out_aligned_size=3D0 quirk_altset_not_supp=3D0  qui=
rk_stall_not_supp=3D0  quirk_zlp_not_supp=3D0 is_selfpowered=3D0  deactivat=
ed=3D0  connected=3D1  ret=3D4294967186
>
> ---------------------------------------------------------
> CPU2 SCHED FTRACE:
>
> kworker/u16:5-192    [002]   304.583354:  irq_handler_entry   irq=3D343 n=
ame=3Ddwc3-msm
> kworker/u16:5-192    [002]   304.583356:  irq_handler_exit   irq=3D343 re=
t=3D0
> kworker/u16:5-192    [002]   304.583358:  irq_handler_entry   irq=3D343 n=
ame=3Ddwc3
> kworker/u16:5-192    [002]   304.583366:  irq_handler_exit   irq=3D343 re=
t=3D2
> kworker/u16:5-192    [002]   304.583377:  sched_wakeup comm=3Dirq/343-dwc=
3  pid=3D20174  prio=3D100  success=3D1  target_cpu=3D2
> kworker/u16:5-192   [002]  304.583411: sched_switch: prev_comm=3Dkworker/=
u16:5 prev_pid=3D192 prev_prio=3D120 prev_state=3DR =3D=3D> next_comm=3Dirq=
/343-dwc3 next_pid=3D20174 next_prio=3D100
> irq/343-dwc3-20174    [002]   304.583454:  irq_handler_entry   irq=3D343 =
name=3Ddwc3-msm
> irq/343-dwc3-20174    [002]   304.583455:  irq_handler_exit   irq=3D343 r=
et=3D0
> irq/343-dwc3-20174    [002]   304.583458:  irq_handler_entry   irq=3D343 =
name=3Ddwc3
> irq/343-dwc3-20174    [002]   304.583465:  irq_handler_exit   irq=3D343 r=
et=3D2
>
> So if we assume that the point of error happens @ 304.567900 due to the
> below points:
> - DWC3 pullup disable routine synchronized IRQs (w/ previous logic)
> before calling stop active transfers.
> - DWC3 request statuses shows ESHUTDOWN, which occurs during stop active
> transfer, as we call giveback w/ that error code
>
> Then we can see that on CPU2, we're still getting DWC3 core IRQs, and
> DWC3 IRQ handler is returning --> 2, which is IRQ_WAKE_THREAD.

very good breakdown of the problem, thank you :-) What if we move the
spin_lock_irqsave() before that !is_on check and do away with
synchronize IRQ?

Then the only thing left would be ignore the interrupt events if they
still come, no?

Something like:

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 612825a39f82..aff9a4673830 100644
=2D-- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2260,20 +2260,12 @@ static int dwc3_gadget_pullup(struct usb_gadget *g,=
 int is_on)
                return 0;
        }

=2D       /*
=2D        * Synchronize any pending event handling before executing the co=
ntroller
=2D        * halt routine.
=2D        */
=2D       if (!is_on) {
=2D               dwc3_gadget_disable_irq(dwc);
=2D               synchronize_irq(dwc->irq_gadget);
=2D       }
=2D
        spin_lock_irqsave(&dwc->lock, flags);

        if (!is_on) {
                u32 count;

+               dwc3_gadget_disable_irq(dwc);
                dwc->connected =3D false;
                /*
                 * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
@@ -3873,6 +3865,9 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_e=
vent_buffer *evt)
        if (!count)
                return IRQ_NONE;

+       if (!dwc->connected)
+               goto out_ignore;
+
        evt->count =3D count;
        evt->flags |=3D DWC3_EVENT_PENDING;

@@ -3887,6 +3882,7 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_e=
vent_buffer *evt)
        if (amount < count)
                memcpy(evt->cache, evt->buf, count - amount);

+out_ignore:
        dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);

        return IRQ_WAKE_THREAD;


(totally untested, mind you :)

Ignoring the events in dwc3_check_event_buf() may be unnecessary since
we're already doing that in dwc3_pullup() after __dwc3_gadget_stop().

What do you think?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDDD38RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhQpAf+LOZFJ60UWyj5R2MTYmxuC93M8PM9rv/I
bL5B3/pwgpEMlYtyPqLokhnVhl6VeBwFObo9E8vYzl9vGTe6ihmygIxC/xkXemfd
iFRveEhf5w2injAPntVrCJP9urOJvlDZn3BBpvWTTzoWYnki5eFqubMxm6aHSfM+
qD5SYjKeIjME/4ToH0FG+lMs8Gl5ewpiS5kHAbO9yA7iPogWe6l/WSbKMs29XONe
jLWWaDov/K6REAOfKdmEx01AvmyvQ+q4vJjT9ne0tsXrgkuk+P6iwWVHE6fMtHxE
+8pwJpYQSGf3dMKuEweOqVLBCLO94zzdopynxmP5aHeJnJvzg9SfAA==
=hixW
-----END PGP SIGNATURE-----
--=-=-=--
