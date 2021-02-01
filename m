Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8262B30A28E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhBAHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:15:57 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:44101 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBAHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:15:33 -0500
Received: by mail-lf1-f43.google.com with SMTP id p21so21267079lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 23:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=sbehkbrFsXF55Kfra6PClHqSkx1WfV59zQA4kfbVUHA=;
        b=mFL7Z0LwpEln9HF8CXQLgvOtfcSYOUq31qMRgxAyvUt66e+ByLkrYBkvsaBxjgJ3dn
         GEJnLwHDbsv0gQUcmFmnT+LuK0nYDVukRpkYbJQOlAPEXzpYvbkd19/DGQPbHsG88qeP
         xq2fEGKnACpmbwjOAJnEvX5PcWjjzKMMd3ZHsvjRKmrqEw7cEgYe5zXUBFgVGWk8FBfR
         TzIDYJ21HwAsoul3jeQo3sfboDMjhLFgkq7j+UZc2u6+0NSXGZWSvK0RsvMJq7Ua+qlK
         kJjtoSMh+CrgBicmpbmAwuwTTAz/GbjWlOQpH2BDsX9ObgUrJZvaD8XiVAPiXONBtZBi
         ndmQ==
X-Gm-Message-State: AOAM5333cl8QyXUh7Hxb2GoEFFzWwO5geUiMSTP0q7yc1xnQmNMjvq3C
        EEmMfKos/RVImjr6wYWCYo0=
X-Google-Smtp-Source: ABdhPJwOnoZBioXFcV709//LGAEbXdHT31zM49Oqx1ocasaVavFL2/vIx/UFlwqhRf/QFQbsmEP+DA==
X-Received: by 2002:a19:4c02:: with SMTP id z2mr7525424lfa.590.1612163689819;
        Sun, 31 Jan 2021 23:14:49 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 8sm2885055lfz.113.2021.01.31.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 23:14:49 -0800 (PST)
Message-ID: <a233ea5d094ff65072359df9be1ac689538ae9c5.camel@fi.rohmeurope.com>
Subject: Re: short-circuit and over-current IRQs
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Mark Brown <broonie@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <536ce0f7-b299-f39c-15e1-a7c1151d0fd8@somainline.org>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
         <20210127122733.GC4387@sirena.org.uk>
         <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
         <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
         <20210127163218.GD4387@sirena.org.uk>
         <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
         <20210128121019.GB4537@sirena.org.uk>
         <a89bf6f0e6c1e4b9afe980908b7e36b70b304a96.camel@fi.rohmeurope.com>
         <536ce0f7-b299-f39c-15e1-a7c1151d0fd8@somainline.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 01 Feb 2021 09:14:42 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-01-30 at 16:43 +0100, AngeloGioacchino Del Regno wrote:
> Il 29/01/21 10:14, Matti Vaittinen ha scritto:
> > On Thu, 2021-01-28 at 12:10 +0000, Mark Brown wrote:
> > > On Thu, Jan 28, 2021 at 09:23:08AM +0000, Vaittinen, Matti wrote:
> > > > On Wed, 2021-01-27 at 16:32 +0000, Mark Brown wrote:
> > > > > limits (one for initiating potential SW recovery - other for
> > > > > HW
> > > > to
> > > > forcing protection) actually make sense. So does implementing
> > > > notifiers
> > > > / error statuses for events where SW recovery is potentially
> > > > helpful.
> > > > But whether the existing event notifications / error flags are
> > > > correct
> > > > for these is something I can't decide :) Here I ask guidance
> > > > for
> > > > Mark &
> > > > others who know what is the idea behind existing error-
> > > > flags/events.
> > > 
> > > It's not that we shouldn't implement support for warnings, it's
> > > that
> > > they're not the common case for hardware and so won't line up
> > > with
> > > behaviour for other users.
> 
> ....but anyway, I have no idea what would you do when a warning is
> triggered: make a good example, please...

Unfortunately, I typically lost the visibility to final solutions :( I
guess that's the prize I must pay for working for a component vendor
nowadays. I've heard "word of mouth" that some setup had issues with
graphics accelerator heating - which was solved by cutting the power
from this IC (via regulator control) when things went wrong. Sure the
video playing was 'stopped' - but rest of the device remained usable
and no data was lost. But as I said, this is what I heard of - not what
I've done.

OTOH. I never stop being surprized by what people invent when they have
a problem to work around. I've seen a phone-like device which had
start-up problems at times - and which did 'secret reboot' by keeping
display running while rebooting - and due to fast reboot this resulted
actually a good user experience. My point? I am positive that by giving
the tools to invent work-around for problem - there will be a work-
around using that tool :)

> > For regulator framework that would mean supporting the warning
> > level
> > events (and regulator_get_error_flags warning-flags?) too.
> > 
> > For (my) driver this would mean getting the information from
> > device-
> > tree. I didn't yet check the existing DT properties (if any for
> > these
> > levels) - but I think we should have something like:
> > 
> > regulator-over-voltage-protection-microvolt = <>;
> > regulator-over-voltage-error-microvolt = <>;
> > regulator-over-voltage-warning-microvolt = <>;
> > 
> > *-protection-* would be point where HW (or driver) shuts down the
> > outputs w/o asking questions. (if HW based protection limit can not
> > be
> > set but protection can be enabled/disabled then value '1' would
> > mean
> > enable, zero would mean disable).
> > 
> 
> regulator-over-voltage-protection;
> ^^^ that would look better, since we already have a
> "regulator-over-current-protection" property to enable OCP.
> 
> Then, my suggestion would be:
> regulator-over-voltage-max-microvolt = <uint32>;
> 
> And to signal that the hardware will auto-shutdown the rail:
> regulator-over-voltage-auto-shutdown;

This would prevent having limits for both the protection and error at
same time, right? I would like to have separate property for HW-
specific shut-down (or shutdown by driver W/O any consumer driver
actions - which seems like HW originated shut-down). This is why I
wanted to have *-protection-* and *-error-*. Most of the ROHM ICs
actually provide the 'protection' - although the limit is rarely
configurable. (I am unsure if it is configurable on any ROHM PMIC I've
worked with) I still think allowing limit would be Ok in order to keep
all of the properties "looking" the same. Few ICs (like the BD9576MUF)
additionally support the 'notification IRQ' with configurable limit -
and this is where we can allow board designer to set this as error or
warning. I am thinking that for BD9576 we should allow setting:

'protection' 	(disable/enable) "HW originated shutdown"
and additionally either
'error'		(limit/disable/enable) "existing err notification"
or 
'warning' (limit/disable/enable) "new warning notification"

So - we would need separate properties for all 3 levels. As I said, I
would like to add the 'limit' also for protection to keep it identical
to error and warning levels.

The thing that bugs me with these limit properties and actually with
many other 'safety related' properties (like charger current/voltage
limits/thresholds at battery nodes) is that when the parsing is left
for IC drivers - then we see no warning when property is given but
driver does not care about it. This is why I think parsing these
properties should be left for the regulator core - and IC drivers
should only fill the enable/disable/set-limit callbacks in ops. The
core could spill a warning if DT defines these limits but the IC driver
does not provide callbacks. (just a thought).

> > *-error-* would be point where driver punts the existing error
> > events
> > via notifications allowing consumers to implement what ever is
> > needed
> > in order to handle error (which now means that something is likely
> > to
> > be broken / out of spec already.
> > 
> 
> This one would be replaced by the property that I've proposed above
> 
> > *-warning-* would be point where driver punts new to-be-invented
> > events
> > / error flags and consumers can implement recovery actions assuming
> > the
> > HW is still operable but getting to the point where things are
> > going to
> > be shut down.
> > 
> 
> regulator-over-voltage-warn-microvolt = <uint32>;
> 
> 
> Less is more, I think. "warn" is shorter, looks nicer to me, but
> then,
> it's not a big deal, that was just a nit.

Thanks for suggestion. I think warn is indeed better. :) I will try to
get the patch done - I am sure it will probably invoke some comments
from Rob as well :)

> 
> > The BD9576 would then allow giving either *-error-* or *-warning-*
> > properties (not both at least for now) and then selects the flag /
> > event based on given property.
> > 
> > Do you think this makes sense? I hope that having these properties
> > and
> > flags/events would help actually utilizing these IRQs from PMICs
> > which
> > support them - and also help inventing recovery actions in consumer
> > drivers, eventually saving the world for sure :]
> > 
> > If no one disagrees with this plan, then I know what I am going to
> > do
> > next week :]
> > 
> 
> But then, as I just said, there's already "something" for over-
> current,
> so... if you implement only the OVP stuff, then the implementation
> would
> look "incomplete".
> At this point it would be nicer to add another 10 lines of code to
> replicate the same on OCP.

Yep. BD9576MUF has configurable OCP for one of the power rails.

> Keep in mind, though, that at least the qcom-labibb regulator does
> *not*
> support what you propose: that one has auto-shutdown (OVP) enabled by
> default (and *cannot* be disabled), no auto-shutdown on OCP (and no
> way
> to enable it).

This is why I am thinking we should put the DT parsing to core and
allow ICs just to provide operations for configuring them. If qcom-
labibb does not allow configurations - then it won't provide
configuration callbacks and if DT limits/enable/disable is attempted
the core can emit a warning(?)

> So, for labibb then "regulator-over-voltage-auto-shutdown" would be
> sort of implicit, so every driver implementing similar hardware would
> have to error out in case one property is set (ovp max voltage)but
> not
> the other (auto-shutdown).

This is why it should be in core. And warning only because we don't
have information about 'implicit features'. We could add a flag for
'implicit protection' to allow drivers to prevent core from emitting
unnecessary warnings - (something like a bit-mask: 
#define REGULATOR_PROT_OVP BIT(0)
#define REGULATOR_PROT_OCP BIT(1)
#define REGULATOR_PROT_UVP BIT(2)
#define REGULATOR_PROT_TEMP BIT(3)
...
int hw_fixed_prot; 

in regulator desc) - but I am not sure what to thin about it now. Let's
discuss further when I get something actually done and we see what it
looks like :)

> 
> In a way, this looks messy.. but it may also make a lot of sense.

I do agree :) Thanks for investing the time to this! Much appreciated!
It is really nice to see someone cares for the work I do XD


Best Regards
	Matti Vaittinen


--
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland
SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~

Simon says - in Latin please.
"non cogito me" dixit Rene Descarte, deinde evanescavit

(Thanks for the translation Simon)


