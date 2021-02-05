Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5B3117FF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBFAzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhBEJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:56:30 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B771C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:55:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s24so3329141pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bdqbiOx96ZjGlvDj89re9Lv5tP/labX2E5OeezghzzA=;
        b=sNaAZVhr4ZWW+HvhkEvCK60kufSKBpL0okB1oVoFhRQkODNHmvla3bL0n2655cHakn
         ahzuSLumkW1g3503AJBqLhhmenG6CeT1aGphN4VUpWBUClFCcOktfkfnMTx35wKd6m9J
         XRMjl762BKyK2T/YM4iB/Af3qwLr91UqEYGIDdodum1nbUPKkvO7VlSygMg8aya62mZf
         H4waAizinttR319yw3YGqLnR9D9ubjjjmv1Ee6TqWJnUkClEAr0CZNt69r5RgEKIYBwI
         WOVmzJ36sjEd0O2ssh2fPxjX3O1ke4RkPfbKPm96OlymIEkLyspIqNOembEfhX19nKiF
         esbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bdqbiOx96ZjGlvDj89re9Lv5tP/labX2E5OeezghzzA=;
        b=TdXuh/7mpKSdTXHMrKAJwlZyaCgtclmcJ9RCZRvh57ERWE9psJ3teR3zsYnQZZhjV+
         F6EOFVbUqWz3YMt66HqUwXwgpmh9hdv6zfMVy7MhbYcuYZc8b+Q0BZrZdD+mtvdiPLhM
         CenZdf3NTTfwORc9OwWuJtkwSzetAa/zj2GgnbUoyOdKySIdRjNfCiZhO8gif0mEG9g2
         iVxI7/9oJB2ALp1DDS20lUG9huzjN2YhC18b07U74ruagvFNIWMqA3UrUsEZ2bMakm5w
         ydqnzZ6OLSM/LEUzQ1jqmt5rsyig94RvR18qMoZNcWrwWT8UJpCRZ4gQbGEuCSa6pABG
         FmbA==
X-Gm-Message-State: AOAM532ptv3D1Rp4xkL2QKMpEc/F8+kGYKYKyYa8y0NrhbxbBT3vyAHG
        XtZ2mv9vjlRe6Ut/GmJNiC8aZg==
X-Google-Smtp-Source: ABdhPJx4IP8HYF4plUaQ5oiiOkbrrvWNIgSboohs8FGAMUWfvXRdAYb53lVFHPh4GcbyTOWtUPEKGQ==
X-Received: by 2002:a17:90a:1503:: with SMTP id l3mr3338386pja.41.1612518948404;
        Fri, 05 Feb 2021 01:55:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i14sm3035535pfk.28.2021.02.05.01.55.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:55:47 -0800 (PST)
Date:   Fri, 5 Feb 2021 15:25:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        anmar.oueja@linaro.org, Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH V7 4/6] kbuild: Add support to build overlays (%.dtbo)
Message-ID: <20210205095545.woevnkxg3ar7ctys@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <434ba2467dd0cd011565625aeb3450650afe0aae.1611904394.git.viresh.kumar@linaro.org>
 <CAMuHMdVp0vGMqoEoP9A7Y7-ph-DYUWdddtChdq_eZcROYTBMHg@mail.gmail.com>
 <20210205092507.fdxotdjlq5rjs2yh@vireshk-i7>
 <CAMuHMdWUMcMcJxnC+oML8P0+r72_+d6RWGY50dOWCUECdJGWPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWUMcMcJxnC+oML8P0+r72_+d6RWGY50dOWCUECdJGWPA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-21, 10:41, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Fri, Feb 5, 2021 at 10:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 05-02-21, 10:02, Geert Uytterhoeven wrote:
> > > Thanks for your patch
> > > (which I only noticed because it appeared in dt-rh/for-next ;-)
> > >
> > > On Fri, Jan 29, 2021 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > Add support for building DT overlays (%.dtbo). The overlay's source file
> > > > will have the usual extension, i.e. .dts, though the blob will have
> > >
> > > Why use .dts and not .dtso for overlays?
> > > Because you originally (until v5) had a single rule for building .dtb
> > > and .dtbo files?
> >
> > I am fine with doing that as well if Rob and David agree to it. Rob
> > did suggest that at one point but we didn't do much about it later on
> > for some reason.
> >
> > FWIW, this will also require a change in the DTC compiler.
> 
> Care to explain why? I've been using .dtsi for ages in
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/renesas-overlays

I don't see you building them anywhere, they aren't added to the
Makefile ever. What am I missing ?

actually none of the dtso's were added to any makefile in that branch.

Anyway, the DTC needs to know how to treat the dtso format and it will
error out currently with unknown format kind of errors.

Below email [1] have some information on the kind of changes required
here. Also note that we had to do similar changes for dtbo earlier
[2].

-- 
viresh

[1] https://lore.kernel.org/lkml/CAK7LNASViCOTGR7yDTfh0O+PAu+X-P2NwdY4oPMuXrr51awafA@mail.gmail.com/
[2] https://lore.kernel.org/lkml/30fd0e5f2156665c713cf191c5fea9a5548360c0.1609926856.git.viresh.kumar@linaro.org/
