Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1B41FD45
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhJBQvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhJBQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:51:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50742C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:50:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y23so16833011lfj.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Csv37OXbbDiSxP1I27uaunb1tkkC28qGypuG9vbumlM=;
        b=f7QX1paUZLa6LbxjYrSrbM9jlt9yPMwzqTWrBad1TWIoRDz21l7WZy5J5Le2KzRQYy
         dg3j4YES0SMxOB8VBaDved+Q7R/c8muwjQwl638BnkC6zXtX+ZRK12dyoZgsWvzTnFhg
         wXyg6GfRhS+egEE51QHkoI6kOutXpxzaZGuHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Csv37OXbbDiSxP1I27uaunb1tkkC28qGypuG9vbumlM=;
        b=X5NIeBoAmLkIRcmvTGzBeXvb+tNEdWlJL4h4TNxfTm1ENMOtKF3GqpZdZbwOBUAcMG
         s3N0fuPWQmY8ClLVBKXxtx19gXvvRuepo4vqJI9No87KajPKi8lGN7ZMyCV/ijgYgyWd
         T7T9rkdyyzPONUc72ravtodm/yuuRduMvUE1OA4UHC1lfqzsVlwP6EH7CMzpw4aLj9Xu
         efjjmt0DsL0Fm0ERFxFojSU/17PoW85/yJrmKOMJUoBiZq/XkpHiN5HzApjgzx3c3pZ4
         Yce5eqIPm7OSQd2j60nh0F6zrgjHynGy6SsMr6/RJWJrAOmDBeektiTcO4V4gt6YVRYK
         4pYQ==
X-Gm-Message-State: AOAM531sbthF0vvHF/gOsFdVlFXJ/UdkoLERU1VL3JKxuro1e6+HUtWd
        bj9OHvd/DnpCkybhAn1dZNX0SVd8RD9HgMJNfZ4=
X-Google-Smtp-Source: ABdhPJxuZ0V/XqThebLePaROhKkNFp4h4fV0nhBcFKDqTz8S41osW0XENq9NP2dnx83Jt63WUr3kHg==
X-Received: by 2002:a05:6512:260f:: with SMTP id bt15mr4590279lfb.134.1633193399157;
        Sat, 02 Oct 2021 09:49:59 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id o13sm230575lfl.111.2021.10.02.09.49.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:49:58 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j5so46968032lfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:49:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3d26:: with SMTP id d38mr4500647lfv.474.1633193397167;
 Sat, 02 Oct 2021 09:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211002020257.34a0e882@oasis.local.home> <259ff554-76b8-8523-033-9e996f549c70@google.com>
 <20211002081750.7eec92dd@oasis.local.home>
In-Reply-To: <20211002081750.7eec92dd@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Oct 2021 09:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJsD3RaqpmAMv7yjpnQqrEuXvibXZZDY7f-nzO+PvULg@mail.gmail.com>
Message-ID: <CAHk-=whJsD3RaqpmAMv7yjpnQqrEuXvibXZZDY7f-nzO+PvULg@mail.gmail.com>
Subject: Re: [BUG 5.15-rc3] kernel BUG at drivers/gpu/drm/i915/i915_sw_fence.c:245!
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Caz Yokoyama <caz.yokoyama@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 5:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 2 Oct 2021 03:17:29 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
>
> > Yes (though bisection doesn't work right on this one): the fix
>
> Interesting, as it appeared to be very reliable. But I didn't do the
> "try before / after" on the patch.

Well, even the before/after might well have worked, since the problem
depended on how that sw_fence_dummy_notify() function ended up
aligned. So random unrelated changes could re-align it just by
mistake.

Patch applied directly.

I'd also like to point out how that BUG_ON() actually made things
worse, and made this harder to debug. If it had been a WARN_ON_ONCE(),
this would presumably not even have needed bisecting, it would have
been obvious.

BUG_ON() really is pretty much *always* the wrong thing to do. It
onl;y results in problems being harder to see because you end up with
a dead machine and the message is often hidden.

                  Linus
