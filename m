Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FF3A85F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhFOQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhFOQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:03:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:01:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f70so27289100qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7C7EVveR2N28ai5r9/J+2yOqz+gY5pQumT6AbxDu9NQ=;
        b=BMDmDwevRAQ/jZtfGP7p38zmpe9NJVDCl+GWwBgJ4KO/Ve2LeGgmD7Qj6TTdeSUewV
         rmTwm91IMkKMHCOrZXNL0KEmd1YUcfnCR6Y18iF/KIN6Y0mnI+Fh4YURVYOn071j2bTw
         FJF8aUtMSOX4S+wBwhW/LG3zFECq46pFpONoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C7EVveR2N28ai5r9/J+2yOqz+gY5pQumT6AbxDu9NQ=;
        b=hnoNQq9hBMV/yMhuYNeLs8snizJTgsizqoswvXotxk6VQO+AMGl5FF34hxB6klIWsm
         2CDqEW4Hz5fkR/dHy2xl2MbeVEm5gWdqBMWK3z1Ggoa7yzeE9w/Euhd2DWlTlVNpXkdo
         dmKCpehtJxdZtn0Fb6jthruqXl7uyRkLWjEUIsHY8IGswiBQRkzAYGqqUNhGe5bYJi+n
         hRbwl9hkvYB31z3jl1tWR3jCV4HqeXKM5rmy4zpGuoy6LtfGb5veveU4YaOsdOMkq60O
         1BQ+lRoPGC5+tzPINBiDgHFTCWdrlFcFEjrTpDAaeA1SKYXS0WFDwgDRmqAbMHT9h0Dc
         VdLA==
X-Gm-Message-State: AOAM5338MA+vG35Ma1qX2ERkeeWBRu/IcuvF5us/QawnIyx/zQhEuZ2T
        ayxFcqk7Ivd7KsRIQ3WouO+H4F7kpcSmh5MkYPiM4w==
X-Google-Smtp-Source: ABdhPJwMhLK3ojmLgXGBYK7lXx8LuQWFcV18TBkTwaLl6+qHJap0zIeFZXk+ggFYSjpX/FOfrM6i9m3q1kO7mfCsLi8=
X-Received: by 2002:a05:620a:a87:: with SMTP id v7mr340087qkg.468.1623772905288;
 Tue, 15 Jun 2021 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr9PXnBb7OmOAMumDodC+0usWqRT-RXwC+YUHZ2Y43Xe_uTQQ@mail.gmail.com>
 <20210615152840.GD11724@lx2k>
In-Reply-To: <20210615152840.GD11724@lx2k>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 16 Jun 2021 01:03:49 +0900
Message-ID: <CAFr9PXkeqryzutzpV6woskee_SwbDMJFgxPtspvTk0-VS6A5xA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mstar for v5.14 v2
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Wed, 16 Jun 2021 at 00:31, Olof Johansson <olof@lixom.net> wrote:
> This time it seems like you based your branch on 5.14-rc5, which is a newer -rc
> than what we have the rest of our trees on. The general rule of thumb is to
> base it on the oldest meaningful rc for the release (rc1 or rc2, most of the
> time). We normally base our tree on rc2 or so, in this case I went forward to
> rc3 earlier.

Sorry, I hadn't even thought of that but it makes sense.

> (Maybe you had the same base last time around, and I missed it -- my tooling
> failed out on the S-o-b checking before I noticed)

Last one was rc5 too.

> To avoid another roundtrip here, I'll apply the two patches directly, but
> please keep it in mind in the future, especially once you have more material
> for a cycle.

Thanks for doing that and the hand holding. I think I can manage to
get it right next time. :)

I have one DTS patch I would like to get into 5.14 for the watchdog
driver that was recently accepted.
Is it still ok to send a PR for that one or is it too late now? I
think I read the cut off is around rc6.

Thanks,

Daniel
