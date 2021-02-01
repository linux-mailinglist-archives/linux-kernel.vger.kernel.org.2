Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108B4309FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 01:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBAAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBAAYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 19:24:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF65C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:23:56 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x21so15570048iog.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 16:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+6+ulDyi6U2H4iOXB1YcmGEFxqpm4cmiSLEvcnumSM=;
        b=s1g6LEQIF+dRC17p5+kv6440BGJWxhEMy5hCfpxzKTZM8FDxRyxZjUCyPgyDbOrLDW
         U5IUIU6xdJNPdQZRxUMCW1F6bGEAXaIUDUG3ShOpg0/JgZ4/T0lNkGZp86Tj9XNVNb72
         Rsod/lgNXYeNgeX45zAROu1OswZu1yn2DDKxmCpnBnKgffFDoMrXgxrhLnQPR3pN3FXY
         RW+8zoIEwNnmj47+3cmHMKcVGFUBWPH3IOPJorf18yhDEmE8wzQJTcZ+k1Xp3To+T+Pm
         8rd+/Dre/88BjUu2Nifgn4nj2lowDigMcgsSQTXdjgpxF15X1jSucUAe4KYFamWCRnZj
         wpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+6+ulDyi6U2H4iOXB1YcmGEFxqpm4cmiSLEvcnumSM=;
        b=W/PH9/g/1cHMXMZFzDdcnhL7JrZnfWlJnKV+J6bC4c+9oPxSCdk4oYhEMiu16LEbbI
         5qz35OpeacaeD/xZ/o0uzGa3pXr193Vivk0vQsRwNMlCk2gB9wis4Qi9kk1UfH90S+5I
         TGP4gDSGo6WKS8MONSBpYDTZ4Q/BDr+Vx6uwg/bOx52Y6SD3gef46ueWGNsQmgntALTg
         Bkvl1zAc7nIv64b3dnzIRNrc9qOFsmczO7t9dlm5S0o28T5dkWkYFiFgMtvi0W3kWkIW
         sdheGKPtY/VEezNzKSayelbLevZZ3pylhX7+cnKB90e9qsw6Td6FKx4LKm5L55DT3XXn
         wBYQ==
X-Gm-Message-State: AOAM530xQHaedm0gwbIJEop3l7OZux/f3EctIBVbHcCKk2NpuWgbtpfo
        L7JrTH7SSUrZAFu4DA4QXSA=
X-Google-Smtp-Source: ABdhPJzgviUON/XVeRLneYaAH+MkQxXranKXNIXDdgdgEmilNO5S0tjJHKrvgcRM3w2tULg85ADxfQ==
X-Received: by 2002:a5d:9710:: with SMTP id h16mr4362661iol.192.1612139035501;
        Sun, 31 Jan 2021 16:23:55 -0800 (PST)
Received: from llvm-development.us-central1-a.c.llvm-285123.internal (131.28.69.34.bc.googleusercontent.com. [34.69.28.131])
        by smtp.gmail.com with ESMTPSA id r1sm7874186iot.8.2021.01.31.16.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 16:23:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 00:23:53 +0000
From:   Vinicius Tinti <viniciustinti@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/i915: Remove unreachable code
Message-ID: <CALD9WKyonuPTPBzLHyLGd0V+w9SQavPdv0c_nBgLOyr6_5QnjQ@mail.gmail.com>
References: <20210129181519.69963-1-viniciustinti@gmail.com>
 <161195375417.17568.2762721732398065240@build.alporthouse.com>
 <20210130123411.GB1822@llvm-development.us-central1-a.c.llvm-285123.internal>
 <161201071009.32035.9188382145053741268@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161201071009.32035.9188382145053741268@build.alporthouse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 9:45 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Vinicius Tinti (2021-01-30 12:34:11)
> > On Fri, Jan 29, 2021 at 08:55:54PM +0000, Chris Wilson wrote:
> > > Quoting Vinicius Tinti (2021-01-29 18:15:19)
> > > > By enabling -Wunreachable-code-aggressive on Clang the following code
> > > > paths are unreachable.
> > >
> > > That code exists as commentary and, especially for sdvo, library
> > > functions that we may need in future.
> >
> > I would argue that this code could be removed since it is in git history.
> > It can be restored when needed.
> >
> > This will make the code cleaner.
>
> It doesn't change the control flow, so no complexity argument. It
> removes documentation from the code, so I have the opposite opinion.

The last change in sdvo related to this function is from commit
ce22c320b8ca ("drm/i915/sdvo: convert to encoder disable/enable"), which
dates from 2012.

It has not been used or changed for a long time. I think it could be
converted to a block comment. This will preserve the documentation
purpose. What do you think?

All this will avoid having "if (0)".

> > > The ivb-gt1 case => as we now set the gt level for ivb, should we not
> > > enable the optimisation for ivb unaffected by the w/a? Just no one has
> > > taken the time to see if it causes a regression.
> >
> > I don't know. I just found out that the code is unreachable.
> >
> > > For error state, the question remains whether we should revert to
> > > uncompressed data if the compressed stream is larger than the original.
> >
> > I don't know too.
> >
> > In this last two cases the code could be commented and the decisions
> > and problems explained in the comment section.
>
> They already are, that is the point.

I meant making them a block comment. For example:

/*
 * Enabling HiZ Raw Stall Optimization, at this point, causes corruption.
 *
 * Calling wa_masked_dis with the arguments wal, CACHE_MODE_0_GEN7,
 * HIZ_RAW_STALL_OPT_DISABLE will cause an HiZ corruption on ivb:g1.
 */

/*
 * Should fallback to uncompressed if we increase size
 * (zstream->total_out > zstream->total_in) by returning -E2BIG?
 */

> -Chris
