Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43B378DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbhEJMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:50:54 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36649 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhEJMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:00:38 -0400
Received: by mail-oi1-f174.google.com with SMTP id w16so7374924oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ft2as+DEhhR7uAKVAn+z+CaK8IC5vgi2WkAS6id5V0Q=;
        b=ahXXXJE3cT1ObcbonDkLDpAttVPSjLUpUjPcesIzHPJ+h8bbb1MJWc0YJS6KuzOeLJ
         ewvAQugTcqKAVlwKVyEFRWqG49U1Ca6g0OYbcZrKbqj7j2epVkJu4qVCVzuvmTgxWPtJ
         XFEqR9AFhyisKd6NJdfeJZKz5lfUxkrbRjJgOWOriHBotBJVUHdhMvFQpvKwVM1PisGi
         bACY2NSEIpyegIBvb1WDFIOlbVsBhi/v3PoNR6uG0eqwCLww2tf3ElXniwM9EhUHzcqA
         DMVG1DUxoAQqaIfyUA5vKd+UyWEUg1H2sPZOlwSHof7x9iEx+7FvAKjKIUxw1sEAToTp
         mwxQ==
X-Gm-Message-State: AOAM532fSeI6XB7w1l7H62WRfHm8cjCRGA10i9GRZDQnzBEOK4Rr5FyC
        JrXR3chdcSO5Y8s9Krzd+7RLkUVA3Tuu/j921oQ=
X-Google-Smtp-Source: ABdhPJw3mWmVQtgGJmtc3X2Fgr1ShkV4TgstW/nQiiPsLAuD10Ol93xQnTGqlRGvUMyKJ6gUc2jY+GdU/CVHKemEh3Y=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr3003924oih.71.1620647973280;
 Mon, 10 May 2021 04:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210508074118.1621729-1-swboyd@chromium.org>
In-Reply-To: <20210508074118.1621729-1-swboyd@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 13:59:17 +0200
Message-ID: <CAJZ5v0jX4ef+oO95dyFmKC0hnfKR7kSmHKQzD=RHgN51O1w_uQ@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 9:41 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The device lists are poorly ordered when the component device code is
> used. This is because component_master_add_with_match() returns 0
> regardless of component devices calling component_add() first. It can
> really only fail if an allocation fails, in which case everything is
> going bad and we're out of memory. The host device (called master_dev in
> the code), can succeed at probe and be put on the device lists before
> any of the component devices are probed and put on the lists.
>
> Within the component device framework this usually isn't that bad
> because the real driver work is done at bind time via
> component{,master}_ops::bind(). It becomes a problem when the driver
> core, or host driver, wants to operate on the component device outside
> of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
> driver core doesn't understand the relationship between the host device
> and the component devices and could possibly try to operate on component
> devices when they're already removed from the system or shut down.
>
> Normally, device links or probe defer would reorder the lists and put
> devices that depend on other devices in the lists at the correct
> location, but with component devices this doesn't happen because this
> information isn't expressed anywhere. Drivers simply succeed at
> registering their component or host with the component framework and
> wait for their bind() callback to be called once the other components
> are ready. We could make various device links between 'master_dev' and
> 'component->dev' but it's not necessary. Let's simply move the hosting
> device to the end of the device lists when the component device fully
> binds. This way we know that all components are present and have probed
> properly and now the host device has really probed so it's safe to
> assume the host driver ops can operate on any component device.

Moving a device to the end of dpm_list is generally risky in cases
when some dependency information may be missing.

For example, if there is a device depending on the hosting one, but
that dependency is not represented by a device link or a direct
ancestor-descendant relationship (or generally a path in the device
dependency graph leading from one of them to the other), then moving
it to the end of dpm_list would cause system-wide suspend to fail (the
hosting device would be suspended before the one depending on it).

That may not be a concern here, but at least it would be good to
document why it is not a concern.
