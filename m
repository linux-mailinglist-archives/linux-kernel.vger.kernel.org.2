Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE943AECB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFUPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:47:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:45:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p7so30808989lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtM0J/nVeGslRIOyE/pPRoPEZFf4Pf55KJfZnOMBln4=;
        b=UYr8k45WsWjOXGMl6cB0u74KMHNtEAZRwf7aPPdDJcw80nMZpcCpk6ZHa5Ybhk1UjT
         0ocxLCQindUGSxtEy7Xcwd18WfLFcc7lpK1L5XymcFQVD3G+hfwvKdsN7lAHetaIDKEH
         h5nREYRlZgunLsZ92CFfshVFrVOjvUUQTnR1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtM0J/nVeGslRIOyE/pPRoPEZFf4Pf55KJfZnOMBln4=;
        b=InM+KesxGivsiQ24JvP901CFhyt0cSvKb/BNr1O8Ugl7c1VAEbvSNi6uBxR5oPh7xp
         GTrbFK2vfStwwAJVYY747how0UgDj2LHtx2T7UySLtuPj961AOCTKTS2JHsF+zvpWOYs
         iDhVghP9Q5ootZVCLmCqssj7ILoOrDb544224Pwg/SahetGuHC90N5TOlBKFe6+zS8oG
         Aq+O/fJqGpaUc2C1jKPkLvYWqfXEKfrnN+ASbXGQwNAcaP0HGm7QpaCpVEyGb99i2zvu
         8gcBqwhVlRXlClWx9T/IxkyZh77OKObUnxAlj4CiShc3J8xCNGkL2gqYYOCJYdqMXMuO
         FN2w==
X-Gm-Message-State: AOAM532x8SWuHFU3rOCQEAKb31/x88iABSJwrqebte5LgVstbbTuqzze
        bGk17ZT73F4TivBUXJEzRG/Akumt4YCvadGi
X-Google-Smtp-Source: ABdhPJyQcNPkY0MURxyooqIzQvhQRO5cHqezyB7q6UjYu9HqvX9lIu/LkHDSa+6KHjYIQtKnjq8wqg==
X-Received: by 2002:a19:7608:: with SMTP id c8mr14675749lff.565.1624290340361;
        Mon, 21 Jun 2021 08:45:40 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x193sm1190971lff.54.2021.06.21.08.45.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:45:39 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k8so25709459lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:45:39 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr21891424ljq.61.1624290339582;
 Mon, 21 Jun 2021 08:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210620120030.1513655-1-avlarkin82@gmail.com>
 <CAADWXX-fpcPh+jGX7=Hbkqr7yhwzbUT915NBBzqHGecFVbxmzw@mail.gmail.com> <YNAitJfOpoBkFitU@google.com>
In-Reply-To: <YNAitJfOpoBkFitU@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jun 2021 08:45:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtK7XgQqTE_OyGV8uPX3d1RqUhTQO1D+Bk3wGEiea3Ow@mail.gmail.com>
Message-ID: <CAHk-=wjtK7XgQqTE_OyGV8uPX3d1RqUhTQO1D+Bk3wGEiea3Ow@mail.gmail.com>
Subject: Re: [PATCH] Input: joydev - prevent potential write out of bounds in ioctl
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexander Larkin <avlarkin82@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Murray McAllister <murray.mcallister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 10:25 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Yes, this makes sense to me and it is safe as joydev->keypam is
> guaranteed to be the right size.
>
> Are you going to reformat this and resend or should I?

I don't have any hardware to test, so please consider that patch of
mine more of a "I think something like this" rather than a real patch
submission.

(I often find it easier to make a patch as a way to just make it very
explicit what I think might be the solution, rather than just
explaining it in English).

So please consider that patch throw-away - it's already gone from my tree.

And I don't need authorship for it: finding the problem - like
Alexander did - or even just writing a good commit message is worth
more than the patch itself, I think. The fix is a one-liner thing, the
real work was finding the bug.

So if you do want to set me as author, you can add my sign-off, but
you can just give credit to Alexander where it really belongs.

           Linus
