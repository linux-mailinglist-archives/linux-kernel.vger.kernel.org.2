Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DA440168
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ2RrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJ2RrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:47:00 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D19C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:44:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q16so18093453ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3S4Qx+KGFNvpnFZCuQvXIFkQqNbKUzy97JWB3qSsstc=;
        b=Yl/D2AjHAXrxTC/iqj40TnEJ49hOsFuhwyqcQLRe8nMFgBFdxyYnG/rLGij6lgTVZB
         9BwcxTUfbNnTcg6Dq/Lm9WLafqJZcSpFxOcsXaoVRAm6KrAT46UzU3vZtiZC+Fjh2Y2n
         4rvufTOC2w9na2ri+11dVzSfFqGwUtwMW4CQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3S4Qx+KGFNvpnFZCuQvXIFkQqNbKUzy97JWB3qSsstc=;
        b=V5+ZZ0xQYRI8FTvR4p+/abnCfefDso336mtlsvSbmF2DihRqPq6jFCMDt2aAVzN0Hb
         iODeUEDY1BxG1sN9fjN4om5XNPhOFx/uqSj5ryDMW47PWc2zCssZipKL9AnThEyAmOTL
         5Vh3uge/w91OqvIalqdCECs0KbGHX5ZCcVY28MNgil+fT5zXLy3kHWnzBueZJNThgXTC
         zdXukx9VpfOZZiEGzXSqxwtwAwZbbzFv/LffLIxRrEdkSxwkNnVgi29oRnoNWkcaremt
         jLAU52kGr0OVA9RDCsRh7ihzSxNqtKZVSEE2f2XMtenbPWaUxlkHeBS1NHl+uF7X2ajD
         8qLw==
X-Gm-Message-State: AOAM530ShJbiEBIf/GNHZJi/UEB91sCj9mS6AB1ewCzRgR7z7LxrMfne
        UVa+PFX4XSjZnpm9qkFTiSRUXr0tFM4yNL9VaQg=
X-Google-Smtp-Source: ABdhPJwL1JDlzuNGJZPRQs6nRzqYVgT4tzJ1IUcLVKmzmCVdwOaYGCXcA9DbxRj5gmFIhTKSfYlv4w==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr4283353ljg.241.1635529469040;
        Fri, 29 Oct 2021 10:44:29 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c9sm662027lff.136.2021.10.29.10.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 10:44:28 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d23so16723372ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:44:28 -0700 (PDT)
X-Received: by 2002:a05:651c:20c:: with SMTP id y12mr13458472ljn.68.1635529468040;
 Fri, 29 Oct 2021 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211029101550.2bde4593@gandalf.local.home>
In-Reply-To: <20211029101550.2bde4593@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 10:44:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi__d+MRw94ZfXYS4BKrSCOgAc-r3inhLh=87h_VJuLhQ@mail.gmail.com>
Message-ID: <CAHk-=wi__d+MRw94ZfXYS4BKrSCOgAc-r3inhLh=87h_VJuLhQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes to comments
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 7:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Also, fix my snake instinct.

On the internet, nobody knows you're a snake.

                 Linus
