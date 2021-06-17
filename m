Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8063AB6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhFQPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhFQPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:04:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2433C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:02:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z22so9432577ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gffjb4M/ANAqzeNlRTmLWG4NfOIBWBpaTeKu6FSOXY4=;
        b=e2pya7mjwKyFA8vanJytXcFh7uxmGZPAlpPiR4xcGsuhpU8OpojtLamxouDGkOAAMZ
         IwsLcVvossuqnXnFhoiFkeYFbsstgBxSGF9e3AJISi2nxNC5XwHJyzfUP8NkIXRymNUQ
         UxNen6DuR0XCy7bVfX0EYRyv6AW8cQOVq9as4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gffjb4M/ANAqzeNlRTmLWG4NfOIBWBpaTeKu6FSOXY4=;
        b=QVgmU6fcOnQaS7riiK55e4A+SqBMqau9zlZSOxC7ShpF92sm3kjmsPN4j2PUJP7OMP
         v3Q2aT39XTHE+CFHyb0i5eMCPvPgBmJ4/qRp9JDHz0Aoh/Ol6iYKInec5lgL6WDXmUdL
         w0n8F4xgv6Ed5BIlI7i7b2LkKgO4DJkjNZfYDfiwkVhI+7wm3xfUSxjhNFd6rbRWGYqE
         FvijGh4iRpBxRN8trbTuJzlIG+gWSJTPyOg9Wxr09XNYLkc3trkde14OMxuwGImLsoFv
         lZj30EzVhvtf+FbeYSGMl7tzyBrp4N9ZrzX5wJssf0hUuUFR0+4y/Voni9etnbqfFTtx
         9nuA==
X-Gm-Message-State: AOAM5306TY/okzujAD1tNdauFCif+V02pvte5JDLubzIjsT1ul/01OeW
        2ZFvVlW5XtVwwkLmZLTRDxmXgM4bZqeKeLGtY0o=
X-Google-Smtp-Source: ABdhPJyhAMRtph+1LpVrttalJCYQw0fsXr/zcPVmuXim3shStlqQ9TY9aOK08PgRrZU8Sjhctu9IKg==
X-Received: by 2002:a2e:530e:: with SMTP id h14mr5110499ljb.454.1623942121706;
        Thu, 17 Jun 2021 08:02:01 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w24sm682201ljw.68.2021.06.17.08.02.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:02:00 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id f30so11094381lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:02:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr4241418lfa.421.1623942120465;
 Thu, 17 Jun 2021 08:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
In-Reply-To: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Jun 2021 08:01:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgg67NMBNG99naEQ1cM0mXBBzdhCJaYFH-kC+mLK+J2g@mail.gmail.com>
Message-ID: <CAHk-=wjgg67NMBNG99naEQ1cM0mXBBzdhCJaYFH-kC+mLK+J2g@mail.gmail.com>
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 2:26 AM Sander Eikelenboom <linux@eikelenboom.it> wrote:
>
> I just tried to upgrade and test the linux kernel going from the 5.12 kernel series to 5.13-rc6 on my homeserver with Xen, but ran in some trouble.
>
> Some VM's boot fine (with more than 256MB memory assigned), but the smaller (memory wise) PVH ones crash during kernel boot due to OOM.
> Booting VM's with 5.12(.9) kernel still works fine, also when dom0 is running 5.13-rc6 (but it has more memory assigned, so that is not unexpected).

Adding Rasmus to the cc, because this looks kind of like the async
roofs population thing that caused some other oom issues too.

Rasmus? Original report here:

   https://lore.kernel.org/lkml/ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it/

I do find it odd that we'd be running out of memory so early..

        Linus
