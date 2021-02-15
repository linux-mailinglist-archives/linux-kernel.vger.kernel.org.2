Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81431C0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBORtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:49:24 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52074 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhBORoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:44:44 -0500
Received: by mail-wm1-f43.google.com with SMTP id r5so3648053wmp.1;
        Mon, 15 Feb 2021 09:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gARK4EEPw8QHG4zORj2hJXRDBS8ikj+RA2aSSrZNdyw=;
        b=fSaU32mrNkPfA/X/5OqMtM8c1wEFv4/cGBngY/E7jYQvJQFn4pHtU1TZ0ZKZPTCkM4
         ZAIdUt/uYR0PuYKWauI/6XvvW4I5LG1wOnxl02yWuks08q+/c4b9Rkf2c27HdFqCmu/C
         giFdnr+Kxd3FmfuBUjzTlZokSIWL09ieLe+30UMEtjUTkKDi8BxTYTeHkGYVcgdA9uv/
         Kor6kva/oaFmRoqu/y3jN9w5v7yCYk0TkYgYj3I/220wxLeeHgpdoJuWIEnkKS/vvYkI
         t0hJtqoxObqvmyj7LqJ/BOOeFVxxac6W3DzSAv3augNT6GmyeyRsp33hcuvDQWeUI3hn
         lGuw==
X-Gm-Message-State: AOAM530RTASD3r1o5qdTzq98QWEYdXF+oegHC/JBjC7o7e+6kh1T7nVB
        0mnayHxQOeQ5upXuD/T3J0A=
X-Google-Smtp-Source: ABdhPJyyv4oPKKxUPnIqfN5TLl844GoE0VrsKXomIWtJSnpWlVA7um4n62TF0QDSN19XH1mtdBWtVQ==
X-Received: by 2002:a1c:48d6:: with SMTP id v205mr25021wma.146.1613411042349;
        Mon, 15 Feb 2021 09:44:02 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id q2sm18201546wrx.79.2021.02.15.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:44:01 -0800 (PST)
Date:   Mon, 15 Feb 2021 18:43:59 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <20210215174359.hrqlz2je54qggvf7@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
 <YCp1p1tRHF6OyR0C@kroah.com>
 <7c8bcf79-233b-7ea8-4fea-2fb29ca430ef@marcan.st>
 <YCqdi/5TSlbt0w/2@kroah.com>
 <e77a02eb-8493-14f0-f71c-a15646324d19@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e77a02eb-8493-14f0-f71c-a15646324d19@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 01:54:25AM +0900, Hector Martin wrote:
> On 16/02/2021 01.12, gregkh wrote:
> > On Tue, Feb 16, 2021 at 12:57:27AM +0900, Hector Martin wrote:
> > > On 15/02/2021 22.22, gregkh wrote:
> > > > On Mon, Feb 15, 2021 at 01:57:39PM +0100, Arnd Bergmann wrote:
> > > > > (adding maintainers for the serial/irqchip/clocksource drivers and
> > > > > arch/arm64 to cc)
> > > > > 
> > > > > I would suggest merging it together as a series through the soc tree for
> > > > > v5.13, once each patch has been reviewed by the respective subsystem
> > > > > maintainers, with possible add-on patches on the same branch for
> > > > > additional drivers that may become ready during the 5.12-rc cycle.
> > > > > After the initial merge, driver patches will of course go through subsystem
> > > > > trees as normal.
> > > > > 
> > > > > Let me know if that works for everyone.
> > > > 
> > > > Sure, as long as the maintainers get to see the patches, I don't think
> > > > I've seen the serial ones at all...
> > > 
> > > Sorry, I figured Krzysztof would take a look at it first and I didn't want
> > > to spam too much. I'm still getting used to figuring out who to CC...
> > 
> > scripts/get_maintainer.pl is your friend.
> 
> It's the additional step of figuring out who to include from
> get_maintainer.pl output, and whether any subsetting is warranted at all,
> that I'm finding less well documented... :-)
> 
> (In particular for a bring-up series such as this one, where most people are
> only concerned with a few patches... but maybe I'm just overthinking things)

For bigger patchsets, you should combine get_maintainer.pl with sending
emails so individual patches will go to all role-based entries from
get_maintainer.pl and to all mailing lists. You can (and sometimes even
worth to) skip proposals based on git-history.

Then the cover letter which should go to everyone... or most of people
and linked from individual patches.

For example the easiest I think:
1. Put all folks and lists as "Cc:" in cover letter.
2. Send everything:
   git send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles --no-rolestats" --to linux-kernel@vger.kernel.org 0*

Optionally you could add --no-git-fallback to get_maintainer if it
proposes some irrelevant addresses.

Other way is to send first cover letter and then reference it via
in-reply-to:

1. To get everyone for cover letter:
   scripts/get_maintainer.pl --no-multiline --interactive --separator=\'' --to '\' --no-git --no-roles --no-rolestats 00*

2. git send-email --cc linux-kernel@vger.kernel.org ... 0000*

3. Finally all patches with in-reply-to:
   git send-email --cc-cmd "scripts/get_maintainer.pl --no-git --no-roles --no-rolestats" --to linux-kernel@vger.kernel.org --no-thread --in-reply-to='foo-bar-xxxxxxx' 000[123456789]-* 00[123456789]*-*

Best regards,
Krzysztof
