Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9823DE3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhHCBAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhHCBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:00:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4550C06175F;
        Mon,  2 Aug 2021 18:00:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r5so18136268ilc.13;
        Mon, 02 Aug 2021 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXoEjoad1R7HKIdPw8tJDXKRSirWOIxZ0y/mYDE99v0=;
        b=ZoNb5UVhY0zVJKHbk9/MQEn67Pd8KgLIzylIDwxnhBFKFL5DDvwTDVHMNdN9plPiUU
         cjI5S6Plz61gmcLk7Zf0PQqFyHeUEYHVcTNSutbPjsX/p0ay6x8ZmoE5UOD3TWp1ecYt
         7W1RkTnOeT5DF2Vpf2gAdtPXAgd5AqEmo72gfD7tneDODCdo9htlPijYQzXkCbRPyG7x
         /bz3EmKxZ6uLVlenU4FjcpJ4D3K9zOep14MHxoH5ekrWEDNBpqft9cc/PxoLEenLPt4L
         80TxkLpQLeLpSKyz9ENWDEVkRO6kwHIrvJaCJL5+Uyflzc7Zj6atlKbciECPHwRCghwV
         CkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXoEjoad1R7HKIdPw8tJDXKRSirWOIxZ0y/mYDE99v0=;
        b=FltRVQlgVK3CwOsHX6px/EYKnxUb7pR37q296U7sS9gnxfWGr83k/gtULvjRH3Zqfk
         2ph+VKqCysyOQZ8vaV3PjETa4D4pO8WPWCLdmAntr/r74G0b4OMcZfreS8KRuQGcA3nu
         7iXow+AyefG8OsuHF+ZD6RZE17ejzTkTRauvQMr5/LEcj1tibHUcKn7jEvA+ETHOrKKP
         T57rw9EF8aSaF1rZrJb7Q1bJZ7+UiL1ceYH7U9UJUe1Fdn0DIhi6kT9sRH9ND4GzylMN
         winZodFFvbJpKqyDJqdmxbI7hd65YArtACrYeS5zSKNSQB2y4aZakiRyjkkVvd0o9KAl
         CPUA==
X-Gm-Message-State: AOAM533UE5RQQRREtTok7qPaobVhk21gMweWxZ9cRINtOXwah1rhYqMu
        yBevNd+VKZrwUOvXTidMqrRnhdtMpGCKSublGKYJHtztY74=
X-Google-Smtp-Source: ABdhPJyODAh/i90UxnyvQBO69A1ty8qM4mUMqEHx363AHB9rZA/5ecsD33TkByGM3BRxYu4hndQw+IsHY2C0IhYVatk=
X-Received: by 2002:a05:6e02:2194:: with SMTP id j20mr383023ila.108.1627952422178;
 Mon, 02 Aug 2021 18:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
 <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
 <CALdjXpBPRraC8xxORgE3SXw4xFnTW-Y6rLbcS+Cx0xYq3+aBeQ@mail.gmail.com>
 <976d34c0-d603-1f16-edbd-ad6c8881ad4e@linuxfoundation.org>
 <CALdjXpAzE3o7Bwdvj1TvsBRpDWDe1FZ8LsmL5q0suxYnRJCOaA@mail.gmail.com> <5165bd84-11af-35dd-8a9b-11c7f219fb88@linuxfoundation.org>
In-Reply-To: <5165bd84-11af-35dd-8a9b-11c7f219fb88@linuxfoundation.org>
From:   Michael <msbroadf@gmail.com>
Date:   Tue, 3 Aug 2021 11:00:10 +1000
Message-ID: <CALdjXpCmx_nfYEguv9UvOrBMYFxB4sqwmNiV99ggHRZnZjiM-A@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 at 09:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/30/21 5:52 PM, Michael wrote:
> > Yes i think just adding the VDEV_ST_USED check in addition to the
> > VDEV_ST_NOT_ASSIGNED state is fine and would fix the issue.
> >
>
> Can you please confirm if this works?
>
> > After many years of writing virtualhere (a similar system to usb/ip
> > but cross-platform and different non-kernel way of doing it server
> > side) I've seen many drivers that issue reset at any time. Loading
> > firmware is usually the reason.  Also sometimes switching
> > configurations requires a reset also, for example some gaming wheels
> > do this. I don't think you should make this VDEV_ST_USED check
> > specific to Wifi devices, as a lot of devices don't follow too closely
> > to the USB protocol to begin with from my experience. They primarily
> > base their USB interactions assuming the windows platform and its
> > quirks.
> >
>
> When sending responses to Linux kernel mailing lists, please use bottom post.
> This check will be used for all drivers. We don't add checks for specific cases
> in the code.
>
> thanks,
> -- Shuah
>

Yes it works with that change.
