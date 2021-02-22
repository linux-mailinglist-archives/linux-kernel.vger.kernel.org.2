Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2796C321E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhBVRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhBVRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:45:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73423C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:45:12 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u4so7171672lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZNyTfd7nEmv+pShZaPJz7a0abWIzHWs8Ubs4x96pL0=;
        b=Qmddt36uLRlJvP0NWVHc7Q1qsFp7aZYSa6RpBiY+6gzP1pNbGUfOor+3oTyHVV2CJU
         OeBIML9y9Npk6n9ttYD5G/VcljRzknXMC2S/W4ZEG4lzquP8r5A5qevSDimdNgvg2f+H
         uyvWz9zOVCyQBhBslydfDfhMBMeCebD6cX6kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZNyTfd7nEmv+pShZaPJz7a0abWIzHWs8Ubs4x96pL0=;
        b=BmKDegPaHO938AvlrqXNuA+UmKSFN18TpZG3/PqWphEMJSrWpNiZv6aLA37TlN0vVY
         2BnD9HZShfJJzbkgldPxLpAU9ih6jFSGYSc18xriJS8ecfaNfmwyfd2lZg6h5eNRKc7C
         yk2UCvok2hogDUppWk8SlrfL8195lZQuLICaHceuEglckf5Cb7Z0pySORZzweb9yvDxN
         mJ3RoJHT2/DlCD4aXmY8v+bcg31ZtONWANVm72Ftz1VgKT92Lbjnco4cdhAREUiqCCJp
         q9ruzpw8+9r4i9jPEXrJ523gpXQIyFEJ11qzifZpt7FmVTVSOxUHlLW+7BswigJxHzPB
         fhbA==
X-Gm-Message-State: AOAM5323GJFsUvZzG3ppfAaHTM71IHRgEmjsPcoxL6Ib2AP+ADcY0c44
        ZqMK33taplwQlZQuVggiaduN9PlL2yld1Q==
X-Google-Smtp-Source: ABdhPJwGobJicY3+IY6mMgL5Pyoar1LS/I78xjES08/7p/omCUFF/m/hBWhZQTR16BVfGIDEnnfP3g==
X-Received: by 2002:a19:8147:: with SMTP id c68mr8982875lfd.351.1614015910372;
        Mon, 22 Feb 2021 09:45:10 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 71sm1225971lfj.18.2021.02.22.09.45.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 09:45:09 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id u4so14460161lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:45:09 -0800 (PST)
X-Received: by 2002:a05:651c:112:: with SMTP id a18mr15068444ljb.465.1614015908831;
 Mon, 22 Feb 2021 09:45:08 -0800 (PST)
MIME-Version: 1.0
References: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
In-Reply-To: <ace202cb-b9bc-c43a-8023-9c45946af3bf@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 09:44:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
Message-ID: <CAHk-=wiaespvE0HmhpJhcNsJXob6WJCH0BdD5XuvBJP7KF_EFg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.12-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Colin King <colin.king@canonical.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 3:54 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Note a set of changes for the qcom adc driver rely on an immutable
> branch from the iio tree:

That part is fine, but what _isn't_ great is the merge commit message.

This is the message in its entirety:

   "Merge remote-tracking branch
'iio-thermal-5.11-rc1/ib-iio-thermal-5.11-rc1' into testing"

Notice how it doesn't say _anything_ useful.

Merges are commits, and they should have commit messages with
*explanation* the same way all regular commits should. In fact, they
generally should have *more* explanation, since they are fundamentally
more interesting and subtle than some one-liner obvious bug-fix.

So this all looks otherwise fine, and I like how you were clearly
aware of the whole cross-tree merge, and how you let me kn0ow about
it. I appreciate that part, and I've pulled your branch.

But I wanted to really take this moment to point out that merge
commits really should have messages explaining *why* and *what* got
merged. Not just the technical "I merged that tree".

           Linus
