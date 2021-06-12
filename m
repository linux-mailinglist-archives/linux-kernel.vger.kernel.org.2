Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1C3A4FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhFLRFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhFLRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 13:05:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DAEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:03:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id u30so34349763qke.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71ddPGTVgi3kmqZ+vnJW6DPtx5A785PjouLOdvG++zA=;
        b=vrxbnEdRbCD5+WoNPmlQ0WTB9AVWDw6LUKHGI3qNXoTD8gWHRXIdWF/Uh0idLiDSBJ
         hJQ4CyuGR6ftCf8WGlkn7sihIRgL5PVdJ4nGpzzFbPfVQihvwCIcVk6ljBwaQ9eApHER
         4yPNEOzuQqQNPhdlLWbuI0tybjlZisBb6OPiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71ddPGTVgi3kmqZ+vnJW6DPtx5A785PjouLOdvG++zA=;
        b=mGoa3cIS7E0ek6o08Va3ZObC+8tc/DNIXNHKpJxyD9AXUk4otaGlXb+FxDnbMPShxN
         hfRSMNtkyJX+ulA0FUxN+DYitEJNshmDUSmVy2wMRhHlaWqGeGcMygvNlqfpFnou560k
         qS90fmZWEkWsC0J/51wchp6DW4wcOITvRc5sgGsbyeD1vQ6JYDLCx+MA2JhyLjR9xVLH
         WVAONdhWkOy44S8zrjhW/RejogtxRn1Xk7Lr0o1wCvHfSF8XK5/s1xZGado8Uzsqbf6V
         xvRHh4h9YAvCiwgrCbIV6fdmHsiDG67qze5KINuM1HCHVBOcQM5EJ1clGL3lyEaHrhr5
         74BQ==
X-Gm-Message-State: AOAM530t1z4e2l+M4pBDtPI5xE01sIUyqIiccTl09Ib+ivNn2nRuV2uT
        paLx7HYeN2dz21NsFqOWjAk7eYI3CCeb2tSHjuRZKQ==
X-Google-Smtp-Source: ABdhPJzSZEFI/aFcPy8IvaFy0dlqizShdbS2S4QT8CXM1JGYQotzIAaT0UYVOnEUQScHKymXgQbSToGX9tCR6ntPZAk=
X-Received: by 2002:a05:620a:e02:: with SMTP id y2mr9470640qkm.54.1623517413796;
 Sat, 12 Jun 2021 10:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr9PXkMSDvks+DeCNJ6iKf6zDH0VaOL6msirR3g2K7BNL8YkQ@mail.gmail.com>
 <20210612155953.GA11724@lx2k>
In-Reply-To: <20210612155953.GA11724@lx2k>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 13 Jun 2021 02:05:35 +0900
Message-ID: <CAFr9PXnuoonY=m53==hyAo4Con_3-Fk_3KEfQp4sfLKBZyGS+Q@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mstar for v5.14
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        SoC Team <soc@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Sun, 13 Jun 2021 at 01:15, Olof Johansson <olof@lixom.net> wrote:
> Overall this is the right way to do it, but my tooling spotted a miss: You
> didn't sign off on at least one of the patches you applied (the UART one). Make
> sure you do 'git am -s' or similar so you have a S-o-b entry when you're the
> one applying the patch.

Ah, so there should have been a sign off from me for Romain's patch
after the existing tags.

> Mind respinning the pull request with that corrected, so we avoid getting an
> email from Stephen Rothwell about it too? :)

Sure.

> Beyond that, keeping an eye on how you sort patches when you have more
> material: In particular we keep DT, soc, drivers and defconfig updates in
> separate branches as much as we can -- sometimes dt-bindings need to be in both
> DT and driver branches, for example. That doesn't apply to this pull request,
> since the MAINTAINERS entry and the other one fix are fine to bundle (they
> would end up in the 'soc' branch at our end).

Thanks for the heads up. We should have one DT patch for 5.14 that
I'll send a separate pull request for.

> We can tweak that over time as you get more familiar with how we separate
> the streams of patches.

Thanks!

Cheers,

Daniel
