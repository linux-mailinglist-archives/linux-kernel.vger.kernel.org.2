Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE6326FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 00:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhB0Xjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 18:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhB0Xjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 18:39:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B133C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 15:39:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id e7so19597236lft.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHYf5YOcJirX+nDC2Sh0poowt9oWDI+kNOd5H2EyN1Y=;
        b=YG34fAKTflHVpLgMkjOhd3eYHYCwQTrqNVIxg6HIeb6qH4OT5Xg2iEGnxhtl3D83VU
         jXx38jfvUQrfrvdmtQYOZ0gEGgYvOP3Vixl5HvfqPu11v5IokKd210p3JXveQBHMfKOF
         FrFntvyTHnLERkoj7XV7uenr6Z623guT239JLNm3PgN/DDs99CsvLSk2LE8OuNtbQKIJ
         LsJFromt/lFqrcol7JcNqMIJkclf9zOOHy+2eEU4bpuXP9sn5AOGBR1hcwdBqN9DeC+d
         XzhJ73zGSuONBnPxzIlZcSLeV1JyTM5R4epZgzdU0zir7c4TpNpCJKfIbw2rrt5QRgB6
         zLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHYf5YOcJirX+nDC2Sh0poowt9oWDI+kNOd5H2EyN1Y=;
        b=jNZm98UROJScz5bUQZwsGF4+OwFq1a8JYxLox8xVDXnmjlaB8DUExO06Au4P/aDIJV
         vWvRvXHstET7SO6m3GNWONBJwzAOzupNhY+tuJYW8XWEco9dgPlAjVT2ubiSBvSPyjHQ
         EuMnKbW/+7FILXb8Rze5rNnoeKkWAA+/kgVmEz2ZDdE1amFwf0y//h6tViJbY5phSFM7
         srk9E5bf44LagNTFjpoPCFjSoiJ7mV85fG63EPGT/Ce4t2wqjbs5oYcraTq4ho9UrEv6
         aao0RO0bOb5BRlYn9WBFy3dk9bfUpL8RcekCXg/jRF0xrEvPd8wEY+x2mJVoCbwaENrz
         EN1w==
X-Gm-Message-State: AOAM531TG7dYaovZfRT1Uatt91VgNiYXX8bGGF8+MJqfp862HEXwCb/F
        rnFas3jauqyUZ5VPfYugSmabVsEhZCB+f6O2GfonLA==
X-Google-Smtp-Source: ABdhPJx45U+cYpscpM6EC0bwdf1lUtE10L6rS094zfbujxE7qiqPep+VnzN53U6f9OJjvpsiC3nNytSXy7caYe7NlCM=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr5493986lfs.586.1614469144151;
 Sat, 27 Feb 2021 15:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20210224113108.4c05915e@canb.auug.org.au> <CAHk-=wi1FEJfk9r4Jw90kU3aayXka4Y4HOWdgAtVQHRFTgpQ+A@mail.gmail.com>
 <20210224114942.4b07cece@canb.auug.org.au> <202102241324.E784B6A0@keescook>
In-Reply-To: <202102241324.E784B6A0@keescook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 28 Feb 2021 00:38:53 +0100
Message-ID: <CACRpkdYgh21LcWEip=rhduQEUYYdMYpEyUNNq86DM4Kk+TPhGg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in Linus' tree
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:30 PM Kees Cook <keescook@chromium.org> wrote:

> I wonder if we need this in Documentation/maintainer/configure-git.rst

That is generally a good idea.

> and to put check_commits and check_fixes into tools/ somewhere?

People keep saying we should put git hooks somewhere where
they can be reused easily. What about just creating
scripts/git-hooks?

Yours,
Linus Walleij
