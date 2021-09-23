Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128DE41615C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbhIWOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:46:56 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37799 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241707AbhIWOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:46:55 -0400
Received: by mail-vs1-f44.google.com with SMTP id q66so6801360vsa.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3ucXHKaz0Rc++ad0uZxKyS05SChsJUfx3Hh2lMYmn4=;
        b=umQzOokeGEfMXSWNdCzm1nhOxpTZW6FcZBLOkwjCo8Ge1Fb9MlrR99/dYo4RLk6Ruy
         Z6c+9rpjTc3d/yP4s9cbeIIenUigkqPUfvRZ95rxNWFX214xP134WCWyNBBKll6GHl1U
         owlu1gzSBumVI6KgiswFVRHpkxFrIOq4JazmwbtlLy5iyfPSBQ09SbCOlSLTz9DYO2zi
         DnpiYM+RLxWbz63af4C4jh6V+bXMY2HeM9ODusGFZyQy/AMWBOWu5sGJc2rVt4eKP22I
         33EoIIyLSiu9imttmPRMdVelnLc3Q5GRfcGaKueQdbzdavqo2pt8quell/cHPCGhsvuG
         G5vw==
X-Gm-Message-State: AOAM532SwZ6yZ7xjyTda+S1FDD7xmoDb2X0g4DRaEtmZNET1WTUP/UJv
        yVzuLsAa8g5TQfsiVUcH6jj6G3kCbVq71tq9GbT7EVYV
X-Google-Smtp-Source: ABdhPJycyPw0Z3wCTyupvlm6Je/yzgM2E9MAnxgje5sO6MKGsuy6PcrBBUp++1JNy3xgQ3TM3ZgYoOoHsUOwOzHhxhg=
X-Received: by 2002:a67:cc1c:: with SMTP id q28mr4390391vsl.37.1632408318973;
 Thu, 23 Sep 2021 07:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
In-Reply-To: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Sep 2021 16:45:07 +0200
Message-ID: <CAMuHMdU1DrwMAP4qRvK6tq5GV_c3bF5RmUR6ok2AqBXSbn7UBg@mail.gmail.com>
Subject: Re: [RFC][CFT] signal handling fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 7:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>         Back in 2012 or so I'd found a bunch of fun issues with multiple
> pending signals on a lot of architectures.  m68k looked scarier than
> usual (due to the combination of variable-sized exception frames with the
> way kernel stack pointer is handled by the hardware), but I'd convinced
> myself that it had been correct.
>
>         Unfortunately, I was wrong - handling of multiple pending signals
> does *not* work correctly there.

[...]

Thank you, queuing in the m68k branch as fixes.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
