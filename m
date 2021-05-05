Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7603747D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhEESFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhEESEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:04:55 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D04C06135C
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:02:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so671199ooi.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkOFpIfIbTV26rdHVkQ0ScdgGkxleiBN1dtxgsOyQI8=;
        b=WDs01NpyL+pQQ5J0fpQMx7+UJWwje0K7gqjVH3snQ0OlSHw0GRM+IcVaCmXcSMqaC6
         GkAa0kCbC3FHOStwcx71nykw3fJoegYem4Uy7L9HoVzzr1eJDO8MVNx4JrnBi2NxWSVL
         moBboqfk90my+7Q2g6JLVmMjHsoAqyj3cH6rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkOFpIfIbTV26rdHVkQ0ScdgGkxleiBN1dtxgsOyQI8=;
        b=FzbLgXyjeG4BGIaHY0aPmBY2tXorsPT58MUGWPJ2UhV8jx4EiryZJyMJOReIRHuv0b
         zUavWiBHO2Qus4/G4mkXmU9no42RuMOqQDW0LI5STi9Jifi3CgYAXm2HJ6Yqkk7hW9NB
         linauNIDAOEKKfDNfHr1A8YxpG2loVGUS/HJM1F/gkHyxHOb/mx5gCWCEVubnRvkDjVI
         SxHRLGYDVB7FZYLfk67pQmv3bhh4MYadn+NxkJbDjFJw58jJ66fz/t+6yWksPiiUGbdv
         PlPNqWD5O3IlCCnNRytLt1rj8IIUTIUMnA80GoxocwVw0ijdFb2cFesjvTiNkwobVjOi
         SKMA==
X-Gm-Message-State: AOAM533gdmgsdvdyosZsKx7JmGQdf/X/PdEYE1Of44dz1CZvdINRRM/L
        bVmnkFvRddWKOmkDVIBa3Ffb9S4uivwf1g==
X-Google-Smtp-Source: ABdhPJxy5+ovdPuCcj7Y4W7LaOO0FPGNCh+qB2HBmfIgfvH1LmYKCv0teauBNo5weCa8OOsyR3i2bA==
X-Received: by 2002:a4a:9c8c:: with SMTP id z12mr25241361ooj.3.1620237777711;
        Wed, 05 May 2021 11:02:57 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id r9sm24319ool.3.2021.05.05.11.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:02:57 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so2503325oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:02:57 -0700 (PDT)
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr24829836otp.21.1620237776769;
 Wed, 05 May 2021 11:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
 <YJIOdNdWTClIXYZz@kernel.org> <YJIOuTbf91DCEkDe@kernel.org>
In-Reply-To: <YJIOuTbf91DCEkDe@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 May 2021 11:02:20 -0700
X-Gmail-Original-Message-ID: <CAE=gft6Z1+kt_6sqRcpFh-=C0ir4cqEkC7p1WcPFhnkWgtprYA@mail.gmail.com>
Message-ID: <CAE=gft6Z1+kt_6sqRcpFh-=C0ir4cqEkC7p1WcPFhnkWgtprYA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 8:19 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, May 05, 2021 at 06:18:15AM +0300, Jarkko Sakkinen wrote:
> > On Tue, May 04, 2021 at 02:56:35PM -0700, Evan Green wrote:
> > > Does anyone know if this series is abandoned, or is Matthew planning
> > > to do another spin? Email to matthewgarrett@google.com bounces.
> > >
> > > -Evan
> >
> > Good question.
> >
> > It could be that because James' patches did not end up to 5.12, but 5.13
> > instead, Matthew has just put this into hold for a while.

Ah, thanks for the context. Which patches are those?

> >
> > I mean the review comments I gave, were relatively cosmetic.
> >
> > If I was the author, that's at least I might have done...
>
> Few months can pass surprisingly fast if you have all sorts of stuff going
> on :-)

Hehe or an entire year can blur by if you're not careful.

>
> /Jarkko
