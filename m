Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8090830965C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 16:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhA3PrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhA3Pod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:44:33 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64AC06178B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 07:43:47 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6DFD23EBCC;
        Sat, 30 Jan 2021 16:43:46 +0100 (CET)
Subject: Re: short-circuit and over-current IRQs
To:     matti.vaittinen@fi.rohmeurope.com, Mark Brown <broonie@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
 <20210127122733.GC4387@sirena.org.uk>
 <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
 <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
 <20210127163218.GD4387@sirena.org.uk>
 <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
 <20210128121019.GB4537@sirena.org.uk>
 <a89bf6f0e6c1e4b9afe980908b7e36b70b304a96.camel@fi.rohmeurope.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <536ce0f7-b299-f39c-15e1-a7c1151d0fd8@somainline.org>
Date:   Sat, 30 Jan 2021 16:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a89bf6f0e6c1e4b9afe980908b7e36b70b304a96.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/01/21 10:14, Matti Vaittinen ha scritto:
> 
> On Thu, 2021-01-28 at 12:10 +0000, Mark Brown wrote:
>> On Thu, Jan 28, 2021 at 09:23:08AM +0000, Vaittinen, Matti wrote:
>>> On Wed, 2021-01-27 at 16:32 +0000, Mark Brown wrote:
>>>> Note that the events the API currently has are expected to be for
>>>> the
>>>> actual error conditions, not for the warning ones - indicating
>>>> that
>>>> the
>>>> voltage is out of regulation for example.
>>> I am unsure how to interpret this. What is the criteria of issue
>>> being
>>> an error/warning. When I was talking about warning I meant that the
>>> issue which is detected is unexpected and abnormal (error?) - but
>>> might
>>> still be recoverable (warning?). I understand the regulator
>>> framework
>>> must not signal same events for different purposes - but I don't
>>> really
>>> know what the current events are used for - I am grateful for any
>>> guidance!
>>
>> What the majority of hardware interrupts on is situations where
>> things
>> have already gone out of spec and there are actual problems with the
>> output - for example with current limiting there's often an actual
>> limiter in there so the regulator simply won't supply any more
>> current
>> than is configured.  With a warning everything is still working fine
>> but
>> getting close to not doing so.
>>
>>>> Well, if these things are kicking in the hardware is in serious
>>>> trouble
>>>> anyway so it's unclear what the system would be likely to do in
>>>> software, and also unclear how safe it is to rely on software to
>>>> be
>>>> able
>>>> to take that action given that it let things get into such a bad
>>>> state
>>>> in the first place.
>>> Actually, bear with me but I am unsure why we have these
>>> notifications
>>> if we don't expect SW to be able to do anything? Wouldn't the panic
>>> print be all that is needed then? I think that setups which have
>>> dual
>>
>> You'll notice that there aren't any actual users of this stuff in
>> tree
>> at the minute - people don't generally put much effort into software
>> recovery as they're not expecting to be anywhere near limiting in
>> normal
>> operation.  What I'd expect people to do where they do implement
>> handling is something like shutting down all other supplies on the
>> device, possibly also trying to shut down the system as a
>> whole.  Things
>> more about preventing physical damage rather than being part of the
>> normal operation of the system.
>>
>> For thermal issues systems generally try to apply software limits
>> well
>> before an individual component starts flagging things up with an
>> interrupt, the limits that devices have are generally super high and
>> often there'll be issues at a system level (eg, a case getting
>> unusably
>> hot) earlier and it can take a while for responses to have an impact.
>>
>>> limits (one for initiating potential SW recovery - other for HW to
>>> forcing protection) actually make sense. So does implementing
>>> notifiers
>>> / error statuses for events where SW recovery is potentially
>>> helpful.
>>> But whether the existing event notifications / error flags are
>>> correct
>>> for these is something I can't decide :) Here I ask guidance for
>>> Mark &
>>> others who know what is the idea behind existing error-
>>> flags/events.
>>
>> It's not that we shouldn't implement support for warnings, it's that
>> they're not the common case for hardware and so won't line up with
>> behaviour for other users.

....but anyway, I have no idea what would you do when a warning is
triggered: make a good example, please...

I mean, take for example the "usual display": you are delivering power
to a DriverIC (which is most of the times undocumented), your display
starts drawing more than expected, so... uh.. so what?
You shut it down? You reboot the DrIC?
I can't imagine a DrIC reboot to restore the power draw...

> 
> I have been pondering this - and I guess evaluating the severity of
> these issues belong to board designer's table. (As when to expect
> things be already so wrong that something is broken "ERROR" - or when
> things are approaching the point where things are wrong - but might
> still be recoverable by <insert recovery action here> "WARNING").
> 
> So, what comes to my mind is pushing this decision to a board designer.
> And to me this sounds like device-tree configuration.
> 

That's 100% DT (or ACPI, whatever), since we're in 2020 :P

> For regulator framework that would mean supporting the warning level
> events (and regulator_get_error_flags warning-flags?) too.
> 
> For (my) driver this would mean getting the information from device-
> tree. I didn't yet check the existing DT properties (if any for these
> levels) - but I think we should have something like:
> 
> regulator-over-voltage-protection-microvolt = <>;
> regulator-over-voltage-error-microvolt = <>;
> regulator-over-voltage-warning-microvolt = <>;
> 
> *-protection-* would be point where HW (or driver) shuts down the
> outputs w/o asking questions. (if HW based protection limit can not be
> set but protection can be enabled/disabled then value '1' would mean
> enable, zero would mean disable).
> 

regulator-over-voltage-protection;
^^^ that would look better, since we already have a
"regulator-over-current-protection" property to enable OCP.

Then, my suggestion would be:
regulator-over-voltage-max-microvolt = <uint32>;

And to signal that the hardware will auto-shutdown the rail:
regulator-over-voltage-auto-shutdown;

> *-error-* would be point where driver punts the existing error events
> via notifications allowing consumers to implement what ever is needed
> in order to handle error (which now means that something is likely to
> be broken / out of spec already.
> 

This one would be replaced by the property that I've proposed above

> *-warning-* would be point where driver punts new to-be-invented events
> / error flags and consumers can implement recovery actions assuming the
> HW is still operable but getting to the point where things are going to
> be shut down.
> 

regulator-over-voltage-warn-microvolt = <uint32>;


Less is more, I think. "warn" is shorter, looks nicer to me, but then,
it's not a big deal, that was just a nit.

> The BD9576 would then allow giving either *-error-* or *-warning-*
> properties (not both at least for now) and then selects the flag /
> event based on given property.
> 
> Do you think this makes sense? I hope that having these properties and
> flags/events would help actually utilizing these IRQs from PMICs which
> support them - and also help inventing recovery actions in consumer
> drivers, eventually saving the world for sure :]
> 
> If no one disagrees with this plan, then I know what I am going to do
> next week :]
> 

But then, as I just said, there's already "something" for over-current,
so... if you implement only the OVP stuff, then the implementation would
look "incomplete".
At this point it would be nicer to add another 10 lines of code to
replicate the same on OCP.

Keep in mind, though, that at least the qcom-labibb regulator does *not*
support what you propose: that one has auto-shutdown (OVP) enabled by
default (and *cannot* be disabled), no auto-shutdown on OCP (and no way
to enable it).

So, for labibb then "regulator-over-voltage-auto-shutdown" would be
sort of implicit, so every driver implementing similar hardware would
have to error out in case one property is set (ovp max voltage)but not
the other (auto-shutdown).

In a way, this looks messy.. but it may also make a lot of sense.

> Best Regards
> 	Matti Vaittinen
> 

Yours,
--Angelo
