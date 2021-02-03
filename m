Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259530E625
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhBCWh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhBCWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:37:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817CDC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 14:36:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so1679220ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+xEB0+NiaQgTKs4uVJJnigCM8+nOmdQI0zj2HVYgC4=;
        b=NMyrlhAYqzfaIWUOBnjchoYPpbT7KAcltQ6HYvNHgskUJc9Ao7LfnMDksjpuRUiorG
         qjyBi4CIZu0mMP2v1CIjLqIg8x09k5VGNQBdGUnZMH2gh1tvjX4uYaF/cwC3d3tM0SGM
         /L2zAEmyUkfJ49aex9fQTEDPDL+dxOb5/7dqv5N9jktEfTlTnHk3Q0bb/FqfuLGqnx59
         zjNq0b3PZtjxuW3nvzILA+DDXKSGgzpfTrFACMmXYBSZPMhmgPfLVi/Fni0AbME9AvfT
         XRtV/jIln2+3O5+DOGErz1uQxyjszLOUuq1mj0L5vqcCaL8W8Peu0Vr++V6fVht8xU+4
         CEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+xEB0+NiaQgTKs4uVJJnigCM8+nOmdQI0zj2HVYgC4=;
        b=JZd4JqP5f7fx4CawqAmLSHgF7/46wU/g+XIBVkW26EjxIlBZHQf6jjKpBWr793kqOv
         R6xFCdVleRqkJITTH6XQHjGBNFScnKscaFTLAuAWhyeom8PnUcvauJsKTyZShWTX2caG
         bYrr/taFxv4T0sbFrs+fweUC2WOuKfRqsU/eo2t9ktsBNTWkBCMXmX35hScjEUMimlJ4
         uTcn1cvTK+yPjGgHwJ7iOvjhf5ahWyZrSfr3KK9WKiJHIXc/M4QWBb3IkQROSv1NkS3O
         ruCMiPvupRO7ricdHWTHk6LA6CGv4vNMACAAwWwckxNfVz41SfTCHY9RZk8v7MyPmdQ/
         lyVA==
X-Gm-Message-State: AOAM5338aGP2gBbZNtHLPZPNpj+jD6Ep4x7MILFX6kTquIPkL/eny+4D
        ebC/EJpIiHYRuBeIEOW/sFCJ6IjzOKs/G467THsYTwYPe+znig==
X-Google-Smtp-Source: ABdhPJwmRNgYzRg+rKLG+KM86CjGb1R/m+o9NkWqgJIQbpIyfUaQLQR5C7OD1snKQvj9GSiUeYbRNY5Hf3NYvMsPOZ4=
X-Received: by 2002:a17:906:17d5:: with SMTP id u21mr5421160eje.541.1612391803181;
 Wed, 03 Feb 2021 14:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20210202200324.5179db33@canb.auug.org.au> <CAK8P3a3uJfyt6vsgTdSjnE23V4E_Mw=N89nrMPLJ6bhA363nqw@mail.gmail.com>
 <5504da4f-7eec-ecb0-c47d-7821d06dc880@infradead.org> <CAK8P3a2Y9-5dhk1MaZhhnKQkbOtqOSqfqZA0c4ncBXgD8tJTZg@mail.gmail.com>
In-Reply-To: <CAK8P3a2Y9-5dhk1MaZhhnKQkbOtqOSqfqZA0c4ncBXgD8tJTZg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 3 Feb 2021 17:36:07 -0500
Message-ID: <CA+CK2bC9oMvtkT3MZzxNMtCn1b0hafYPbLH3GM_Z_66j_NQeJA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > After the most recent build errors, I tried to apply Pavel's patch
> >   https://lore.kernel.org/linux-mm/CA+CK2bBjC8=cRsL5VhWkcevPsqSXWhsANVjsFNMERLT8vWtiQw@mail.gmail.com/
> > but patch said that it was already applied (by Andrew I think),
> > so I bailed out (gave up).
>
> As far as I can tell, there are two different bugs that got mixed up, and
> we need both Pavel's patch (which is now in -next) and Stephen's
> (which got dropped again).

Stephen's patch looks OK to me. I should have used define instead of
inline to begin with.

Thank you,
Pasha

>
>         Arnd
