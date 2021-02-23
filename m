Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20398322F11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhBWQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhBWQuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:50:11 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:49:30 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id f136so2030997vke.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hppxaNuvZF4RtoIyCyx97F5+o6L1UtpFhzjnpRDReOU=;
        b=BCn631Zi8EX1COoO+C9ZI9wESGizzGZ1jl+x4MGHG6ldkf9l3InsoToEB1fZkEinaF
         RRN1F3gTEpgoCp5TJYpR+4ziIvjHW2L8ck04RM6YcmtBC8KBNLuFwG4gZ2nJdl1fUGN2
         ICMXi73V+wjUWH3sQ0iK1tQ3kR/52H+bToUGs+a2xEVBXdaAU0QbrrVSo6rMLGlz3vk0
         2EPx/5J/RBrZvwM7dINFACXJf3Enxtvi8wjhoIPXKwnDX3k8eGubUHYEqXorxomcvjh5
         VbKpCwun/qTOD6oQeZpyIr6NRDF7u43LyWoxqIJ1nFXBY2IZJv4cSf3bU/fVn9xn+DdD
         sTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hppxaNuvZF4RtoIyCyx97F5+o6L1UtpFhzjnpRDReOU=;
        b=taFyPOw32N0vAWPjj6hPWA5dc7rlhfRZnZ/A85MYIIPfGEI9BD/ahshCEvrHDRtvXO
         thybc7bQawFcrGw7Tzj+w+I+suP1NsCXEKeOniZOvwfYCTTioLp14KGaAf15x0NdrV0n
         ZEQyAZKlzs4TuffnH9Qicx4+2Uya56QzGPiRW5IBKlqfgrcZPHs8F/OrBmbJhUj7JwAz
         jJ9twe1HG0FbU38pAuPtPmKmNTKr5uHsJDHT0twVUfuaZDlNV73ItTtD2OqNTcqBL+H/
         39pD7NJ2uE2Jb7vAccMFUL3FlAJSAgUbEECgqSI/W3cxNWYIvWbQ/vOuxUpoOvGsWc1V
         LcMQ==
X-Gm-Message-State: AOAM530gU6RpwR3gbrw6AgooDOFUVLFBnl6PvJ4ie3G4NNf1cOUzmKtI
        cdoHPDg08EICbiX/NR83lxU7qJCjJ3Fd+WFewfSBnw==
X-Google-Smtp-Source: ABdhPJxIldJarzDE6bop7IkLjGMHtktTZHgpT7YiWVyNfUErYV1SP9KN0TEO73Oq9gCpTia4ab3QttCbhHOfvuV+CG4=
X-Received: by 2002:a1f:3d49:: with SMTP id k70mr1740882vka.3.1614098968880;
 Tue, 23 Feb 2021 08:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20210222072217.15633-1-jindong.yue@nxp.com> <CABCJKudwajnmHAEC1XAH=pouCoOXq7q6NmpLST5pba8ejU6FtA@mail.gmail.com>
 <CANLsYkx0Y_f8tdeioUFrwBRV8M6OtLcSuPDZbgb6noPgrfyjOA@mail.gmail.com>
In-Reply-To: <CANLsYkx0Y_f8tdeioUFrwBRV8M6OtLcSuPDZbgb6noPgrfyjOA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 23 Feb 2021 08:49:17 -0800
Message-ID: <CABCJKuemAmeaSshvb=B6D1kBt-n_unEx11rwzOZmDxAd+EQ31g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove casting to rproc_handle_resource_t
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Jindong Yue <jindong.yue@nxp.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 8:41 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, 22 Feb 2021 at 15:48, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Hi,
> >
> > On Sun, Feb 21, 2021 at 11:18 PM Jindong Yue <jindong.yue@nxp.com> wrote:
> > >
> > > There are four different callback functions that are used for the
> > > rproc_handle_resource_t callback that all have different second
> > > parameter types.
> > >
> > > rproc_handle_vdev -> struct fw_rsc_vdev
> > > rproc_handle_trace -> struct fw_rsc_trace
> > > rproc_handle_devmem -> struct fw_rsc_devmem
> > > rproc_handle_carveout -> struct fw_rsc_carveout
> > >
> > > These callbacks are cast to rproc_handle_resource_t so that there is no
> > > error about incompatible pointer types. Unfortunately, this is a control
> > > flow integrity violation, which verifies that the callback function's
> > > types match the prototypes exactly before jumping.
> >
> > Thank you for sending the patch! It might be worth noting that Clang's
> > Control-Flow Integrity checking is currently used only in Android
> > kernels, so while the type mismatches are real and should be fixed,
> > they don't result in runtime errors without this feature.
> >
> > > To fix this, change the second parameter of all functions to void * and
> > > use a local variable with the correct type so that everything works
> > > properly. With this, we can remove casting to rproc_handle_resource_t
> > > for these functions.
> > >
> > > Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >
> > This looks correct to me. Please feel free to add:
> >
> > Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>
> Where is the original patch?  I can't find it on the linux-remoteproc
> and linux-kernel mailing lists.

Looks like it was sent to linux-remoteproc, but I also don't see it in
lore.kernel.org. Not sure what happened there. Jindong, perhaps it's
worth resending and including linux-kernel too?

Sami
