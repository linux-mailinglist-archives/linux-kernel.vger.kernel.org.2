Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBF309E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhAaUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhAaUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:01:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:51:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l12so16978630ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WFOrbv1SU9tZ0yXUcs0p5sjC97OnytuDtsfVd7rBwc=;
        b=HD/BSPgkG1rhP0Y0B3mR81N8DWvKSELu3ZKJJv9/GqtfKpwhZXTlNPuZNKi6ix0u8N
         7qrzchFAj04aT4jgAY2qOcosrB1KnkmpTn8SoMTd4e4/Q3Nm/kNzygy91C2cuBZ19fhD
         UfzGVvG4Bu8Ry4Hr3jQGnzzory3uSsb0PaAfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WFOrbv1SU9tZ0yXUcs0p5sjC97OnytuDtsfVd7rBwc=;
        b=lX8Odxj239No82MhG63PvNp6Z9HkpttzQw+tdEtVXLdop/x0gtKDHC41pG5JWMv0gR
         +YQxAnZtFFnx9REffuSSxWi9nhbA4p5MnXycczZNdpIUOtoU3+qk/jJnTZWdKY4/7eG0
         99YxekvlMa9rRGWo9pvtOFXFpjk6fs1qnjz5mTPUCOx0kSc/CiWy/l9fRBr8zDVS26RD
         UarHSl9+caaGYtFLmYOs3aoffMJJKfiXftTfDQG1TrCiYqCnTMWlmyAj96B21YbggEHr
         4DM2k1a+wCLK0STNQC+IYoiJGiyZpt1vTZuFcCR30/0rTDsvOsQxZcPkGBPbIfDjCpSW
         erWg==
X-Gm-Message-State: AOAM5301FJitaWJG+bN22fG5uAZgmQP6a5cC6Sib68ZrDLOR+FjyX2O2
        ikF7BuobEcovgrcZvV1KuSr9PGtHgKG8eA==
X-Google-Smtp-Source: ABdhPJxsD0roQqMoSv1z9DBuh4swpAiC+UpZBHBULGhVbH60T4AcUXR/LQXYsHVcxl8b0DI1K51Axg==
X-Received: by 2002:a2e:b746:: with SMTP id k6mr8626069ljo.354.1612122684519;
        Sun, 31 Jan 2021 11:51:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d17sm3560545ljg.125.2021.01.31.11.51.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:51:23 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id a8so19875070lfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:51:23 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr6612559lfu.40.1612122683073;
 Sun, 31 Jan 2021 11:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20210131105717.GA4432@zn.tnic>
In-Reply-To: <20210131105717.GA4432@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:51:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoGGvZcvU+zikDmbRkVz=KFgg5Ph=N+BwKbyOmrF3-SQ@mail.gmail.com>
Message-ID: <CAHk-=wgoGGvZcvU+zikDmbRkVz=KFgg5Ph=N+BwKbyOmrF3-SQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/entry for v5.11-rc6
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:57 AM Borislav Petkov <bp@suse.de> wrote:
>
> A single fix for objtool to generate proper unwind info for newer
> toolchains which do not generate section symbols anymore. And a cleanup
> ontop.

Manual pr-tracker-bot says thanks.

Oh, and I'm about to merge your EFI pull request too, so you can
consider that merged too (I'll holler separately in the unlikely case
I see any issues).

Manual pr-tracker-bot is starting to feel lazy.

             Linus
