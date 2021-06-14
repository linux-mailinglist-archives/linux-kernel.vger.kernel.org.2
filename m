Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D360E3A6B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhFNQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:03:18 -0400
Received: from mail-il1-f175.google.com ([209.85.166.175]:40615 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhFNQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:03:15 -0400
Received: by mail-il1-f175.google.com with SMTP id b14so12652838ilq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bXIOpXty1ev+pQBgiRMuI/vbY9HsNHNYSyOaqdGDdmk=;
        b=LnFuMHr+mk21j0sg9Q6t/q84i7xlqR50j+7vXt6Odzpvl3A0pKoGDsQOTH5Apr6Tvt
         PRAFuAXcGXmxetZobzS1V/sZrPH/VkeYdyI+BxQb/U/kjUKigJnU20k9niLDbEFJ7SSf
         yO8KwIxv5T86ZUUh2yT+TQiUVqZMwSXAv6ntWKPdYxhYmf4QgnCuTRraqEGWLNFPWyc/
         05tf8oOWSazHAhjWmJs1cbL4s9wixeXAddtekQztD2X1jCdKLxUY7d6GviceIKO+fyGq
         maaNL5BsoijvRtPjY3BMxYzldvdrOFg+vxbuyf9bUC+pbEtcm5qOrvVGlJLOgK+8KF2c
         gGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bXIOpXty1ev+pQBgiRMuI/vbY9HsNHNYSyOaqdGDdmk=;
        b=NKA8QhZRAs1b2XNZVha3Ho0EhTipqZFAiEk9JW93N6nTa+zFYJ8rEQ7mtmiQVRAHea
         MP0Whcz4d7qMyXVMiDhijkaFfAyZTrUY182KG7Au2NdlZhmCj/2A+kWqjzlm+cImGIAv
         3RlGIBd++fWEMXXc0rQX4nwzzYyQTFf9j85UeR2g7EpH/vcdlh3qGh0wUFyofzFn95nT
         Zf8yG4jjGSOVt5lSPyKJK0PIONEL4j4CGkdl/494QJKD95wPqq1BxKR52BGOazceL5Sn
         ggEFozBuJupmNGSR5ekuXRJ/3kceg+erCWxMb2v170+1OK9Y+igxFkxchYfV8JjGTKsT
         sPbg==
X-Gm-Message-State: AOAM531GK5JEL68f5FsY9BnQnvLIdZpUG5oAPupoxL+7JzoTAo+6FD7l
        YgedDad59hAIADs1yMPyVSgukvs64v9fyu3C+fbT6bAmhmU=
X-Google-Smtp-Source: ABdhPJwnnFtTMbFvOWbgHXJsCmicLdY+oAlpdvUauCveDLj6gZH8gAuOmlughZHyjQolLt0hn1zFu+ZGENWVbSeRUMs=
X-Received: by 2002:a92:260b:: with SMTP id n11mr14248059ile.134.1623686400589;
 Mon, 14 Jun 2021 09:00:00 -0700 (PDT)
MIME-Version: 1.0
From:   denis bider <denisbider.ietf@gmail.com>
Date:   Mon, 14 Jun 2021 10:59:49 -0500
Message-ID: <CADPMZDD=1W-jb+9o15djZ-VhdzB8=RT1oNQJ=DxBmcvXhcjnCg@mail.gmail.com>
Subject: Linus's "let's kill people" rant (Re: Maintainers / Kernel Summit
 2021 planning kick-off)
To:     linux-kernel@vger.kernel.org, torvalds@transmeta.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus -

what you wrote here on June 10 is fatally wrong. You mistake a neat,
cute narrative of how we imagine mRNA works, with what these vaccines
actually do in the body.

You owe it to yourself, and to anyone who trusts you, to postpone
non-urgent work, and spend a month researching these vaccines.

Look into the number of deaths and side effects "after" the vaccines.
Even the numbers in official reports (VAERS and its European
equivalent) are unprecedented compared to any previous treatment. The
number of deaths officially logged is hundreds of times beyond
anything before.

These unprecedented numbers are accompanied by suppression of
information, deplatforming and censorship that we had never seen.
Doctors and nurses are being fired and having licenses suspended for
doubting the administrators' narrative. Filling out a VAERS report is
12+ pages of work with penalties.

The VAERS numbers are backlogged and suppressed, and the real numbers
may be 10x higher.

You believe these vaccines are saving millions. But the same
dishonesty which is used to suppress information about them was used
to inflate the pandemic, in all ways you can think of.

Putting people with respiratory issues into nursing homes LITERALLY to
drive up deaths. PCR tests with 40+ cycles and 10% false positives,
while testing much of the population every week. Rewarding hospitals
$13k for each Covid diagnosis and $30k to put them on a ventilator,
which is a death sentence. Changed reporting guidelines so that deaths
"with virus" are treated as if "of" the virus. If the common cold were
treated this way, it would be the most lethal disease in history.
According to CDC, only 6% of US deaths "with Covid" actually listed it
as the single cause. Suppressing HCQ and ivermectin EVEN NOW when
hundreds of studies have shown they are safe and effective cures. In
Queensland, a doctor can't prescribe HCQ for Covid on penalty of up to
6 months in prison.

Now with these vaccines, the opposite. Every death "with" Covid is
because of Covid, but every death "after" vaccines is unrelated to
vaccines. An anonymous report by a doctor in the Kansas City area
states that out of 500 people who got vaccinated in nursing homes, 22
died within 48 hours. Are you willing to bet your life that this is
false?

You are making the stereotypical mistake of an engineer. You work with
simple deterministic systems. This gives you confidence to treat
everything as a simple deterministic system - including the body.

You have little in common with PhDs who treat the body as complex and
holistic, and warn about the effects of our interventions. Such people
seem like Debby Downers to you.

You find much more in common with those drug and vaccine developers
who use a gung-ho, engineer mentality. Even when the penalty for their
mistakes and dishonesty is death.

Can you recall, off-hand, the most recent experience of merging a
kernel commit which you 100% believed will not break userspace - and
then it broke userspace? Isn't it nice, for you, that the penalty for
this is not disability or death for 5% of your users?

Count the number of times you have done this. How many of your users
would still be alive if your product was an annual injectable? What
does this say about a vax developed this way?

You MUST research this, or more will die; including people you know.
Your current knowledge - not to even mention the statement you made -
is extremely dangerous and harmful.

The West Coast is a bubble bordering on self-indoctrinated and insane.
There's nothing technical that you can do right now that's more
important than waking yourself up from this.

It's not that this discussion does not belong on this mailing list.
It's that 90% of the work on this mailing list should stop right now,
and EVERYONE should research Covid and the vaccines.

Regards,

denis bider


----- Original Message -----

>
> And I know *a lot* of people who will never take part in this generic
> human experiment that basically creates a new humanoid race (people
> who generate and exhaust the toxic spike proteine, whose gene sequence
> doesn't look quote natural). I'm one of them, as my whole family.

Please keep your insane and technically incorrect anti-vax comments to yourself.

You don't know what you are talking about, you don't know what mRNA
is, and you're spreading idiotic lies. Maybe you do so unwittingly,
because of bad education. Maybe you do so because you've talked to
"experts" or watched youtube videos by charlatans that don't know what
they are talking about.

But dammit, regardless of where you have gotten your mis-information
from, any Linux kernel discussion list isn't going to have your
idiotic drivel pass uncontested from me.

Vaccines have saved the lives of literally tens of millions of people.

Just for your edification in case you are actually willing to be
educated: mRNA doesn't change your genetic sequence in any way. It is
the exact same intermediate - and temporary - kind of material that
your cells generate internally all the time as part of your normal
cell processes, and all that the mRNA vaccines do is to add a dose
their own specialized sequence that then makes your normal cell
machinery generate that spike protein so that your body learns how to
recognize it.

The half-life of mRNA is a few hours. Any injected mRNA will be all
gone from your body in a day or two. It doesn't change anything
long-term, except for that natural "your body now knows how to
recognize and fight off a new foreign protein" (which then tends to
fade over time too, but lasts a lot longer than a few days). And yes,
while your body learns to fight off that foreign material, you may
feel like shit for a while. That's normal, and it's your natural
response to your cells spending resources on learning how to deal with
the new threat.

And of the vaccines, the mRNA ones are the most modern, and the most
targeted - exactly because they do *not* need to have any of the other
genetic material that you traditionally have in a vaccine (ie no need
for basically the whole - if weakened - bacterial or virus genetic
material). So the mRNA vaccines actually have *less* of that foreign
material in them than traditional vaccines do. And a *lot* less than
the very real and actual COVID-19 virus that is spreading in your
neighborhood.

Honestly, anybody who has told you differently, and who has told you
that it changes your genetic material, is simply uneducated. You need
to stop believing the anti-vax lies, and you need to start protecting
your family and the people around you. Get vaccinated.

I think you are in Germany, and COVID-19 numbers are going down. It's
spreading a lot less these days, largely because people around you
have started getting the vaccine - about half having gotten their
first dose around you, and about a quarter being fully vaccinated. If
you and your family are more protected these days, it's because of all
those other people who made the right choice, but it's worth noting
that as you see the disease numbers go down in your neighborhood,
those diminishing numbers are going to predominantly be about people
like you and your family.

So don't feel all warm and fuzzy about the fact that covid cases have
dropped a lot around you. Yes, all those vaccinated people around you
will protect you too, but if there is another wave, possibly due to a
more transmissible version - you and your family will be at _much_
higher risk than those vaccinated people because of your ignorance and
mis-information.

Get vaccinated. Stop believing the anti-vax lies.

And if you insist on believing in the crazy conspiracy theories, at
least SHUT THE HELL UP about it on Linux kernel discussion lists.

Linus
