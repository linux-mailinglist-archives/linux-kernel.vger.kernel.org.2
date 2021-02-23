Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A60322EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhBWQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhBWQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:42:21 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA4C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:41:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id u20so17765489iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmPfSnwb9WVL3HWBYOU43s+aaTja6BAXtWKSK5U9rZk=;
        b=DYBn/AWB8IOwn86jhiwxaefJTaFpiOI8uu8fUG2/mG2HudIzd3AU1KFaB41PLWCMMx
         kSQMe9CtkmbmFhBHQj/ELY92QI981kY+wcJcs7eOZl8ju9pdyilct4125awQUU8uZOpk
         8bkqpiRhZeiTyWwY3kdLFhHQEdTj22aMthsGr5k0jALyChQZEqLjaWewXHQgUsjnmiDk
         OH2QJh/c72QXHPkr/EEJOMLkb58Yruoj3H/57OOvkjlCIBbkINR+s/+3EFd905WzyXJl
         q4OI0IeOCSwsgIgLsyeMWqE+nDVh3ePcbn2NVGRSCHATkKVIWI04Mw3zQ6LtkbDQYvto
         Sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmPfSnwb9WVL3HWBYOU43s+aaTja6BAXtWKSK5U9rZk=;
        b=Rpz7y/+hLI5qJA2AsT9F9f72z6Rs+nKJdjls+5ozScPgK4ETpMa8CrKjFeeYYXRn2q
         /z8r42BOrnXIV7n5VyeqTFYeYfm4kzYXWevM9G8cDVM+ZF5dkgssoeb5zmc49yfB7vUn
         1yR4h74dGk9AcJRJiFXjPUQalP4678o5L/ioFEp97TyJHeYaG2n/3jPtv7FQCBV7hamm
         9U2UVHyhZjfVFyjvC5C8ciMIr9oyxEuKFHh0SvtwiGnVhHB4z7XcWoslo+kHHL5i7gE8
         tzNMEWXFVjOclujfWXhgYvC13fBlktHIKkV3HwT9oPagPzXa/fstJbrTfmcXu9M47iqE
         PQ3A==
X-Gm-Message-State: AOAM533aV3zCiqy9dwLNQyqAYO67uX7V0mLNgwwWY4D7A2gqXWcRU8ix
        oab54aKWVT8LxdUMcxSJc7Z31ayS+xNLLsrm/hqaRA==
X-Google-Smtp-Source: ABdhPJwbMFIFE/4C+InN3vcoDlCGPex/eVyjX+Msr152C/ArBe0qRarWWm8l6hjmXO8FbEc4DvT0tYFKqyDGqgH6vvc=
X-Received: by 2002:a05:6638:1390:: with SMTP id w16mr493408jad.83.1614098499898;
 Tue, 23 Feb 2021 08:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20210222072217.15633-1-jindong.yue@nxp.com> <CABCJKudwajnmHAEC1XAH=pouCoOXq7q6NmpLST5pba8ejU6FtA@mail.gmail.com>
In-Reply-To: <CABCJKudwajnmHAEC1XAH=pouCoOXq7q6NmpLST5pba8ejU6FtA@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 23 Feb 2021 09:41:28 -0700
Message-ID: <CANLsYkx0Y_f8tdeioUFrwBRV8M6OtLcSuPDZbgb6noPgrfyjOA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: core: Remove casting to rproc_handle_resource_t
To:     Sami Tolvanen <samitolvanen@google.com>
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

On Mon, 22 Feb 2021 at 15:48, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi,
>
> On Sun, Feb 21, 2021 at 11:18 PM Jindong Yue <jindong.yue@nxp.com> wrote:
> >
> > There are four different callback functions that are used for the
> > rproc_handle_resource_t callback that all have different second
> > parameter types.
> >
> > rproc_handle_vdev -> struct fw_rsc_vdev
> > rproc_handle_trace -> struct fw_rsc_trace
> > rproc_handle_devmem -> struct fw_rsc_devmem
> > rproc_handle_carveout -> struct fw_rsc_carveout
> >
> > These callbacks are cast to rproc_handle_resource_t so that there is no
> > error about incompatible pointer types. Unfortunately, this is a control
> > flow integrity violation, which verifies that the callback function's
> > types match the prototypes exactly before jumping.
>
> Thank you for sending the patch! It might be worth noting that Clang's
> Control-Flow Integrity checking is currently used only in Android
> kernels, so while the type mismatches are real and should be fixed,
> they don't result in runtime errors without this feature.
>
> > To fix this, change the second parameter of all functions to void * and
> > use a local variable with the correct type so that everything works
> > properly. With this, we can remove casting to rproc_handle_resource_t
> > for these functions.
> >
> > Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> This looks correct to me. Please feel free to add:
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Where is the original patch?  I can't find it on the linux-remoteproc
and linux-kernel mailing lists.

>
> Sami
