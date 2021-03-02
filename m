Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2A32A6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838949AbhCBPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351175AbhCBNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:34:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E068C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:33:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 18so22710111lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSy8XDFMp0a7WSm8SRUUoPZjrV8zT9TVzmc4W+YVnt0=;
        b=muTIlCk5kkvjyji32omYwf+paO3hraugCWesSpuLQsEWurrOtv2LkuCl6kR08bkfvg
         A6GnCuAbiavXpP6X+RWNX7lHIkfAB0M8pik4fuBcTkyX+KWS7eB9P4AK6fMy4PSjqHzF
         5KnqjvDB2QI67xes/P70H8yoAXPOvpsDSCaT/bAAzGvwusGzda3XPI3AQOJyQi94scJI
         iWF71bvf56zWzmx0LJMa9rlv1NqnmUgyPwP6B9pW9/y5uzP1wyMeFMFpdmE7RlmwwPKa
         +ahhi2xIdYnuy0TnkKnyvj4yGAq+UjuJmNT5XjAaepghP6qYE+xKENxLMqwATj0/K4B+
         fTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSy8XDFMp0a7WSm8SRUUoPZjrV8zT9TVzmc4W+YVnt0=;
        b=U5rVtUXKRuYAFcpl9CoQpAMWwzLJZSeiTPfNmgxTTlNgAX7uZV5FyS6GxgIj8F36u7
         i9kg8wQ2VfDQZDhXZKl7kVd9dc0I25HHLpO5/H3ni2skpjZ2v3Ab1nsrOYomoXBi6554
         88jwFKYb2IlejpslA68DOoCUtZs3itTCgNyI3YhCYUxLFMUaFR9X6awr4oQ7l9GoWHvk
         AjPRNBv9TS+Y7mOvl324mTXfCR2aE1RFDGBl57tQNIIUlyEyJS35CabWZSS786Rf0adS
         Wko4tv9XY+ch4kAzsQ28sLP8Z9cN7Pm9dGFAsPVQtlrwxPys8eV3S4yGNPIjw6E+g0tT
         V84A==
X-Gm-Message-State: AOAM530g/E4jK4EVWPuANcSuTpXX5rfGA9xRyZ8M4wisEdhtB2D57NQz
        J92PF/2QC6+NzOB3nS845npqg0As7tMnAbjJhARREA==
X-Google-Smtp-Source: ABdhPJx92UylmzN7UzJit4KOHJg5xSFTK0EOobHZawkbLd9lf5/TSOXqApb0TItqvbUM4jSbHtr8kr6+qxcDjcviWwI=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr12700579lfl.529.1614692000450;
 Tue, 02 Mar 2021 05:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20210208222203.22335-1-info@metux.net> <20210208222203.22335-12-info@metux.net>
 <CACRpkdYbOX_RDqwxaiugtYB4vSpSKChvKsPjcB_vv3Q74QeG2Q@mail.gmail.com> <c5ed2b27-21a2-5a07-8dd9-e080f9a6cd98@metux.net>
In-Reply-To: <c5ed2b27-21a2-5a07-8dd9-e080f9a6cd98@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 14:33:09 +0100
Message-ID: <CACRpkdZ1PvA6822YYPwzHNvVrvd+bNFRLwpQ=RRrXpitWmnrxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/12] platform/x86: skeleton for oftree based board
 device initialization
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:54 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 12.02.21 10:58, Linus Walleij wrote:

> > If the usecase is to explicitly work around deployed firmware that cannot
> > and will not be upgraded/fixed by describing the hardware using DT
> > instead, based on just the DMI ID then we should spell that out
> > explicitly.
>
> Okay, maybe I should have stated this more clearly.
>
> OTOH, the scope is also a little bit greater: certain external cards
> that don't need much special handling for the card itself, just
> enumerate devices (and connections between them) using existing drivers.
>
> That's a pretty common scenario in industrial backplane systems, where
> we have lots of different (even application specific) cards, usually
> composed of standard chips, that can be identified by some ID, but
> cannot describe themselves. We have to write lots of specific drivers
> for them, usually just for instantiating existing drivers. (we rarely
> see such code going towards mainline).
>
> A similar case (mainlined) seems to be the RCAR display unit - they're
> using dt overlays that are built into the driver and applied by it
> based on the detected DU at runtime. RCAR seems to be a pure DT
> platform, so that's an obvious move. APU2/3/4 is ACPI based, so I went
> in a different direction - but I'm now investigating how to make DT
> overlays work on an ACPI platform (eg. needs some initial nodes, ...)
> In case that's successful, I'll rework my RFC to use overlays, and
> it will become much smaller (my oftree core changes then won't be
> necessary anymore).

I understand. I have had the same problem with trying to fix 96boards
mezzanines.

I also tried to sidestep the DT overlays, and it was generally disliked.
The DT people have made up their mind that overlays is what they
want to use for this type of stuff.

Yours,
Linus Walleij
