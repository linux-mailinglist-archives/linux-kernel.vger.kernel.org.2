Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44A136E039
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhD1U01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhD1U0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:26:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B936CC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:25:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 124so20265369lff.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24dqn/+FEtUll0rSYOdRnvFq6DTtKXVWdo2aK61CiNw=;
        b=dRDRaAX9ayALovqfgdL291l0lKLnc5uDr0fCOZ4yRUgugmE5ggRX0Wv8tfjce1adSn
         IyhtE55ZvnES7iabYqiKOupAbZzDmu5pHHIDFouMFkZ4cwHG1LUrLKne5no1F6ew8n3w
         mZ5NxKOhAsoeJPOQcsoN1olaEIQ5JCs3rZkFWAEHjCYT017Ox8VuCnlp0yQEdE6j8cWt
         9AhI9K8VgO67u5s7bf/Y0+qdwr/o6i/+ICgsJU7AUFmo0okdlQmxEc6a6q3VQStI3gsI
         mNlPs61YWci3Bpd0MNUyeFYZLv14/jWleoekAnomnmMJ+d706RjUukVJzfLeBi+P6wHl
         42yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24dqn/+FEtUll0rSYOdRnvFq6DTtKXVWdo2aK61CiNw=;
        b=iSVD8rEBEIJS73+1ZFknuoSAuFzFj62We0qKSLxFxeS1g0jwYN1bt0p/2cYC6CLCnE
         FyM0R+gh178Hk72yOzdY0mC4AotKmZRJ35RL4OIWTEs/ytV9ofndDi94Ht3lUcPgjnIq
         BdFQfYXDhCwU7zqP+jMWI1znDxeGR8CjCBNzFN6+F2wYPNuIj16ENsyezqgM7GnkrnIe
         39VLdyzFQDZijOaNjp7ChkOBZjsRWRzOeCndxHtK5v+xezVTDQYK0y3/JR3aC3Ee1Prr
         01A6n7p0WQ84lv4eN59y/uQgnfJYNCxMsC75A/6hIqmaInP8GQ2ojVYk1yJCYI9LwFah
         cL1Q==
X-Gm-Message-State: AOAM531QDww5Q+x9ApbNIA0k5kP4FycptkZHBV7S3qyhlMrk2q3iADJs
        aWYBqIWlI5+LbhsG/SocHl/TvyQlaV9uiIFBIgqQyg==
X-Google-Smtp-Source: ABdhPJyLKfJiWtybsYLfzFW3x4KBfvZ1SNTdYHGgqEIxXyky1SVISrVnvlf8ahz8T3/oFlzGumQIh1DxPIl79sIZXaU=
X-Received: by 2002:a19:ac09:: with SMTP id g9mr22162307lfc.547.1619641536929;
 Wed, 28 Apr 2021 13:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <CAJTyqKP4Ud7aWxdCihfzeZ3dQe_5yeTAVnXcKDonciez-g2zWA@mail.gmail.com>
In-Reply-To: <CAJTyqKP4Ud7aWxdCihfzeZ3dQe_5yeTAVnXcKDonciez-g2zWA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Apr 2021 13:25:25 -0700
Message-ID: <CAKwvOdmxYoNu1uD9DnSB_hLvnHM5W5rJf_KLOLkwgxAVQjz3pQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     mceier+kernel@gmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:34 AM Mariusz Ceier <mceier+kernel@gmail.com> wrote:
>
> Maybe it would also be worthwhile to make the requirement that the
> kernel must be buildable with free software (not just open source
> software) explicit ?

The kernel is already buildable by LLVM (and clang); in fact Android,
CrOS, and Google's production servers already do so.
https://clangbuiltlinux.github.io/
-- 
Thanks,
~Nick Desaulniers
