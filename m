Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5008D3F0AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhHRSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHRSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:18:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:18:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t9so6531077lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kj1bCH98p646RpPq8Rr83F+jI2xp0GCJol1FdHiRh/w=;
        b=GdS0+UrCzlqRPfYHYfxsdr9dMrIlfVJgbajZHdqBY5kRBhUSqWkHyr6N0+fGv9NMSH
         0fwugwuLJPptmLidf81uGFApkPRncioGOPVXS/GWcCYgF4sErKi1Vx3Z4MOz/cOJsway
         jaRQ3Wbl5Q/IvCXzso0SR7oyoAtIIxTcFN3Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kj1bCH98p646RpPq8Rr83F+jI2xp0GCJol1FdHiRh/w=;
        b=D/800zWn9IJu1kR5SA0kBHwuv8NwLqMBf1DPTsn2g8Dzk215X0P1a8X1vEK6BnEFbs
         cnFTTC4+V5nMn71nCbHdnVABJwUn3XP+faYjiUSqFSbQw4mDY3bJCFEHAgKllXUycWBa
         Qokwcywnyl8YR4qhn+LDEGMBH6n9nLMux9PE4W0jZRPn4L2v9Pg+If15BhnIgkeiToNw
         ektQceg1ZYMIMPOyfEn7e3JWWHKg0zVm9Y6Rtu2F1a0Fvfp0NXup9oS0MuOX8rWZA5uX
         kU8Omr195yYx2t2TyOt5j0M+MGCvb4YQsbJCNn2YUI+9H2OFP5YG9vlkHu1aCCW4i+o2
         8PYw==
X-Gm-Message-State: AOAM5321Yf9QVS1AkXrPPFgnGngevUjD6SOq/LwTOB1BaJPEP6n9gOQk
        bNvfEA5cP2VuZK2qDSgcQS1yp0ebQKOjZg==
X-Google-Smtp-Source: ABdhPJwAy2acecFgNSi4JLc+mbM4DVZ+0lDhTFtP1W9JmlIQhYgwE8qk/B0NquAN7VyHXa8NqjMVZQ==
X-Received: by 2002:a19:e002:: with SMTP id x2mr7314316lfg.84.1629310696905;
        Wed, 18 Aug 2021 11:18:16 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r7sm44536lfr.60.2021.08.18.11.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 11:18:15 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w4so5229125ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:18:15 -0700 (PDT)
X-Received: by 2002:a2e:8808:: with SMTP id x8mr9241330ljh.220.1629310694800;
 Wed, 18 Aug 2021 11:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210802024945.GA8372@xsang-OptiPlex-9020> <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
 <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com> <20210818153155.GL6464@techsingularity.net>
In-Reply-To: <20210818153155.GL6464@techsingularity.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Aug 2021 11:17:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuCQSmpMA8HiGNHx3XVVFwEONQWydH2yrnzoT_ZDksGw@mail.gmail.com>
Message-ID: <CAHk-=wjuCQSmpMA8HiGNHx3XVVFwEONQWydH2yrnzoT_ZDksGw@mail.gmail.com>
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 8:31 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> I know hackbench is not particularly interesting but it's used often
> enough when comparing kernels and patches that commit 3a34b13a88 will be
> a regression magnet.

Fair enough.

And I like that patch anyway because of how it makes that EPOLLET
behaviour much more explicit, so I just committed it.

               Linus
