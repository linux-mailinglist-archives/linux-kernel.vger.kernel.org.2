Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807B93E37D5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 03:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhHHBqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 21:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHBqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 21:46:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A0C061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 18:45:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h2so5901034lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 18:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w4erDKGKuVVmFk4MydRg6Ar+fFrOU424KnWvFwilis=;
        b=XQCgclUTilDpeG14v61gFXy71aParHT8xRCiA5zhibT/18J5dNpdwYSQZ8VFH3xYLi
         UouX4jszNKuY20e9pvwt2LCrNiDIpOJFtut9zegLJ/8arWSa61qw0UX+aFzmbtnlaxM5
         7mm0FXEg+miCXynrt8UhLLncLuOhIJRpSLyZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w4erDKGKuVVmFk4MydRg6Ar+fFrOU424KnWvFwilis=;
        b=iQIkL2eUTaJCwnuUNpaH+kwo5oLn5ERnFMNFWrrjH3TpKjGkn3bXtOqo0ZbkPFqGbN
         CPItmI7vgo/mZhbwDppzC+BY+0rYVVM1f3esLR8ErbpFX9xaCG6LwJDBLTBReITFkVul
         g4rVYrv1Vo+XCzmpfwTiHKMqmfSxpN0YJ1XxUuzutdj8xAieFxXm1bVljKsmYP2VteDM
         3stwG/ttJdj8q/1lVJVlnhIp/aA2FcK0NjtXIQj16Vl7pqW8Fw5TqyoXmESZadkEnY0B
         7vv/ouTo8O7ASszTxU01ulQ5Y9594p3yqYMuymNsO+TV0cdC6ILG2Ps4gDojitA84760
         +61g==
X-Gm-Message-State: AOAM533KNEwxwdiYCd0G5Lq74Mj799gW4/fKf2zne7ktd0UoNFWOQcg9
        QTgI+jCdpkI2OLxEvB7ny2lEdOP6QG4Jc8+x
X-Google-Smtp-Source: ABdhPJztPoK1x5+rOrIKDWC4cn3Ovh2YQw3Es/nLBRiLc+sZ2AZY5lgZPlRxb072yRthya5jc+IN7g==
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr10947135ljc.283.1628387142213;
        Sat, 07 Aug 2021 18:45:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u14sm1403516lfu.120.2021.08.07.18.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 18:45:41 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id g13so26352228lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 18:45:41 -0700 (PDT)
X-Received: by 2002:ac2:4885:: with SMTP id x5mr11940305lfc.487.1628387141249;
 Sat, 07 Aug 2021 18:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <87a6lvak43.fsf@disp2133> <20210806021052.3013-1-hdanton@sina.com>
 <87r1f7450i.fsf@disp2133> <20210806061458.3075-1-hdanton@sina.com>
 <CAHk-=wjdfLQ+z=uM3qUPSb1wgnugeN5+wyH11kmatUXskYqrCA@mail.gmail.com>
 <20210807050314.1807-1-hdanton@sina.com> <CAHk-=whyqY=1cAOXTE1o=w2jm8CKcM47=iOR2o2aNundzUpa_g@mail.gmail.com>
 <20210807091128.1862-1-hdanton@sina.com> <CAHk-=wh+z6ePDWhCX-EfypR-9VyHf8j_cQyOETOHtSzC6LPNAQ@mail.gmail.com>
 <20210808004243.2007-1-hdanton@sina.com> <CAHk-=wh=CdjTFEsVb7wr+ZEyNKoM2JBdvdcTGJqW5EeQPqzFdw@mail.gmail.com>
 <20210808012056.2067-1-hdanton@sina.com>
In-Reply-To: <20210808012056.2067-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Aug 2021 18:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKuUWiX_7joreSoiqwreGXBoY-1OhGFAV5QCO+ekmQKA@mail.gmail.com>
Message-ID: <CAHk-=wiKuUWiX_7joreSoiqwreGXBoY-1OhGFAV5QCO+ekmQKA@mail.gmail.com>
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 6:21 PM Hillf Danton <hdanton@sina.com> wrote:
>
> The smart syzbot reported it, Sir.

Where?

Do you have something _after_ the fix that got merged and that this
whole thread is all about. Commit 345daff2e994 ("ucounts: Fix race
condition between alloc_ucounts and put_ucounts")

Because that fix matches the syzbot reports I saw. It explains them
100%, and the fix is clearly the right thing.

> If it is so ObviouslyCorrect(tm) then where is the count screwup coming from?

The syzbot reports I see are the ones from _before_ the fix.

And the bug was the one I have now exhaustively explained to you
several times. That got fixed.

So where's the report after the fix?

Point to it. Christ, Hilf, I've been asking you to explain yourself
too many times already.

I'm going to stop wasting my time with your emails unless you can
point to an actual report. No more  made-up examples that have nothing
to back them up and where you don't react to my answers to them except
with more verbiage without any technical details.

              Linus
