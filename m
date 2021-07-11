Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1839E3C3B56
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGKJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 05:40:13 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E957C0613DD;
        Sun, 11 Jul 2021 02:37:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a2so14881876pgi.6;
        Sun, 11 Jul 2021 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyADryaaKYb3XAJJutH0DbN4r3ZI4tbb2wHJF+sttgU=;
        b=W/H/7C0Ak3Jx02rZBj1OXQxYsjcjKGTztXrp+V5BRx+YB0vgdM6WxpPTU2p3GKN9Sv
         0PrKzwocabO3OVacDUdkqlzjgQ5hAY2D8oHPrqSuNBUpB9OkLiXRGNoXLrEZi5b/Ja2q
         htNBG/Mx4xOSbB0M/Y8VpP+3FKHtsq3BB/+ijJ5gJ7bh+M/pdEEpEqIGVh5qqxPx/AjY
         X3+tM/zG+7RPfRj2s2eBJrOcz/UWCl9XOprR0du8efIiusbz6bR+xK0Ir7RqjLrCj72V
         7dnBX5z7SqTWU1SokqpFVPIa7ZYkuj8xH8dT0MX0QFHcuAxWpJvrJpe/b++cCbjSK08M
         04ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyADryaaKYb3XAJJutH0DbN4r3ZI4tbb2wHJF+sttgU=;
        b=oP2hsI2br2540X14ZJGndv4Mky/9G4MaGzhOkLOl81RDT01BhscifPKmuN9GDrTNmL
         il8BFg5pC8/yZ0LtBXWWvVZC6hEGmkUYpvPUjSbSjg/JQ/2KuSkw+tyyUn7gxbsC1uzl
         Cmb959CxtbGHZ6EZuKK3k6fUXwyby6IuBWXoCKx0ZzDbxgZ9CgvzpM/917B4iRUQoW4e
         iWlmUgG1prIGOTlLi3kTkf3rpUKwEY0ommxszxfMRGzagua2vk+NGWZ1KNjohAwWVtPx
         j8j/8Db8KmnRZ7RjIPVqxREbvQuoxfooBnMIgeJhQdCmVqBEKXliyPVVm61jNeFEbbX3
         2ecg==
X-Gm-Message-State: AOAM533PaBseNGHQ01bewjEtvtK7YVK173FyPGCpd5qp6HdFxqSoEnPu
        2v/i74qAtoO5EAnWi/fMRnQFKivwRdDdAfDD18c=
X-Google-Smtp-Source: ABdhPJy/GzHGpUoIcFb9z2sihphy2dHy8FVvpfWYgU/TXe2xy04Z/o5yaDVp9rMIhcP/NE6xaKN6PMjRG9dOcxT0ynQ=
X-Received: by 2002:a63:f609:: with SMTP id m9mr47774568pgh.74.1625996245771;
 Sun, 11 Jul 2021 02:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210708224226.457224-1-djrscally@gmail.com> <20210709170426.GC4112@sirena.org.uk>
In-Reply-To: <20210709170426.GC4112@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 11 Jul 2021 12:37:03 +0300
Message-ID: <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        mgross@linux.intel.com, luzmaximilian@gmail.com,
        lgirdwood@gmail.com, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 8:05 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:

> > This series is a prototype of an emulation of the device tree regulator
> > initialisation and lookup functions, using software nodes. Software nodes
>
> What is a software node and why would we want to use one here?

Software node is a representation of (missed and / or quirked)
firmware nodes in the code.

> Why are we not just using board files, what does this new abstraction
> solve?

Software node _is_ a board file part. The idea behind that is that the
driver, which requires any additional / necessary property that has
been missed in the firmware nodes, wouldn't need special treatment if
that property comes from a board file rather than firmware.

-- 
With Best Regards,
Andy Shevchenko

On Fri, Jul 9, 2021 at 8:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:
>
> > See previous series for some background context [1]
>
> That's a link to a series "[PATCH v5 0/6] Introduce intel_skl_int3472
> module" which doesn't have any explanatory text as to what it's doing in
> the cover letter (just an inter version changelog) nor any obvious
> relevance to this series, are you sure that's the right link?  In
> general it's best if your patch series contains enough explanatory
> information to allow someone to have a reasonable idea what the series
> does without having to follow links like this.
>
> > This series is a prototype of an emulation of the device tree regulator
> > initialisation and lookup functions, using software nodes. Software nodes
>
> What is a software node and why would we want to use one here?
>
> > relating to each regulator are registered as children of the TPS68470's ACPI
> > firmware node. Those regulators have properties describing their constraints
> > (for example "regulator-min-microvolt"). Similarly, software nodes are
> > registered and assigned as secondary to the Camera's firmware node - these
> > software nodes have reference properties named after the supply in the same
> > way as device tree's phandles, for example "avdd-supply", and linking to the
> > software node assigned to the appropriate regulator. We can then use those
> > constraints to specify the appropriate voltages and the references to allow the
> > camera drivers to look up the correct regulator device.
>
> So these systems lack an enumerable description of the system provided
> by hardware or firmware (or given that these are ACPI systems I guess
> the firmware description is just broken) so we need to use board files.
> Why are we not just using board files, what does this new abstraction
> solve?
>
> > I'm posting this to see if people agree it's a good approach for tackling the
> > problem; I may be overthinking this and there's a much easier way that I should
>
> I don't think I understand what the problem you are trying to solve is
> so it's hard to say if this is a good approach to solving it.



-- 
With Best Regards,
Andy Shevchenko
